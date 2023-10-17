require './lib/game_board'
require './lib/player'
require './lib/cell'

class Game_Controller
  def initialize
    @game_board = Game_Board.new
    @players = Array.new
    add_player("One")
    add_player("Two")
    @active_player_one = {
      player: @players[0],
      mark: "O"
    }
    @active_player_two = {
      player: @players[1],
      mark: "X"
    }
    @active_player = @active_player_one
    @winner = nil
    @menu = :menu_main
  end

  def new_game
    puts "New Game"
    @game_board.clear
    @winner = nil
  end

  def start_game
    loop do
      case @menu
      when :menu_main
        puts "MAIN MENU"
        puts "1. Play"
        puts "2. Display Players"
        puts "3. Add Player"
        puts "4. Select Players"
        case gets.to_i
        when 1 then @menu = :menu_play
        when 2 then display_players
        when 3 then add_player
        when 4 then @menu = :menu_select_players
        end
      when :menu_play
        puts ""
        puts "PLAY"
        if @winner
          new_game
          @menu = :menu_main
        else
          puts @game_board
          puts "Turn: #{@active_player[:player].name} (#{@active_player[:mark]})"
          puts "Enter Row and Col"
          play_turn(gets.to_i, gets.to_i)
        end
      when :menu_select_players
        puts ""
        puts "SELECT PLAYERS"
        display_players
        puts "Enter Player One and Player Two IDs"
        select_players(gets.to_i, gets.to_i)
      end
    end
  end

  private

  def display_players
    puts ""
    puts "Player Name (Win:Tie:Lose)"
    @players.each_with_index {|player, i| puts "#{i+1}. #{player}" }
  end

  def add_player(name = nil)
    while name == nil
      puts ""
      puts "Enter Player Name:"
      name = gets.chomp
    end
    @players.push(Player.new(name))
  end

  def select_players(p1, p2)
    if p1 == p2 || !p1.between?(1, @players.length) || !p2.between?(1, @players.length)
      puts "Invalid player choices (#{p1},#{p2})"
    else
      @active_player_one[:player] = @players[p1 - 1]
      @active_player_two[:player] = @players[p2 - 1]
      puts "Valid player choices (O: #{@active_player_one[:player].name}, X: #{@active_player_two[:player].name})"
      @menu = :menu_main
    end
  end

  def play_turn(row, col)
    mark = @active_player[:mark]
    if @winner || !row.between?(0,2) || !col.between?(0,2) || !@game_board.set_mark(row, col, mark) 
      puts "Invalid #{mark} move at (#{row},#{col})"
    else
      puts "Valid #{mark} move at (#{row},#{col})"
      check_win
      switch_turn
    end
  end

  def check_win
    # Win
    mark_win("Top Row")           if board_equal([[0,0], [0,1], [0,2]])
    mark_win("Middle Row")        if board_equal([[1,0], [1,1], [1,2]])
    mark_win("Bottom Row")        if board_equal([[2,0], [2,1], [2,2]])
    mark_win("Left Column")       if board_equal([[0,0], [1,0], [2,0]])
    mark_win("Center Column")     if board_equal([[0,1], [1,1], [2,1]])
    mark_win("Right Column")      if board_equal([[0,2], [1,2], [2,2]])
    mark_win("Forward Diagonal")  if board_equal([[2,0], [1,1], [0,2]])
    mark_win("Backward Diagonal") if board_equal([[0,0], [1,1], [2,2]])
    # Tie
    if @game_board.board.flatten.map {|cell| cell.mark }.uniq.sort == ["O", "X"]
      @winner = "TIE"
      puts "TIE GAME"
      @active_player[:player].tie
      switch_turn
      @active_player[:player].tie
      switch_turn
    end
  end

  def board_equal(pos)
    pos.map {|coor| @game_board.get_mark(coor[0], coor[1]) }.push(@active_player[:mark]).uniq.size == 1
  end

  def mark_win(msg)
    @winner = @active_player[:player].name
    puts "#{msg} Victory for #{@winner}"
    @active_player[:player].win
    switch_turn
    @active_player[:player].lose
    switch_turn
  end

  def switch_turn
    @active_player = @active_player == @active_player_one ? @active_player_two : @active_player_one 
  end
end