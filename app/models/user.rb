class User < ApplicationRecord
  has_many :products
  has_one :cart, dependent: :destroy
  has_many :cart_items, through: :cart
  has_secure_password

  def generate_token
    payload = { user_id: id }
    self.token_expires_at = Time.current + 1.days
    save
    JWT.encode(payload, MyJwtConfig::JWT_SECRET, 'HS256')
  end

  def self.decode_token(token)
    decoded_token = JWT.decode(token, MyJwtConfig::JWT_SECRET, true, algorithm: 'HS256')
    decoded_token[0]['user_id']
  end 
end
