require 'rspec/core'
require 'rspec/expectations'

module Specstar
  module Models
    module Matchers
      def validate_presence_of_methods_in_options(model, options)
        if options[:if] && options[:if].is_a?(Symbol)
          return false unless model.respond_to? options[:if]
        end

        if options[:unless] && options[:unless].is_a?(Symbol)
          return false unless model.respond_to? options[:unless]
        end

        true
      end

      def undefined_method_in_options(model, options)
        if options[:if] && options[:if].is_a?(Symbol)
          return options[:if] unless model.respond_to? options[:if]
        end

        if options[:unless] && options[:unless].is_a?(Symbol)
          return options[:unless] unless model.respond_to? options[:unless]
        end

        nil
      end

      def has_attribute?(model, attr, extras={})
        attr = attr.to_s

        result = model.attributes.include? attr

        if result && extras.any?
          properties = model.class.columns_hash[attr]
          extras.each_pair do |property, value|
            result = false && break unless properties.send(property).to_s == value.to_s
          end
        end

        result
      end

      def has_association?(model, association)
        model.class.reflect_on_all_associations.map { |a| a.name.to_s }.include? association.to_s
      end

      RSpec::Matchers.define :validate_presence_of do |attr, options|
        match do |model|
          (has_attribute?(model, attr) || has_association?(model, attr)) &&
              model._validators[attr.to_sym].select do |validator|
                validator.instance_of?(ActiveRecord::Validations::PresenceValidator) && (options.nil? || validate_presence_of_methods_in_options(model, options) && (options.to_a - validator.options.to_a).empty?)
              end.size > 0
        end

        failure_message do |model|
          if has_attribute?(model, attr) || has_association?(model, attr)
            if options.nil? || validate_presence_of_methods_in_options(model, options)
              "expected #{model.class} to validate presence of #{attr}."
            else
              "expected #{model.class} to define #{undefined_method_in_options(model, options)}."
            end
          else
            "expected #{model.class} to have an attribute or association #{attr}."
          end
        end
      end

      RSpec::Matchers.define :validate_uniqueness_of do |attr, options|
        match do |model|
          (has_attribute?(model, attr) || has_association?(model, attr)) && model._validators[attr].select do |validator|
            validator.instance_of?(ActiveRecord::Validations::UniquenessValidator) && (options.nil? || validate_presence_of_methods_in_options(model, options) && (options.to_a - validator.options.to_a).empty?)
          end.size > 0
        end

        failure_message do |model|
          if has_attribute?(model, attr) || has_association?(model, attr)
            if options.nil? || validate_presence_of_methods_in_options(model, options)
              "expected #{model.class} to validate uniqueness of #{attr}."
            else
              "expected #{model.class} to define #{undefined_method_in_options(model, options)}."
            end
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

        failure_message do |model|
          if has_attribute?(model, attr) || has_association?(model, attr)
            "expected #{model.class} to validate inclusion of #{attr} in [#{options.delete(:in).map(&:to_s).join(', ')}]."
          else
            "expected #{model.class} to have an attribute or association #{attr}."
          end
        end
      end

      RSpec::Matchers.define :validate_numericality_of do |attr, options|
        options = options || {}

        match do |model|
          (has_attribute?(model, attr) || has_association?(model, attr)) &&
              model._validators[attr].select do |validator|
                validator.instance_of?(ActiveRecord::Validations::NumericalityValidator) && validator.options.merge(options) == validator.options
              end.size > 0
        end

        failure_message do |model|
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
