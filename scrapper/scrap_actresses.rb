require 'nokogiri'
require 'open-uri'
require 'openssl'
require 'uri'

#the url for the Wikipedia Page list of actresses
url = "http://en.wikipedia.org/wiki/List_of_American_film_actresses"
data = Nokogiri::HTML(open(url))

# to narrow down the search of the "li" div class of ".div-col" contains only actresses names
actress_list =  data.css(".div-col li")

#iterate through each actress and search the twitter page
#there is a class called .verified in the result html after a search
#the first is the one we want
#get the next element "span" which has a text of Selena's twitter 
actress_list.each do |actress|
	#this is where the actress name is from the Wikipedia
	actress_name = actress.at_css('a').text.strip
	
	#There was a problem with spaces and some of the characters on actress names
	#It was causing a bad uri error
	#Solution is to use the URI::encode and then parse
	url2 = URI::encode("https://twitter.com/search?q="+actress_name+"&mode=users")
	URI.parse(url2)
	data2 = Nokogiri::HTML(open(url2, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE))
	
	#this is where the verified account is located, ignore all other.
	twitter_account = data2.css(".verified")[1].next_element
	
	if !twitter_account.nil?
		puts actress_name+"| "+twitter_account
	else
		puts actress_name
	end
end