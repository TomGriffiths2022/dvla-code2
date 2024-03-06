require 'json'

class Driver

  attr_accessor :last_name, :first_name, :date_of_birth, :driver_id, :entitlements, :details, :errors

  def initialize(last_name: nil, first_name: nil, date_of_birth: nil, driver_id: nil, entitlements: nil, errors: nil)
    @last_name = last_name
    @first_name = first_name
    @date_of_birth = date_of_birth
    @driver_id = driver_id
    @entitlements = entitlements


    @details = 
      if errors
      # If errors are present, use them in the details object
        {
          last_name: last_name,
          first_name: first_name,
          date_of_birth: date_of_birth,
          driver_id: driver_id,
          entitlements: entitlements,
          errors: errors
        }
      else
      # If no errors present, then omit them from the details object 
        {
          last_name: last_name.capitalize,
          first_name: first_name.capitalize,
          date_of_birth: Date.parse(date_of_birth).strftime('%d, %b, %Y'),
          driver_id: driver_id.upcase,
          entitlements: Driver.translate_entitlements(entitlements),
        }
      end
  end

  def self.validated(driver)
    # creates an array with all error messages for any driver, by validating each attribute of the driver
    errors = []
    errors << "Invalid driverId" if DriverIdValidator.validation(driver[:driverid]) != true
    errors << "Invalid entitlements" if EntitlementsValidator.entitlement_check(eval(driver[:entitlements])).include?(false)
    errors << "Invalid last name" if LastNameValidator.validator(driver[:lastname]) != true
    errors << "Invalid first name" if FirstNameValidator.validator(driver[:firstname]) != true
    errors << DateOfBirthValidator.validator(driver[:dateofbirth]) unless DateOfBirthValidator.validator(driver[:dateofbirth]) == true
    errors
  end

  def self.translate_entitlements(entitlements)
    entitlements = entitlements.map{ |entitlement_code| entitlement_code == 'A' ? 'Motorbike' : entitlement_code }
    entitlements = entitlements.map{ |entitlement_code| entitlement_code == 'B' ? 'Car' : entitlement_code }
    entitlements = entitlements.map{ |entitlement_code| entitlement_code == 'C' ? 'Lorry' : entitlement_code }
    entitlements = entitlements.map{ |entitlement_code| entitlement_code == 'D' ? 'Bus' : entitlement_code }
    entitlements
  end

  def self.calculate_valid_drivers
    # Calculates the valid drivers extracted from the original drivers.csv
    valid_drivers_file = open("valid_drivers.json")
    drivers = valid_drivers_file.read
    parsed = JSON.parse(drivers).to_h
    number_of_valid_drivers = parsed["valid_drivers"].count
    puts "Number of valid drivers in 'drivers.csv' file is #{number_of_valid_drivers}"
  end
  
  def self.calculate_invalid_drivers
    # Calculates the invalid drivers extracted from the original drivers.csv
    invalid_drivers_file = open("invalid_drivers.json")
    drivers = invalid_drivers_file.read
    parsed = JSON.parse(drivers).to_h
    number_of_invalid_drivers = parsed["invalid_drivers"].count
    puts "Number of invalid drivers in 'drivers.csv' file is #{number_of_invalid_drivers}"
  end
end

#Testing consideration for entire app - testing comes from unit tests and create api for functional testing
#Improvement- use db for data as it will prevent potential duplication (primary keys DriverID?)
#Improvement - check for duplication of data
#Improvement - for more entitlements, use a translation file, using I18n potentially
#Unit test individual functions