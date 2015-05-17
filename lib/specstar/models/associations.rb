require 'rspec/core'
require 'rspec/expectations'

module Specstar
  module Models
    module Matchers

      def match?(association, options)
        options.each_pair.select do |key, value|
          association.options[key.to_sym].to_s != value.to_s
        end.size == 0
      end

      RSpec::Matchers.define :belong_to do |attr, options={}|
        match do |model|
          association = model.class.reflect_on_association(attr)
          association && association.macro == :belongs_to && match?(association, options)
        end

        failure_message do |model|
          "expected #{model.class} to belong to #{attr}."
        end
      end

      RSpec::Matchers.define :have_many do |attr, options={}|
        match do |model|
          association = model.class.reflect_on_association(attr)
          association && association.macro == :has_many && match?(association, options)
        end

        failure_message do |model|
          if options
            "expected #{model.class} to have many #{attr} with #{options}."
          else
            "expected #{model.class} to have many #{attr}."
          end
        end
      end

    end
  end
end
