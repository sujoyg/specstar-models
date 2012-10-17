This package helps you check that the attributes of a model have been defined correctly.

You may have created a model `Store` as follows:

    class CreateStores < ActiveRecord::Migration
      def change
        create_table :stores do |t|
          t.string :title
          t.string :description, :null => false
          t.string :url, :limit => 1024
          t.boolean :open
        end
      end
    end

The `have_attribute` matcher allows you test each of these attributes as follows:

    require 'spec_helper'

    describe Store do
      it { should have_attribute(:title) }
      it { should have_attribute(:description).with(:type => :string, :null => false) }
      it { should have_attribute(:url).with(:type => :string, :limit => 1024) }
      it { should have_attribute(:open).with(:type => :boolean) }
    end

To make this matcher available in your model specs, do the following:

**Gemfile**

    group :test do
      ...
      gem 'specstar-models', '~> 0.0.4'
      ...
    end

**spec/spec_helper.rb**

    require 'specstar/models'

    RSpec.configure do |config|
      ...
      config.include Specstar::Models::Matchers, :type => :model
      ...
    end


