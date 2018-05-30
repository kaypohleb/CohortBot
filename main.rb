require 'telegram/bot'
# dependencies to install: telegram-bot-api
require_relative 'calendarqs.rb'
require_relative 'events.rb'

token = '579880565:AAHSDFejcoQOgm2XDjCR7q5h3RuBbZv-3y4'

Telegram::Bot::Client.run(token) do |bot|
    
    bot.listen do |message|

        case message.text
         when '/start'
            bot.api.send_message(chat_id: message.chat.id, parse_mode: 'HTML',
                text:"Hello, #{message.from.first_name} \nI can help you look up and edit your calendar for you \n/today \t/week \t/tomorrow")
         when '/today'
            bot.api.send_message(chat_id: message.chat.id, parse_mode:"HTML", 
                text:"#{Calendarqs.get_items('today')}")
                message.text=""
         when '/week'
            bot.api.send_message(chat_id: message.chat.id, parse_mode: 'HTML',
               text: "#{Calendarqs.get_items('week')}")
            message.text=""
        when '/tomorrow'
            bot.api.send_message(chat_id: message.chat.id, parse_mode: 'HTML',
               text: "#{Calendarqs.get_items('tomorrow')}")
            message.text=""
        when'/event'
            event=Event.new(bot,message)
            event.start_planning
            bot.api.send_message(chat_id: message.chat.id, text: "#{calendarqs.add_event(event.event_details)}")
            message.text=""        
                
        end
    end
end
