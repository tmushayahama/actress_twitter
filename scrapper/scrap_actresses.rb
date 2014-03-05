require 'nokogiri'
require 'open-uri'
require 'openssl'

url = "http://en.wikipedia.org/wiki/List_of_American_film_actresses"
data = Nokogiri::HTML(open(url))
actress_list =  data.css(".div-col li")
actress_list.each do |actress|
	puts actress.at_css('a').text.strip
end

url2 = "https://twitter.com/search?q=Selena%20Gomez&mode=users"
data2 = Nokogiri::HTML(open(url2, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE))
puts data2.css(".verified")[1].next_element.text