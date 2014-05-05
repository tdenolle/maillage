BEGIN {
	FS=OFS=";"
	# linking rules (field match)
	split("5|9|11",rules,"|")
	print "URL_SOURCE;URL_CIBLE"
		
}
function match_field(rule,val1,val2){


}
{
	if(FNR==NR){ #Only true when in the first file
		sources[$0]=25 # 25 is the max links number per source
	}
	else{ # second file
		nb_links = 10 # TODO; build priorisation
		split($0,t,FS)
		#print "Linking target :"$1
		for(r = 1; r <= length(rules) && nb_links > 0; r++ ){	
			f_idx = rules[r];
			#print "Matching field index :"f_idx
			for(i in sources){
				split(i,s,FS)
				if(sources[i]>0 && s[1]!=t[1]){ # Sources is available and  Do not link url with herself
					if(t[f_idx]==s[f_idx]){
						#print i"****"$0
						print s[1],t[1]
						nb_links--
						if(sources[i] > 1){
						    sources[i]--
						}else {
						    delete sources[i]
						}
					}
				}
				if(nb_links<=0)
					break;
			}
		}
	}
}
END{

}
