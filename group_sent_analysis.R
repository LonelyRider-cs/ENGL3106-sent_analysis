library(tidyverse)
library(gutenbergr)
library(tidytext)
library(textdata)
data("stop_words")

#add blank tokens into stop words
blank_token <- data.frame(NA, "blank")
names(blank_token) <- c("word", "lexicon")
stop_words <- rbind(stop_words, blank_token)

#downloading all american corups files individually and then cleaning the rows
american1 <- gutenberg_download(25344, meta_fields = c("title", "author"))
american1 <- american1[213:8686, ]

american2 <- gutenberg_download(77, meta_fields = c("title", "author"))
american2 <- american2[309:10440, ]

american3 <- gutenberg_download(74, meta_fields = c("title", "author"))
american3 <- american3[458:8818, ]

american4 <- gutenberg_download(76, meta_fields = c("title", "author"))
american4 <- american4[552:11980, ]

american5 <- gutenberg_download(86, meta_fields = c("title", "author"))
american5 <- american5[335:12911, ]

american6 <- gutenberg_download(2701, meta_fields = c("title", "author"))
american6 <- american6[15:23571, ]

american7 <- gutenberg_download(1900, meta_fields = c("title", "author"))
american7 <- american7[669:11165, ]

american8 <- gutenberg_download(209, meta_fields = c("title", "author"))
american8 <- american8[15:4540, ]

american9 <- gutenberg_download(2833, meta_fields = c("title", "author"))
american9 <- american9[575:12846, ]

american10 <- gutenberg_download(19717, meta_fields = c("title", "author"))
american10 <- american10[30:7326, ]

american11 <- gutenberg_download(203, meta_fields = c("title", "author"))
american11 <- american11[21:20845, ]

american12 <- gutenberg_download(73, meta_fields = c("title", "author"))
american12 <- american12[12:5293, ]

american13 <- gutenberg_download(514, meta_fields = c("title", "author"))
american13 <- american13[74:20628, ]

american14 <- gutenberg_download(5348, meta_fields = c("title", "author"))
american14 <- american14[63:6978, ]

american15 <- gutenberg_download(940, meta_fields = c("title", "author"))
american15 <- american15[145:15393, ]

american16 <- gutenberg_download(5436, meta_fields = c("title", "author"))
american16 <- american16[142:8567, ]

american17 <- gutenberg_download(51060, meta_fields = c("title", "author"))
american17 <- american17[121:6503, ]

american18 <- gutenberg_download(2148, meta_fields = c("title", "author"))
american18 <- american18[40:9462, ]

american19 <- gutenberg_download(154, meta_fields = c("title", "author"))
american19 <- american19[16:14539, ]

american20 <- gutenberg_download(2145, meta_fields = c("title", "author"))
american20 <- american20[21:24362, ]

american21 <- gutenberg_download(2046, meta_fields = c("title", "author"))
american21 <- american21[140:5860, ]

#download all british novels individually
brit1 <- gutenberg_download((768), meta_fields = c("title", "author")) #Wuthering Heights 
brit1 <- brit1[7:12085, ]

brit2 <- gutenberg_download((1260), meta_fields = c("title", "author")) #Jane Eyre 
brit2 <- brit2[145:20659,]

brit3 <- gutenberg_download((969), meta_fields = c("title", "author")) #The Tenant of Wildfell Hall
brit3 <- brit3[433:18061,]

brit4 <- gutenberg_download((11), meta_fields = c("title", "author")) #Alice's Adventures in Wonderland
brit4 <- brit4[10:3339,]

brit5 <- gutenberg_download((345), meta_fields = c("title", "author")) #Dracula 
brit5 <- brit5[162:15482,]

brit6 <- gutenberg_download((174), meta_fields = c("title", "author")) #The Picture of Dorian Gray
brit6 <- brit6[58:8498,]

brit7 <- gutenberg_download((766), meta_fields = c("title", "author")) #David Copperfield 
brit7 <- brit7[161:38191,]

brit8 <- gutenberg_download(36, meta_fields = c("title", "author"))  # the war of the worlds
brit8 <- brit8[24:6474,]

brit9 <- gutenberg_download(98, meta_fields = c("title", "author")) # a tale of two cities
brit9 <- brit9[79:15865,]

brit10 <- gutenberg_download(786, meta_fields = c("title", "author")) # hard times
brit10 <- brit10[125:11629,]

brit11 <- gutenberg_download(110, meta_fields = c("title", "author")) # tess of the d'Ubervilles
brit11 <- brit11[46:17615,]

brit12 <- gutenberg_download(145, meta_fields = c("title", "author")) #middlemarch
brit12 <- brit12[81:33280,]

brit13 <- gutenberg_download(219, meta_fields = c("title", "author")) #heart of darkness
brit13 <- brit13[11:3312,]

brit14 <- gutenberg_download(4276, meta_fields = c("title", "author")) #north and south
brit14 <- brit14[31:19064,]

brit15 <- gutenberg_download(21839, meta_fields = c("title", "author")) #sense and sensibility
brit15 <- brit15[429:13242,]

brit16 <- gutenberg_download(42671, meta_fields = c("title", "author")) #pride and prejudice
brit16 <- brit16[59:13297,]

brit17 <- gutenberg_download(105, meta_fields = c("title", "author")) #persuasion
brit17 <- brit17[16:8324,]

brit18 <- gutenberg_download(84, meta_fields = c("title", "author")) #frankenstein
brit18 <- brit18[16:7244,]

brit19 <- gutenberg_download(82, meta_fields = c("title", "author")) #ivanhoe: a romance
brit19 <- brit19[811:19722,]

brit20 <- gutenberg_download(7412, meta_fields = c("title", "author")) #coningsby, or the new generation
brit20 <- brit20[169:17567,]

brit21 <- gutenberg_download(3760, meta_fields = c("title", "author")) # sybil or, the two nations
brit21 <- brit21[43:17875,]

brit22 <- gutenberg_download(599, meta_fields = c("title", "author"))   # vanity fair
brit22 <- brit22[13:30002,]

brit23 <- gutenberg_download(2153, meta_fields = c("title", "author"))   # mary barton
brit23 <- brit23[52:17825,]

#bind all the american novels together
american_corpus <- rbind(american1, american2, american3, american4, american5, american6, american7, american8, american9, american10, american11, american12, american13, american14, american15, american16, american17, american18, american19, american20, american21)
#unnest all words
american_corpus_tokens <- american_corpus %>% unnest_tokens(word, text)
#remove stop words from corpus
american_corpus_tokens_stop_words_removed <- american_corpus_tokens %>% anti_join(stop_words)

#bind all the british novels together
british_corpus <- rbind(brit1, brit2, brit3, brit4, brit5, brit6, brit7, brit8, brit9, brit10, brit11, brit12, brit13, brit14, brit15, brit16, brit17, brit18, brit19, brit20, brit21, brit22, brit23)
#unests all words
british_corpus_tokens <- british_corpus %>% unnest_tokens(word, text)
#remove all stop words
british_corpus_tokens_stop_words_removed <- british_corpus_tokens %>% anti_join(stop_words)


# A: the top 20 frequently used words in the american corpus
#American
american_wc_20 <- american_corpus_tokens_stop_words_removed %>% 
  count(word, sort = TRUE) %>% 
  top_n(20) %>% 
  mutate(word = reorder(word, n))

ggplot(american_wc_20, aes(word,n))+
  geom_col()+
  ggtitle("Top Words in the American Corpus")+
  xlab("words")+
  ylab(NULL)+
  coord_flip()

#British
british_wc_20 <- british_corpus_tokens_stop_words_removed %>% 
  count(word, sort = TRUE) %>% 
  top_n(20) %>% 
  mutate(word = reorder(word, n))

ggplot(british_wc_20, aes(word,n))+
  geom_col()+
  ggtitle("Top Words in the British Corpus")+
  xlab("words")+
  ylab(NULL)+
  coord_flip()


#B: Using the Bing sentiment lexicon, find the ten most negative novels in each corpus 
#by calculating theratio of negativesentiment words to total emotion words
BING <- get_sentiments("bing")

#american
american_sentiment_ratio <- american_corpus_tokens %>% 
  group_by(title) %>% 
  inner_join(BING) %>% 
  count(sentiment) %>% 
  spread(sentiment, n) %>% 
  mutate(sentiment = positive - negative) %>% 
  mutate(positive_ratio = (positive)/(positive + negative)) %>% 
  ungroup() %>% 
  mutate(title = reorder(title, positive_ratio)) %>% 
  top_n(-10)


ggplot(american_sentiment_ratio, aes(title, positive_ratio)) +
  geom_point(col="tomato2", size=3) +   # Draw points, specifying point color and size
  geom_segment(aes(x=title, 
                   xend=title, 
                   y=min(positive_ratio), 
                   yend=max(positive_ratio)), 
               linetype="dashed", 
               size=0.1) +              # Draw dashed lines
  labs(title="Ratio of Positive Words to Total Emotions Words", 
       subtitle="Major American Novels Corpus", 
       caption="source: Project Gutenberg") +  
  coord_flip()
  
#british
british_sentiment_ratio <- british_corpus_tokens %>% 
  group_by(title) %>% 
  inner_join(BING) %>% 
  count(sentiment) %>% 
  spread(sentiment, n) %>% 
  mutate(sentiment = positive - negative) %>% 
  mutate(positive_ratio = (positive)/(positive + negative)) %>% 
  ungroup() %>% 
  mutate(title = reorder(title, positive_ratio)) %>% 
  top_n(-10)


ggplot(british_sentiment_ratio, aes(title, positive_ratio)) +
  geom_point(col="tomato2", size=3) +   # Draw points, specifying point color and size
  geom_segment(aes(x=title, 
                   xend=title, 
                   y=min(positive_ratio), 
                   yend=max(positive_ratio)), 
               linetype="dashed", 
               size=0.1) +              # Draw dashed lines
  labs(title="Ratio of Positive Words to Total Emotions Words", 
       subtitle="Major British Novels Corpus", 
       caption="source: Project Gutenberg") +  
  coord_flip()

#C: Using the same sentiment lexicon, determine the overall sentiment of each corpora.
#american
american_sentiment_corpus <- american_corpus_tokens %>% 
  inner_join(BING) %>% 
  count(sentiment) %>% 
  spread(sentiment, n) %>% 
  mutate(sentiment = positive - negative) %>% 
  mutate(positive_ratio = (positive)/(positive + negative))

#british
british_sentiment_corpus <- british_corpus_tokens %>% 
  inner_join(BING) %>% 
  count(sentiment) %>% 
  spread(sentiment, n) %>% 
  mutate(sentiment = positive - negative) %>% 
  mutate(positive_ratio = (positive)/(positive + negative))

#graph comparing the the two corpuses overall sentiment
#first combine necassary data into single data frame
overall_sentiment <- data.frame("Corpus" = c("American", "British"), "Overall_Sentiment" = c(american_sentiment_corpus$sentiment[1], british_sentiment_corpus$sentiment[1]))

ggplot(overall_sentiment, aes(Corpus, Overall_Sentiment)) +
  geom_point(col="tomato2", size=3) +   # Draw points, specifying point color and size
  geom_segment(aes(x=Corpus, 
                   xend=Corpus, 
                   y=min(Overall_Sentiment), 
                   yend=max(Overall_Sentiment)), 
               linetype="dashed", 
               size=0.1) +              # Draw dashed lines
  labs(title="Overall Sentiment of each Corpus", 
       subtitle="American and British Corpus", 
       caption="source: Project Gutenberg") +  
  coord_flip()

#D: What fifteen words contribute most to the positive and negative scores of eachcorpus
#american
american_top_15_sentiments <- american_corpus_tokens %>%
  inner_join(BING) %>%
  count(word, sort = TRUE) %>%
  top_n(15) %>%
  mutate(word = reorder(word, n))


ggplot(american_top_15_sentiments, aes(word, n)) +
  geom_col()+
  labs(title = "Top BING Words in Major American Novels Corpus",
       subtitle = "BING sentiment lexicon")+
  coord_flip()

#british
british_top_15_sentiments <- british_corpus_tokens %>%
  inner_join(BING) %>%
  count(word, sort = TRUE) %>%
  top_n(15) %>%
  mutate(word = reorder(word, n))


ggplot(british_top_15_sentiments, aes(word, n)) +
  geom_col()+
  labs(title = "Top BING Words in Major British Novels Corpus",
       subtitle = "BING sentiment lexicon")+
  coord_flip()


#E: Using the NRC sentiment lexicon, find the top fifteen “anger” and “joy” words of 
#each corpus.
NRC <- lexicon_nrc()
nrcJoy <- NRC %>% 
  filter(sentiment == "joy")
nrcAnger <- NRC %>% 
  filter(sentiment == "anger")

#american
american_Joy <- american_corpus_tokens_stop_words_removed %>% 
  inner_join(nrcJoy) %>% 
  count(word, sort = TRUE) %>% 
  top_n(15)
american_Anger <- american_corpus_tokens_stop_words_removed %>% 
  inner_join(nrcAnger) %>% 
  count(word, sort = TRUE) %>% 
  top_n(15)

#british
british_Joy <- british_corpus_tokens_stop_words_removed %>% 
  inner_join(nrcJoy) %>% 
  count(word, sort = TRUE) %>% 
  top_n(15)
british_Anger <- british_corpus_tokens_stop_words_removed %>% 
  inner_join(nrcAnger) %>% 
  count(word, sort = TRUE) %>% 
  top_n(15)

#F: Which novel in each corpus is characterized by the greatest level of disgust?
nrcDisgust <- NRC %>% 
  filter(sentiment == "disgust")

#american
american_DisgustNovels <- american_corpus_tokens_stop_words_removed %>% 
  group_by(title) %>% 
  inner_join(nrcDisgust) %>% 
  count(sentiment) %>% 
  spread(sentiment, n)

#british
british_DisgustNovels <- american_corpus_tokens_stop_words_removed %>% 
  group_by(title) %>% 
  inner_join(nrcDisgust) %>% 
  count(sentiment) %>% 
  spread(sentiment, n)

#G: Using the AFINN sentiment lexicon, find the five most positive and negative novels 
#in your combined corpora.(AFINN)
afinn <- lexicon_afinn()
modAfinn <- afinn %>% 
  filter(word != "miss")
#american
american_Afinn <- american_corpus_tokens_stop_words_removed %>% 
  group_by(title) %>% 
  inner_join(modAfinn) %>% 
  summarise(sentiment = sum(value)) %>% 
  ungroup() %>% 
  mutate(title = reorder(title, sentiment))

#british
british_Afinn <- british_corpus_tokens_stop_words_removed %>% 
  group_by(title) %>% 
  inner_join(modAfinn) %>% 
  summarise(sentiment = sum(value)) %>% 
  ungroup() %>% 
  mutate(title = reorder(title, sentiment))

