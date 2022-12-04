class Player < ApplicationRecord
  belongs_to :team

  def self.sort_name
    self.order(:name)
  end
end