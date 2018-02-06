class UserFormsController < ApplicationController
  def new
    @user_form = UserForm.new
  end

  def create
    @user_form = UserForm.new(user_form_params)
    if @user_form.save
      session[:searched_user] = @user_form.screen_name
      redirect_to result_path, notice: '検索'
    else
      render :new
    end
  end

  private

  def user_form_params
    params.require(:user_form).permit(:screen_name)
  end
end
