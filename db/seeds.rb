# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
require 'nokogiri'
require 'open-uri'
require 'openssl'
require 'uri'

#the url for the Wikipedia Page list of actresses
wikipedia_actresses_url = "http://en.wikipedia.org/wiki/List_of_American_film_actresses"
actresses_data = Nokogiri::HTML(open(wikipedia_actresses_url))

# div class of ".div-col" contains only actresses names
actress_list =  actresses_data.css(".div-col li")

#iterate through each actress and search the twitter page
#there is a class called .verified in the result html after a search
#the first is the one we want
#get the next element "span" which has a text of actress' twitter
actress_list.each do |actress|
  #this is where the actress name is from the Wikipedia
  actress_name = actress.at_css('a').text.strip

  #There was a problem with spaces and some of the characters on actress names
  #It was causing a bad uri error
  #Solution is to use the URI::encode and then parse
  #remember to remove the space in between so that twitter will not assume you meant "and" i.e. Searching for "Caroline Aaron"
  #will yield Steve Begleiter ‏twitter account who has chldren named Caroline and Aaron
  twitter_search_url = URI::encode("https://twitter.com/search?q="+actress_name.gsub(" ", "")+"&mode=users")
  URI.parse(twitter_search_url)
  twitter_search_data = Nokogiri::HTML(open(twitter_search_url, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE))

  #this is where the verified account class is located, ignore all other. Check if the full name matches the actress name
  verified_icon_class = twitter_search_data.css(".verified")[1]
  
  #refer to twitter div class and see how it is structured. I used the next_element to locate the screen name
  #I used 2 previous_element methods to verify if the name == the actress full name
  if !verified_icon_class.next_element.nil? && !verified_icon_class.previous_element.previous_element.nil?
    screen_name_class = verified_icon_class.next_element
    fullname = verified_icon_class.previous_element.previous_element
    #Does fullname of the verified badge match the actress name
    if fullname.text.strip.upcase==actress_name.upcase
      # remove the first '@' symbol
      twitter_account_name = screen_name_class.text.strip.gsub(/^\@/, "")
      t = TwitterAccount.create(:actress=>actress_name, :twitter_url=>twitter_account_name)
      puts actress_name+" | "+twitter_account_name
    end
  else
    t = TwitterAccount.create(:actress=>actress_name, :twitter_url=>nil)
    puts actress_name
  end
end
