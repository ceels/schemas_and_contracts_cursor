class AddCsvFileToDatasets < ActiveRecord::Migration[7.0]
  def change
    add_column :datasets, :csv_file, :string
  end
end
