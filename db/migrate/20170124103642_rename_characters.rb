class RenameCharacters < ActiveRecord::Migration
  def change
  	rename_table :charecters ,:characters
  end
end
