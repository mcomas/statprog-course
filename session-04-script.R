cards = c('2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A')
# Shuffling certain vector
sample(cards)

# Extraction or sampling without replacement
sample(cards, 5)

# Sampling with replacement
sample(cards, 5, replace = TRUE)

breast_cancer = c('yes', 'no')
sample(breast_cancer, 200, replace = TRUE, prob = c(0.004, 0.996))

# ====
# P("With breast cancer") = 0.004
# P("+ test" | "With breast cancer") = 0.8
# P("- test" | "Without breast cancer") = 0.9
# ====
# A = "With breast cancer"
# Ac = "Without breast cancer"
# B = "+ test"

# P("With breast cancer" | "+ test") = P(A|B) = P(A) x P(B|A) / (P(A) P(B|A)   + P(Ac) P(B|Ac))
0.004 * 0.8 / (0.004 * 0.8 + 0.996 * 0.1)

# P("With breast cancer" | "+ test") = 0.03

library(tidyverse)
N = 100000
test_result_sampling = function(breast_cancer){
  if(breast_cancer == 'yes'){
    sample(c('+', '-'), 1, prob = c(0.8, 0.2))
  }else{
    sample(c('+', '-'), 1, prob = c(0.1, 0.9))
  }
}
women40s = tibble(
  breast_cancer = sample(c('yes', 'no'), N, replace = TRUE, prob = c(0.004, 0.996)),
  test_result = map_chr(breast_cancer, ~test_result_sampling(.x))
)
women40s %>%
  count(breast_cancer, test_result)


sample_space = expand_grid(blue = 1:6, red = 1:6)
# P(A|C)
sample_space %>%
  filter((blue + red) %% 2 == 0) %>%  # Sum is even
  summarise(Prob_A_C = mean(blue == 6))

# P(A|B,C)
sample_space %>%
  filter(red == 6, (blue + red) %% 2 == 0) %>%  # Red is six and sum is even
  summarise(Prob_A_B.C = mean(blue == 6))

# They are different therefore they are dependant.
