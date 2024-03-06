require 'pry'

module EntitlementsValidator
  # Validates the entitlements is one of the acceptable values
  #
  # @param [Array] entitlements
  #
  # @return [Array] results

  ACCEPTABLE_ENTITLEMENTS = %w[A B C D]

  def self.entitlement_check(entitlements)
    results = []
    # Checks that the incoming entitlements is one of the acceptable values, if not return false
    entitlements.each do |entitlement|
      results.push(ACCEPTABLE_ENTITLEMENTS.any?(entitlement.upcase))
    end
    # returns the results array which will contain the validation result for each entitlement brought in
    results
  end
end