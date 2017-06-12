require 'terminal-table'
 
class Player
  attr_accessor :name, :chooses, :score_top, :score_bottom, :total_score
   def initialize nameInput
    @name = nameInput
    @chooses = ["ones", "twos", "threes", "fours", "fives", "sixes", "3 of a kind", "4 of a kind", "small straight", "large straight", "full house", "chance","Yahtzee"]
    @score_top = 0
    @score_bottom = 0
    @total_score = 0
   end
def table
     table = Terminal::Table.new do |t|
    t.title = 'Yahtzee Scorecard'
    t.headings = '', 'Score', "#{name}"
    t.add_row [1, 'Ones' '', ""]
    t.add_row [2, 'Twos' '', '']
    t.add_row [3, 'Threes' '', '']
    t.add_row [4, 'Fours' '', '']
    t.add_row [5, 'Fives' '', '']
    t.add_row [6, 'Sixes' '', '']
    t.add_row [6, 'TOP TOTAL' '', '']
    t.add_row [7, '3 - Kind' '', '']
    t.add_row [8, '4 - Kind' '', '']
    t.add_row [9, 'Sm Strt' '', '']
    t.add_row [10, 'Lg Strt' '', '']
    t.add_row [11, 'Fll Hs' '', '']
    t.add_row [12, 'Yahtzee' '', '']
    t.add_row [13, 'Chance' '', '']
    t.add_row [13, 'BOTTOM TOTAL' '', '']
    t.add_row [13, 'Final Total' '', '']
  end
  puts table
end
 
 
  def score
    @total_score += @score_top + @score_bottom  
  end
 
def score_bonus
  if @score_top > 63
     @total_score += 25
  end
end
 
  
  
  def print_board
    @round.print
  end
 
  def ones(dice)
    @score_top += dice.count(1)*1 
  end
   
  def twos(dice)
    @score_top += dice.count(2)*2 
  end
   
  def threes(dice)
    @score_top += dice.count(3)*3 
  end
   
  def fours(dice)
    @score_top += dice.count(4)*4 
  end
   
  def fives(dice)
    @score_top += dice.count(5)*5 
  end
   
  def sixes(dice)
    @score_top += dice.count(6)*6 
  end
  
  def set_one dice
    dice.each do |x|
      if dice.count(x) >= 3
        @score_bottom += x
      end
    end
  end
  
  def set_two dice
    dice.each do |x|
      if dice.count(x) >= 4
        @score_bottom += x
      end
    end
  end
 
  def set_three dice
    if dice.sort === [1,2,3,4] || [2,3,4,5] || [3,4,5,6]
      puts "small straight!!!"
      @score_bottom += 30
    else
      puts "nope, not a straight... 0 points"
    end
  end
 
  def set_four dice
    if dice.sort === [1,2,3,4,5] || [2,3,4,5,6]
      puts "straight!!!"
      @score_bottom += 35
    else
      puts "nope, not a straight... 0 points"
    end
  end
  
  def set_five dice
    @test = []
    dice.each do |x|
      @test << dice.count(x)
    end
    if @test == [3,3,3,2,2]
      puts "you just got a full house"
      @score_bottom += 45
    else
      puts "You will get 0 points because you do not have a full house"
    end
  end
 
  def set_six dice
    dice.each { |a| @score_bottom += a }
  end
  
  def chooseAction playersDice
    @dice = playersDice
    def options userChoose
      case userChoose
      when "ones"
        ones @dice 
        @chooses.delete("ones")    
      when "twos"
        twos @dice
        @chooses.delete("twos")    
      when "threes"
        threes @dice
        @chooses.delete("threes")    
      when "fours"
        fours @dice
        @chooses.delete("fours")    
      when "fives"
        fives @dice
        @chooses.delete("fives")    
      when "sixes"
        sixes @dice
        @chooses.delete("sixes")    
      when "3 of a kind"
        set_one @dice
        @chooses.delete("3 of a kind")    
      when "4 of a kind"
        set_two @dice
        @chooses.delete("4 of a kind")    
      when "small straight"
        set_three @dice
        @chooses.delete("small straight")
      when "large straight"
        set_four @dice
        @chooses.delete("large straight")
      when "full house"
        set_five @dice
        @chooses.delete("full house")
      when "chance"
        set_six @dice
        @chooses.delete("chance")
      when "Yahtzee"
        set_seven @dice
        @chooses.delete("Yahtzee")
      else
        puts "That is not a choice"
        choose
      end
    end
    def choose 
      puts "choose your method"
      p @chooses
      @choiceInput = gets.chomp
      if @chooses.include?(@choiceInput)
        options @choiceInput
      else
        puts "That is not an option"
        choose
      end
    end
    
    choose
end
 
  def start_turn
    @playersDice = doRolling
    chooseAction @playersDice
  end
 
  def finished?
    @round.complete?
  end
  UPPER_MOVES = [:ones, :twos, :threes, :fours, :fives, :sixes]
  LOWER_MOVES = [:full_house, :small_straight, :large_straight, :three_of_a_kind, :four_of_a_kind, :yahtzee, :chance]
  
  def upper_bonus
    upper_total_raw >= 63 ? 35 : 0
  end
  
  def upper_total
    upper_total_raw + upper_bonus
  end
  
  def lower_total
    subtotal(lower_moves)
  end
  
  def grand_total
    lower_total + upper_total
  end
  
  
  def doRolling
    @howManyRolls = 0
    def keepDice playerArray
      @playerArray = playerArray
      @diceKeptArray = []
      def keepTheseDice
        puts "What dice do you want to keep?"
        p @playerArray
        input = gets.chomp.split(" ").map(&:to_i)        
        if @playerArray.include?(input[0])
          input.each do |input|
            removeIndex = @playerArray.index(input)
            @playerArray.delete_at(removeIndex)
            @diceKeptArray << input
          end
        else
          puts "You are cheating"
        end
        puts "Do you want to keep any more dice, you are currently keeping"
        p @diceKeptArray
        if gets.chomp == "yes"
          keepTheseDice
        else
          puts "Do you want to roll again?"
          if gets.chomp == "yes"
            puts "Rolling dice"
            rollDice @diceKeptArray
          else
            puts "You have these dice"
            p @diceKeptArray + @playerArray
            return @diceKeptArray + @playerArray
          end
        end
      end
      keepTheseDice
    end
    def rollDice array
      until array.length == 5
        array << rand(1..6)
        sleep 0.1
        p array
      end
       @howManyRolls += 1
      if @howManyRolls < 3
       keepDice array
      else
        @howManyRolls = 0
        puts "This is your role"
        p array
        array
      end
    end
    rollDice []
  end
  
    def print
      puts "1s\t\t#{score(:ones)}"
      puts "2s\t\t#{score(:twos)}"
      puts "3s\t\t#{score(:threes)}"
      puts "4s\t\t#{score(:fours)}"
      puts "5s\t\t#{score(:fives)}"
      puts "6s\t\t#{score(:sixes)}"
      puts "bonus\t\t#{upper_bonus}"
      puts "upper total\t#{upper_total}"
      puts "3 of a kind\t#{score(:three_of_a_kind)}"
      puts "4 of a kind\t#{score(:four_of_a_kind)}"
      puts "full house\t#{score(:full_house)}"
      puts "small_straight\t#{score(:small_straight)}"
      puts "large_straight\t#{score(:large_straight)}"
      puts "yahtzee\t\t#{score(:yahtzee)}"
      puts "chance\t\t#{score(:chance)}"
      puts "lower total\t#{lower_total}"
      puts "grand total\t#{grand_total}"
    end
  
    private
    def subtotal(move_set)
      move_set.map {|name, move| move.score}.inject(0){|total, val| total + (val.nil? ? 0 : val)}
    end
  
    def upper_moves
      @moves.select {|name,move| UPPER_MOVES.include? name}
    end
  
    def lower_moves
      @moves.select {|name,move| LOWER_MOVES.include? name}
    end
end
 
@playersArray = []
 
  def createPlayers
    puts "How many people are playing today?"
    amtOfPlayers = gets.chomp.to_i
    amtOfPlayers.times do
      puts "What is your name?"
      input = gets.chomp
      input = Player.new input
      @playersArray << input
    end
  end
 
createPlayers
 
13.times do
  @playersArray.each do |x|
    if x.chooses.count >= 1
      x.table
      puts "It is #{x.name}'s turn!"
      x.start_turn
      x.score
      puts "#{x.name} has #{x.total_score} points!"
    else
      score_bonus
          puts "#{x.name} has #{x.total_score}"
    end
  end
end
