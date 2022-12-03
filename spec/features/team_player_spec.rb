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

  it 'has a link to create a new player for the team' do
    visit "/teams/#{@sounders.id}/players"

    expect(page).to have_link("Create Player")

    click_link "Create Player"

    expect(current_path).to eq("/teams/#{@sounders.id}/players/new")
    expect(page).to have_content("New Player Name:")
    expect(page).to have_content("New Player Salary:")
    expect(page).to have_content("New Player Citizen? (T/F)")
    expect(page).to have_content("New Player Trade Eligible? (T/F")
    expect(page).to have_content("New Player Contract Length in Months:")
    expect(page).to have_button("Create Player")

    fill_in "6", with: "Nicolas Lodeiro"
    fill_in "7", with: 123123
    fill_in "8", with: false
    fill_in "9", with: false
    fill_in "10", with: 23
    
    click_button "Create Player"

    expect(current_path).to eq("/teams/#{@sounders.id}/players")
    expect(page).to have_content("Nicolas Lodeiro")
    expect(page).to have_content("Salary: 123123")
    expect(page).to have_content("US Citizen? false")
    expect(page).to have_content("Eligible for Trade? false")
    expect(page).to have_content("Contract Length (Months): 23")
    

  end


end