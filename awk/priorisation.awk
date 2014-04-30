BEGIN
{
	FS=OFS=";"
	max_source_links=25
	sum_points=0
	nb_sources=0
	nb_targets=0
}
{
    if(FNR==NR){ # first file
        nb_sources++
        ##print $1,max_source_links > "prioritized_sources.csv"
	}
	else{ # second file
	    points=10
	    pop=$23
        #check population level
        if(pop > 0 && pop <= 10 ){
            points += 20
        }
        else if(pop > 10 && pop <= 20){
            points += 30
        }
        else{ # Default
            points += 10
        }
        sum_points+=points
        targets[nb_targets++] = $0
        points[nb_targets] = points
	}
}
END
{
    point_price = int(sum_points/max_source_links*nb_sources)
    for( i = 1 ; i <= nb_targets ; i++)
        print targets[i],points[i]*point_price #> "prioritized_targets.csv"
}