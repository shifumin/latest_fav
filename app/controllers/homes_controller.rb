class HomesController < ApplicationController
  before_action :login_required, only: :result

  def index; end

  def result
    render and return unless twitter_client.user?(session[:search_user])
    @search_user = session[:search_user]

    favorites = twitter_client.favorites(@search_user, count: 200)
    @lateset_favorite = favorites.find do |favorite|
      favorite.user.screen_name == @current_user.screen_name
    end
  end

  private

  def twitter_client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.secrets[:twitter][:consumer_key]
      config.consumer_secret     = Rails.application.secrets[:twitter][:consumer_secret]
      config.access_token        = @current_user.token
      config.access_token_secret = @current_user.token_secret
    end
  end
end
