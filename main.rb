require './app/robosim'

# main
module Main
  # Send welcome message
  puts WELCOME
  RoboSim.new.call
  # Send goodbye message
  puts GOODBYE
end
