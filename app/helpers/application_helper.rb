module ApplicationHelper
	def initialize_client
      Restforce.new
    end 

    # def gravatar_for(user, options={size: 100})
	   #  gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
	   #  size = options[:size]
	   #  gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
	   #  image_tag(gravatar_url, alt: user.first_name, class: "gravatar")
    # end 
end
