require 'nokogiri'
require 'open-uri'

url = "http://en.wikipedia.org/wiki/List_of_American_film_actresses"
data = Nokogiri::HTML(open(url))
actress_list =  data.css(".div-col li")
actress_list.each do |actress|
	puts actress.at_css('a').text.strip
end