# ROBOSIM

**Author:** Matt Patterson

**Ruby Version:** 2.4.2

### Gems used:

- Rubocop
- RSpec

### Application

To run the application with user input

`ruby main.rb`


To run the application using a file

`ruby main.rb examples/input`



#### Valid Commands
- `place [x, y, direction]` - _place robot_
- `move` - _move robot_
- `left` - _rotate robot 90' anti clockwise_
- `right` - _rotate robot 90' clockwise_
- `report` - _show robot current position_

#### Other Commands
- `help` - _show command list_
- `exit` - _exit application_

### Tests

To run specs you must have the rspec gem

`gem install rspec`

Run specs using

`rspec spec`

### Example

- Example test file located in examples folder

To run it:

`ruby main.rb examples/input`
