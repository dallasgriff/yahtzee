require 'terminal-table'

table = Terminal::Table.new do |t|
  t.title = 'Yahtzee Scorecard'
  t.headings = '', 'Score', 'Player 1', 'Player 2'
  t.add_row [1, 'Ones' '', '', '']
  t.add_row [2, 'Twos' '', '', '']
  t.add_row [3, 'Threes' '', '', '']
  t.add_row [4, 'Fours' '', '', '']
  t.add_row [5, 'Fives' '', '', '']
  t.add_row [6, 'Sixes' '', '', '']
  t.add_row [6, 'TOP TOTAL' '', '', '']
  t.add_row [7, '3 - Kind' '', '', '']
  t.add_row [8, '4 - Kind' '', '', '']
  t.add_row [9, 'Sm Strt' '', '', '']
  t.add_row [10, 'Lg Strt' '', '', '']
  t.add_row [11, 'Fll Hs' '', '', '']
  t.add_row [12, 'Yahtzee' '', '', '']
  t.add_row [13, 'Chance' '', '', '']
  t.add_row [13, 'BOTTOM TOTAL' '', '', '']
  t.add_row [13, 'GRAND TOTAL' '', '', '']

end

puts table

#
#   +---------+-------------+-------------+----------------+
#   | Player  | Top Score   | Lower Score | Total Score    |
#   +---------+-------------+-------------+----------------+
#   | One     |             |             |                |
#   | Two     |             |             |                |
#   +---------+-------------+-------------+----------------+

