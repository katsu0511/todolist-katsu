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
    @profile.assign_attributes(nickname: params[:nickname], introduction: params[:introduction], gender: params[:gender])

    if params[:avatar]
      @profile.image_name = "user_#{current_user.id}.jpg"
      avatar = params[:avatar]
      File.binwrite("public/avatars/#{@profile.image_name}", avatar.read)
    end

    if @profile.save
      redirect_to profile_path, notice: 'successfully updated your profile!'
    else
      flash[:notice] = 'failed to update'
      render("profiles/edit")
    end
  end

end
