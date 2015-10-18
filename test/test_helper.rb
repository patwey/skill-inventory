ENV['RACK_ENV'] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'tilt/erb'
require 'tilt/haml'

DatabaseCleaner[:sequel, { :connection => Sequel.sqlite('db/skill_inventory_test.sqlite3')}].strategy = :truncation

class Minitest::Test
  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

  # Helpers
  def add_skill(num)
    num.times do |i|
      SkillInventory.add({:title       => "a title #{i + 1}",
                          :description => "a description #{i + 1}"})
    end
  end
end

Capybara.app = SkillInventoryApp

class FeatureTest < Minitest::Test
  include Capybara::DSL
end
