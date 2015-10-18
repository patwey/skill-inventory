class SkillInventory
  def self.database
    if ENV['RACK_ENV'] == 'test'
      @database ||= Sequel.sqlite('db/skill_inventory_test.sqlite3')
    else
      @database ||= Sequel.sqlite('db/skill_inventory_development.sqlite3')
    end
  end

  def self.table
    database.from(:skills)
  end

  def self.all
    table.to_a.map { |row| Skill.new(row) }
  end

  def self.add(data)
    table.insert(data)
  end

  def self.find(id)
    row = table.where(:id => id).to_a.first
    Skill.new(row)
  end

  def self.delete(id)
    table.where(:id => id).delete
  end

  def self.update(id, data)
    table.where(:id => id).update(data)
  end
end
