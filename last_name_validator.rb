module LastNameValidator
  # Validates the last_name of the driver is valid
  #
  # @param [String] last_name
  #
  # @return [Boolean]

  
  def self.validator(last_name)
    # Checks that the incoming last_name is valid, as this is a required field, return false if it does not match the regex
    last_name.match?(/^[a-zA-Z{1,} '-]+$/)
  end
end

# Regex explanation
# ^               // start of line
# [a-zA-Z]{1,}    // will except a name with at least one alphabetic character
# \'-             // allowable additional characters (apostrophe and hyphen)