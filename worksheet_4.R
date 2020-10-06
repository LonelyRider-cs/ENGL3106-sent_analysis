library(tidyverse)
library(gutenbergr)
library(tidytext)
library(textdata)
data("stop_words")

#get 12 gutenberg ids that all are of the subject science fiction
sf_gutenberg_ids <- gutenberg_subjects %>% 
       filter(str_detect(subject, "Science fiction"))

#science fiction corpra
sf_info <-gutenberg_metadata %>% filter(gutenberg_id==35)
sf1 <- gutenberg_download(35, meta_fields = c("title", "author"))
sf1 <- sf1[9:3221, ]
sf1_strip <- gutenberg_strip(sf1)

sf_info <- sf_info %>% add_row(gutenberg_metadata %>% filter(gutenberg_id==36))
sf2 <- gutenberg_download(36, meta_fields = c("title", "author"))
sf2 <- sf2[24:6474, ]

sf_info <- sf_info %>% add_row(gutenberg_metadata %>% filter(gutenberg_id==42))
sf3 <- gutenberg_download(42, meta_fields = c("title", "author"))
sf3 <- sf3[17:3040, ]

sf_info <- sf_info %>% add_row(gutenberg_metadata %>% filter(gutenberg_id==62))
sf5 <- gutenberg_download(62, meta_fields = c("title", "author"))
sf5 <- sf5[204:7138, ]

sf_info <- sf_info %>% add_row(gutenberg_metadata %>% filter(gutenberg_id==64))
sf6 <- gutenberg_download(64, meta_fields = c("title", "author"))
sf6 <- sf6[174:9322, ]

sf_info <- sf_info %>% add_row(gutenberg_metadata %>% filter(gutenberg_id==68))
sf7 <- gutenberg_download(68, meta_fields = c("title", "author"))
sf7 <- sf7[38:6740, ]

sf_info <- sf_info %>% add_row(gutenberg_metadata %>% filter(gutenberg_id==72))
sf8 <- gutenberg_download(72, meta_fields = c("title", "author"))
sf8 <- sf8[42:6244, ]

sf_info <- sf_info %>% add_row(gutenberg_metadata %>% filter(gutenberg_id==83))
sf9 <- gutenberg_download(83, meta_fields = c("title", "author"))
sf9 <- sf9[99:12418, ]

sf_info <- sf_info %>% add_row(gutenberg_metadata %>% filter(gutenberg_id==84))
sf10 <- gutenberg_download(84, meta_fields = c("title", "author"))
sf10 <- sf10[16:7244, ]

sf_info <- sf_info %>% add_row(gutenberg_metadata %>% filter(gutenberg_id==96))
sf11 <- gutenberg_download(96, meta_fields = c("title", "author"))
sf11 <- sf11[38:6288, ]

sf_info <- sf_info %>% add_row(gutenberg_metadata %>% filter(gutenberg_id==123))
sf12 <- gutenberg_download(123, meta_fields = c("title", "author"))
sf12 <- sf12[99:5130, ]

keep <- c("gutenberg_id", "title", "author", "gutenberg_bookshelf")
sf_info_final <- sf_info[keep]

sf_info_final$publication_date <- c(1895, 1898, 1886, 1912, 1913, 1914, 1916, 1865, 1823, 1929, 1914)

sf_corpus <- rbind(sf1, sf2, sf3, sf5, sf6, sf7, sf8, sf9 ,sf10, sf11 , sf12) %>% unnest_tokens(word, text)



#get 12 gutenberg ids that all are of the subject sports
sport_gutenberg_ids <- gutenberg_subjects %>% 
       filter(str_detect(subject, "College sports"))

#sport corpra
sport_info <-gutenberg_metadata %>% filter(gutenberg_id==8550)
sport1 <- gutenberg_download(8550, meta_fields = c("title", "author"))
sport1 <- sport1[50:6595, ]

sport_info <- sport_info %>% add_row(gutenberg_metadata %>% filter(gutenberg_id==10323))
sport2 <- gutenberg_download(10323, meta_fields = c("title", "author"))
sport2 <- sport2[77:7887, ]

sport_info <- sport_info %>% add_row(gutenberg_metadata %>% filter(gutenberg_id==19246))
sport3 <- gutenberg_download(19246, meta_fields = c("title", "author"))
sport3 <- sport3[56:6285, ]

sport_info <- sport_info %>% add_row(gutenberg_metadata %>% filter(gutenberg_id==39582))
sport4 <- gutenberg_download(39582, meta_fields = c("title", "author"))
sport4 <- sport4[103:9296, ]

sport_info <- sport_info %>% add_row(gutenberg_metadata %>% filter(gutenberg_id==39668))
sport5 <- gutenberg_download(39668, meta_fields = c("title", "author"))
sport5 <- sport5[87:5709, ]

sport_info <- sport_info %>% add_row(gutenberg_metadata %>% filter(gutenberg_id==40668))
sport6 <- gutenberg_download(40668, meta_fields = c("title", "author"))
sport6 <- sport6[107:9017, ]

sport_info <- sport_info %>% add_row(gutenberg_metadata %>% filter(gutenberg_id==41206))
sport7 <- gutenberg_download(41206, meta_fields = c("title", "author"))
sport7 <- sport7[105:8565, ]

sport_info <- sport_info %>% add_row(gutenberg_metadata %>% filter(gutenberg_id==41665))
sport8 <- gutenberg_download(41665, meta_fields = c("title", "author"))
sport8 <- sport8[135:8804, ]

sport_info <- sport_info %>% add_row(gutenberg_metadata %>% filter(gutenberg_id==42130))
sport9 <- gutenberg_download(42130, meta_fields = c("title", "author"))
sport9 <- sport9[127:8806, ]

sport_info <- sport_info %>% add_row(gutenberg_metadata %>% filter(gutenberg_id==42403))
sport10 <- gutenberg_download(42403, meta_fields = c("title", "author"))
sport10 <- sport10[141:8891, ]


keep <- c("gutenberg_id", "title", "author", "gutenberg_bookshelf")
sport_info_final <- sport_info[keep]

sport_info_final$gutenberg_bookshelf <- "sports"

sport_info_final$publication_date <- c(1915, 1910, 1911, 1910, 1899, 1910, 1911, 1911, 1912, 1913)

sport_corpus <- rbind(sport1, sport2, sport3, sport4, sport5, sport6, sport7, sport8, sport9, sport10) %>% unnest_tokens(word, text)


