library(tidyverse)

dplot = mpg %>%
  mutate(car = str_to_title(sprintf("%s %s", manufacturer, model))) %>%
  group_by(car) %>%
  summarise(hwy = mean(hwy)) %>%
  mutate(
    car = fct_reorder(car, hwy)
  )

p1 = ggplot(data=dplot) +
  geom_point(aes(x=hwy, y=car), shape = 21) +
  geom_text(aes(x=hwy, y=car, label = car), hjust = -0.1) +
  theme_classic() +
  theme(
    axis.text.y = element_blank(),
    axis.line.y = element_blank(),
    axis.ticks.y = element_blank()) +
  coord_cartesian(xlim = c(15, 40)) +
  labs(x = "Average Highway Miles per Gallon", y = '')

library(svglite)
ggsave(p1, filename = 'figure01.svg')

##
library(ggtern)
library(nycflights13)
dplot = flights %>%
  count(dest, origin) %>%
  group_by(dest) %>%
  mutate(p_dest = prop.table(n)) %>%
  filter(n() == 3) %>%
  pivot_wider(id = dest, names_from = origin, values_from = p_dest, values_fill = 0) %>%
  ungroup() %>%
  left_join(airports, by = c('dest' = 'faa')) %>%
  filter(tzone == "America/Chicago")

library(ggtern)
p2 = ggtern(data=dplot) +
  geom_mask() +
  geom_point(aes(x=LGA, y=EWR, z=JFK, col=name), 
            size = 2) +
  theme_light() +
  labs(title = 'Origin flight distribution with destination in America/Chicago time zone',
       subtitle = 'Only destination with available flights from all three origins are shown', 
       col = 'Destination')

ggsave(p2, filename = 'figure02.svg', width = 8.5, height = 5.8)
