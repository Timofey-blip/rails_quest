class AddIndexesToAgentsSkills < ActiveRecord::Migration[7.0]
  def change
    add_index :agents, :codename, unique: true, name: "index_agents_on_codename"
    add_index :skills, :name, unique: true, name: "index_skills_on_name"
    add_index :agent_skills, [ :agent_id, :skill_id ], unique: true, name: "index_agent_skills_on_agent_id_and_skill_id"
  end
end
