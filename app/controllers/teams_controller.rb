class TeamsController < ApplicationController

  before_action :authenticate_user, except: [:edit_password, :reset_password]
  before_action :restrict_user, only: [:index, :new, :create]

  def index
    @users = User.all
  end

  def new
    @user = User.new
    @user.places.build
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to teams_path, notice: 'User was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit_password
    @user = User.find_by(reset_token_digest: params[:id])
  end

  def reset_password
    @user = User.find_by(reset_token_digest: params[:id])
    if @user.present?
      if params[:user][:password] == params[:user][:password_confirmation]
        @user.password = params[:user][:password]
        if @user.save
          session[:user_id] = @user.id
          flash.now[:notice] = 'Password successfully updated'
          redirect_to new_place_path
        else
          flash.now[:error] = @user.errors.full_messages.join(",")
          render :edit_password
        end
      else
        flash.now[:error] = 'Password and Password Confirmtion does not match'
        render :edit_password
      end
    else
      flash.now[:error] = 'Invalid User'
      render :edit_password
    end
  end

  private
    def restrict_user
      if current_user.is_team_member
        redirect_to places_path
      end
    end

    def user_params
      params.require(:user).permit(
        :name,
        :email,
        :password,
        :is_team_member,
        :manager_id,
        places_attributes: [
          :id,
          :place_name,
          :approved_by_manager,
          :_destroy
        ]
      )
    end
end
