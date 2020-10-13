Brit1 <- gutenberg_download(c(768), meta_fields = c("title", "author")) #Wuthering Heights 
View(Brit1) 

Brit2 <-gutenberg_download(c(1260), meta_fields = c("title", "author")) #Jane Eyre 
View(Brit2)
Brit2 <- Brit2[145:20659,]
View(Brit2)

Brit3 <-gutenberg_download(c(969), meta_fields = c("title", "author")) #The Tenant of Wildfell Hall
View(Brit3)
Brit3 <- Brit3[433:18061,]
View(Brit3)

Brit4 <-gutenberg_download(c(11), meta_fields = c("title", "author")) #Alice's Adventures in Wonderland
View(Brit4)
Brit4 <- Brit4[10:3339,]
View(Brit4) 

Brit5 <-gutenberg_download(c(345), meta_fields = c("title", "author")) #Dracula 
View(Brit5)
Brit5 <- Brit5[162:15482,]
View(Brit5)

Brit6 <- gutenberg_download(c(174), meta_fields = c("title", "author")) #The Picture of Dorian Gray
View(Brit6)
Brit6 <- Brit6[58:8498,]
View(Brit6)

Brit7 <- gutenberg_download(c(766), meta_fields = c("title", "author")) #David Copperfield 
View(Brit7)
Brit7 <- Brit7[161:38191,]
View(Brit7) 

BritishCorpus <- rbind(Brit1, Brit2, Brit3, Brit4, Brit5, Brit6, Brit7) %>%
  unnest_tokens(word,text)

Britishscrub <- BritishCorpus %>%
  anti_join(stop_words)

britwc <- Britishscrub %>%
  count(word, sort = TRUE) %>%
  top_n(20) %>%
  mutate(word = reorder(word, n))

BING <- get_sentiments("bing") %>%
  filter(word != "miss") 

brit_sent_ratio <- BritishCorpus %>%
  group_by(title) %>%
  inner_join(BING) %>%
  count(sentiment) %>%
  spread(sentiment, n) %>%
  mutate(sentiment = positive - negative) %>%
  mutate(positiveratio = (positive)/(positive + negative)) %>%
  mutate(title = reorder(title, positiveratio))
  
brit_sent_ratio_noStopWords <- Britishscrub %>%
  group_by(title) %>%
  inner_join(BING) %>%
  count(sentiment) %>%
  spread(sentiment, n) %>%
  mutate(sentiment = positive - negative) %>%
  mutate(positiveratio = (positive)/(positive + negative)) %>%
  ungroup() %>%
  mutate(title = reorder(title, positiveratio))

 



     
     
     
     )