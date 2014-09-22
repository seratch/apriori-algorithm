module Apriori
  class FrequentItemSet

    attr_reader :item_set, # string[]
                :support # number

    def initialize(item_set, support)
      @item_set = item_set
      @support = support
    end
  end
end
