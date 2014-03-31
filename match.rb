
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

def show_winner(playdatas,index)
	
	winner_index = playdatas.each_with_index.max_by {|playdata,i|
		playdata["profile"]["tracks"][index]["exhaust"]["highscore"].to_i
	}.last
	return playdatas[winner_index]["profile"]["name"]

end

def compare(playdatas)
	if playdatas.count <= 1 then 
		return
	end	
	playdatas.each do |playdata|
		printf("%12s",playdata["profile"]["name"])
	end
	puts ""
	winners = Array.new()
	scores = Array.new()
	playdatas[0]["profile"]["tracks"].each_with_index do |track,index|
		printf("%12s",track["title"])
		puts ""
		playdatas.each do |playdata|
			score=playdata["profile"]["tracks"][index]["exhaust"]["highscore"]	
			printf("%12s", score)
			scores.push(score)
		end
		winner=show_winner(playdatas,index)
		printf("%12s",winner)
		winners.push(winner)
		puts ""
	end
	playdatas.each_with_index do |playdata,i|
		printf("%12s",winners.select{|p|p==playdata["profile"]["name"]}.count())
	end
	printf("%12s",winners.count())
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
		#playdatas.each do |playdata|
		#	show_data(playdata)
		#end
	end
	compare(playdatas)
end
main()
	
