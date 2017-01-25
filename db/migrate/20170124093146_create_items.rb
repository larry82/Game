class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :info
      t.integer :atk
      t.integer :def

      t.timestamps null: false
    end
  end
end
