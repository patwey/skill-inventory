require_relative '../test_helper.rb'

class SkillInventoryTest < Minitest::Test
  def add_skill(num)
    num.times do |i|
      SkillInventory.add({:title       => "a title #{i + 1}",
                          :description => "a description #{i + 1}"})
    end
  end

  def test_it_can_return_an_inventory_of_existing_skills
    skills = SkillInventory.all
    assert_equal [], skills

    add_skill(2)
    new_skills = SkillInventory.all

    assert_equal 'a title 1', new_skills.first.title
    assert_equal 'a description 1', new_skills.first.description
    assert_equal 'a title 2', new_skills.last.title
    assert_equal 'a description 2', new_skills.last.description
  end

  def test_it_can_create_a_skill
    assert_equal 0, SkillInventory.all.count

    SkillInventory.add({:title       => 'my new skill',
                        :description => 'about my new skill'})
    skills = SkillInventory.all

    assert_equal 1, skills.count
    assert_equal 'my new skill', skills.first.title
    assert_equal 'about my new skill', skills.first.description
  end

  def test_it_can_return_a_single_skill_given_an_id
    add_skill(3)

    assert_equal 3, SkillInventory.all.count

    id = SkillInventory.all.first.id
    skill = SkillInventory.find(id)

    assert_equal 'a title 1', skill.title
    assert_equal 'a description 1', skill.description

    diff_id = SkillInventory.all.last.id
    diff_skill = SkillInventory.find(diff_id)

    assert_equal 'a title 3', diff_skill.title
    assert_equal 'a description 3', diff_skill.description
  end

  def test_it_can_update_a_skill_given_an_id
    add_skill(2)

    assert_equal 2, SkillInventory.all.count

    id = SkillInventory.all.last.id
    SkillInventory.update(id, {:title       => 'updated title',
                               :description => 'updated description'})
    skill = SkillInventory.find(id)

    assert_equal 'updated title', skill.title
    assert_equal 'updated description', skill.description
  end

  def test_it_can_delete_a_skill
    add_skill(2)

    total = SkillInventory.all.count

    assert_equal 2, total

    id = SkillInventory.all.last.id
    SkillInventory.delete(id)

    assert_equal (total - 1), SkillInventory.all.count

    id = SkillInventory.all.first.id
    SkillInventory.delete(id)

    assert_equal (total - 2), SkillInventory.all.count
  end
end
