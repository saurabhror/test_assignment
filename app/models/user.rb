class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  after_create :send_invitation_mail
  has_many :places, dependent: :destroy

  def send_invitation_mail
    update_attribute(:reset_token_digest, generate_token)
    UserMailer.invitation_mail(self).deliver_now if !is_manager
  end

  def generate_token
    SecureRandom.hex(10)
  end

end
