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

  it 'has link on the teams players index page to sort the players alphabetically by name' do
    raul = @sounders.players.create!(name: "Raul Ruidiaz", salary: 3000000, citizen: false, trade_eligible: false, contract_length_months: 39)
    roldan = @sounders.players.create!(name: "Cristian Roldan", salary: 24500, citizen: true, trade_eligible: true, contract_length_months: 27)

    visit "/teams/#{@sounders.id}/players"
    expect(raul.name).to appear_before(roldan.name)
    expect(page).to have_link "Sort Players By Name"
    click_link "Sort Players By Name"
    # save_and_open_page
    
    expect(roldan.name).to appear_before("Salary: #{roldan.salary}")
    expect("Salary: #{roldan.salary}").to appear_before("US Citizen? #{roldan.citizen}")
    expect("US Citizen? #{roldan.citizen}").to appear_before("Eligible for Trade? #{roldan.trade_eligible}")
    expect("Eligible for Trade? #{roldan.trade_eligible}").to appear_before("Contract Length (Months): #{roldan.contract_length_months}")
    expect("Contract Length (Months): #{roldan.contract_length_months}").to appear_before(raul.name)
    expect(raul.name).to appear_before("Salary: #{raul.salary}")
    expect("Salary: #{raul.salary}").to appear_before("US Citizen? #{raul.citizen}")
    expect("US Citizen? #{raul.citizen}").to appear_before("Eligible for Trade? #{raul.trade_eligible}")
    expect("Eligible for Trade? #{raul.trade_eligible}").to appear_before("Contract Length (Months): #{raul.contract_length_months}")
  end

  it 'has a link to edit the player' do
    raul = @sounders.players.create!(name: "Raul Ruidiaz", salary: 3000000, citizen: false, trade_eligible: false, contract_length_months: 39)
    roldan = @sounders.players.create!(name: "Cristian Roldan", salary: 24500, citizen: true, trade_eligible: true, contract_length_months: 27)
    rsl = Team.create!(name: "Real Salt Lake", city: "Salt Lake City", owner: "some guy", title_holder: false, titles_won: 1)
    jimmy = rsl.players.create!(name: "Jimmy Jim", salary: 20, citizen: true, trade_eligible: true, contract_length_months: 14)

    visit "/teams/#{@sounders.id}/players"
    expect(page).to have_link("Edit Raul Ruidiaz")
    expect(page).to have_link("Edit Cristian Roldan")
    
    click_link "Edit Raul Ruidiaz"
    expect(current_path).to eq("/players/#{raul.id}/edit")
    click_link "Player Index"
    expect(current_path).to eq("/players")
    
    visit "/teams/#{rsl.id}/players"
    expect(page).to have_link("Edit Jimmy Jim")
    click_link "Edit Jimmy Jim"
    expect(current_path).to eq("/players/#{jimmy.id}/edit")
  end

  it 'has a form on the index page that allows a user to find players who make more than an input salary' do
    raul = @sounders.players.create!(name: "Raul Ruidiaz", salary: 3000000, citizen: false, trade_eligible: false, contract_length_months: 39)
    roldan = @sounders.players.create!(name: "Cristian Roldan", salary: 24500, citizen: true, trade_eligible: true, contract_length_months: 27)

    visit "/teams/#{@sounders.id}/players"


  end

end