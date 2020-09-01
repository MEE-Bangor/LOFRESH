#Manually add the word 'sample' to the first line of track_WP1_18S.txt
track_WP1_18S <- track_WP1_18S <- read_table2("C:/Users/bsp81d/OneDrive - Bangor University/LOFRESH/WP1_results/18S_results/track.txt", 
                                              col_names = FALSE)
track_WP1_18S[] <- lapply(track_WP1_18S, gsub, pattern='"', replacement='')
track_WP1_18S<-track_WP1_18S %>%
  row_to_names(row_number = 1)
track_WP1_18S <- gather(track_WP1_18S, stage, reads, 2:7, factor_key=TRUE)

track_WP1_18S$stage<-factor(track_WP1_18S$stage,levels= c('input','filtered','denoisedF',
                                                          'denoisedR','merged',
                                                          'nonchim'),ordered=TRUE)
track_WP1_18S$reads<-as.numeric(track_WP1_18S$reads)

ggplot(track_WP1_18S, aes(x=stage, y=reads, group=sample)) +
 geom_point(stat='summary', fun.y=sum) +
##ylim(0,100000)+
stat_summary(fun.y=sum, geom="line")

#Manually add the word 'sample' to the first line of track_WP1_CO1.txt
track_WP1_CO1 <- track_WP1_CO1 <- read_table2("C:/Users/bsp81d/OneDrive - Bangor University/LOFRESH/WP1_results/CO1_results/track.txt", 
                                              col_names = FALSE)
track_WP1_CO1[] <- lapply(track_WP1_CO1, gsub, pattern='"', replacement='')
track_WP1_CO1<-track_WP1_CO1 %>%
  row_to_names(row_number = 1)
track_WP1_CO1 <- gather(track_WP1_CO1, stage, reads, 2:7, factor_key=TRUE)

track_WP1_CO1$stage<-factor(track_WP1_CO1$stage,levels= c('input','filtered','denoisedF',
                                                          'denoisedR','merged',
                                                          'nonchim'),ordered=TRUE)
track_WP1_CO1$reads<-as.numeric(track_WP1_CO1$reads)

ggplot(track_WP1_CO1, aes(x=stage, y=reads, group=sample)) +
  geom_point(stat='summary', fun.y=sum) +
  ##ylim(0,100000)+
  stat_summary(fun.y=sum, geom="line")


