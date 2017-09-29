require './constants'
require './helpers'
require './robot'

# RoboSim - The Application
class RoboSim
  include Helpers

  def initialize
    # Get user file
    @file = input_file(ARGV)
    # Initialize robot
    @robot = Robot.init
  end

  def call
    loop do
      result = run_cmd
      break if result == false
    end
  end

  private

  def run_cmd
    # Get user command
    cmd = await_command(@file)
    # Quit if exit is typed
    return quit_robosim if exit?(cmd)
    # Show help message if help is typed
    return display_help if help?(cmd)
    # Convert user input into arguments
    args = parse_user_input(cmd)
    # Send invalid command message if command does not exist
    display_invalid_command(args[0]) unless valid_command?(args[0])
    # Run robot command
    @robot = run_robot_command(args)
  end

  def run_robot_command(args)
    result = send_robot_command(@robot, args)
    # Print robot response
    puts result[:response] unless result[:response].nil?
    # return new robot
    result[:robot]
  end

  # display help list
  def display_help
    puts command_list
    false
  end

  # return false to quit
  def quit_robosim
    false
  end

  # display invalid command
  def display_invalid_command(cmd)
    puts invalid_command(cmd)
    true
  end
end
