#Actress Twitter

This a Ruby on Rails practice project for some serious web crawling.

##Before  Downloading
Please visit some tutorials for a basic Ruby on Rails (RoR) Project set-up. 
For windows the one I used was http://www.youtube.com/watch?v=-umoWOjJ3gc

##Additional Gemfiles Needed

After you have successfully finished the set-up, download the following additional gems
+ Nokogiri
+ Openssl 

##Quickstart
You are ready to go.
The seed.rb file contains all the code you need to populate the database with actresses and their twitter accounts if they have one. For the interested, take a look at how the code works

To populate the db, simply run 
    rake gb::setup

##The Implementation
I used Nokogiri to download the html for the Wikipedia Page containing a list of actresses by their full names

+ Get the actress names from Wikipedia. The parent class of the actress name list is "div-col" which contains only actresses names.
+ Iterate through each actress and search the twitter page
  - Look at the class called "verified" in the resulting html after a search
  - The second set is the one we want
  - Get the next element "span" which has a text of actress' twitter
  - Verify if the full name on twitter matches the full name on the Wikipedia list
   * The previous.previous element is the one which contains the full name
		
##Limitations

This method is limited in the following cases.
+ If an actress' full name is different from the one on twitter, then we cannot retrieve their twitter account.
+ If an actress is not verified on twitter, but she actually has a twitter account, then we cannot add any unverified twitter account to our database.

##Tips

When searching for someone on twitter, remember to remove the space in between so that twitter will not assume you meant "and" i.e. Searching for "Caroline Aaron"
will yield Steve Begleiter ‏twitter account who has chldren named Caroline and Aaron


##Enjoy!!

