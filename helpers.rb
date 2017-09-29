# Robosim helpers
module Helpers
  # check if user passed in file
  def input_file(args)
    file_location = args.pop
    return nil if file_location.nil?

    begin
      File.open(file_location, 'r')
    rescue Errno::ENOENT
      puts 'File could not be read'
      exit
    end
  end

  # Nice print awaiting user input and return
  def await_command(file)
    if file
      user_input = file.gets
      return 'EXIT' if user_input.nil?
      return user_input.chomp.upcase
    end

    print '$ '
    $stdout.flush

    gets.chomp.upcase
  end

  # Check if user wants to exit the application
  def exit?(cmd)
    cmd == EXIT_COMMAND
  end

  # Check if user is seeking help
  def help?(cmd)
    cmd == HELP_COMMAND
  end

  # Check if user input is a valid command
  def valid_command?(cmd)
    USER_COMMANDS.include? cmd
  end

  # Check if command is place
  def place_command?(cmd)
    cmd == 'PLACE'
  end

  # Invalid command message
  def invalid_command(cmd)
    "'#{cmd}' is not a valid command. Type 'help' for command list"
  end

  # Formatted commands for display
  def command_list
    "#{AVAILABLE_COMMANDS} \n" + USER_COMMANDS.join("\n")
  end

  # Space out comma separated args
  # Return args as array
  def parse_user_input(cmd)
    cmd.tr(',', ' ').split(' ')
  end

  # Run robot command and return result
  def send_robot_command(robot, args)
    unless place_command?(args[0]) || Robot.placed?(robot)
      return robot_not_placed(robot)
    end

    Robot.send args[0].downcase, robot, args.drop(1)
  end

  # Return robot not placed response
  def robot_not_placed(robot)
    {
      robot: robot,
      response: ROBOT_NOT_PLACED
    }
  end
end
