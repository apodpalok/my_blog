class Article < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :taggings
  has_many :tags, through: :taggings
  belongs_to :user
  has_attached_file :image, styles: { large: '600*600', medium: '300*300>', small: '100*100>' }
  validates :title, presence: true, length: { minimum: 5 }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
