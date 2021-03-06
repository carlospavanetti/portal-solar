require 'test_helper'

class PowerGeneratorTest < ActiveSupport::TestCase
  test "should search by term in description or name" do
    term = 'YC600i'
    found = PowerGenerator.by_term term
    assert(found.all? do |pg|
        pg.name.include?(term) || pg.description.include?(term)
    end)
  end

  test "should search by manufacturer" do
    found = PowerGenerator.by_manufacturer 'Solar Group'
    manufacturers = found.distinct.pluck(:manufacturer)
    assert(manufacturers == ['Solar Group'])
  end

  test "should return all entities when manufacturer is not passed" do
    found = PowerGenerator.by_manufacturer ''
    assert(found.count == PowerGenerator.count)
  end

  test "should perform an advanced search" do
    found = PowerGenerator.by_advanced_search(
      structure_type: 'fibrocimento', lenght: '', width: 0.3)
    assert(found.present?)
    assert(found.distinct.pluck(:structure_type) == ['fibrocimento'])
  end
end
