class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def play
    puts 'Get ready! The game is about to start!'
    sleep(1)
    take_turn until self.game_over == true
    game_over_message
    reset_game
  end

  def take_turn
    show_sequence
    require_sequence
    if @game_over == true
      game_over_message
      reset_game
    else
      round_success_message
      self.sequence_length += 1
    end
    sleep(2)
  end

  def show_sequence
    add_random_color
    self.seq.each do |color|
      puts "#{color}"
      sleep(2)
      system('clear')
    end
  end

  def require_sequence
    answer = []
    i = 0
    alive = true

    until alive == false || self.seq == answer
      puts 'Please enter the correct color'
      answer << gets.chomp.downcase
      if self.seq[i] != answer[i]
        @game_over = true
        alive = false
      else
        i += 1
      end
    end
  end

  def add_random_color
    @seq << COLORS.sample
  end

  def round_success_message
    puts 'Good Job! On to the next round.'
    sleep(1)
    system('clear')
  end

  def game_over_message
    puts 'Wrong answer... Game over!'
  end

  def reset_game
    self.sequence_length = 1
    self.game_over = false
    self.seq = []
  end
end

Simon.new.play
