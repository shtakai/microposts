module MicropostsHelper
  def repost(user, micropost)
    link_to(
      "Repost", 
      repost_path(micropost), 
      method: :post, 
    ) unless user.id == micropost.user.id
  end
  
  def favolite(micropost)
    link_to("Fav", favolite_url(micropost), remote: true, class: 'btn btn:default')
  end
end 
