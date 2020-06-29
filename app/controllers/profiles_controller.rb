class ProfilesController < ApplicationController
  before_action :forbid_unuser

  def show
    @profile = current_user.profile
  end

  def edit
    @profile = current_user.build_profile
  end

end
