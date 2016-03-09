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

FactoryGirl.define do
  factory :attendee do
    
  end
end
