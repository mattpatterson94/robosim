# Robot
class Robot
  def self.init
    place_robot(START_X, START_Y, 'NORTH', false)
  end

  def self.place(robot, args)
    check_valid_arguments(args)
    robot = place_robot(args[0], args[1], args[2])

    { robot: robot, response: nil }
  rescue ArgumentError => e
    { robot: robot, response: e.message }
  end

  def self.move(robot, _args)
    operator = move_operator(robot[:direction])
    coordinate = move_coordinate(robot[:direction])

    robot = move_robot(robot, operator, coordinate)

    { robot: robot, response: nil }
  rescue ArgumentError => e
    { robot: robot, response: e.message }
  end

  def self.left(robot, _args)
    dir = directions.index(robot[:direction])
    new_dir = (dir - 1) % directions.size
    robot[:direction] = directions[new_dir]

    { robot: robot, response: nil }
  end

  def self.right(robot, _args)
    dir = directions.index(robot[:direction])
    new_dir = (dir + 1) % directions.size
    robot[:direction] = directions[new_dir]

    { robot: robot, response: nil }
  end

  def self.report(robot, _args)
    response = "Output: #{robot[:x]},#{robot[:y]},#{robot[:direction]}"

    { robot: robot, response: response }
  end

  def self.placed?(robot)
    robot[:placed]
  end

  private_class_method def self.place_robot(x, y, direction, placed = true)
    {
      x: x.to_i,
      y: y.to_i,
      direction: direction,
      placed: placed
    }
  end

  private_class_method def self.move_robot(robot, operator, coordinate)
    coordinates = { x: robot[:x], y: robot[:y] }

    if operator == '+'
      coordinates[coordinate] += 1
    else
      coordinates[coordinate] -= 1
    end

    unless valid_move?(coordinates[:x], coordinates[:y])
      raise ArgumentError, 'Unreachable position'
    end

    robot.merge(coordinates)
  end

  private_class_method def self.valid_move?(x, y)
    return false unless x.to_i >= START_X && x.to_i <= END_X
    return false unless y.to_i >= START_Y && y.to_i <= END_Y

    true
  end

  private_class_method def self.move_operator(direction)
    return '+' if %w[NORTH EAST].include? direction

    '-'
  end

  private_class_method def self.move_coordinate(direction)
    return :x if %w[EAST WEST].include? direction

    :y
  end

  private_class_method def self.check_valid_arguments(args)
    check_parameters(args)
    check_xy(args[0], args[1])
    check_direction(args[2])
    check_on_board(args[0], args[1])
  end

  private_class_method def self.check_on_board(x, y)
    error("Robot can't be placed here: #{x},#{y}") unless valid_move?(x, y)
  end

  private_class_method def self.check_parameters(args)
    error("Missing parameter(s) #{args.join(',')}") if args.size < 3
  end

  private_class_method def self.check_xy(x, y)
    error("X is not a valid number: #{x}") unless x == '0' || x.to_i > 0
    error("Y is not a valid number: #{y}") unless y == '0' || y.to_i > 0
  end

  private_class_method def self.check_direction(direction)
    error("Invalid Direction: #{direction}") unless valid_direction?(direction)
  end

  private_class_method def self.error(message)
    raise ArgumentError, "ERROR: #{message}"
  end

  private_class_method def self.valid_direction?(direction)
    directions.include? direction.upcase
  end

  private_class_method def self.directions
    %w[NORTH EAST SOUTH WEST]
  end
end
