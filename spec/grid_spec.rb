RSpec.describe Ruboku::Grid do
  let(:trivial_1x1) { Ruboku::Grid.from_grid([[1]]) }
  let(:simple_2x2) do
    Ruboku::Grid.from_grid([
      [1,2,3,4],
      [3,4,1,2],
      [2,3,4,1],
      [4,1,2,3]
    ])
  end

  describe '::from_grid' do
    it 'returns a Ruboku::Grid' do
      expect(trivial_1x1).to be_a(Ruboku::Grid)
    end

    it 'infers size correctly in trivial cases (size=1)' do
      expect(trivial_1x1.size).to be(1)
    end

    it 'infers size correctly in non-trivial cases (size=2)' do
      expect(simple_2x2.size).to be(2)
    end

    it 'raises ArgumentError if the parameter is not an array' do
      expect { Ruboku::Grid.from_grid(:foo) }.to raise_error(ArgumentError)
    end

    it 'raises ArgumentError if the parameter is not an array of arrays' do
      expect { Ruboku::Grid.from_grid([:foo]) }.to raise_error(ArgumentError)
    end

    it 'raises ArgumentError if the grid is not square' do
      expect { Ruboku::Grid.from_grid([[1,2]]) }.to raise_error(ArgumentError)
    end

    it 'raises ArgumentError if any value is greater than the max' do
      expect { Ruboku::Grid.from_grid([[2]]) }.to raise_error(ArgumentError)
    end
  end

  describe '#size' do
    it 'is 3 by default' do
      expect(Ruboku::Grid.new.size).to eq(3)
    end

    it 'is the value passed to the constructor' do
      expect(Ruboku::Grid.new(4).size).to eq(4)
    end
  end

  describe '#max_value' do
    it 'is 9 by default' do
      expect(Ruboku::Grid.new.max_value).to eq(9)
    end

    it 'is the square of the value passed to the constructor' do
      expect(Ruboku::Grid.new(4).max_value).to eq(16)
    end
  end

  describe '#acceptable_values' do
    it 'is 1 to 9 by default' do
      expect(Ruboku::Grid.new.acceptable_values).to match_array([1,2,3,4,5,6,7,8,9])
    end

    it 'is all the values between 1 and the square of the value passed to the constructor' do
      expect(Ruboku::Grid.new(2).acceptable_values).to match_array([1,2,3,4])
    end
  end

  describe '#grid' do
    it 'is an array of arrays' do
      expect(Ruboku::Grid.new.grid).to be_an(Array)
      expect(Ruboku::Grid.new.grid.first).to be_an(Array)
    end

    it 'has max_value rows' do
      expect(Ruboku::Grid.new.grid).to have_attributes(count: 9)
    end

    it 'has max_value columns' do
      expect(Ruboku::Grid.new.grid).to all(have_attributes(count: 9))
    end
  end

  describe '#to_a' do
    it 'has the right number of elements' do
      expect(Ruboku::Grid.new(3).to_a).to have_attributes(count: 81)
    end

    it 'lists elements in the right order' do
      expect(simple_2x2.to_a).to match_array([1,2,3,4,3,4,1,2,2,3,4,1,4,1,2,3])
    end
  end
end