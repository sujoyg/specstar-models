# 0.2.10
  * Fix: validate_numericality_of was not working.

# 0.2.9
  * Feature: Adding a matcher for has_one association.

# 0.2.8
  * Bug: validate_inclusion_of matcher was causing an exception.

# 0.2.7
  * Feature: Improving error messages for association matchers.

# 0.2.6
  * Feature: Adding a matcher for has_and_belongs_to_many association.

# 0.2.5
  * Feature: Ability to match options with association matchers.

# 0.2.4
  * Feature: Adding a matcher for has_many association.

# 0.2.3
  * Feature: Adding a matcher for belongs_to association.

# 0.2.2
  * Bug: Fix validate matches to use ActiveRecord instead of ActiveModel.

# 0.2.0
  * Feature: Removing specstar-remarkable matchers.

# 0.1.2
  * Always converting actual attribute names to string before checking for existence.

# 0.1.1
  * Explicitly require rspec/expectations.

# 0.1.0
  * Include remarkable/active_record within the gem.

# 0.0.9
  * Better support for conditions in validate_presence_of.

# 0.0.8
  * Feature: Support options for validate_uniqueness_of.

# 0.0.6
  * Bug: Do not crash when validate_numericality_of is used without any options.

# 0.0.5
  * Feature: Introducing validate_numericality_of matcher.

# 0.0.4
  * Feature: Introducing validate_presence_of, validate_uniqueness_of and validate_inclusion_of matchers.

# 0.0.3
  * Fix: Do not cache the with clause for subsequent matches.

# 0.0.2
  * Fix: Do not crash when the with clause is missing.

# 0.0.1
  * Fix: Requiring rspec explicitly to eliminate 'uninitialized constant RSpecAttributeMatchers::RSpec' on running rake tasks.

# 0.0.0
  * Feature: Introducing rspec_attribute_matchers, a simple way of writing specs for activemodel attributes.
