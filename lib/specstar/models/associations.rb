require 'rspec/core'
require 'rspec/expectations'

module Specstar
  module Models
    module Matchers

      RSpec::Matchers.define :belong_to do |attr|
        match do |model|
          association = model.class.reflect_on_association(attr)
          association && association.macro == :belongs_to
        end

        failure_message do |model|
          "expected #{model.class} to belong to #{attr}."
        end
      end

      RSpec::Matchers.define :have_many do |attr|
        match do |model|
          association = model.class.reflect_on_association(attr)
          association && association.macro == :has_many
        end

        failure_message do |model|
          "expected #{model.class} to have many #{attr}."
        end
      end

    end
  end
end
