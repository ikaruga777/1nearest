
def get_1near_score(music , score , type = 2)
	near =  ( 10000000 - (10000000 / getchain(music , type) ) / 2 ) 
	get_1near_score =	10000000 - near
	puts near
end

def getchain(music , type)
	return 2403
end

get_1near_score("dummy", 10000000 )

