require './app/robot'

describe Robot do
  subject { described_class }

  before do
    stub_const('START_X', 1)
    stub_const('START_Y', 1)
    stub_const('END_X', 5)
    stub_const('END_Y', 5)
  end

  describe '#init' do
    let!(:valid_response) do
      {
        x: 1,
        y: 1,
        direction: 'NORTH',
        placed: false
      }
    end

    it 'initialises robot position and returns response' do
      expect(subject.init).to eq valid_response
    end
  end

  describe '#place' do
    let!(:robot) do
      {
        x: 4, y: 5,
        direction: 'NORTH',
        placed: true
      }
    end

    let!(:valid_robot) do
      {
        x: 2, y: 2,
        direction: 'SOUTH',
        placed: true
      }
    end

    let!(:valid_place) { [2, 2, 'SOUTH'] }
    let!(:out_of_bounds) { [6, 6, 'NORTH'] }
    let!(:invalid_xy) { ['asd', 6, 'NORTH'] }
    let!(:invalid_direction) { [1, 1, 'INVALID'] }

    it 'returns new robot when valid' do
      expect(subject.place(robot, valid_place)). to eq(response: nil, robot: valid_robot)
    end

    it 'returns error when out of bounds' do
      expect(subject.place(robot, out_of_bounds)).to eq(response: 'ERROR: Robot can\'t be placed here: 6,6', robot: robot)
    end

    it 'returns error when invalid coordinates' do
      expect(subject.place(robot, invalid_xy)).to eq(response: 'ERROR: X is not a valid number: asd', robot: robot)
    end

    it 'returns error when invalid direction' do
      expect(subject.place(robot, invalid_direction)).to eq(response: 'ERROR: Invalid Direction: INVALID', robot: robot)
    end
  end

  describe '#move' do
    let!(:robot_x_end) { { x: 5, y: 4, direction: 'EAST', placed: true } }
    let!(:robot_y_end) { { x: 4, y: 5, direction: 'NORTH', placed: true } }
    let!(:robot_x_start) { { x: 0, y: 4, direction: 'WEST', placed: true } }
    let!(:robot_y_start) { { x: 4, y: 0, direction: 'SOUTH', placed: true } }
    let!(:robot_valid) { { x: 4, y: 3, direction: 'NORTH', placed: true } }

    it 'returns error when robot at end of x grid facing east' do
      expect(subject.move(robot_x_end, nil)).to eq(response: 'Unreachable position', robot: robot_x_end)
    end

    it 'returns error when robot at end of y grid facing north' do
      expect(subject.move(robot_y_end, nil)).to eq(response: 'Unreachable position', robot: robot_y_end)
    end

    it 'returns error when robot at start of x grid facing west' do
      expect(subject.move(robot_x_start, nil)).to eq(response: 'Unreachable position', robot: robot_x_start)
    end

    it 'returns error when robot at start of y grid facing south' do
      expect(subject.move(robot_y_start, nil)).to eq(response: 'Unreachable position', robot: robot_y_start)
    end

    it 'moves the robot and returns a valid robot with new position' do
      expect(subject.move(robot_valid, nil)).to eq(response: nil, robot: { x: 4, y: 4, direction: 'NORTH', placed: true })
    end
  end

  describe '#left' do
    let!(:robot_valid) { { x: 5, y: 4, direction: 'WEST', placed: true } }

    it 'rotates robot anti clockwise' do
      robot = subject.left(robot_valid, nil)[:robot]
      expect(robot[:direction]).to eq 'SOUTH'
      robot = subject.left(robot, nil)[:robot]
      expect(robot[:direction]).to eq 'EAST'
    end
  end

  describe '#right' do
    let!(:robot_valid) { { x: 5, y: 4, direction: 'EAST', placed: true } }

    it 'rotates robot anti clockwise' do
      robot = subject.right(robot_valid, nil)[:robot]
      expect(robot[:direction]).to eq 'SOUTH'
      robot = subject.right(robot, nil)[:robot]
      expect(robot[:direction]).to eq 'WEST'
    end
  end

  describe '#report' do
    let!(:robot_valid) { { x: 5, y: 4, direction: 'EAST', placed: true } }
    let!(:valid_response) { 'Output: 5,4,EAST' }

    it 'shows a report based on the robot' do
      expect(subject.report(robot_valid, nil)).to eq(robot: robot_valid, response: valid_response)
    end
  end
end
