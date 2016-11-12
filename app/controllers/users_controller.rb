class UsersController < ApplicationController
  before_action :get_user_by_id, only: [:show, :followings, :followers]
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.
                        order(created_at: :desc).
                        page params[:page]
    @following_number = following_users(all: true).size
    @followers_number = followers_users(all: true).size
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user  
    else
      render 'new'
    end
  end
  
  def edit
    @user = get_current_user
    unless is_current_user?
      flash[:danger] = "You can't edit the other user"
      redirect_to user_path(@user)
    end
  end
  
  def update
    @user = get_current_user
    if @user.update(user_params) || is_current_user?
      flash[:success] = "Updated your profile"
      redirect_to @user 
    else
      render 'edit'
    end
  end
  
  def followings
    @follow_users = following_users
    @follow_title = "Users whom this user follows."
  end
  
  def followers
    @follow_users = followers_users
    @follow_title = "Users who follow this user."
    render 'followings'
  end
  
  private
  
  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation,
      :profile,
      :location,
      :url,
    )
  end
  
  
  def is_current_user?
    get_current_user.id == params[:id].to_i
  end
  
  def get_user_by_id
    @user = User.find_by(id: params[:id])
  end
  
  def following_users(all: nil)
    !!all ? @user.following_users : @user.following_users.page(params[:page])
  end
  
  def followers_users(all: nil)
    !!all ? @user.follower_users : @user.follower_users.page(params[:page])
  end
  
end
