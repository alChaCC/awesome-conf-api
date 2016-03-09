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
#  interests     :string
#  thumbnail_url :string
#  image_url     :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Attendee < ActiveRecord::Base
  class << self
    def csv_upload(file_path)
      return_h = {}
      return_h['success'] = []
      return_h['failure'] = []
      rows  = []
      CSV.parse(File.read(file_path), headers: true, header_converters: lambda { |s| s.squish }) {|r| rows << r.to_hash}
      rows.each_with_index do |row, index|
        a = Attendee.new(row.reject!{|k| k == 'id'})
        if a.save
          return_h['success'] << row['id']
        else
          return_h['failure'] << "#{row['id']}-#{a.errors.full_messages}"
        end
      end
      return_h
    end
  end
end
