class Team < ApplicationRecord
  has_many :players

  def self.created_order
    Team.all.sort_by { |team| team.created_at }.reverse
  end
end