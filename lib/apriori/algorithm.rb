require 'apriori/analysis_result'
require 'apriori/association_rule'
require 'apriori/frequent_item_set'
require 'set'

#
# Apriori Algorithm(http://en.wikipedia.org/wiki/Apriori_algorithm) implementation in Ruby.
# which is based on https://github.com/asaini/Apriori/blob/master/apriori.py.
#
module Apriori
  class Algorithm

    attr_reader :min_support, :min_confidence

    def initialize(min_support = 0.15, min_confidence = 0.6)
      @min_support = min_support
      @min_confidence = min_confidence
    end

    # transactions: string[][]
    def analyze(transactions) # AnalysisResult
      frequencies = {} # {item_set: count}
      frequent_item_sets = {} # {item_set_size: FrequentItemSet[]}

      one_element_item_sets = to_one_element_item_sets(transactions) # string[][]
      one_c_item_sets = find_item_sets_min_support_satisfied(
          one_element_item_sets, transactions, min_support, frequencies) # FrequentItemSet[]

      current_l_item_sets = one_c_item_sets # FrequentItemSet[]
      item_set_size = 1
      while current_l_item_sets.length != 0
        frequent_item_sets[item_set_size] = current_l_item_sets
        joined_sets = to_fixed_size_joined_sets(current_l_item_sets.map { |_| _.item_set }, item_set_size + 1)
        current_l_item_sets = find_item_sets_min_support_satisfied(joined_sets, transactions, min_support, frequencies)
        item_set_size += 1
      end

      found_sub_sets = [] # string[][]
      association_rules = [] # AssociationRule[]
      frequent_item_sets.each do |item_set_size, item_sets|
        item_sets = item_sets.map { |_| _.item_set }
        next if item_sets.length == 0 || item_sets[0].length <= 1

        item_sets.each do |item_set|
          to_all_sub_sets(item_set).each do |subset_item_set|
            diff_item_set = ((item_set - subset_item_set) + (subset_item_set - item_set)).uniq
            if diff_item_set.length > 0
              item_support = calculate_support(item_set, frequencies, transactions)
              subset_support = calculate_support(subset_item_set, frequencies, transactions)
              confidence = item_support / subset_support
              if !is_the_rule_already_found(found_sub_sets, subset_item_set) && confidence >= min_confidence
                found_sub_sets << subset_item_set
                association_rules << Apriori::AssociationRule.new(subset_item_set, diff_item_set, confidence)
              end
            end
          end
        end
      end

      Apriori::AnalysisResult.new(frequent_item_sets, association_rules)
    end

    private

    def find_item_sets_min_support_satisfied(item_sets, transactions, min_support, frequencies)
      local_frequencies = {} # {item_set: count}

      item_sets.each do |item_set|
        transactions.each do |transaction|
          # just optimization for performance
          is_subset = item_set.length == 1 ? transaction.include?(item_set.first) :
              item_set.to_set.subset?(transaction.to_set)
          if is_subset
            frequencies[item_set] = 0 unless frequencies[item_set]
            local_frequencies[item_set] = 0 unless local_frequencies[item_set]
            frequencies[item_set] += 1
            local_frequencies[item_set] += 1
          end
        end
      end

      filtered_item_sets = [] # FrequentItemSet[]
      local_frequencies.each do |item_set, local_count|
        support = local_count.to_f / transactions.length
        if support >= min_support
          already_added = false
          filtered_item_sets.each do |frequent_item_set|
            unless already_added
              diff_set = ((frequent_item_set.item_set - item_set) + (frequent_item_set.item_set - item_set)).uniq
              already_added = diff_set.length == 0
            end
          end
          unless already_added
            filtered_item_sets << Apriori::FrequentItemSet.new(item_set, support)
          end
        end
      end
      filtered_item_sets
    end

    def to_one_element_item_sets(transactions)
      nested_array_of_item = []
      transactions.each do |transaction|
        transaction.reject { |_| _.nil? }.each do |item|
          nested_array_of_item << [item]
        end
      end
      nested_array_of_item.uniq
    end

    def to_fixed_size_joined_sets(item_sets, length)
      joined_set_array = []
      item_sets.each do |item_set_a|
        item_sets.each do |item_set_b|
          joined_set = ((item_set_a - item_set_b) + (item_set_b - item_set_a)).uniq
          if joined_set.length > 0 && joined_set.length == length
            joined_set_array << joined_set
          end
        end
      end
      joined_set_array.uniq
    end

    def to_all_sub_sets(item_set)
      (1...(item_set.length)).flat_map { |n| item_set.to_a.combination(n) }.first
    end

    def calculate_support(item_set, frequencies, transactions)
      frequency = frequencies[item_set]
      frequency ? (frequency.to_f / transactions.length) : 0
    end

    def is_the_rule_already_found(found_sub_sets, item_set)
      found_sub_sets.any? { |sub_set| sub_set == item_set }
    end

  end
end
