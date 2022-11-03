monty_hall = function(selection){
  doors = sample(c('goat','goat','car'))
  doors_discarted = which(1:3 != selection & doors != 'car')
  door_discarted = doors_discarted[sample.int(length(doors_discarted), 1)]
  cat(sprintf("Door %d has a goat. Do you want to change your choice?\n",  door_discarted))
  while(TRUE){
    cat("Type y or n and press return\n")
    yn = scan(nmax = 1, what = 'character', quiet = TRUE)
    if(yn %in% c('y','n')) break
  }
  if(yn == 'y') selection = setdiff(1:3, c(selection, door_discarted))
  
  if(doors[selection] == 'car'){
    cat("Congratulations. You have won a car!!!\n")
  }else{
    cat("Ohh! You have got the goat.\n")
  }
}
