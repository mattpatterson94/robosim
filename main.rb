require './constants'
require './commands'
require './robot'

# Send welcome message
puts WELCOME

# Initialize robot
robot = Robot.init

loop do
  # Get user command
  cmd = await_command
  # Quit if exit is typed
  break if exit?(cmd)
  # Show help message if help is typed
  next puts command_list if help?(cmd)
  # Convert user input into arguments
  args = parse_user_input(cmd)
  # Send invalid command message if command does not exist
  next puts invalid_command(cmd) unless valid_command?(args[0])
  # Run robot command
  result = send_robot_command(robot, args)
  # Update robot
  robot = result[:robot]
  # Print robot response
  puts result[:response] unless result[:response].nil?
end

# Send goodbye message
puts GOODBYE

# TODO:
# Check validity of args for place
# remove extra line on response
