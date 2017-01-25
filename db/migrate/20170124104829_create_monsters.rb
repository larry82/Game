class CreateMonsters < ActiveRecord::Migration
  def change
    create_table :monsters do |t|
      t.string :name
      t.integer :attack
      t.integer :hp
      t.integer :level
      t.integer :exp
      t.string :category
      t.string :info

      t.timestamps null: false
    end
  end
end
