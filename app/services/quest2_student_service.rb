class Quest2StudentService
  class << self

    def all_agents
      Agent.order(:codename).pluck(:codename).join("\n")
    end


    def all_missions
      Mission.order(:title).pluck(:title).join("\n")
    end


    def agents_with_missions
      Agent.includes(:missions).order(:codename).map do |agent|
        missions = agent.missions.order(:title).map(&:title).join(", ")
        "#{agent.codename}: #{missions}"
      end.join("\n")
    end


    def agents_with_missions_sorted_by_mission_count
      Agent.includes(:missions)
           .map { |a| [a, a.missions.count] }
           .sort_by { |a, count| [-count, a.codename] }
           .map do |agent, count|
             missions = agent.missions.order(:title).map(&:title).join(", ")
             "#{agent.codename} (#{count}): #{missions}"
           end.join("\n")
    end


    def agents_with_skills
      Agent.includes(:skills).order(:codename).map do |agent|
        skills = agent.skills.order(:name).map(&:name).join(", ")
        "#{agent.codename}: #{skills}"
      end.join("\n")
    end

    
    def skills_by_agent_count
      Skill.includes(:agents)
           .map { |s| [s, s.agents.count] }
           .sort_by { |s, count| [-count, s.name] }
           .map do |skill, count|
             agents = skill.agents.order(:codename).map(&:codename).join(", ")
             "#{skill.name} (#{count}): #{agents}"
           end.join("\n")
    end
  end
end
