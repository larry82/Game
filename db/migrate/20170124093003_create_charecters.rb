class CreateCharecters < ActiveRecord::Migration
  def change
    create_table :charecters do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.integer :level
      t.integer :exp
      t.integer :atk
      t.integer :def
      t.integer :hp
      t.integer :mp
      t.string :job

      t.timestamps null: false
    end
  end
end
