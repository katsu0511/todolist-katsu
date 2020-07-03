class ProfilesController < ApplicationController
  before_action :forbid_unuser

  def show
    @profile = current_user.profile
  end

  def edit
    @profile = current_user.prepare_profile
  end

  def update
    @profile = current_user.prepare_profile
    @profile.assign_attributes(profile_params)

    if @profile.save
      redirect_to profile_path, notice: 'successfully updated your profile!'
    else
      flash.now[:error] = 'failed to update'
      render :edit
    end
  end

  private
  def profile_params
    params.require(:profile).permit(
      :nickname,
      :introduction,
      :gender
    )
  end

end
