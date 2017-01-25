class CreateUserItems < ActiveRecord::Migration
  def change
    create_table :user_items do |t|
      t.references :user, index: true, foreign_key: true
      t.references :item, index: true, foreign_key: true
      t.integer :number
      t.boolean  :equipted, default: false

      t.timestamps null: false
    end
  end
end
