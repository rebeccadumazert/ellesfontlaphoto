class ConseilsVideo < ApplicationRecord
  has_one_attached :image
  has_one_attached :video
  validate :correct_type_attachment

  validates :video, presence: true

  has_one :notation_conseils_video

  has_one_attached :video
  acts_as_taggable_on :tags, :category

  CONSEIL_CATEGORIES = [
    "promotion et commercial",
    "administratifs et financiers",
    "artistiques et techniques",
    "égalité et inclusion",
  ]

  CONSEIL_TAGS = ["Commencer mon activité", "Me former"]

  VIDEO_FORMAT = {
    "Verbatim": "Un jour, on m'a dit que…",
    "Thématique": "La première fois que...",
    "Témoignage": "Déclic, témoignage"
  }

  def correct_type_attachment
    if image.attached? && !image.content_type.in?(%w(image/jpg image/jpeg image/png))
      errors.add(:image, "L'image doit être au format png ou jpeg/jpg")
    end
    if video.attached? && !video.content_type.in?(%w(video/mp4))
      errors.add(:video, "La vidéo doit être au format mp4 et ne doit pas depasser 100MB ")
    end
  end

end
