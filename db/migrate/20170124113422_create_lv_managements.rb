class CreateLvManagements < ActiveRecord::Migration
  def change
    create_table :lv_managements do |t|
      t.integer :level
      t.integer :require_exp

      t.timestamps null: false
    end

    (1..50).each do |i|

    	LvManagement.create(
    		level: i,
    		require_exp: 10*i+i*i*5,
   		)

	end



  end
end
