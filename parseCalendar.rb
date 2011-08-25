require 'csv'
require 'active_support/core_ext'
require 'ri_cal'
require 'tzinfo'



# 	puts talks.join('*')
calendar = 0
talks = []
File.open("betterTalks.ics", "r") do |file|
	calendar = RiCal.parse(file)[0]
end
CSV.foreach("data/talks.csv") do |talk|
	talks << talk 
end

# calendar.x_properties.each do |prop|
# 	prop[1] = prop[1][0]
# 	puts prop[1]
# end
#calendar.name=()
 calendar.events.each do |event|
	talk = talks.assoc(event.summary.split(' -- ')[0])
	unless talk.nil?
 		event.url=(talk[2])
 	else
 		event.url=('http://www.esug.org/wiki/pier/Conferences/2011/Schedule-And-Talks')
 	end
 	#puts event
end

 aFile = File.new("testtalks.ics", "w")
 aFile.write(calendar.export)
 aFile.close

# cal = RiCal.Calendar do |cal|
# 	CSV.foreach("data/talks.csv") do |talks|
#   	cal.event do |event|
#     	event.summary     = talks.join(' -- ')
#     	event.description = ""
#     	event.dtstart     = Time.parse("2011-08-22T09:00:00").set_tzid('Europe/London')
#     	event.dtend       = Time.parse("2011-08-22T10:00:00").set_tzid('Europe/London')
#     	#event.location    = "Cape Canaveral"
#     	#event.add_attendee  ""
#     	#event.url         = "http://nasa.gov"
#   	end
#   end
# end
# 
# 
# 
# #puts cal.to_s