a <- 2
cat(sprintf("%d\n", a))

# How to create functions.
squared = function(x){
  return(x * x) # x^2
}

# We can remove return() statement
squared = function(x){
  x * x # x^2
}

b <- squared(a)
cat(b, "\n")

# Vectors

## atomic vectors
x = c(1,2,3,4,5,6)
typeof(x)

y = c(TRUE, FALSE, FALSE)
typeof(y)

z = c(TRUE, 2, 4, "stringr")
typeof(z)

typeof(seq(2, 10))
2:10
seq(1, 10, 2)
seq(1, 10, length.out = 20)

typeof(c(c(1,2,3,4), c(3,4,5,6)))
class(x)
class(y)

# logical -> integer -> numeric (double) -> character

## lists
lx = list(TRUE, c(1L, 2L, 4L), c(6,7,8), c("I", "am", "Marc"))
ly = list(list(1,2,3), list(4,5,6))


## Arrays and matrices

# They are built from vectors with an attribute denoting dimension
m = 1:10
dim(m) = c(2, 5)
class(m)
typeof(m)


lm = list(1,"2",TRUE,4,5,6)
dim(lm) = c(2,3)
lm


# Subsetting
z[c(1,4,2,3,3,3,3)]
z[-1]
z[-c(2,4)]

## Selection with logical vectors
## We want to select all the elements greater than 3
x[c(FALSE, FALSE, FALSE, TRUE, TRUE, TRUE)]
x > 3
x[x>3]


xm = x

names(xm) = c("one", "two", "three", "four", "five", "six")
xm[c("three", "six")]
xm[c("three", "six", "six")]


lx[c(1,3)]
lx[c(TRUE, FALSE, FALSE, FALSE)]

## List's have an special selection operator "[[*]]"
typeof(lx[[4]])
typeof(lx[4])

## With matrices we have another way to select: indexing in within dimensions
lm[1,2]

## Iteration
for(i in x){
  cat(-i, "\n")
}

for(i in x+1){
  cat(-i, "\n")
}

for(i in 1:length(x)){
  cat(-x[i], "\n")
}

# Let's do a more real example
# We create a list with people information
L = list(
  list('name' = 'Marc',
       'age' = 40,
       'sex' = 'male'),
  list('name' = 'Manel',
       'age' = 45,
       'sex' = 'male'),
  list('name' = 'Christine',
       'age' = 30,
       'sex' = "female"),
  list('name' = 'Sonia',
       'age' = 43,
       'sex' = 'female')
)

# We want to print the information in a single string.  It will take the following pattern
# "%s is %s years old and is a %s"

result = vector(mode = 'character', 4) # Equivalently, rep("", 4)
for(i in 1:length(L)){
  list_vector = L[[i]]
  result[i] = sprintf("%s is %s years old and is a %s", list_vector[['name']], list_vector[['age']], list_vector[['sex']])
}


# We can capture the main functionality with a function
print_person = function(name, age, sex){
  sprintf("%s is %s years old and is a %s", name, age, sex)
}

result = vector(mode = 'character', 4) # rep("", 4)
for(i in 1:length(L)){
  list_vector = L[[i]]
  result[i] = print_person(list_vector[['name']], list_vector[['age']], list_vector[['sex']])
}
result


# Or better, we can capture the functionality from each element of the list
l_print_person = function(list_vector){
  sprintf("%s is %s years old and is a %s", list_vector[['name']], list_vector[['age']], list_vector[['sex']])
}

result = rep("", 4)
for(i in 1:length(L)){
  result[i] = l_print_person(L[[i]])
}
result

# With apply functions, we can apply the function `l_print_person()` to each element of L.
sapply(L, l_print_person)


# We can avoid the creation of `l_print_person` object and passing the function as a parameter
sapply(L, function(list_vector){
  sprintf("%s is %s years old and is a %s", list_vector[['name']], list_vector[['age']], list_vector[['sex']])
})

## `lapply` is doing the same as `sapply` bu returning a list
lapply(L, l_print_person)

# mapply iterates in different vectors. In this example we will use it with function `paste()`.

# paste function concatenate strings
paste("a", "b")

# We can concatenate element by element
mapply(paste, c(1,2,3,4), c("one", "two", "three", "four"), c(TRUE, FALSE, TRUE, FALSE))

# Usually, R functions reuse the elements of a vector if they are not length enough
mapply(paste, c(1,2,3), c("one", "two", "three", "four"), c(TRUE))


# Note: In fact, because function paste() i svectorial, it was not necessary to iterate with function `mapply()`.
paste(c(1,2,3,4), c("one", "two", "three", "four"), c(TRUE, FALSE, TRUE, FALSE))


library(purrr)
# To replicate the behaviour  of `sapply(L, l_print_person)`
map_chr(L, l_print_person)

# To replicate `mapply(paste, c(1,2,3,4), c("one", "two", "three", "four"), c(TRUE, FALSE, TRUE, FALSE))`
pmap_chr(list(c(1,2,3,4), c("one", "two", "three", "four"), c(TRUE, FALSE, TRUE, FALSE)), paste)


# Answering to the question. Is it the same iterate throught 1:length(L) or L?

# Here we are iterating throught integers 1 -> 2 -> 3 -> 4
for(i in 1:length(L)){
  # i = 1
  
  print(l_print_person(L[[i]]))
}

# Here we are iterating throught the elements of the list (the lists containing people information)
for(i in L){
  # i = list('name' = 'Marc',
  #          'age' = 40,
  #          'sex' = 'male')
  print(l_print_person(i))
}
