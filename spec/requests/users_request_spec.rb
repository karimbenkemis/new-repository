require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) do
    User.create(
      email: 'danie@example.com',
      password: 'supersecurepassword',
      password_confirmation: 'supersecurepassword',
    )
  end

  let(:user_to_process) do
    User.create(
      email: 'karim@example.com',
      password: 'testpassword',
      password_confirmation: 'testpassword',
    )
  end

  describe 'GET /index' do
    it 'returns http success' do
      auth_token = authenticate_user(user)
      get users_path, headers: { 'Authentication' => "Bearer #{auth_token}" }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'DELETE /delete' do
    it 'returns http success' do
      auth_token = authenticate_user(user)
      delete "/users/#{user_to_process.id}", headers: { 'Authentication' => "Bearer #{auth_token}" }
      expect(response).to have_http_status(:no_content)
    end
  end

  describe 'DELETE /delete same user in Authentication token' do
    it 'returns http success' do
      auth_token = authenticate_user(user)
      delete "/users/#{user.id}", headers: { 'Authentication' => "Bearer #{auth_token}" }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'GET /archive/:id' do
    it 'returns http success' do
      auth_token = authenticate_user(user)
      get "/users/archive/#{user_to_process.id}", headers: { 'Authentication' => "Bearer #{auth_token}" }
      expect(response).to have_http_status(:no_content)
    end
  end

  describe 'GET /archive/:id same user in Authentication token' do
    it 'returns http success' do
      auth_token = authenticate_user(user)
      get "/users/archive/#{user.id}", headers: { 'Authentication' => "Bearer #{auth_token}" }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'GET /unarchive/:id' do
    it 'returns http success' do
      auth_token = authenticate_user(user)
      get "/users/unarchive/#{user_to_process.id}" , headers: { 'Authentication' => "Bearer #{auth_token}" }
      expect(response).to have_http_status(:no_content)
    end
  end

  describe 'GET /unarchive/:id same user in Authentication token' do
    it 'returns http success' do
      auth_token = authenticate_user(user)
      get "/users/unarchive/#{user.id}" , headers: { 'Authentication' => "Bearer #{auth_token}" }
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
