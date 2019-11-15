class Event < ApplicationRecord
  validates :start_date, presence: true
  validate :start_must_be_future
  validates :duration,
    presence: true,
    numericality: { only_integer: true, greater_than: 0 }
  validate :duration_must_be_multiple_of_5
  validates :title,
    presence: true,
    length: { minimum: 5, maximum: 140 }
  validates :description,
    presence: true,
    length: { minimum: 20, maximum: 1000 }
  validates :price,
    presence: true,
    numericality: { only_integer: true, greater_than: 1, less_than_or_equal_to: 1000 }
  validates :location, presence: true

  belongs_to :admin, class_name: "User"

  has_many :participations, dependent: :destroy
  has_many :participants, through: :participations, class_name: "User"

  has_many_attached :event_image

  def end_date
    start_date + 60 * duration
  end

  private

  #Valider que la date de début est bien dans le futur
  def start_must_be_future #A utilser à l'occasion
    return if start_date.blank? #On sort de la boucle si start_date est vide

    if start_date < Time.now
      errors.add(:start_date, "cannot be past")
    end
  end

  #Duration is multiple of 5
  def duration_must_be_multiple_of_5
    return if duration.blank? #On sort si la fonction est vide

    if duration % 5 != 0
      errors.add(:duration, "Duration has to be multiple of 5")
    end

  end


end
