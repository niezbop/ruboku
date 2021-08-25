module Ruboku
  class Solver
    class UnsolvableError < StandardError
    end

    class TooManyIterationsError < StandardError
    end

    attr_accessor :max_iterations, :verbose

    def initialize(max_iterations: 10_000, verbose: false)
      @max_iterations = max_iterations
      @verbose = verbose
    end

    def solve(grid)
      return grid if is_determined?(grid)
      working_grid = create_undetermined_copy(grid)
      # Propagate inital values
      log "#=== Propagating inital values"
      working_grid.each_with_index do |v, (i,j)|
        next if v.is_a? Array # Undetermined value
        propagate_value(working_grid, v, i, j)
      end

      # Actual solving
      log "\n#=== Starting to iterate"
      iterations = 0
      loop do
        i,j,val = get_naive_candidate(working_grid)
        raise UnsolvableError if val.nil?
        working_grid.grid[i][j] = val
        propagate_value(working_grid, val, i, j)
        break if is_determined?(working_grid)
        iterations += 1
        raise TooManyIterationsError if iterations > max_iterations
      end
    
      working_grid
    rescue UnsolvableError, TooManyIterationsError => e
      log working_grid.to_s
      raise e
    end

    private

    def get_naive_candidate(grid)
      log '+--- Getting candidate for solver'
      final_i = final_j = final_val = nil
      grid.each_with_index do |val, (i,j)|
        next unless val.is_a? Array
        raise UnsolvableError if val.count < 1
        next unless val.count == 1
        final_i = i
        final_j = j
        final_val = val.first
        break
      end

      return final_i, final_j, final_val
    end

    def create_undetermined_copy(grid)
      working_grid = Grid.new(grid.size, fill: false)
      grid.each_with_index do |value, (i,j)|
        working_grid.grid[i][j] = value || grid.acceptable_values.dup
      end
      working_grid
    end

    def propagate_value(grid, value, i, j)
      log "+-- Propagating #{value} at #{i},#{j}"
      # Propagate on row
      log "Removing #{value} from row #{i}"
      grid.grid[i].each_with_index do |potential_values, iterator_j|
        next unless potential_values.is_a? Array
        next if iterator_j == j
        remove_potential_value(potential_values, value)
      end
      # Propagate on column
      log "Removing #{value} from column #{j}"
      grid.grid.each_with_index do |row, iterator_i|
        next unless row[j].is_a? Array
        next if iterator_i == i
        remove_potential_value(row[j], value)
      end
      # Propagate on block
      block_i_start = (i / grid.size) * grid.size
      block_j_start = (j / grid.size) * grid.size
      block_i_end = block_i_start + grid.size - 1
      block_j_end = block_j_start + grid.size - 1
      log "Removing #{value} from block [#{block_i_start}-#{block_i_end};#{block_j_start}-#{block_j_end}]"
      grid.each_with_index do |potential_values, (iterator_i, iterator_j)|
        next unless potential_values.is_a? Array
        next if iterator_i < block_i_start
        next if iterator_i > block_i_end
        next if iterator_j < block_j_start
        next if iterator_j > block_j_end
        next if iterator_i == i
        next if iterator_j == j
        remove_potential_value(potential_values, value)
      end
    end

    def remove_potential_value(potential_values, value)
      potential_values.delete(value)
      raise UnsolvableError if potential_values.empty?
    end

    def is_determined?(grid)
      grid.all? { |v| v.is_a? Integer }
    end

    def log(line)
      puts line if verbose
    end
  end
end