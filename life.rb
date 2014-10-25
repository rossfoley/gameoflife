class Life
  def initialize(board)
    @board = board
    @prev = board
    @height = board.length
    @width = board[0].length
  end

  def to_s
    @board.map do |row|
      row.join ' '
    end.join "\n"
  end

  def next
    copy_board_to_prev
    for y in (0...@height)
      for x in (0...@width)
        neighbors = alive_neighbors(x, y) 

        if alive? x,y
          if neighbors < 2 or neighbors > 3
            @board[y][x] = 0
          else
            @board[y][x] = 1
          end
        else
          if neighbors == 3
            @board[y][x] = 1
          else
            @board[y][x] = 0
          end
        end
      end
    end
  end

  private

  def alive?(x, y)
    @prev[y][x] == 1
  end

  def alive_neighbors(x, y)
    neighbors = [get(x-1, y-1), get(x, y-1), get(x+1, y-1),
                 get(x-1, y),                get(x+1, y),
                 get(x-1, y+1), get(x, y+1), get(x+1, y+1)]
    neighbors.reduce :+
  end

  def get(x, y)
    if x < 0 or x >= @width
      0
    elsif y < 0 or y >= @height
      0
    else
      @prev[y][x]
    end
  end

  def copy_board_to_prev
    @prev = @board.map do |row|
      row.clone
    end.clone
  end
end
