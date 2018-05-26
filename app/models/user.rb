class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  include ActiveRecord::SecureToken::ClassMethods       
  before_create :generate_authentication_token, :set_active

  validates_presence_of :first_name, :email, :encrypted_password, on: :create
  validates_uniqueness_of :email, on: :create

  class << self

  	def created? user_params
  		return false if !user_params.present?
  		begin
  			return User.create(user_params)
  		rescue => e
  			Error.report_errors("Exception::User.created? -> #{e.class}, error_message: #{e.message}")
  		end
  		false
  	end

  	def by_email email_id
  		return email_id.present? ? find_by(email: email_id.strip) : nil
  	end

  end

  protected
  def generate_authentication_token
  	self.authentication_token = generate_unique_secure_token		
  end

  def set_active
  	self.active = true
  end       
end
