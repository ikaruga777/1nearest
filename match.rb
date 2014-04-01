
require 'net/http'
require 'uri'
require 'json'
#require './near.rb'
#users =  %w{ikaruga FM}

class Playdatas
	
	def initialize(users)
		@datas = Array.new()
		users.each do |user|
			@datas << (JSON.parse(getjson(user)))
		end	
	end
	def getjson(user)
		uri = URI.parse('http://sdvx-s.coresv.com/user/'+ user +'.json')
		return Net::HTTP.get(uri)
	end

	def show_data(datas)
		puts @datas["profile"]["name"].to_s
		@datas["profile"]["tracks"].each do|track|
			puts track["title"]
			puts track["exhaust"]["highscore"]
		end
	end

	def show_winner(index)
		
		winner_index = @datas.each_with_index.max_by {|data,i|
			data["profile"]["tracks"][index]["exhaust"]["highscore"].to_i
		}.last
		return @datas[winner_index]["profile"]["name"]	
	end
	def compare()
		if @datas.count <= 1 then 
			return
		end	
		@datas.each do |data|
			printf("%12s",data["profile"]["name"])
		end
		puts ""
		winners = Array.new()
		scores = Array.new()
		@datas[0]["profile"]["tracks"].each_with_index do |track,index|
			printf("%12s",track["title"])
			puts ""
			@datas.each do |data|
				score=data["profile"]["tracks"][index]["exhaust"]["highscore"]	
				printf("%12s", score)
				scores.push(score)
			end
			winner=show_winner(index)
			printf("%12s",winner)
			winners.push(winner)
			puts ""
		end
		@datas.each_with_index do |data,i|
			printf("%12s",winners.select{|p|p==data["profile"]["name"]}.count())
		end
		printf("%12s",winners.count())
		puts ""
	#puts playdatas[1]["profile"]["tracks"]
	end
end	

def main
	users = ARGV
	if users.empty?
		puts "input user names"
		return
	end
	playdatas = Playdatas.new(users)
	playdatas.compare()
end
main()
	
