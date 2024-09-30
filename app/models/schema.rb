class Schema < ApplicationRecord
  belongs_to :dataset
  validates :structure, presence: true
end