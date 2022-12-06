class Player < ApplicationRecord
  belongs_to :team

  def self.sort_name
    self.order(:name)
  end

  def self.salary_filter(filter_num)
    self.where("salary > #{filter_num.to_i}") 
  end

  def self.eligible_sort
    where(trade_eligible: true)
  end
end