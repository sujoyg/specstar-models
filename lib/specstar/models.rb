require 'rspec'

module Specstar
  module Models
    module Matchers
      def properties_to_sentence(hash)
        " of " + hash.map { |key, value| "#{key} #{value}" }.to_sentence if hash.present?
      end

      RSpec::Matchers.define :have_attribute do |attr|
        attr = attr.to_s

        @extras = nil
        chain :with do |extras|
          @extras = extras
        end

        match do |target|
          result = target.attributes.include? attr

          if result && @extras
            properties = target.class.columns_hash[attr]
            @extras.each_pair do |property, value|
              result = false && break unless properties.send(property) == value
            end
          end

          result
        end

        failure_message_for_should do |target|
          "Expected #{target.class} to have an attribute '#{attr}'#{properties_to_sentence @extras}."
        end

        description do
          "have an attribute '#{attr}'#{properties_to_sentence @extras}."
        end
      end

      def has_attribute?(model, attr, extras={})
        attr = attr.to_s

        result = model.attributes.include? attr

        if result && extras.any?
          properties = model.class.columns_hash[attr]
          extras.each_pair do |property, value|
            result = false && break unless properties.send(property) == value
          end
        end

        result
      end

      def has_association?(model, association)
        model.class.reflect_on_all_associations.map { |a| a.name }.include? association.to_sym
      end

      RSpec::Matchers.define :validate_presence_of do |attr|
        match do |model|
          (has_attribute?(model, attr) || has_association?(model, attr)) &&
              model._validators[attr].select { |validator| validator.instance_of? ActiveModel::Validations::PresenceValidator }.size > 0
        end

        failure_message_for_should do |model|
          if has_attribute?(model, attr) || has_association?(model, attr)
            "expected #{model.class} to validate presence of #{attr}."
          else
            "expected #{model.class} to have an attribute or association #{attr}."
          end
        end
      end

      RSpec::Matchers.define :validate_uniqueness_of do |attr|
        match do |model|
          (has_attribute?(model, attr) || has_association?(model, attr)) &&
              model._validators[attr].select { |validator| validator.instance_of? ActiveRecord::Validations::UniquenessValidator }.size > 0
        end

        failure_message_for_should do |model|
          if has_attribute?(model, attr) || has_association?(model, attr)
            "expected #{model.class} to validate uniqueness of #{attr}."
          else
            "expected #{model.class} to have an attribute or association #{attr}."
          end
        end
      end

      RSpec::Matchers.define :validate_inclusion_of do |attr, options|
        match do |model|
          (has_attribute?(model, attr) || has_association?(model, attr)) &&
              model._validators[attr].select do |validator|
                validator.instance_of?(ActiveModel::Validations::InclusionValidator) && validator.options.merge(options) == validator.options
              end.size > 0
        end

        failure_message_for_should do |model|
          if has_attribute?(model, attr) || has_association?(model, attr)
            "expected #{model.class} to validate inclusion of #{attr} in [#{options.delete(:in).map(&:to_s).join(', ')}]."
          else
            "expected #{model.class} to have an attribute or association #{attr}."
          end
        end
      end

      RSpec::Matchers.define :validate_numericality_of do |attr, options|
        match do |model|
          (has_attribute?(model, attr) || has_association?(model, attr)) &&
              model._validators[attr].select do |validator|
                validator.instance_of?(ActiveModel::Validations::NumericalityValidator) && validator.options.merge(options) == validator.options
              end.size > 0
        end

        failure_message_for_should do |model|
          if has_attribute?(model, attr) || has_association?(model, attr)
            "expected #{model.class} to validate numericality of #{attr} in [#{options.delete(:in).map(&:to_s).join(', ')}]."
          else
            "expected #{model.class} to have an attribute or association #{attr}."
          end
        end
      end
    end
  end
end
