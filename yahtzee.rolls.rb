@howManyRolls = 0



def keepDice playerArray
  @playerArray = playerArray
  @diceKeptArray = []
  def keepTheseDice
    puts "You will be throwing away these dice!"
    p @playerArray
    
    input = gets.chomp.to_i
    if @playerArray.include?(input)
      removeIndex = @playerArray.index(input)
      @playerArray.delete_at(removeIndex)
      @diceKeptArray << input
    else
      puts "You are cheating"
    end
    puts "Do you want to keep any more dice, you are currently keeping"
    p @diceKeptArray
    if gets.chomp == "yes"
      keepTheseDice
    else
      puts "Rolling dice"
      rollDice @diceKeptArray
    end
  end
  keepTheseDice
end



def rollDice array
  until array.length == 5
    array << rand(1..6)
    sleep 0.5
    p array
  end
   @howManyRolls += 1
  if @howManyRolls < 3
   keepDice array
  else
    @homeManyRolls = 0
    puts "This is your role"
    p array
    array
  end
end