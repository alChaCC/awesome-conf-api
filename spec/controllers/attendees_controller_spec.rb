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

  describe 'Get interleave_by_interests' do
    before do
      FactoryGirl.reload
      @attendee1 = create(:attendee, interests: ['Ruby', 'Rails', 'React'], importance: 1, first_name: 'Aloha')
      @attendee2 = create(:attendee, interests: ['Ruby', 'Rails'], importance: 2, first_name: 'Chen')
      @attendee3 = create(:attendee, interests: ['Rails'], importance: 3, first_name: 'Nobody')
      @attendee4 = create(:attendee, interests: ['React'], importance: 4, first_name: 'Jordan')
      @attendee4 = create(:attendee, interests: ['PHP'], importance: 6, first_name: 'Curry')
    end

    it 'has a 200 status code and correct response body' do
      @attendee = Attendee.find_by_first_name('Chen')
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
      @not_related_attendee = Attendee.find_by_first_name('Nobody')
      expected_not_related_response = {
        'id'            => @not_related_attendee.id,
        'first_name'    => @not_related_attendee.first_name,
        'last_name'     => @not_related_attendee.last_name,
        'country'       => @not_related_attendee.country,
        'title'         => @not_related_attendee.title,
        'company'       => @not_related_attendee.company,
        'interests'     => @not_related_attendee.interests,
        'thumbnail_url' => @not_related_attendee.thumbnail_url
      }
      params = { interest: 'Ruby' }
      get :interleave_by_interests, params
      expect(response.code).to eq('200')
      expect(JSON.parse(response.body)['related_attendees'].first).to eq(expected_response)
      expect(JSON.parse(response.body)['not_related_attendees'].last).to eq(expected_not_related_response)
      expect(JSON.parse(response.body)['related_attendees'].size).to eq(2)
      expect(JSON.parse(response.body)['not_related_attendees'].size).to eq(3)
    end

    it 'has a 404 status code' do
      params = { id: "random" }
      get :show, params
      expect(response.code).to eq('404')
    end

  end

end
