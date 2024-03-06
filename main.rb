require_relative 'driver_id_validator'
require_relative 'first_name_validator'
require_relative 'date_of_birth_validator'
require_relative 'last_name_validator'
require_relative 'entitlements_validator'
require_relative 'driver'

require 'csv'
require 'pry'

def input_from_file
# Receive a file of driver data which are to be validated, and if valid write to valid_drivers.json file
# If not valid then write to invalid_drivers.json file with original data and errors
puts "Analysing drivers.csv file"
valid_drivers = []
invalid_drivers = []
  table = CSV.foreach('drivers.csv', headers: true, header_converters: :symbol) do |row|
    first_name = row[:firstname]
    last_name = row[:lastname]
    date_of_birth = row[:dateofbirth]
    driver_id = row[:driverid]
    entitlements = eval(row[:entitlements]) # using eval to persist the array of data

    # Validate the row of data
    errors = Driver.validated(row)
    if errors.empty?
      # If there are no errors, produce a valid vehicle
      valid_driver = Driver.new(last_name: last_name, first_name: first_name, date_of_birth: date_of_birth, driver_id: driver_id, entitlements: entitlements)
      # Add the valid vehicle to the valid_vehicles array
      valid_drivers << valid_driver.details
    else
      # If there are errors, produce an invalid vehicle
      invalid_driver = Driver.new(last_name: last_name, first_name: first_name, date_of_birth: date_of_birth, driver_id: driver_id, entitlements: entitlements, errors: errors)
      # Add the invalid vehicle to the invalid_vehicles array
      invalid_drivers << invalid_driver.details
    end
  end
  write_to_file(valid_drivers: valid_drivers)
  write_invalid_drivers_to_file(invalid_drivers: invalid_drivers)
  puts "All vehicles have been validated"
end

def write_to_file(valid_drivers:)
# Read the valid_vehicles.json file
  file = File.read('valid_drivers.json')
  array = JSON.parse(file)
  array["valid_drivers"] = []
# Add each valid_vehicle to the array
  valid_drivers.each do |driver|
    array["valid_drivers"] << driver
  end
# Open the valid_vehicles.json file ready for writing
  File.open("valid_drivers.json", "w") do |f|
    f.write(JSON.pretty_generate(array))
  end
end

def write_invalid_drivers_to_file(invalid_drivers:)
  # Read the invalid_vehicles.json file
  file = File.read('invalid_drivers.json')
  array = JSON.parse(file)
  array["invalid_drivers"] = []
# Add each invalid_vehicle to the array
  invalid_drivers.each do |driver|
    array["invalid_drivers"] << driver
  end
  # Open the invalid_vehicles.json file ready for writing
  File.open("invalid_drivers.json", "w") do |f|
    f.write(JSON.pretty_generate(array))
  end
end

input_from_file
Driver.calculate_valid_drivers
Driver.calculate_invalid_drivers

# Consideration - refactor the writing to file to be more efficient?
# Consideration - use the main file interactively. If needed more functionality, extrapolate methods to their own files etc.



