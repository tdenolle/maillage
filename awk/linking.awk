function match(criteria, source, target){
	switch(criteria) {
		# 1st criteria : same ID_LOCALITE and has one RUBRIQUE in common
		case 1:
			return source[2]==target[2] && has_list_item_in_common(source[7],target[7],"|");
		# 2nd criteria : same ID_DEPARTEMENT and has one RUBRIQUE in common
		case 2:
			return source[3]==target[3] && has_list_item_in_common(source[7],target[7],"|");
		# 3rd criteria : same ID_REGION and has one RUBRIQUE in common
		case 3:
			return source[4]==target[4] && has_list_item_in_common(source[7],target[7],"|");
		# 4st criteria : random
		case 3:
			return true;
		default:
			# Unknown criteria
			return false;
	}
}
function has_list_item_in_common(str1,str2,sep){
	split(str1,array1,sep)
	split(str2,array2,sep)
	for(a in array1){
		for(b in array2){
			if(a==b)
				return true;
		}
	}
	return false;
}
BEGIN {
	FS=OFS=";"
	# linking rules (field match)
	split("5|9|11",rules,"|")
	#print "URL_SOURCE;URL_CIBLE"
	start_time=systime()-1
}
#NR==FNR #Only true when in the first file
{
	if(FNR==NR){ # Source processing (first arg file)
		sources[$0]=$7 # $7 is the max links number per source
		#TODO : get the latest field value /
	}
else{ # Target Processing (second arg file)
		nb_links=200 # TODO : get latest field value
		split($0,t,FS)
		#if((int(FNR) % 100)==0)
		printf("[idx:%d][tps:%d][src:%d]Linking target:%s\n",FNR,int(FNR) / ( systime()-start_time  ),length(sources),$1) > "linking.log"
		for(r = 1; r <= 4 && nb_links > 0; r++ ){ #TODO : deal with criteria array
			#f_idx = rules[r];
			#print "Matching field index :"f_idx
			for(i in sources){
				split(i,s,FS)
				if(sources[i]>0 && s[1]!=t[1]){ # Sources is available and  Do not link url with herself
					if(match(r,s,t)){
						#print i"****"$0
						print s[1],t[1]
						nb_links--
						sources[i]--
						if(sources[i]<=0)
        			delete sources[i]
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
