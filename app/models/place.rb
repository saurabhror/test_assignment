class Place < ApplicationRecord
  belongs_to :user, optional: true
  validates :place_name, presence: true
  after_create :notify_manager
  after_update :notify_team

  def notify_manager
    team = self.user
    user = User.find_by(id: team.manager_id)
    UserMailer.notify_manager_mail(user, team, self).deliver_now if user
  end

  def notify_team
    user_ids = Place.where(place_name: place_name).pluck(:user_id)

    User.where(id: user_ids).each do |team|
      UserMailer.notify_team_mail(team, self).deliver_now
    end

  end


end
