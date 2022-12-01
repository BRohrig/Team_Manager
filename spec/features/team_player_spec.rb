require 'rails_helper'

RSpec.describe 'the index of players to teams' do
  
  before :each do
    @sounders = Team.create!(name: "Sounders FC", city: "Seattle", owner: "Adrian Hanauer", title_holder: false, titles_won: 2)
  end

  it 'displays the players associated with a team' do
    raul = @sounders.players.create!(name: "Raul Ruidiaz", salary: 3000000, citizen: false, trade_eligible: false, contract_length_months: 39)
    visit "/teams/#{@sounders.id}/players"

    expect(page).to have_content(raul.name)
    expect(page).to have_content(raul.salary)
    expect(page).to have_content(raul.citizen)
    expect(page).to have_content(raul.trade_eligible)
    expect(page).to have_content(raul.contract_length_months)

  end


end