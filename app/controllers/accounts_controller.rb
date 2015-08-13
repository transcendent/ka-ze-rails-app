class AccountsController < Devise::RegistrationsController

	 
    before_filter :update_sanitized_params, if: :devise_controller?

    def update_sanitized_params
       devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:first_name, :last_name, :phone, :email, :title, :password, :password_confirmation)}
    end

    def edit_profile
    	@account = current_account
    	render 'devise/registrations/edit_profile'
    end

    def update_profile
    	@account = current_account
    	if @account.update_attributes(account_params)
  		flash[:success] = "Profile updated"
  		update_account_record_sfdc
  		redirect_to root_url
  		else
  		render 'devise/registrations/edit_profile'
  		end
    end


	private
	def account_params
		params.require(:account).permit(:first_name, :last_name, :phone)
	end

	protected

    def update_account_record_sfdc
      client = initialize_client
      # don't forget to include the external ID
      client.upsert!('Account', 'Rails_ID__c', Rails_ID__c: @account.id, FirstName: @account.first_name, LastName: @account.last_name, PersonEmail: @account.email, Phone: @account.phone)
    end

end