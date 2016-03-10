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

require 'rails_helper'

RSpec.describe Attendee, type: :model do
  it "can upload attendee by CSV" do
    upload_result = Attendee.csv_upload(File.join("#{Rails.root}/spec/fixtures/", 'sample_data.csv'))
    expect(Attendee.all.size).to eq(2405)
    expect(upload_result['success']).to include("9895")
  end
end
