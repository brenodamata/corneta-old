class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  # def twitter
  #   @user = User.from_omniauth(request.env["omniauth.auth"])
  #   sign_in_and_redirect @user
  # end

  def twitter
    generic_callback( 'twitter' )
  end

  def generic_callback( provider )
    @identity = Identity.find_for_oauth env["omniauth.auth"]

    @user = @identity.user || current_user

    if @user.nil?
      @user = User.create_new( email: @identity.email || "" )
      @identity.update_attribute( :user_id, @user.id )
      redirect_to new_account_user_path(@user)
    end

    if @user.email.blank? && @identity.email
      @user.update_attribute( :email, @identity.email)
    end

    if @user.persisted?
      @identity.update_attribute( :user_id, @user.id )
      # This is because we've created the user manually, and Device expects a
      # FormUser class (with the validations)
      @user = FormUser.find @user.id
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: provider.capitalize) if is_navigational_format?
    else
      session["devise.#{provider}_data"] = env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

end
