BEGIN
{
	FS=OFS=";"
	max_source_links=25
	sum_points=0
	nb_sources=0
	nb_targets=0
	#split("23,50,between,1,22|23,500,between,31,41",criteria,"|")
	#djslqk
}
{
    if(FNR==NR){ # first file
        nb_sources++
        print $0,max_source_links > "prioritized_sources.csv"
	}
	else{ # second file
	    points=10
	    # population level criteria
	    pop=$23
        if(pop > 0 && pop <= 22 ){ # 0 à 9999 habitants
            points += 50
        }
        else if(pop >= 31 && pop <= 41){ # 10000 à 24999 habitants
            points += 500
        }
        else if(pop == 42){ # 25000 à 29999 habitants
            points += 600
        }
        else if(pop == 43){ # 30000 à 39999 habitants
            points += 650
        }
        else if(pop == 44){ # 40000 à 49999 habitants
            points += 700
        }
        else if(pop == 51){ # 50000 à 69999 habitants
            points += 750
        }
        else if(pop == 52){ # 70000 à 99999 habitants
            points += 800
        }
        else if(pop == 61){ # 100000 à 149999 habitants
            points += 850
        }
        else if(pop == 62){ # 150000 à 199999 habitants
            points += 900
        }
        else if(pop == 71){ # 200000 à 299999 habitants
            points += 950
        }
        else if(pop == 72){ # 300000 à 499999 habitants
            points += 1000
        }
        else if(pop == 73){ # 500000 à 1499999 habitants
            points += 1050
        }
        else if(pop >= 80){ # > 1500000 habitants
            points += 5000
        }
        else{ # unknown
            # TODO : log INFO as unknown for target X
        }
        # Crawl criteria
        if($21>=0 && $21 <= 10){
        	points += 10
        }
        sum_points+=points
        targets[nb_targets++] = $0
        points[nb_targets] = points
	}
}
END
{
    point_price = sum_points/(max_source_links*nb_sources)
    for( i = 1 ; i <= nb_targets ; i++)
        print targets[i],points[i]*point_price > "prioritized_targets.csv"
}
