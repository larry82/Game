class CreateItemEffects < ActiveRecord::Migration
  def change
    create_table :item_effects do |t|
      t.references :item, index: true, foreign_key: true
      t.string :name
      t.string :category
      t.integer :number

      t.timestamps null: false
    end
  end
end
