module ApplicationHelper
	def initialize_client
      Restforce.new :username => Rails.application.secrets.sfdc_user_name,
       :password => Rails.application.secrets.sfdc_password,
       :security_token => Rails.application.secrets.sfdc_security_token,
       :client_id      => Rails.application.secrets.sfdc_client_id,
       :client_secret  => Rails.application.secrets.sfdc_client_secret
    end 

    # def gravatar_for(user, options={size: 100})
	   #  gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
	   #  size = options[:size]
	   #  gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
	   #  image_tag(gravatar_url, alt: user.first_name, class: "gravatar")
    # end 
end
