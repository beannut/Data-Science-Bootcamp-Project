## Rock Scissors Paper
## Rock = 1, Paper = 2, Scissors = 3, Exit = 4


weapons <- c("rock", "paper", "scissors", "exit")
win <- 0
lose <- 0
tie <- 0

Rock_Scissors_Paper_Game <- function() {
  
  while (TRUE) {
    player_weapons <- as.numeric(readline("Choose your move: Rock[1], Paper[2], Scissors[3], Exit[4]: "))
    if (player_weapons == 4){
      cat("Good Bye My Friend!")
      break
    }
    
    player_weapons <- weapons[player_weapons]
    computer_weapons <- weapons[sample(1:3, 1)]
    
    if (player_weapons == computer_weapons) {
      tie <- tie + 1
      
    } else if (player_weapons == "paper" & computer_weapons == "scissors") {
      lose <- lose + 1
    } else if (player_weapons == "scissors" & computer_weapons == "rock") {
      lose <- lose + 1
    } else if (player_weapons == "rock" & computer_weapons == "papers") {
      lose <- lose + 1
    } else {
      win <- win + 1 
    } 
    
    cat("Player Weapons:", player_weapons, "\n")
    cat("Computer Weapons:", computer_weapons, "\n")
    cat("Win:",win, "lose:",lose,"Tie:",tie)
  }
}
