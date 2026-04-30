class Mission < ApplicationRecord
  belongs_to :agent

  enum :status, { assigned: "assigned", in_progress: "in_progress", completed: "completed" }

  validates :title, presence: true
  validates :status, presence: true, inclusion: { in: %w[assigned in_progress completed] }
end
