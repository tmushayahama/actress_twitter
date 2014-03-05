require 'nokogiri'
require 'open-uri'
require 'openssl'

#this is just an example of getting Selena Gomez verified twitter account
#First we search for Selena Gomez
#there is a class called .verified in the result html
#the first is the one we want
#get the next element "span" which has a text of Selena's twitter 

selena_search_twitter_url = "https://twitter.com/search?q=Selena%20Gomez&mode=users"
selena_search_twitter_html = Nokogiri::HTML(open(selena_search_twitter_url, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE))
puts selena_search_twitter_html.css(".verified")[1].next_element.text