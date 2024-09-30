class CreateSchemas < ActiveRecord::Migration[7.0]
  def change
    create_table :schemas do |t|
      t.references :dataset, null: false, foreign_key: true
      t.json :structure

      t.timestamps
    end
  end
end
