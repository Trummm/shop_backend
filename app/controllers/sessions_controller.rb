  class SessionsController < ApplicationController
    def create
      user = User.find_by(email: params[:email])

      if user&.authenticate(params[:password])
        token = user.generate_token
        user.update(token: token)
        render json: { token: token }
      else
        render json: { error: 'Invalid email or password' }, status: :unauthorized
      end 
    end
  
    def destroy
      if @current_user
        @current_user.update(token: nil, token_expires_at: nil)
        render json: { message: 'Logged out successfully' }
      else
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end 
    end
  end
