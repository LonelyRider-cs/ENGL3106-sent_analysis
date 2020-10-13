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

#bind all the novesl together
american_corpus <- rbind(american1, american2, american3, american4, american5, american6, american7, american8, american9, american10, american11, american12, american13, american14, american15, american16, american17, american18, american19, american20, american21)
#unnest all words
american_corpus_tokens <- american_corpus %>% unnest_tokens(word, text)

#remove stop words from corpus
american_corpus_tokens_stop_words_removed <- american_corpus_tokens %>% anti_join(stop_words)

#the top 20 frequently used words in the american corpus
american_wc_20 <- american_corpus_tokens_stop_words_removed %>% 
  count(word, sort = TRUE) %>% 
  top_n(20) %>% 
  mutate(word = reorder(word, n))


#Using the Bing sentiment lexicon, find the ten most negative novels in each corpus 
#by calculating theratio of negativesentiment words to total emotion words
BING <- get_sentiments("bing")

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








