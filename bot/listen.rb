require "facebook/messenger"
include Facebook::Messenger


Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])

# 接受訊息
Bot.on :message do |message|

	# 得到基本資訊
	sender_id = message.sender["id"]
	text 	  = message.text
	text 	||= " "
	mid 	  = message.id




	# 辨別使用者行為
    if text.include?('回復圖片')
    	action = '回復圖片'

	elsif text.include?('回復選擇題')
		action = '回復選擇題'

	elsif text.include?('回復文字')
		action = '回復文字'
    	
	end


	# 根據行為處理
	
	# 回復文字
	if action == "回復文字"
		message.reply( 
			text: "輸入「？」查詢指令" 
		)
	end

	# 回復圖片
	if action == '回復圖片'
		message.reply( 
			attachment: {
				type: 'image',
				payload: {
					url: 'http://s2.quickmeme.com/img/c7/c76d5631d56b2873f68d5c8d2a3f989435ffd1a29e5866cae6701e5d8432cbf9.jpg'
				}
			}
		)
	end

	# 回復選擇題
	if action == "回復選擇題"
		message.reply(
			attachment: {
				type: 'template',
				payload: {
					template_type: 'button',
					text: '安安歡迎光臨，我先幫你算基礎代謝量，你平常運動量如何？',
					buttons: [
						{ type: 'postback', title: '只會坐著ㄎㄎ笑', payload: 'Exercise_1' },
						{ type: 'postback', title: '偶爾動一動', payload: 'Exercise_2' },
						{ type: 'postback', title: '運動少年', payload: 'Exercise_3' },
					]
				}
			}
		)
	end






	
end

# 設定

# 開始使用
Facebook::Messenger::Thread.set({
  setting_type: 'call_to_actions',
  thread_state: 'new_thread',
  call_to_actions: [
    {
      payload:'Welcome'
    }
  ]
}, access_token: ENV['ACCESS_TOKEN'])


# 開始使用的歡迎語
Facebook::Messenger::Thread.set({
  setting_type: 'greeting',
  greeting: {
    text: '全國首間熱量賭場上線拉！'
  },
}, access_token: ENV['ACCESS_TOKEN'])


# 漢堡 Menu
Facebook::Messenger::Thread.set({
  setting_type: 'call_to_actions',
  thread_state: 'existing_thread',
  call_to_actions: [
    {
      type: 'postback',
      title: '更改基本資料',
      payload: 'Edit_info'
    },
    {
      type: 'postback',
      title: '教學',
      payload: 'Help'
    },
    {
      type: 'postback',
      title: '刪除',
      payload: 'Delete'
    },
    {
      type: 'postback',
      title: '熱量報表大平台',
      payload: 'Web_diary'
    },
    {
      type: 'postback',
      title: '商店',
      payload: 'Web_shop'
    }

  ]
}, access_token: ENV['ACCESS_TOKEN'])



