class Participation < ApplicationRecord
  belongs_to :event
  belongs_to :participant, class_name: "User"

  after_create :new_participant_email

  def new_participant_email
    ParticipationMailer.new_participant_email(self.participant,self.event).deliver_now
  end
end
