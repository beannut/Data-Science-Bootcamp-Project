import random as ran
def game():
    weapons = ["rock", "paper", "scissors"]
    win = 0
    lose = 0
    tie = 0
    while True:
          player_weapons = input("Choose you weapon: rock paper scissors: ")
          computer_weapons = ran.choice(weapons)

          if player_weapons == 'exit':
            print("Good bye my friend")
            break
          elif player_weapons == "paper" and computer_weapons == "scissors":
              print("You lose!")
              lose += 1
          elif player_weapons == "scissors" and computer_weapons == "rock":
              print("You lose!")
              lose += 1
          elif player_weapons == "rock" and computer_weapons == "paper":
              print("You lose!")
              lose += 1
          elif player_weapons == computer_weapons:
              print("You tie!")
              tie += 1
          else:
              print("You win!")
              win += 1
  
          print(f"Player Weapons : {player_weapons}")
          print(f"Computer Weapons : {computer_weapons}")
          print(f"Win: {win}, lose: {lose}, Tie: {tie}")
