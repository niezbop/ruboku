module Ruboku
  class Grid
    class << self
      def from_grid(array_of_arrays)
        raise ArgumentError, 'Not a grid' unless
          array_of_arrays.is_a?(Array) and
          array_of_arrays.all? { |array| array.is_a? Array }
        raise ArgumentError, 'Not a standard layout' unless
          is_perfect_square?(array_of_arrays.count) and
          array_of_arrays.all? { |array| array.count == array_of_arrays.count }

        size = Math.sqrt(array_of_arrays.count).to_i
        max_value = size * size
        acceptable_values = (1..max_value).to_a + [ nil ]

        raise ArgumentError, 'Unexpected values' if array_of_arrays.flatten.any? { |value| !acceptable_values.include?(value) }

        grid = self.new(size, fill: false)
        grid.grid = array_of_arrays
        return grid
      end

      private

      def is_perfect_square?(value)
        square_root_i = Math.sqrt(value).to_i
        square_root_i * square_root_i == value.to_i
      end
    end

    attr_accessor :grid, :size, :max_value, :acceptable_values
    include Enumerable

    def initialize(size = 3, fill: false)
      @size = size
      @max_value = size * size
      @acceptable_values = (1..max_value).to_a
      @grid = max_value.times.map { max_value.times.map { fill ? @acceptable_values.sample : nil } }
    end

    def format(format: Ruboku::GridFormats::COMPACT)
      Ruboku::Formatter.new(self).format_grid(format: format)
    end

    def each
      self.each_with_index { |value, _index| yield value }
    end

    def each_with_index
      grid.each_with_index { |row, i| row.each_with_index { |value, j| yield value, [i,j] }}.flatten
    end

    def each_row(&block)
      grid.each(&block)
    end
  end
end