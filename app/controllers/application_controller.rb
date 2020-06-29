class ApplicationController < ActionController::Base
  private
  def forbid_unuser
    if !user_signed_in?
      redirect_to new_user_session_path, notice: 'You need to sign in'
    end
  end
end
