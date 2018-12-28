class UserMailer < ApplicationMailer

  def invitation_mail(user)
    @user = user
    mail(to: @user.email, subject: "Welcome #{@user.name}" )
  end

  def notify_manager_mail(user, team, place)
    @user = user
    @team = team
    @place = place
    mail(to: @user.email, subject: "Welcome #{@user.name}" )
  end

  def notify_team_mail(team, place)
    @team = team
    @place = place
    mail(to: @team.email, subject: "Welcome #{@team.name}" )
  end


end
