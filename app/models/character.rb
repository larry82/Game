class Character < ActiveRecord::Base
  belongs_to :user

	def require_exp_for_level_up
		LvManagement.where(level:self.level).first.require_exp
	end


  def add_exp_and_check_level_up(monster_exp)
  	self.update(exp: self.exp+monster_exp )
  	charecter_exp   = self.exp
  	charecter_level = self.level

  	lv_management = LvManagement.where(level:charecter_level).first

  	# 經驗值夠了就升級
  	if charecter_exp >= lv_management.require_exp 
  		self.update(
  			exp: (charecter_exp - lv_management.require_exp),
  			level: charecter_level+1
  		)
  	end


  end

end
