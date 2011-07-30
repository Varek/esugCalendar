require 'open-uri'
require 'nokogiri'
require 'csv'

# Get a Nokogiri::HTML:Document for the page we’re interested in...

doc = Nokogiri::HTML(open('data/talks.html'))

# Do funky things with it using Nokogiri::XML::Node methods...

####
# Search for nodes by css
# doc.css('h3.r a.l').each do |link|
#   puts link.content
# end
# 
# ####
# # Search for nodes by xpath
CSV.open("data/talks.csv", "wb") do |csv|
doc.xpath('//div[@class="contents"]/ul[1]/li').each do |talk|
	title = talk.children[1].content
	namesArray = talk.children[2].content.delete(',').split(' ').reject{|elem| elem.eql?('by') or elem.eql?('administered') or elem.eql?('and')}
	name = namesArray.slice!(0, 2)
	namesTemp = []
	until name.nil? or name.empty?
 		namesTemp << name.join(' ') 
 		name = namesArray.slice!(0, 2)
 		end
 	names = namesTemp.join('#')
 	csv << [title, names]
	end
	end
# 
# ####
# # Or mix and match.
# doc.search('h3.r a.l', '//h3/a[@class="l"]').each do |link|
#   puts link.content
# end