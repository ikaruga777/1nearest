require "open-uri"
require "rubygems"
require "nokogiri"

def parse_ranking_page(url)
	charset =nil
	html = open(url) do|f|
		charset = f.charset
		f.read
	end

	doc = Nokogiri::HTML.parse(html, nil,"cp932")

	players=doc.xpath("//div[@class='player_line']")
	players.each do |player|
	
		#title
		name=player.children.search("div[@class='playername']").text 
		score=player.children.search("div[@class='score']").text
		puts name + "\t" + score
	end
		
end

def main
	url="http://p.eagate.573.jp/game/sdvx/ii/p/ranking/ranking.html?type=2&id=s6%2Bd8VIwFljA5R3beEg5Qw%3D%3D&"
	puts url
	(1..10).each do |i|
		parse_ranking_page(url + "detail_page=" + i.to_s)
	end
end
main()

