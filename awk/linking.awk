BEGIN {
	FS=OFS=";"
	# linking rules (field match)
	split("2|3|4",rules,"|") 
	print "URL_SOURCE;URL_CIBLE"
		
}
#NR==FNR #Only true when in the first file  
{
#     print FNR"-"NR"-"$0
	if(FNR==NR){ #Only true when in the first file 
		sources[$0]=3 # 3 is the max links number per source
	#	print $0
	}
	else{ # second file
		nb_links = 2 # TODO; build priorisation
		split($0,t,FS)
		print "Linking target :"$1
		for(r = 1; r <= length(rules) && nb_links > 0; r++ ){	
			f_idx = rules[r];
			print "Matching field index :"f_idx 
			for(i in sources){
				split(i,s,FS)
				if(sources[i]>0 && s[1]!=t[1]){ # Sources is available and  Do not link url with herself
					if(t[f_idx]==s[f_idx]){
						#print i"****"$0
						print s[1],t[1] 	
						nb_links--
						sources[i]--
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
