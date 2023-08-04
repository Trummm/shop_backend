class ApplicationController < ActionController::API
  before_action :authenticate_request, unless: :login_request?

  def current_user
    token = request.headers['Authorization']&.split(' ')&.last

    return unless token

    user_id = User.decode_token(token)
    @current_user = User.find_by(id: user_id) if user_id
  end 

  private
  def authenticate_request
    token = request.headers['Authorization']&.split(' ')&.last
    return render json: { error: 'Unauthorized' }, status: :unauthorized unless token

    user_id = User.decode_token(token)
    @current_user = User.find_by(id: user_id)

    return render json: { error: 'Unauthorized' }, status: :unauthorized unless @current_user
  rescue JWT::DecodeError
    render json: { error: 'Invalid token' }, status: :unauthorized
  end

  def login_request?
    controller_name == 'sessions' && action_name == 'create'
  end
end 
          