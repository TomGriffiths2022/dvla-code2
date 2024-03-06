require 'pry'

module DriverIdValidator
  # Validates the driver_id is in the correct format and length
  #
  # @param [String] driver_id
  #
  # @return [Boolean]

  def self.validation(driver_id)
    # regex will match the driver_id input and compare against permitted values
    # as per the brief.
    # [A-Z]{4}: The first four characters must be uppercase letters (A to Z).
    # (?:X|[A-Z]): The fifth character can be either 'X' or an uppercase letter (A to Z).
    # (0[1-9]|1[0-2]){1}: Month should be between 01 and 12 and should match only once.
    # \d{2}: Two digits for the year of birth.
    if driver_id.empty?
      false # driver_id is required so if it's empty then the validation is false
    else
      driver_id.match?(/^[A-Z]{4}(?:X|[A-Z])(0[1-9]|1[0-2]){1}\d{2}$/) # returns true if the driver_id is valid
    end
  end
end

# Testing considerations - different formats of vrn (different length etc.)
