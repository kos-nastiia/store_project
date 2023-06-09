class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :title,  null: false
      t.text :description
      t.decimal :price,  precision: 8, scale: 2, null: false, default: 0.0
      t.integer :balance, null: false, default: 0

      t.timestamps
    end
  end
end
