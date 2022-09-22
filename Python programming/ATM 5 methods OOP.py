class ATM:
  def __init__(self, name, account_number, bank_name, balance, password):
      self.name = name
      self.account_number = int(account_number)
      self.bank_name = bank_name
      self.balance = balance
      self.password = password

  def __str__(self):
      return f"Welcome to {self.bank_name}"

  
  def deposit(self):
      deposit_amount= int(input("How much do you want to deposit in this account?: "))
      self.balance = self.balance + deposit_amount
      print(f"Your current balance = {self.balance} Baht")
  
  def withdrawal(self):
      withdrawal_amount = int(input("How much do you want to withdraw in this account?: "))
      
      if self.balance >= withdrawal_amount:
          print("Your withdrawal was successful")
          self.balance = self.balance - withdrawal_amount
          print(f"Your current balance = {self.balance} Baht")

      else:
        print("Insufficient funds")
  
  def current_balance(self):
        print(f"Your current balance = {self.balance} Baht")

  def transfer(self):
      tran_account_num = int(input("What is your account number?: ")) 
      tran_account_amount = int(input("How much do you want to transfer?: "))

      if self.balance >= tran_account_amount:
          print("Your transactions was successfull")
          self.balance = self.balance - tran_account_amount
          print(f"Your current balance = {self.balance} Baht")
      
      else:
          print("Insufficient funds")
    
  def atm_password(self):
      your_password = int(input("Please enter the 6 digit bank password: "))
      x = 0
      while x<3:
        if self.password == your_password:
            print("Correct")
            break
        else:
            print(" Incorrect Password : The password you entered is incorrect. Please try again")
            x = x+1


