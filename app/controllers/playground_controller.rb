class PlaygroundController < ApplicationController
	def index
		@user  = User.first
		@character = @user.characters.first
		@items = @user.items
		@equips = @user.user_items.where(equipted: true).all
	end

	def search_for_monsters
		@user  = User.first
		@character = @user.characters.first
		@monsters = Monster.all
	end

	def engage
		@character = Character.find(params[:character_id])
		@monster = Monster.find(params[:monster_id])
		@rounds_character_attack = (@monster.hp/@character.atk.to_f)
		@rounds_monster_attack = (@character.hp/@monster.attack.to_f)
		
		if @rounds_character_attack <= @rounds_monster_attack
			@result = '贏了'
			@character.add_exp_and_check_level_up(@monster.exp)

		else 
			@result = '輸了'
		end	

	end

end
