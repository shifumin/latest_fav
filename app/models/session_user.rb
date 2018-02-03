class SessionUser
  attr_reader :user_id, :screen_name, :name, :token, :token_secret

  def initialize(session)
    @user_id = session[:user_id]
    @screen_name = session[:screen_name]
    @name = session[:name]
    @token = session[:oauth_token]
    @token_secret = session[:oauth_token_secret]
  end
end
