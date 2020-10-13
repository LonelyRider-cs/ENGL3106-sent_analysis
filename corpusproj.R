library(tidyverse)
library(gutenbergr)
library(tidytext)
library(textdata)
data("stop_words")

brit24 <- gutenberg_download(36, meta_fields = c("title", "author"))  # the war of the worlds
brit24 <- brit24[24:6474,]

brit23 <- gutenberg_download(2153, meta_fields = c("title", "author"))   # mary barton
brit23 <- brit23[52:17825,]

brit22 <- gutenberg_download(599, meta_fields = c("title", "author"))   # vanity fair
brit22 <- brit22[13:30002,]

brit21 <- gutenberg_download(3760, meta_fields = c("title", "author")) # sybil or, the two nations
brit21 <- brit21[43:17875,]

brit20 <- gutenberg_download(7412, meta_fields = c("title", "author")) #coningsby, or the new generation
brit20 <- brit20[169:17567,]

brit19 <- gutenberg_download(82, meta_fields = c("title", "author")) #ivanhoe: a romance
brit19 <- brit19[811:19722,]

brit18 <- gutenberg_download(84, meta_fields = c("title", "author")) #frankenstein
brit18 <- brit18[16:7244,]

brit17 <- gutenberg_download(105, meta_fields = c("title", "author")) #persuasion
brit17 <- brit17[16:8324,]

brit16 <- gutenberg_download(42671, meta_fields = c("title", "author")) #pride and prejudice
brit16 <- brit16[59:13297,]

brit15 <- gutenberg_download(21839, meta_fields = c("title", "author")) #sense and sensibility
brit15 <- brit15[429:13242,]

brit14 <- gutenberg_download(4276, meta_fields = c("title", "author")) #north and south
brit14 <- brit14[31:19064,]

brit13 <- gutenberg_download(219, meta_fields = c("title", "author")) #heart of darkness
brit13 <- brit13[11:3312,]

brit12 <- gutenberg_download(145, meta_fields = c("title", "author")) #middlemarch
brit12 <- brit12[81:33280,]

brit11 <- gutenberg_download(110, meta_fields = c("title", "author")) # tess of the d'Ubervilles
brit11 <- brit11[46:17615,]

brit10 <- gutenberg_download(786, meta_fields = c("title", "author")) # hard times
brit10 <- brit10[125:11629,]

brit9 <- gutenberg_download(98, meta_fields = c("title", "author")) # a tale of two cities
brit9 <- brit9[79:15865,]


brit_corpus <- rbind(brit24,brit23,brit22,brit21,brit20,brit19,brit18,brit17,brit16,brit15,brit14,brit13,brit12,brit11,brit10,brit9) %>% 
  unnest_tokens(word,text)

brit_scrub <- brit_corpus %>%
  anti_join(stop_words)

brit_wc <- brit_scrub %>%
  count(word, sort = TRUE) %>%
  top_n(20) %>%
  mutate(word = reorder(word, n))

BING_mod <- get_sentiments("bing") %>%
  filter(word != "miss")          # "filter" the word "miss" since it is a major false negative

brit_sent_ratio_allWords <- brit_corpus %>%
  group_by(title) %>%
  inner_join(BING_mod) %>%
  count(sentiment) %>%
  spread(sentiment, n) %>%
  mutate(sentiment = positive - negative) %>%
  mutate(positiveratio = (positive)/(positive + negative)) %>%
  mutate(title = reorder(title, positiveratio))

brit_sent_ratio_noStopWords <- brit_scrub %>%
  group_by(title) %>%
  inner_join(BING_mod) %>%
  count(sentiment) %>%
  spread(sentiment, n) %>%
  mutate(sentiment = positive - negative) %>%
  mutate(positiveratio = (positive)/(positive + negative)) %>%
  ungroup() %>%
  mutate(title = reorder(title, positiveratio))








