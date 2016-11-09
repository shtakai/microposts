class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
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
  end
  
  def followers
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
  
end
