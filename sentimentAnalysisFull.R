#Sentiment analysis of 19th Century novels, American and British.
#Oct. 13
#TODO: ggplot visualizations, research questions
#First download necessary libraries.
library(tidyverse)
library(gutenbergr)
library(tidytext)
library(textdata)
data("stop_words")

#To filter out blank or NA rows in our corpus, we add it to the stop words list.
blank_token <- data.frame(NA, "blank")
names(blank_token) <- c("word", "lexicon")
stop_words <- rbind(stop_words, blank_token)%>%
  filter(word != "miss") #Instead of filtering "miss" out of each sentiment lexicon, we
                         #can filter it out of the stop words entirely.

#American novels
american1 <- gutenberg_download(25344, meta_fields = c("title", "author"))
american1 <- american1[213:8686, ] #The Scarlet Letter

american2 <- gutenberg_download(77, meta_fields = c("title", "author"))
american2 <- american2[309:10440, ] #The House of the Seven Gables

american3 <- gutenberg_download(74, meta_fields = c("title", "author"))
american3 <- american3[458:8818, ] #Huck Finn

american4 <- gutenberg_download(76, meta_fields = c("title", "author"))
american4 <- american4[552:11980, ] #Tom Sawyer

american5 <- gutenberg_download(86, meta_fields = c("title", "author"))
american5 <- american5[335:12911, ] #Connecticut Yankee

american6 <- gutenberg_download(2701, meta_fields = c("title", "author"))
american6 <- american6[15:23571, ] #Moby-Dick

american7 <- gutenberg_download(1900, meta_fields = c("title", "author"))
american7 <- american7[669:11165, ] #Typee

american8 <- gutenberg_download(209, meta_fields = c("title", "author"))
american8 <- american8[15:4540, ] #Turn of the Screw

american9 <- gutenberg_download(2833, meta_fields = c("title", "author"))
american9 <- american9[575:12846, ] #Portrait of a Lady, vol. 1

american10 <- gutenberg_download(19717, meta_fields = c("title", "author"))
american10 <- american10[30:7326, ] #The Bostonians, vol. 1

american11 <- gutenberg_download(203, meta_fields = c("title", "author"))
american11 <- american11[21:20845, ] #Uncle Tom's Cabin

american12 <- gutenberg_download(73, meta_fields = c("title", "author"))
american12 <- american12[12:5293, ] #Red Badge of Courage

american13 <- gutenberg_download(514, meta_fields = c("title", "author"))
american13 <- american13[74:20628, ] #Little Women

american14 <- gutenberg_download(5348, meta_fields = c("title", "author"))
american14 <- american14[63:6978, ] #Ragged Dick

american15 <- gutenberg_download(940, meta_fields = c("title", "author"))
american15 <- american15[145:15393, ] #Last of the Mohicans

american16 <- gutenberg_download(5436, meta_fields = c("title", "author"))
american16 <- american16[142:8567, ] #Hyperion

american17 <- gutenberg_download(51060, meta_fields = c("title", "author"))
american17 <- american17[121:6503, ] #Arthur Gordon Pym of Nantucket

american18 <- gutenberg_download(2148, meta_fields = c("title", "author"))
american18 <- american18[40:9462, ] #The Works of Edgar Allan Poe, vol. 2

american19 <- gutenberg_download(154, meta_fields = c("title", "author"))
american19 <- american19[16:14539, ] #The Rise of Silas Lapham

american20 <- gutenberg_download(2145, meta_fields = c("title", "author"))
american20 <- american20[21:24362, ] #Ben-Hur

american21 <- gutenberg_download(2046, meta_fields = c("title", "author"))
american21 <- american21[140:5860, ] #Clotel

american_corpus <- rbind(american1, american2, american3, american4, american5, american6, american7, american8, american9, american10, american11, american12, american13, american14, american15, american16, american17, american18, american19, american20, american21)
#unnest all words
american_corpus_tokens <- american_corpus %>% unnest_tokens(word, text)
#remove stop words from corpus
american_corpus_tokens_stop_words_removed <- american_corpus_tokens %>% anti_join(stop_words)

#British novels
brit1 <- gutenberg_download(36, meta_fields = c("title", "author"))  # the war of the worlds
brit1 <- brit1[24:6474,]

brit3 <- gutenberg_download(2153, meta_fields = c("title", "author"))   # mary barton
brit3 <- brit3[52:17825,]

brit4 <- gutenberg_download(599, meta_fields = c("title", "author"))   # vanity fair
brit4 <- brit4[13:30002,]

brit5 <- gutenberg_download(3760, meta_fields = c("title", "author")) # sybil or, the two nations
brit5 <- brit5[43:17875,]

brit6 <- gutenberg_download(7412, meta_fields = c("title", "author")) #coningsby, or the new generation
brit6 <- brit6[169:17567,]

brit7 <- gutenberg_download(82, meta_fields = c("title", "author")) #ivanhoe: a romance
brit7 <- brit7[811:19722,]

brit8 <- gutenberg_download(84, meta_fields = c("title", "author")) #frankenstein
brit8 <- brit8[16:7244,]

brit9 <- gutenberg_download(105, meta_fields = c("title", "author")) #persuasion
brit9 <- brit9[16:8324,]

brit10 <- gutenberg_download(42671, meta_fields = c("title", "author")) #pride and prejudice
brit10 <- brit10[59:13297,]

brit11 <- gutenberg_download(21839, meta_fields = c("title", "author")) #sense and sensibility
brit11 <- brit11[429:13242,]

brit12 <- gutenberg_download(4276, meta_fields = c("title", "author")) #north and south
brit12 <- brit12[31:19064,]

brit13 <- gutenberg_download(219, meta_fields = c("title", "author")) #heart of darkness
brit13 <- brit13[11:3312,]

brit14 <- gutenberg_download(145, meta_fields = c("title", "author")) #middlemarch
brit14 <- brit14[81:33280,]

brit15 <- gutenberg_download(110, meta_fields = c("title", "author")) # tess of the d'Ubervilles
brit15 <- brit15[46:17615,]

brit16 <- gutenberg_download(786, meta_fields = c("title", "author")) # hard times
brit16 <- brit16[125:11629,]

brit17 <- gutenberg_download(98, meta_fields = c("title", "author")) # a tale of two cities
brit17 <- brit17[79:15865,]

brit18 <- gutenberg_download((768), meta_fields = c("title", "author")) #Wuthering Heights 
brit18 <- brit18[4:12085,]

brit19 <-gutenberg_download((1260), meta_fields = c("title", "author")) #Jane Eyre 
brit19 <- brit19[145:20659,]

brit20 <-gutenberg_download((969), meta_fields = c("title", "author")) #The Tenant of Wildfell Hall
brit20 <- brit20[433:18061,]

brit21 <-gutenberg_download((11), meta_fields = c("title", "author")) #Alice's Adventures in Wonderland
brit21 <- brit21[10:3339,]

brit22 <-gutenberg_download((345), meta_fields = c("title", "author")) #Dracula 
brit22 <- brit22[162:15482,]

brit23 <- gutenberg_download((174), meta_fields = c("title", "author")) #The Picture of Dorian Gray
brit23 <- brit23[58:8498,]

brit24 <- gutenberg_download((766), meta_fields = c("title", "author")) #David Copperfield 
brit24 <- brit24[161:38191,]

brit_corpus <- rbind(brit1,brit3,brit4,brit5,brit6,brit7,brit8,brit9,brit10,brit11,brit12,brit13,brit14,
                     brit15,brit16,brit17,brit18,brit19,brit20,brit21,brit22,brit23,brit24) %>% 
  unnest_tokens(word,text)

brit_scrub <- brit_corpus %>%
  anti_join(stop_words)

#a. the top 20 frequently used words in the corpus
#American
american_wc_20 <- american_corpus_tokens_stop_words_removed %>% 
  count(word, sort = TRUE) %>% 
  top_n(20) %>% 
  mutate(word = reorder(word, n))
#British
brit_wc <- brit_scrub %>%
  count(word, sort = TRUE) %>%
  top_n(20) %>%
  mutate(word = reorder(word, n))

#b. Using the Bing sentiment lexicon, find the ten most negative novels in each corpus 
#by calculating the ratio of negative sentiment words to total emotion words
BING <- get_sentiments("bing")
#American
american_sentiment_ratio <- american_corpus_tokens_stop_words_removed %>% 
  group_by(title) %>% 
  inner_join(BING) %>% 
  count(sentiment) %>% 
  spread(sentiment, n) %>% 
  mutate(sentiment = positive - negative) %>% 
  mutate(positive_ratio = (positive)/(positive + negative)) %>% 
  ungroup() %>% 
  mutate(title = reorder(title, positive_ratio)) %>% 
  top_n(-10)
#British
brit_sent_ratio_noStopWords <- brit_scrub %>%
  group_by(title) %>%
  inner_join(BING) %>%
  count(sentiment) %>%
  spread(sentiment, n) %>%
  mutate(sentiment = positive - negative) %>%
  mutate(positiveratio = (positive)/(positive + negative)) %>%
  ungroup() %>%
  mutate(title = reorder(title, positiveratio))

#c. Using the same sentiment lexicon, determine the overall sentiment of each corpus.
#American
american_sentiment_corpus <- american_corpus_tokens_stop_words_removed %>% 
  inner_join(BING) %>% 
  count(sentiment) %>% 
  spread(sentiment, n) %>% 
  mutate(sentiment = positive - negative) %>% 
  mutate(positive_ratio = (positive)/(positive + negative))
#British
british_sentiment_corpus <- brit_scrub %>% 
  inner_join(BING) %>% 
  count(sentiment) %>% 
  spread(sentiment, n) %>% 
  mutate(sentiment = positive - negative) %>% 
  mutate(positive_ratio = (positive)/(positive + negative))

#d. What fifteen words contribute most to the positive and negative scores of each corpus
#American
american_top_15_sentiments <- american_corpus_tokens_stop_words_removed %>%
  inner_join(BING) %>%
  count(word, sort = TRUE) %>%
  top_n(15) %>%
  mutate(word = reorder(word, n))

ggplot(american_top_15_sentiments, aes(word, n)) +
  geom_col()+
  labs(title = "Top BING Words in Major American Novels",
       subtitle = "BING sentiment lexicon")+
  coord_flip()
#British
british_top_15_sentiments <- brit_scrub %>%
  inner_join(BING) %>%
  count(word, sort = TRUE) %>%
  top_n(15) %>%
  mutate(word = reorder(word, n))

ggplot(british_top_15_sentiments, aes(word, n)) +
  geom_col()+
  labs(title = "Top BING Words in Major British Novels",
       subtitle = "BING sentiment lexicon")+
  coord_flip()

#e. Using the NRC sentiment lexicon, find the top fifteen “anger” and “joy” words of 
#each corpus.
NRC <- lexicon_nrc()
nrcJoy <- NRC %>% 
  filter(sentiment == "joy")
nrcAnger <- NRC %>% 
  filter(sentiment == "anger")
#American
ameriJoy <- american_corpus_tokens_stop_words_removed %>% 
  inner_join(nrcJoy) %>% 
  count(word, sort = TRUE) %>% 
  top_n(15)
ameriAnger <- american_corpus_tokens_stop_words_removed %>% 
  inner_join(nrcAnger) %>% 
  count(word, sort = TRUE) %>% 
  top_n(15)
#British
britJoy <- brit_scrub %>% 
  inner_join(nrcJoy) %>% 
  count(word, sort = TRUE) %>% 
  top_n(15)
britAnger <- brit_scrub %>% 
  inner_join(nrcAnger) %>% 
  count(word, sort = TRUE) %>% 
  top_n(15)

#f. Which novel in each corpus is characterized by the greatest level of disgust?
nrcDisgust <- NRC %>% 
  filter(sentiment == "disgust")
#American
ameriDisgustNovels <- american_corpus_tokens_stop_words_removed %>% 
  group_by(title) %>% 
  inner_join(nrcDisgust) %>% 
  count(sentiment) %>% 
  spread(sentiment, n)
#British
britDisgustNovels <- brit_scrub %>% 
  group_by(title) %>% 
  inner_join(nrcDisgust) %>% 
  count(sentiment) %>% 
  spread(sentiment, n)

#g. Using the AFINN sentiment lexicon, find the five most positive and negative novels 
#in your combined corpora.(AFINN)
afinn <- lexicon_afinn()
#American
ameriAfinn <- american_corpus_tokens_stop_words_removed %>% 
  group_by(title) %>% 
  inner_join(afinn) %>% 
  summarise(sentiment = sum(value)) %>% 
  ungroup() %>% 
  mutate(title = reorder(title, sentiment))
View(ameriAfinn %>% 
       top_n(5))
View(ameriAfinn %>% 
       top_n(-5))
#British
britAfinn <- brit_scrub %>% 
  group_by(title) %>% 
  inner_join(afinn) %>% 
  summarise(sentiment = sum(value)) %>% 
  ungroup() %>% 
  mutate(title = reorder(title, sentiment))
View(britAfinn %>% 
       top_n(5))
View(britAfinn %>% 
       top_n(-5))