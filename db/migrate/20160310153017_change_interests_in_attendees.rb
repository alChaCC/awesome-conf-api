class ChangeInterestsInAttendees < ActiveRecord::Migration
  def change
    remove_column :attendees, :interests, :string
    add_column :attendees, :interests, :text, array: true
  end
end
