#Oct. 1, Z. Blue
#Okay let's try sentiment analysis on larger corpora of texts. A bunch of novels.
dickensNovels <- gutenberg_download(c(19337, 98, 1023, 766, 821, 
                                      1400, 786, 963, 968,
                                      967, 730, 883, 564, 700, 580), 
                                    meta_fields = c("title", "author")) %>% 
  unnest_tokens(word, text) #Downloads 15 novels, retains the title and author columns,
                            #and unnests them.
#Here we have 15 of Charles Dickens' novels, unnested and ready for cleaning and anything
#else we might need to do. Doing it like this puts all of your text data into a single 
#object, instead of creating fifteen discrete objects and merging them together.
scrubbedDickens <- dickensNovels %>% 
  anti_join(stop_words) #Scrubs text
#Let's do a quick word search.
dickensWC <- scrubbedDickens %>% 
  count(word, sort = TRUE) %>% 
  top_n(25) %>% 
  mutate(word = reorder(word, n))
#And plot the results.
ggplot(data = dickensWC) +
  aes(word, n) +
  geom_col()+
  coord_flip()+
  xlab("words")+
  ylab("count")+
  ggtitle("Yeah it's a word count alright")
#Now let's do sentiment analysis. Bing first
modBing <- get_sentiments("bing") %>% 
  filter(word != "miss") #We do this to filter out the word "miss" from the bing lexicon.
                         #We do this because bing reads the word as negative, not a title.
dickensSentimentRatio <- dickensNovels %>% 
  group_by(title) %>% #group data by title
  inner_join(modBing) %>% #add modded Bing data
  count(sentiment) %>% #count sentiment
  spread(sentiment, n) %>%
  mutate(sentiment = positive - negative) %>% #new column with sentiment difference
  mutate(posRatio = (positive)/(positive + negative)) %>% #new column with positive ratio
  ungroup() %>% 
  mutate(title = reorder(title, posRatio)) #reorder the title column by posRatio
#And graph it.
ggplot(dickensSentimentRatio, aes(title, posRatio)) +
  geom_point(col = "tomato2", size=3)+
  geom_segment(aes(x=title, xend = title, y=min(posRatio), yend = max(posRatio)),
               linetype = "dashed", size = 0.1)+
  coord_flip()
#NRC sentiment analysis.
nrcFear <- get_sentiments("nrc") %>% 
  filter(word != "miss") %>% 
  filter(sentiment == "fear")
dickensFear <- dickensNovels %>% 
  inner_join(nrcFear) %>% 
  count(word, sort = TRUE) %>% 
  top_n(25) %>% 
  mutate(word = reorder(word, n))
#No ggplot for this one, because I didn't get to it quick enough
#And AFINN
afinn <- lexicon_afinn()
modAfinn <- afinn %>% 
  filter(word != "miss")
dickensAfinn <- dickensNovels %>% 
  group_by(title) %>% 
  inner_join(modAfinn) %>% 
  summarise(sentiment = sum(value)) %>% 
  ungroup() %>% 
  mutate(title = reorder(title, sentiment)) %>% 
  top_n(-6)

ggplot(dickensAfinn, aes(title, sentiment)) +
  geom_col()+
  coord_flip()
#And there ya go. Sentiment analysis is getting the words