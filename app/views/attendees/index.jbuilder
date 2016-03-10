json.attendees @attendees do |attendee|
  json.id             attendee.id
  json.first_name     attendee.first_name
  json.last_name      attendee.last_name
  json.country        attendee.country
  json.title          attendee.title
  json.company        attendee.company
  json.interests      attendee.interests
  json.thumbnail_url  attendee.thumbnail_url
end

