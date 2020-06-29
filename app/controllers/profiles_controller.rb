class ProfilesController < ApplicationController
  before_action :forbid_unuser

  def show
    @profile = current_user.profile
  end

  def edit
  end

end
