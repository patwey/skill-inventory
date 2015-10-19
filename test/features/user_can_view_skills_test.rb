require_relative '../test_helper'

class ViewSkillsTest < FeatureTest
  def test_user_can_navigate_from_homepage_to_the_index_page
    # As a user, when I navigate to the homepage, and I click the Skill Index
    # link, then I am brought to the skills index
    visit '/'
    assert_equal '/', current_path

    assert has_link? 'Skill Index'
    click_link 'Skill Index'

    assert_equal '/skills', current_path
  end

  def test_user_can_see_existing_skills_on_the_index_page
    # As a user, when I navigate to the skills index, and skills exist,
    # then I see a title link, update button and delete button for each
    # specific skill
    add_skill(5)
    assert_equal 5, SkillInventory.all.count

    skills = SkillInventory.all.map { |skill| skill }

    visit '/skills'
    assert_equal '/skills', current_path

    assert has_css? '.skill-index'
    within '.skill-index'  do
      skills.each do |skill|
        assert has_css? "#skill-#{skill.id}"
        within "#skill-#{skill.id}" do
          assert has_link? "#{skill.title.capitalize}"
          assert has_link? "Update"
          assert has_css? "#delete-skill-#{skill.id}"
          within "#delete-skill-#{skill.id}" do
            assert has_button? "Delete"
          end
        end
      end
    end
  end

  def test_user_can_see_link_to_add_new_skill_on_index_page_if_no_skills_exist
    # As a user, when I navigate to the skills index, and skills do not exist,
    # then I see a prompt to add a new skill
    assert_equal 0, SkillInventory.all.count

    visit '/skills'
    assert_equal '/skills', current_path

    refute has_css? '.skill-index'
    assert has_css? '.empty-skill-index'
    within '.empty-skill-index' do
      assert has_link? 'Add a skill'
    end
  end

  def test_user_can_see_info_for_a_specific_skill
    # As a user, when I navigate to the skills index, and I click on the title
    # link of a specific skill, then I see the title and description for that
    # skill, an update link, a delete link and an option to return to the index
    add_skill(2)
    assert_equal 2, SkillInventory.all.count
    skill = SkillInventory.all.first

    visit '/skills'
    assert_equal '/skills', current_path

    assert has_css? '.skill-index'
    within '.skill-index' do
      assert has_css? "#skill-#{skill.id}"
      within "#skill-#{skill.id}" do
        assert has_link? "#{skill.title.capitalize}"
        click_link "#{skill.title.capitalize}"
      end
    end

    assert_equal "/skills/#{skill.id}", current_path

    assert has_css? "#skill-#{skill.id}"
    within "#skill-#{skill.id}" do
      assert has_css? ".skill-title"
      assert has_css? ".skill-description"
      assert has_link? "Update"
      assert has_css? "#delete-skill-#{skill.id}"
      within "#delete-skill-#{skill.id}" do
        assert has_button? "Delete"
      end
    end

    assert has_link? "Return to Index"
  end
end
