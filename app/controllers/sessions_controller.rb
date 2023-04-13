class SessionsController < ApplicationController
  skip_before_action :authorize, only: :create

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      user.regenerate_token
      render json: {id: user.id, name: user.name,email: user.email,role: user.role, token: user.token}, status: :ok
    else
      respond_unauthorized("Incorrect email or password")
    end
  end

  def destroy
    current_user.invalidate_token
    head :ok
  end    
end

