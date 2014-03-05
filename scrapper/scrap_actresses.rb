require 'nokogiri'
require 'open-uri'
require 'openssl'
require 'uri'

url = "http://en.wikipedia.org/wiki/List_of_American_film_actresses"
data = Nokogiri::HTML(open(url))
actress_list =  data.css(".div-col li")
actress_list.each do |actress|
	actress_name = actress.at_css('a').text.strip
	#actress_name.gsub! " ", "%20"
	url2 = URI::encode("https://twitter.com/search?q="+actress_name+"&mode=users")
	URI.parse(url2)
	data2 = Nokogiri::HTML(open(url2, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE))
	twitter_account = data2.css(".verified")[1].next_element
	if !twitter_account.nil?
		puts actress_name+"| "+twitter_account
	else
		puts actress_name
	end
end