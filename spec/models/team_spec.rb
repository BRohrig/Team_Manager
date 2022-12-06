require 'rails_helper'

RSpec.describe Team do
  it 'has a method to list teams by most recently created first' do
    sounders = Team.create!(name: "Sounders FC", city: "Seattle", owner: "Adrian Hanauer", title_holder: false, titles_won: 2)
    rsl = Team.create!(name: "Real Salt Lake", city: "Salt Lake City", owner: "some guy", title_holder: false, titles_won: 1)

    expect(Team.created_order).to eq([rsl, sounders])
  end

  it 'has a method to count players on a team' do
    sounders = Team.create!(name: "Sounders FC", city: "Seattle", owner: "Adrian Hanauer", title_holder: false, titles_won: 2)
    raul = sounders.players.create!(name: "Raul Ruidiaz", salary: 3000000, citizen: false, trade_eligible: false, contract_length_months: 39)

    expect(sounders.player_count).to eq(1)

    roldan = sounders.players.create!(name: "Cristian Roldan", salary: 24500, citizen: true, trade_eligible: true, contract_length_months: 27)
    expect(sounders.player_count).to eq(2)
  end


end