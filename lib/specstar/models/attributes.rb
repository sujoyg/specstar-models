require 'rspec/core'
require 'rspec/expectations'

module Specstar
  module Models
    module Matchers
      RSpec::Matchers.define :have_attribute do |attr|
        attr = attr.to_s

        @extras = nil
        chain :with do |extras|
          @extras = extras
        end

        match do |target|
          result = target.attributes.keys.map(&:to_s).include? attr

          if result && @extras
            properties = target.class.columns_hash[attr]
            @extras.each_pair do |property, value|
              result = false && break unless properties.send(property).to_s == value.to_s
            end
          end

          result
        end

        failure_message do |target|
          "Expected #{target.class} to have an attribute '#{attr}'#{properties_to_sentence @extras}."
        end

        description do
          "have an attribute '#{attr}'#{properties_to_sentence @extras}."
        end

        def properties_to_sentence(hash)
          " of " + hash.map { |key, value| "#{key} #{value}" }.to_sentence if hash.present?
        end
      end

    end
  end
end
