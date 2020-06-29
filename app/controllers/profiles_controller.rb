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
    @profile.assign_attributes(nickname: params[:nickname], introduction: params[:introduction], gender: params[:gender], avatar: params[:avatar])
    if @profile.save
      redirect_to profile_path, notice: 'Successfully updated!'
    else
      flash[:notice] = 'failed to save'
      render("profiles/edit")
    end
  end

end
