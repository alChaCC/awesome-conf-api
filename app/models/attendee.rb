# == Schema Information
#
# Table name: attendees
#
#  id            :uuid             not null, primary key
#  first_name    :string
#  last_name     :string
#  country       :string
#  title         :string
#  company       :string
#  importance    :integer
#  bio           :text
#  thumbnail_url :string
#  image_url     :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  interests     :text             is an Array
#

class Attendee < ActiveRecord::Base
  default_scope { order('importance DESC') }

  class << self
    def csv_upload(file_path)
      return_h = {}
      return_h['success'] = []
      return_h['failure'] = []
      rows  = []
      CSV.parse(File.read(file_path), headers: true, header_converters: lambda { |s| s.squish }) {|r| rows << r.to_hash}
      rows.each_with_index do |row, index|
        row_id = row['id']
        interests_array = row['interests'].gsub(/([{}])/,'').split(',')
        row['interests'] = interests_array
        a = Attendee.new(row.reject!{|k| k == 'id'})
        if a.save
          return_h['success'] << row_id
        else
          return_h['failure'] << "#{row_id}-#{a.errors.full_messages}"
        end
      end
      return_h
    end

    def find_related_people(interest)
      related     = Attendee.where.contains(interests: [interest])
      non_related = Attendee.where.not('interests && ARRAY[?]', interest)
      [related, non_related]
    end
  end
end
