require_relative 'driver_id_validator'
require 'rspec/expectations'
include RSpec::Matchers

# a unit test method to check different driver_ids, and determine if they are valid or invalid
def validation_test(valid)
  if valid == true
    return 'DriverID valid'
  else
    return 'DriverID invalid'
  end
end

  tests = { #batch of inputs against what is expected of the validation
    'SCHNL0792' => 'DriverID valid',
    'WIZAJ0805' => 'DriverID valid',
    'WARDX0482' => 'DriverID valid',
    '2024-02-13' => 'DriverID invalid',
    '' => 'DriverID invalid',
    'SCHUL0567' => 'DriverID valid',
    'ZIEMX0264' => 'DriverID valid',
    'MCGLC0375' => 'DriverID valid',
    'HOWE21083' => 'DriverID invalid',
    '?!2345678' => 'DriverID invalid',
    '2024C1152' => 'DriverID invalid',
    'YOST21068' => 'DriverID invalid',
    'MAYER504229MV4VN' => 'DriverID invalid',
    'HERMC' => 'DriverID invalid',
    '""' => 'DriverID invalid'
  }

  tests.each_pair do |key, value|
    #gives the result of the validation as a boolean
    result = DriverIdValidator.validation(key)
    #performs the above unit test
    validated = validation_test(result)
    #output of the test compared to the given input
    puts "Given input #{key} returns #{validated}"
    #expectation of the result of the test to equal what is expected
    expect(validated).to eq("#{value}") 
  end
