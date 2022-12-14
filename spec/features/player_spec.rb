require 'rails_helper'

RSpec.describe 'the players pages' do
  before :each do
    @sounders = Team.create!(name: "Sounders FC", city: "Seattle", owner: "Adrian Hanauer", title_holder: false, titles_won: 2)
    @raul = @sounders.players.create!(name: "Raul Ruidiaz", salary: 3000000, citizen: false, trade_eligible: false, contract_length_months: 39)
    @roldan = @sounders.players.create!(name: "Cristian Roldan", salary: 24500, citizen: true, trade_eligible: true, contract_length_months: 27)
  end

  # user story 3
  it 'displays the player names' do
    visit "/players"

    expect(page).to have_content(@raul.name)
    expect(page).to have_content(@raul.salary)
    expect(page).to have_content(@raul.citizen)
    expect(page).to have_content(@raul.trade_eligible)
    expect(page).to have_content(@raul.contract_length_months)
    expect(page).to have_content(@roldan.name)
    expect(page).to have_content(@roldan.salary)
    expect(page).to have_content(@roldan.citizen)
    expect(page).to have_content(@roldan.trade_eligible)
    expect(page).to have_content(@roldan.contract_length_months)
  end

  # user story 4
  it 'displays the players info on their page' do
    visit "/players/#{@raul.id}"

    expect(page).to have_content(@raul.name)
    expect(page).to have_content("Salary: $#{@raul.salary}")
    expect(page).to have_content("US Citizen? #{@raul.citizen}")
    expect(page).to have_content("Eligible for Trade? #{@raul.trade_eligible}")
    expect(page).to have_content("Contract Length in Months: #{@raul.contract_length_months}")
    expect(page).to_not have_content(@roldan.name)
    expect(page).to_not have_content(@roldan.salary)
  end

  # user story 8
  it 'has a link to the player index' do
    visit "/players"
    expect(page).to have_link 'Player Index', href: "/players"

    visit "/players/#{@raul.id}"
    expect(page).to have_link 'Player Index', href: "/players"
  end

  # user story 9
  it 'has a link to the team index' do
    visit "/players"
    expect(page).to have_link 'Team Index', href: "/teams"

    visit "/players/#{@raul.id}"
    expect(page).to have_link 'Team Index', href: "/teams"
  end

  # user story 14
  it 'has a link to an update page which allows me to modify the player' do
    visit "/players/#{@raul.id}"
    expect(page).to have_link 'Update Player', href: "/players/#{@raul.id}/edit"

    click_link 'Update Player'
    expect(current_path).to eq("/players/#{@raul.id}/edit")
    expect(page).to have_content("Update Player Name:")
    expect(page).to have_content("Update Player Salary:")
    expect(page).to have_content("Update Player Citizenship (T/F):")
    expect(page).to have_content("Update Player Trade Eligibility (T/F):")
    expect(page).to have_content("Update Player Contract Length:")
    expect(page).to have_button("Submit")

    fill_in "f", with: "Joao Paulo"
    fill_in "g", with: 22223
    fill_in "h", with: true
    fill_in "i", with: true
    fill_in "j", with: 3

    click_on "Submit"

    expect(current_path).to eq("/players/#{@raul.id}")
    expect(page).to have_content("Joao Paulo")
    expect(page).to have_content("Salary: $22223")
    expect(page).to have_content("US Citizen? true")
    expect(page).to have_content("Eligible for Trade? true")
    expect(page).to have_content("Contract Length in Months: 3")
    expect(page).to_not have_content("Raul Ruidiaz")
    expect(page).to_not have_content("Salary: 3000000")
    expect(page).to_not have_content("US Citizen: false")
    expect(page).to_not have_content("Eligible for Trade? false")
    expect(page).to_not have_content("Contract Length in Months: 39")
  end

  # user story 15
  it 'has a link to only display players who are eligible for trade' do
    rsl = Team.create!(name: "Real Salt Lake", city: "Salt Lake City", owner: "some guy", title_holder: false, titles_won: 1)
    jimmy = rsl.players.create!(name: "Jimmy Jim", salary: 20, citizen: true, trade_eligible: true, contract_length_months: 14)
    bob = rsl.players.create!(name: "bobby bob", salary: 42, citizen: false, trade_eligible: false, contract_length_months: 4)

    visit "/players"
    expect(page).to have_link "Trade Eligible Players"
    click_link "Trade Eligible Players"
  
    expect(page).to have_content("Players Eligible for Trade:")
    expect(page).to have_content(@roldan.name)
    expect(page).to have_content("Team ID: #{@sounders.id}")
    expect(page).to have_content("Salary: $#{@roldan.salary}")
    expect(page).to have_content("US Citizen? #{@roldan.citizen}")
    expect(page).to have_content("Eligible for Trade? #{@roldan.trade_eligible}")
    expect(page).to have_content("Contract Length in Months: #{@roldan.contract_length_months}")
    expect(page).to have_content(jimmy.name)
    expect(page).to have_content("Team ID: #{rsl.id}")
    expect(page).to have_content("Salary: $#{jimmy.salary}")
    expect(page).to have_content("US Citizen? #{jimmy.citizen}")
    expect(page).to have_content("Eligible for Trade? #{jimmy.trade_eligible}")
    expect(page).to have_content("Contract Length in Months: #{jimmy.contract_length_months}")
  end

  # user story 18
  it 'has a link to edit the player' do
    rsl = Team.create!(name: "Real Salt Lake", city: "Salt Lake City", owner: "some guy", title_holder: false, titles_won: 1)
    jimmy = rsl.players.create!(name: "Jimmy Jim", salary: 20, citizen: true, trade_eligible: true, contract_length_months: 14)

    visit "/players"
    expect(page).to have_link("Edit Raul Ruidiaz")
    expect(page).to have_link("Edit Cristian Roldan")
    expect(page).to have_link("Edit Jimmy Jim")

    click_link "Edit Raul Ruidiaz"
    expect(current_path).to eq("/players/#{@raul.id}/edit")
    click_link "Player Index"
    expect(current_path).to eq("/players")
    click_link "Edit Jimmy Jim"
    expect(current_path).to eq("/players/#{jimmy.id}/edit")
  end

  # user story 20
  it 'has a link to delete a player on that players show page' do
    visit "/players/#{@roldan.id}"
    expect(page).to have_link("Delete Cristian Roldan")

    click_link("Delete Cristian Roldan")
    expect(current_path).to eq("/players")
    expect(page).to have_content("Raul Ruidiaz")
    expect(page).to_not have_content("Cristian Roldan")
    visit "/players/#{@raul.id}"
    expect(page).to have_content("Raul Ruidiaz")
    expect(page).to have_link("Delete Raul Ruidiaz")
    click_link("Delete Raul Ruidiaz")
    expect(current_path).to eq("/players")
    expect(page).to_not have_content("Raul Ruidiaz")
    expect(page).to_not have_content("Cristian Roldan")
  end

  # user story 23
  it 'has a link to delete each player on the player index page' do
    visit "/players"
    expect(page).to have_content(@roldan.name)
    expect(page).to have_content(@raul.name)
    expect(page).to have_link("Delete #{@roldan.name}")
    expect(page).to have_link("Delete #{@raul.name}")

    click_link "Delete #{@roldan.name}"
    expect(current_path).to eq("/players")
    expect(page).to_not have_content(@roldan.name)
    expect(page).to have_content(@raul.name)
    click_link "Delete #{@raul.name}"
    expect(page).to_not have_content(@raul.name)

  end
end