require 'rails_helper'

RSpec.describe AttendeesController, type: :controller do
  render_views
  describe 'Get Index' do
    before do
      FactoryGirl.reload
      for i in 1..100
        create(:attendee)
      end
    end

    it 'only show 25 attendees' do
      get :index
      expect(response.code).to eq('200')
      expect(JSON.parse(response.body)['attendees'].size).to eq(25)
    end

    describe 'support pagination' do
      it 'page1' do
        @attendee = Attendee.find_by_first_name('Aloha-100')
        expected_response = {
          'id'            => @attendee.id,
          'first_name'    => @attendee.first_name,
          'last_name'     => @attendee.last_name,
          'country'       => @attendee.country,
          'title'         => @attendee.title,
          'company'       => @attendee.company,
          'interests'     => @attendee.interests,
          'thumbnail_url' => @attendee.thumbnail_url
        }
        params = { page: 1 }
        get :index, params
        expect(response.code).to eq('200')
        expect(JSON.parse(response.body)['attendees'].first).to eq(expected_response)
      end

      it 'page4' do
        @attendee = Attendee.find_by_first_name('Aloha-25')
        expected_response = {
          'id'            => @attendee.id,
          'first_name'    => @attendee.first_name,
          'last_name'     => @attendee.last_name,
          'country'       => @attendee.country,
          'title'         => @attendee.title,
          'company'       => @attendee.company,
          'interests'     => @attendee.interests,
          'thumbnail_url' => @attendee.thumbnail_url
        }
        params = { page: 4 }
        get :index, params
        expect(response.code).to eq('200')
        expect(JSON.parse(response.body)['attendees'].first).to eq(expected_response)
      end
    end
  end

  describe 'Get Show' do
    before do
      @attendee = create(:attendee)
    end

    it 'has a 200 status code and correct response body' do
      expected_response = {
        attendee: {
          id:             @attendee.id,
          first_name:     @attendee.first_name,
          last_name:      @attendee.last_name,
          country:        @attendee.country,
          title:          @attendee.title,
          company:        @attendee.company,
          interests:      @attendee.interests,
          bio:            @attendee.bio,
          image_url:      @attendee.image_url
        }
      }
      params = { id: @attendee.id }
      get :show, params
      expect(response.code).to eq('200')
      expect(response.body).to eq(expected_response.to_json)
    end

    it 'has a 404 status code' do
      params = { id: "random" }
      get :show, params
      expect(response.code).to eq('404')
    end
  end
end
