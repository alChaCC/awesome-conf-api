json.attendee do
  json.id             @attendee.id
  json.first_name     @attendee.first_name
  json.last_name      @attendee.last_name
  json.country        @attendee.country
  json.title          @attendee.title
  json.company        @attendee.company
  json.interests      @attendee.interests
  json.bio            @attendee.bio
  json.image_url      @attendee.image_url
end

