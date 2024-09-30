class Dataset < ApplicationRecord
    has_one :schema, dependent: :destroy
    validates :name, presence: true
    validates :source, presence: true
    validates :data_sample, presence: true
  end