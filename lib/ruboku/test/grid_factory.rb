module Ruboku
  module Test
    module GridFactory
      class << self
        # Initial
        # 7  |42 |9 1
        # 2  |319| 57
        #  93|756|8 4
        # ---+---+---
        # 958|2  |7  
        # 4  |   |   
        #    |   |2 8
        # ---+---+---
        # 546|1 7| 9 
        # 37 | 9 | 85
        # 8  |54 |   
        # Solved
        # 765|428|931
        # 284|319|657
        # 193|756|824
        # ---+---+---
        # 958|264|713
        # 432|871|569
        # 617|935|248
        # ---+---+---
        # 546|187|392
        # 371|692|485
        # 829|543|176
        def easy_9
          g = Ruboku::Grid.new(3)
          g.grid[0][0] = 7
          g.grid[0][3] = 4
          g.grid[0][4] = 2
          g.grid[0][6] = 9
          g.grid[0][8] = 1
          g.grid[1][0] = 2
          g.grid[1][3] = 3
          g.grid[1][4] = 1
          g.grid[1][5] = 9
          g.grid[1][7] = 5
          g.grid[1][8] = 7
          g.grid[2][1] = 9
          g.grid[2][2] = 3
          g.grid[2][3] = 7
          g.grid[2][4] = 5
          g.grid[2][5] = 6
          g.grid[2][6] = 8
          g.grid[2][8] = 4
          g.grid[3][0] = 9
          g.grid[3][1] = 5
          g.grid[3][2] = 8
          g.grid[3][3] = 2
          g.grid[3][6] = 7
          g.grid[4][0] = 4
          g.grid[5][6] = 2
          g.grid[5][8] = 8
          g.grid[6][0] = 5
          g.grid[6][1] = 4
          g.grid[6][2] = 6
          g.grid[6][3] = 1
          g.grid[6][5] = 7
          g.grid[6][7] = 9
          g.grid[7][0] = 3
          g.grid[7][1] = 7
          g.grid[7][4] = 9
          g.grid[7][7] = 8
          g.grid[7][8] = 5
          g.grid[8][0] = 8
          g.grid[8][3] = 5
          g.grid[8][4] = 4
          g
        end
      end
    end
  end
end