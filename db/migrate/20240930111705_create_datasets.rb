class CreateDatasets < ActiveRecord::Migration[7.0]
  def change
    create_table :datasets do |t|
      t.string :name
      t.string :source
      t.json :data_sample

      t.timestamps
    end
  end
end