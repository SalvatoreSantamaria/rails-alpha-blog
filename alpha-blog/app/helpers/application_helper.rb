# To have a profile image associated with an email account you control, add one to the site en.gravatar.com. This will be the globally recognized avatar (gravatar for short) associated with that email address.


module ApplicationHelper #any method that helps with views, put in app helper file
  def gravatar_for(user, options = { size: 80}) #passing in user object
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.username, class: "img-circle")
  end
end
