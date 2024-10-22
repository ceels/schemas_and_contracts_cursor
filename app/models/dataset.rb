  class Dataset < ApplicationRecord
    has_one :schema, dependent: :destroy
    has_one_attached :csv_file
  
    validates :name, presence: true
    validates :source, presence: true
    validates :csv_file, presence: true
  
    # Remove the data_sample validation if you no longer need it
    # validates :data_sample, presence: true
  end
