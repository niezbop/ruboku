RSpec.describe Ruboku::Solver do
  let(:solver) { Ruboku::Solver.new }
  let(:empty_3x3) { Ruboku::Grid.new }

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
  let(:easy_3x3_unsolved) do
    Ruboku::Grid.from_grid([
      [7,nil,nil,4,2,nil,9,nil,1],
      [2,nil,nil,3,1,9,nil,5,7],
      [nil,9,3,7,5,6,8,nil,4],
      [9,5,8,2,nil,nil,7,nil,nil],
      [4,nil,nil,nil,nil,nil,nil,nil,nil],
      [nil,nil,nil,nil,nil,nil,2,nil,8],
      [5,4,6,1,nil,7,nil,9,nil],
      [3,7,nil,nil,9,nil,nil,8,5],
      [8,nil,nil,5,4,nil,nil,nil,nil]
    ])
  end

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
  let(:easy_3x3_solved) do
    Ruboku::Grid.from_grid([
      [7,6,5,4,2,8,9,3,1],
      [2,8,4,3,1,9,6,5,7],
      [1,9,3,7,5,6,8,2,4],
      [9,5,8,2,6,4,7,1,3],
      [4,3,2,8,7,1,5,6,9],
      [6,1,7,9,3,5,2,4,8],
      [5,4,6,1,8,7,3,9,2],
      [3,7,1,6,9,2,4,8,5],
      [8,2,9,5,4,3,1,7,6]
    ])
  end

  describe '#solve' do
    it 'solves easy 3x3 grid' do
      expect(solver.solve(easy_3x3_unsolved)).to eq(easy_3x3_solved)
    end
  end
end