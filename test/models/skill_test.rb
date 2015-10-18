require_relative '../test_helper'

class SkillTest < Minitest::Test
  def test_a_skill_has_a_title_and_description
    skill = Skill.new(:title        => 'a title',
                      :description => 'a description')

    assert skill.class == Skill
    assert_equal 'a title', skill.title
    assert_equal 'a description', skill.description
  end
end
