require 'date'
module DateOfBirthValidator
  # Validates the date_of_birth is valid and not in the future
  #
  # @param [String] date_of_birth
  #
  # @return [Boolean] if validated
  # @return [String] as an error message

  def self.validator(date_of_birth)
    lower_age_limit = 15 # as per the brief
    upper_age_limit = 100 # as per the brief
    future_error_message = "Cannot be born in the future" # as per the brief
    invalid_error = "Date_of_birth: #{date_of_birth} is not valid"
  
    if date_of_birth.empty?
      # date_of_birth is a mandatory fields, thus will throw an error if empty
      invalid_error
    else
      incoming_date_of_birth = Date.parse(date_of_birth) #parsing the string as a date
      age_calculation = age_calculator(incoming_date_of_birth) # returns the age of the driver in years
      
      #using Proc to store the block of code in a variable for the case statement
      within_range = Proc.new{|age_calculation| (age_calculation >= lower_age_limit && age_calculation <= upper_age_limit)}
    
      case age_calculation #case statement to determine the age of the driver
      when age_calculation <= 0 # and if the calculation gives a value less than 0 years(i.e. they are born today/after today's date)
        future_error_message
      when within_range
        true
      else
        invalid_error #for dates that are not within the accepted range
      end
    end
  end


  def self.age_calculator(date_of_birth)
    # Using this calculation to calculate the age of the driver
    # Using Time returns the seconds, therefore the multiplications will convert to years
    ((Time.now - date_of_birth.to_time)/(60*60*24*365)).floor
  end
end



# Consideration - different formats of date, i.e. MM/DD/YYYY etc.
#               - is 100 years and 1 day out-of-range etc.
