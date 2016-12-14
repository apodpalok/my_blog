class Doctor < ApplicationRecord
  has_many :patients
  validates :name, presence: true
end
