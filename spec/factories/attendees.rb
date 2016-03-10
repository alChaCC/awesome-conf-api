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
    sequence(:first_name) { |n| "Aloha-#{n}" }
    sequence(:last_name)  { |n| "last_name-#{n}" }
    sequence(:country)    { %w[Ireland USA UK].cycle }
    title 'CEO'
    sequence(:importance) { |n| Time.now.to_i + n }
    bio   'hi'
    interests 'all'
    thumbnail_url 'url'
    image_url 'url'
  end
end
