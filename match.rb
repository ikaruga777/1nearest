
require 'net/http'
require 'uri'
require 'json'

uri = URI.parse('http://sdvx-s.coresv.com/user/ikaruga.json')
json = Net::HTTP.get(uri)
parsed = JSON.parse(json)
parsed["profile"]["tracks"].each do|track|
	puts track["title"]
end


	
