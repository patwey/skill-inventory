require_relative '../test_helper'

class AddSkillTest < FeatureTest
  def test_user_can_navigate_from_homepage_to_add_skill_page
    # As a user, when I navigate to the homepage, and I press the Add a Skill
    # button, then I am brought to the add skill page
    visit '/'
    assert_equal '/', current_path

    assert has_link? 'Add a Skill'
    click_link 'Add a Skill'

    assert_equal '/skills/add', current_path
  end

  def test_user_can_navigate_from_add_skill_page_to_homepage
    # As a user, when I navigate to the add skill page, and I click the return
    # to Index link, then I return to the skills index
    visit '/skills/add'
    assert_equal '/skills/add', current_path

    assert has_link? 'Return to Index'
    click_link 'Return to Index'

    assert_equal '/skills', current_path
  end

  def test_user_can_see_add_skill_form
    # As a user, when I navigate to the add skill page, then I see the add
    # skill form and a link to return to the index
    visit '/skills/add'
    assert_equal '/skills/add', current_path

    assert has_css? '.add-skill'
    within '.add-skill' do
      assert has_field? 'skill[title]'
      assert has_field? 'skill[description]'
      assert has_button? 'Submit'
    end

    assert has_link? 'Return to Index'
  end

  def test_user_can_add_a_skill
    # As a user, when I navigate to the add skill page, and I enter in a title
    # and description and I press submit, then a skill is created
    # and I am brought to the skill index
    visit '/skills/add'
    assert_equal '/skills/add', current_path

    assert has_css? '.add-skill'
    within '.add-skill' do
      fill_in('skill[title]', with: 'my new skill')
      fill_in('skill[description]', with: 'my new description')
      click_button 'Submit'
    end

    assert_equal '/skills', current_path
  end
end
