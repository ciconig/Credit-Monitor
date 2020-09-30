# packages used to plot ts in ggplot 
library("ggfortify")
library("changepoint")
library("strucchange")
library("ggpmisc")

## System 

## Total Loans

com.loans = as.vector(SYSTEM$`1302000`, "numeric")
mort.loans = as.vector(SYSTEM$`1304000`, "numeric")
consumer.loans = as.vector(SYSTEM$`1305000`, "numeric")
credit.cards = as.vector(SYSTEM$`1305400`, "numeric")
personal = as.vector(SYSTEM$`1305100`, "numeric")

total.loans = com.loans+mort.loans+consumer.loans+credit.cards+personal

dates = c(dates, dates1)
remove(dates1)
df = data.frame(dates, total.loans, com.loans, mort.loans, consumer.loans, credit.cards, personal)


## Crescimento

df$Growth <- with(df, ave(total.loans, FUN= function(x) c(NA, diff(x)/x[-length(x)]) ))
ggplot(df, aes(dates, Growth)) +
  geom_line(color = "#00AFBB", size = 1) + 
  theme_minimal() +
  labs(title = "Total Loans, (%)", subtitle = "SYSTEM", y = "value")

## Por segmento individual 

df$Growth <- with(df, ave(com.loans, FUN= function(x) c(NA, diff(x)/x[-length(x)]) ))
ggplot(df, aes(dates, com.loans)) +
  geom_line(color = "#00AFBB", size = 1) + 
  theme_minimal() +
  labs(title = "Comercial Loans, (Milions)", subtitle = "SYSTEM", y = "value") + 
  scale_y_continuous(labels = comma)

df$Growth <- with(df, ave(mort.loans, FUN= function(x) c(NA, diff(x)/x[-length(x)]) ))
ggplot(df, aes(dates, Growth)) +
  geom_line(color = "#00AFBB", size = 1) + 
  theme_minimal() +
  labs(title = "Mortgage Loans", subtitle = "SYSTEM", y = "value") +
  scale_y_continuous(labels = comma)

df$Growth <- with(df, ave(consumer.loans, FUN= function(x) c(NA, diff(x)/x[-length(x)]) ))
ggplot(df, aes(dates, Growth)) +
  geom_line(color = "#00AFBB", size = 1) + 
  theme_minimal() +
  labs(title = "Consumer Loans", subtitle = "SYSTEM", y = "value") +
  scale_y_continuous(labels = comma)

## multiplos segmentos

growth_rate <- function(x)(x/lag(x)-1)

df$growth <- growth_rate(df$total.loans)
df$com.growth <- growth_rate(df$com.loans)
df$mort.growth = growth_rate(df$mort.loans)
df$consumer.growth = growth_rate(df$consumer.loans)
df$credit.growth = growth_rate(df$credit.cards)
df$personal.growth = growth_rate(df$personal)

df.growth = as.data.frame(cbind(dates, df$growth, df$com.growth, df$mort.growth, df$consumer.growth, df$credit.growth,
              df$personal.growth))
df.growth$dates = dates

df.growth = df %>% 
  select(dates, com.growth, mort.growth, consumer.growth) %>%
  gather(key = "variable", value = "value", -dates)


ggplot(df.growth, aes(x = dates, y = value)) + 
  geom_line(aes(color = variable), size = 1) + 
  scale_color_manual(values = c("darkslategrey", "steelblue", "darkseagreen4")) + 
  theme_minimal() + 
  labs(title = "Loan Growth by segment, %", ylab("Growth"), xlab("dates")) 

ggplot(df.growth, aes(x = dates)) +
  geom_line(aes(y = com.growth), size = 1, color = "steelblue") + 
  labs(title = "Loan Growth by segment, %") 




















