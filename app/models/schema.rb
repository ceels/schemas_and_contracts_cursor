class Schema < ApplicationRecord
  belongs_to :dataset
  validates :structure, presence: true

  # Ensure the structure is always stored as JSON
  def structure=(value)
    super(value.is_a?(String) ? JSON.parse(value) : value)
  end
end
