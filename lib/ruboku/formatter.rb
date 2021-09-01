module Ruboku
  class Formatter
    def initialize(grid)
      @grid = grid
    end

    def format_grid(format: Ruboku::GridFormats::COMPACT)
      case format
      when Ruboku::GridFormats::COMPACT
        compact_format
      when Ruboku::GridFormats::PRETTY
        pretty_format
      end
    end

    private

    attr_accessor :grid

    def pretty_format
      horizontal_split = max_value.times.map { '-' }.each_slice(size).map(&:join).join('+') + "\n"
      blank = max_value.to_s.length.times.map { ' ' }.join
      # Rows 1 to max_value
      (1..max_value).each_slice(size).map do |vertical_slice|
        vertical_slice.map do |i|
          # Row i, columns 1 to max_value
          (1..max_value).each_slice(size).map do |horizontal_slice|
            horizontal_slice.map { |j| format_value(grid.grid[i-1][j-1]) }.join
          end.join('|')
        end.join("\n") + "\n"
      end.join(horizontal_split)
    end

    def compact_format
      grid.grid.map { |row| row.map { |value| format_value(value) }.join }.join("\n")
    end

    def blank_value
      @blank_value ||= digit_count(max_value).times.map { ' ' }.join
    end

    def format_value(value)
      value.is_a?(Integer) ? format(value_format, value) : blank_value(max_value)
    end

    def value_format
      @value_format ||= "%0#{digit_count(max_value)}d"
    end

    def digit_count(value)
      value.digits.count
    end

    def max_value
      grid.max_value
    end

    def size
      grid.size
    end
  end
end