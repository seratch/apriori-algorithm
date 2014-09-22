module Apriori
  class AnalysisResult

    attr_reader :frequent_item_sets, # {[itemSetSize: number]: FrequentItemSet[]}
                :association_rules # AssociationRule[]

    def initialize(frequent_item_sets, association_rules)
      @frequent_item_sets = frequent_item_sets
      @association_rules = association_rules
    end
  end
end
