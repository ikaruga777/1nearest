
require 'net/http'
require 'uri'
require 'json'


#users =  %w{ikaruga FM}

def getjson(user)
	uri = URI.parse('http://sdvx-s.coresv.com/user/'+ user +'.json')
	getjson = Net::HTTP.get(uri)
end

def main
	users = ARGV
	if users.empty?
		puts "input user names"
		return
	end
	
	parsed = JSON.parse(getjson(users[0]))
	parsed["profile"]["tracks"].each do|track|
		puts track["title"]
		puts track["exhaust"]["highscore"]
	end
end

main()
	
