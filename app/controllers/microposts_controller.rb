class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = current_user.feed_items.
                                includes(:user).
                                order(created_at: :desc).
                                page params[:id]
      render 'static_pages/home'
    end
  end
  
  def destroy
    @micropost = current_user.microposts.
                              find_by(id: params[:id])
    return redirect_to root_url if @micropost.nil?
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end
  
  def repost
    # TODO: refer original post id
    if !!repostable_micropost
      micropost = Micropost.create(
        user: current_user,
        content: repostable_micropost.content
      )
      flash[:success] = "Reposted."
    else
      flash[:danger] = "Can't Repost"
    end
    redirect_to root_path
  end
  
  private
  
  def micropost_params
    params.require(:micropost).permit(:content)
  end
      
  def repostable_micropost
    micropost = Micropost.find_by(id: params[:id])
    !!micropost && micropost.user_id == current_user.id ? nil : micropost
  end
end
