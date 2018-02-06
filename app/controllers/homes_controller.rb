class HomesController < ApplicationController
  before_action :login_required, only: :result

  def index; end

  def result
    @searched_user = session[:searched_user]
    @searched_user_is_present = twitter_client.user?(@searched_user)

    render and return unless @searched_user_is_present

    favorites = twitter_client.favorites(@searched_user, count: 200)
    late_favorites = favorites.find_all do |favorite|
      favorite.user.screen_name == @current_user.screen_name
    end

    @late_five_favorites = late_favorites.take(5)
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
