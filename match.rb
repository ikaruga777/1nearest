
require 'net/http'
require 'uri'
require 'json'
#require './near.rb'
#users =  %w{ikaruga FM}


def getjson(user)
	uri = URI.parse('http://sdvx-s.coresv.com/user/'+ user +'.json')
	getjson = Net::HTTP.get(uri)
end
def show_data(playdata)
	puts playdata["profile"]["name"].to_s
	playdata["profile"]["tracks"].each do|track|
		puts track["title"]
		puts track["exhaust"]["highscore"]
	end
end
def compare(playdatas)
	if playdatas.count <= 1 then 
		return
	end	
	playdatas.each do |playdata|
		printf("%12s",playdata["profile"]["tracks"][1])
	end
	playdatas.each do |playdata|
		printf("%12s",playdata["profile"]["name"])
	end
	puts ""
	playdatas.each_with_index do |playdata,i|
		printf("%12s", playdata["profile"]["tracks"][i]["exhaust"])
	end
	puts ""
#puts playdatas[1]["profile"]["tracks"]
end

def main
	users = ARGV
	if users.empty?
		puts "input user names"
		return
	end
	playdatas= Array.new
	users.each do |user|
		playdatas.push(JSON.parse(getjson(user)))
		playdatas.each do |playdata|
			show_data(playdata)
		end
	end
	#compare(playdatas)
end
main()
	
