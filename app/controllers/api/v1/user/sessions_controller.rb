class Api::V1::User::SessionsController < Devise::SessionsController
  # skip_before_action :verify_signed_out_user
  # POST /resource/sign_in
  def create
    @user = warden.authenticate!(auth_options)
    @token = Tiddle.create_and_return_token(@user, request)
    render json: { message: 'User logged in successfully', auth_token: @token, status: 200 }
  end

  # DELETE
  def destroy
    Tiddle.expire_token(current_user, request) if current_user
    render json: {}
  end
end
