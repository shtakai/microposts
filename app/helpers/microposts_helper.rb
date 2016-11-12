module MicropostsHelper
  def repost(user, micropost)
    link_to(
      "Repost", 
      repost_path(micropost), 
      method: :post, 
    ) unless user.id == micropost.user.id
  end
end 
