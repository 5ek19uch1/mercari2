# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  def emailpass
  end
  # GET /resource/sign_up
  def new
    # super
    @user = User.new
    @sns = SnsCredential.new
  end


  # def new
  # end

  # def after_inactive_sign_up_path_for(resource)
  #   sms_confirmation_signup_index_path
  # end


  def phone_number
  end

  def credit
    @user = User.new
  end


  
  
def card
end  


def create
  # binding.pry
   if params[:user][:password] == "" 
     params[:user][:password] = "Devise.friendly_token.first(6)" 
     params[:user][:password_confirmation] = "Devise.friendly_token.first(6)"

     super
     # binding.pry
     sns = SnsCredential.update(user_id:  @user.id)
   else #email登録なら
    #  binding.pry
     super
   end
 end

 def world
  # @user = User.find(params[:id])
  @user = User.find(params[:id])
  @addresses = @user.addresses.includes(:user)
end


  
  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
