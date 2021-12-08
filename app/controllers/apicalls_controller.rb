class ApicallsController < ApplicationController
  before_action :token_status?
  rescue_from RestClient::BadRequest, with: :not_found
  rescue_from ActionView::Template, with: :not_found

  private

  def not_found
    render 'notfound'
  end

  def token_status?
    if Apicall.all.empty?
      create_token
    else
      token_time = Apicall.first.updated_at.time + 1.hour
      update_token unless token_time > Time.now.utc
    end
  end

  def create_token
    Apicall.create(token: access_token)
  end

  def update_token
    Apicall.first.update(token: access_token)
  end

  def access_token
    grant = Base64.strict_encode64("#{SPOTIFY_CLIENT_ID}:#{SPOTIFY_SECRET}")

    response = RestClient.post('https://accounts.spotify.com/api/token',
                               { 'grant_type' => 'client_credentials' },
                               { 'Authorization' => "Basic #{grant}" })
    JSON.parse(response)['access_token']
  end
end
