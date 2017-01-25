Bot.on :postback do |postback|

# 取得基本資料
	# 找到或建立user
	sender_id = postback.sender["id"]
	user = User.where(sender_id:sender_id).first_or_create(sender_id:  sender_id)
	# 載入或創造語音包
	voice_controller = user.using_voice_package.name_en

	# Start 按鈕事件
	if postback.payload == 'Welcome'
		postback.reply(
			attachment: {
				type: 'template',
				payload: {
					template_type: 'button',
					text: '安安你好，我是幹話瘦身機器人，先幫你算個基礎代謝量，平常運動量如何？',
					buttons: [
						{ type: 'postback', title: '能不動就不動', payload: 'Exercise_1' },
						{ type: 'postback', title: '偶爾動一動', payload: 'Exercise_2' },
						{ type: 'postback', title: '過動', payload: 'Exercise_3' },
					]
				}
			}
		)

	end
	if postback.payload == 'Exercise_1'
		user.update(exercise:30)
		postback.reply(
			text: '好，那你的體重呢？(會幫你保密的，放心)'
		)
	elsif postback.payload == 'Exercise_2'
		user.update(exercise:35)
		postback.reply(
			text: '好，那你的體重呢？(會幫你保密的，放心)'
		)
	elsif postback.payload == 'Exercise_3'
		user.update(exercise:40)
		postback.reply(
			text: '好，那你的體重呢？(會幫你保密的，放心)'
		)
	end

	if postback.payload == 'Help'
		postback.reply(
				text:'功能解說：

1.輸入『食物』，例如：乾麵，就可以記錄那個食物的熱量，並得到籌碼
2.輸入『食物？』，例如：牛奶？ 就可以查某個食物的熱量
3.輸入『刪除』 就可以刪除上一筆記錄
4.輸入『查詢』就可以查詢今天吃東西的狀況
5.想看美美der紀錄圖表，或是其他服務，可以上我們的網站 https://firstmealbot.herokuapp.com/shop?id='+user.id.to_s+'

6.如果有任何想跟小編說的話，就在前面加上『＠』，我們會用最快的速度回覆你喲！'
		)
	end

	if postback.payload == 'Edit_info'
		postback.reply(
			text: '請上我們的網站更新呦：https://firstmealbot.herokuapp.com/diary?id='+user.id.to_s
		)
	end

	

	if postback.payload == 'Delete'
		food = user.foods.last
		if food.present?
			postback.reply(
				attachment: {
					type: 'template',
					payload: {
						template_type: 'button',
# 確認刪除 delete_confirm
						text: I18n.t(voice_controller+'.delete_confirm',full_record:food.full_record),
						buttons: [
							{ type: 'postback', title: '確定', payload: 'Delete_Comfirm' },
							{ type: 'postback', title: '不要', payload: 'Delete_Cancel' },
						]
					}
				}
			)
		else

# 沒有記錄 delete_no_record
			message.reply(
				text: I18n.t(voice_controller+'.delete_no_record')
			)
		end
		
	end

	if postback.payload == 'Delete_Comfirm'
		food = user.foods.last
		full_record = food.full_record
		food.destroy
# 成功刪除 delete_done
		postback.reply(
			text: I18n.t(voice_controller+'.delete_done',full_record:food.full_record)
		)
	end

# 查不到的東西是食物
	if postback.payload == 'Is_food'

		food = user.foods.where(unknown: true).last
		
		# 回覆已經記錄好惹
		postback.reply(	text: '記錄好惹 '+food.full_record)

		# 告訴 admin 有人查不到食物	
		Bot.deliver({
			recipient: { id: User.where(role:'admin').first.sender_id},
			message: {
				text: '有人要記錄資料庫裡沒有的食物拉! 他叫'+user.name+'，他說： '+food.full_record
			}
		}, access_token: ENV['ACCESS_TOKEN'])
	end

# 查不到的東西不是食物
	if postback.payload == 'Not_food' 
		user.foods.where(unknown: true).last.destroy
		postback.reply(
			text: '...太寂寞嗎，想聊天的話句子前面先打個 @ 小編就會回你呦！有其他問題可以打「教學」<3  '
		)
	end



	if postback.payload == 'Delete_Cancel'

# 取消刪除 delete_cancel
		postback.reply(
			text: I18n.t(voice_controller+'.delete_cancel')
		)
	end

	if postback.payload == 'Web_diary'
		postback.reply(
			text: '在這個舞台上會給你們帶來各位滿滿的大 平 台 <3 '
		)
		postback.reply(
			text: '輕輕按下去：https://firstmealbot.herokuapp.com/diary?id='+user.id.to_s
		)
	end

	if postback.payload == 'Web_shop'
		postback.reply(
			text: '想要讓我口氣好一點嗎 <3 買個語音包試試：https://firstmealbot.herokuapp.com/shop?id='+user.id.to_s
		)
	end

	if postback.payload == 'Food_search_correct'
		user.food_searches.last.update(correct: true)
		postback.reply(
			text: '這超簡單，根本一塊蛋糕(250卡)。'
		)
	end

	if postback.payload == 'Food_search_incorrect'
		user.food_searches.last.update(correct: false)

		# 告訴 admin 有人查不到食物	
		Bot.deliver({
			recipient: { id: User.where(role:'admin').first.sender_id},
			message: {
				text: '有人查不到食物拉! 他叫'+user.name+'，他說： '+user.food_searches.last.text
			}
		}, access_token: ENV['ACCESS_TOKEN'])

		postback.reply(
			text: "...好，我跟小編說了，你等他一下 o'_'o"
		)
	end


	


	

end
