## Activity 1
tab1 = flights %>%
  group_by(month, origin, dest) %>%
  summarise(.groups = 'drop_last',
            distance = median(distance, na.rm=TRUE),
            n = n(),
            dep_delay_m = median(dep_delay, na.rm=TRUE),
            arr_delay_m = median(arr_delay, na.rm=TRUE),
            dep_arr_delay_cor = cor(dep_delay, arr_delay, use = 'na.or.complete')
  ) %>%
  mutate(p_origin = prop.table(n)) %>%
  group_by(month, dest) %>%
  mutate(p_dest = prop.table(n)) %>%
  ungroup() %>%
  # left_join(airports %>% select(faa, lat_origin = lat, lon_origin = lon), by = c('origin' = 'faa')) %>%
  left_join(airports %>% select(faa, lat_dest = lat, lon_dest = lon), by = c('dest' = 'faa')) %>%
  arrange(month, desc(n))

tab1 %>%
  filter(dest == "ATL") %>%
  pivot_wider(month, names_from = origin, values_from = p_dest)

## Proposal for activity 2
cases = new_cases %>%
  select(-World) %>%
  pivot_longer(cols = -date, values_to = 'cases', values_drop_na = TRUE)
deaths = new_deaths %>%
  select(-World) %>%
  pivot_longer(cols = -date, values_to = 'deaths', values_drop_na = TRUE)
tab2 = locations %>%
  select(name = location, population) %>%
  right_join(
    inner_join(cases, deaths, by = c("date", "name")), by = 'name') %>%
  arrange(desc(date))


tab2 %>%
  filter(month(date) == 10) %>%
  group_by(name) %>%
  summarise(.groups = 'drop',
            cases_inc = 1000 * 365.25 * mean(cases / first(population)),
            deaths_inc = 1000 * 365.25 * mean(deaths / first(population))) %>%
  arrange(desc(deaths_inc))

