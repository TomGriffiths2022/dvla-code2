module FirstNameValidator
  # Validates the first_name of the driver is valid
  # As it is optional, a blank first_name is acceptable
  #
  # @param [String] first_name
  #
  # @return [Boolean]

  
  def self.validator(first_name)
    # Checks that the incoming first_name is valid or blank, if not return false
    first_name.match?(/^[a-zA-Z{1,} '-]+$/) || first_name.empty?
  end
end

# Regex explanation
# ^               // start of line
# [a-zA-Z]{1,}    // will except a name with at least one alphabetic character
# \'-             // allowable additional characters (apostrophe and hyphen)
