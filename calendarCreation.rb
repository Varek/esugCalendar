require 'csv'
require 'active_support/core_ext'
require 'ri_cal'
require 'tzinfo'



# 	puts talks.join('*')
 

cal = RiCal.Calendar do |cal|
	CSV.foreach("data/talks.csv") do |talks|
  	cal.event do |event|
    	event.summary     = talks.join(' -- ')
    	event.description = ""
    	event.dtstart     = Time.parse("2011-08-22T09:00:00").set_tzid('Europe/London')
    	event.dtend       = Time.parse("2011-08-22T10:00:00").set_tzid('Europe/London')
    	#event.location    = "Cape Canaveral"
    	#event.add_attendee  ""
    	#event.url         = "http://nasa.gov"
  	end
  end
end


aFile = File.new("talks.ics", "w")
aFile.write(cal.export)
aFile.close
#puts cal.to_s