module Apriori
  class AssociationRule

    attr_reader :lhs, # string[]
                :rhs, # string[]
                :confidence # number

    def initialize(lhs, rhs, confidence)
      @lhs = lhs
      @rhs = rhs
      @confidence = confidence
    end
  end
end
