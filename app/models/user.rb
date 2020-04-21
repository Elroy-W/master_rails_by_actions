class User < ApplicationRecord
  authenticates_with_sorcery!

  attr_accessor :password, :password_confirmation

  validates_presence_of :email, message: "Email address can not be blank!"
  validates_format_of :email, message: "Email address is invalid!", 
  with: /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/,
  if: proc { |user| !user.email.blank? }
validates :email, uniqueness: true


  validates_presence_of :password, message: "Password can not be blank！", 
    if: :need_validate_password
  validates_presence_of :password_confirmation, message: "Please confirm your password",
    if: :need_validate_password
  validates_confirmation_of :password, message: "Password does not match to confirm password",
    if: :need_validate_password
  validates_length_of :password, message: "Passwords must have at least 6 characters！", minimum: 6,
    if: :need_validate_password

      def username
        self.email.split('@').first
    end

  private
  def need_validate_password
    self.new_record? || 
      (!self.password.nil? || !self.password_confirmation.nil?)
  end
end