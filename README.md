This package helps you check that the attributes and validations of a model have been defined correctly.

Matchers
--------

**have_attribute**

You may have created a model `Store` as follows:

    class CreateStores < ActiveRecord::Migration
      def change
        create_table :stores do |t|
          t.string :title
          t.string :body, :null => false
          t.string :url, :limit => 1024
          t.boolean :open
        end
      end
    end

The `have_attribute` matcher allows you test each of these attributes as follows:

    require 'spec_helper'

    describe Store do
      it { should have_attribute(:title) }
      it { should have_attribute(:body).with(:type => :string, :null => false) }
      it { should have_attribute(:url).with(:type => :string, :limit => 1024) }
      it { should have_attribute(:open).with(:type => :boolean) }
    end

**validate**

You may have a model `User` as follows:

    class User < ActiveRecord::Base
      ...
      validates :url, url: true
      ...
    end

This matcher allows you to write the following spec:

    require 'spec_helper'

    describe User do
      it { should validate :url, url: true }
    end

**validate_inclusion_of**

You may have a model `User` as follows:

    class User < ActiveRecord::Base
      ...
      validates_inclusion_of :verified, in: [true, false]
      ...
    end

This matcher allows you to write the following spec:

    require 'spec_helper'

    describe User do
      it { should validate_inclusion_of :verfied, in: [true, false] }
    end

**validate_numericality_of**
You may have a model `User` as follows:

    class User < ActiveRecord::Base
      ...
      validates_numericality_of :age, greater_than_or_equal_to: 0
      ...
    end

This matcher allows you to write the following spec:

    require 'spec_helper'

    describe User do
      it { should validate_numericality_of :age, greater_than_or_equal_to: 0 }
    end

**validate_presence_of**

You may have a model `User` as follows:

    class User < ActiveRecord::Base
      ...
      validates_presence_of :email
      ...
    end

This matcher allows you to write the following spec:

    require 'spec_helper'

    describe User do
      it { should validate_presence_of :email }
    end

**validate_uniqueness_of**

You may have a model `User` as follows:

    class User < ActiveRecord::Base
      ...
      validates_uniqueness_of :email
      ...
    end

This matcher allows you to write the following spec:

    require 'spec_helper'

    describe User do
      it { should validate_uniqueness_of :email }
    end

**belong_to**

You may have a model `User` as follows:

    class User < ActiveRecord::Base
      ...
      belongs_to :community
      ...
    end

This matcher allows you to write the following spec:

    require 'spec_helper'

    describe User do
      it { should belong_to :community }
    end

**have_many**

You may have a model `Blog` as follows:

    class Blog < ActiveRecord::Base
      ...
      has_many :posts
      ...
    end

This matcher allows you to write the following spec:

    require 'spec_helper'

    describe Blog do
      it { should have_many :posts }
    end

**have_one**

You may have a model `Blog` as follows:

    class Blog < ActiveRecord::Base
      ...
      has_one :author
      ...
    end

This matcher allows you to write the following spec:

    require 'spec_helper'

    describe Blog do
      it { should have_one :author }
    end

**has_and_belongs_to_many**

You may have a model `Person` as follows:

    class Person < ActiveRecord::Base
      ...
      has_and_belongs_to_many :groups, class_name: 'Organization'
      ...
    end

This matcher allows you to write the following spec:

    require 'spec_helper'

    describe Person do
      it { should have_and_belong_to_many :groups, class_name: 'Organization' }
    end

Using in Specs
--------------
To make these matchers available in your model specs, do the following:

**Gemfile**

    group :test do
      ...
      gem 'specstar-models', '~> 0.2.3'
      ...
    end

**spec/spec_helper.rb**

    require 'specstar/models'

    RSpec.configure do |config|
      ...
      config.include Specstar::Models::Matchers, :type => :model
      ...
    end


Related Tools
-------------
You may also want to consider the following gems to help with your specs:
 
* **specstar-controllers**: Matchers for checking that the filters and layouts in a controller have been defined correctly. Learn more [here](https://github.com/sujoyg/specstar-controllers 'Github'). Released gems are [here](http://rubygems.org/gems/specstar-controllers). 
* **specstar-support-random**: Utility methods for generating random objects (e.g. URLs, emails, hashes) for use in your specs. Learn more [here](https://github.com/sujoyg/specstar-support-random 'Github'). Released gems are [here](http://rubygems.org/gems/specstar-support-random).

 
