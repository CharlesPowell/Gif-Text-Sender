require 'bundler'
require 'nokogiri'
require 'open-uri'
require 'nexmo'
Bundler.require()


get '/' do
  erb :index
end

post '/gif' do
  query = params[:query]
  number = params[:number]
  search(query)

  nexmo = Nexmo::Client.new(key: ENV['key'], secret: ENV['secret'])
  nexmo.send_message(from: ENV['from'], to: number, text: "#{@gif} end:")

  puts "#{@gif}"
  erb :index
end


def search(query)

    url = ("http://giphy.com/search/" + query)
    doc = Nokogiri::HTML(open(url))
    @gif = doc.css(".unloaded")[0]['data-animated']

end
