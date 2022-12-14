require 'rails_helper'

RSpec.describe 'the teams index page' do
  # user story 1
  it 'displays the team names' do
    sounders = Team.create!(name: "Sounders FC", city: "Seattle", owner: "Adrian Hanauer", title_holder: false, titles_won: 2)
    visit "/teams"
   
    expect(page).to have_content(sounders.name)
  end

  # user story 2
  it 'displays the team name and attributes when i navigate to its ID page' do
    sounders = Team.create!(name: "Sounders FC", city: "Seattle", owner: "Adrian Hanauer", title_holder: false, titles_won: 2)
    
    visit "/teams/#{sounders.id}"
    
    expect(page).to have_content(sounders.name)
    expect(page).to have_content(sounders.owner)
    expect(page).to have_content(sounders.city)
    expect(page).to have_content(sounders.title_holder)
    expect(page).to have_content(sounders.titles_won)
  end

  # user story 6
  it 'displays the team names by most recently created' do
    rsl = Team.create!(name: "Real Salt Lake", city: "Salt Lake City", owner: "some guy", title_holder: false, titles_won: 1)
    sounders = Team.create!(name: "Sounders FC", city: "Seattle", owner: "Adrian Hanauer", title_holder: false, titles_won: 2)
    
    visit "/teams"
  
    expect(sounders.name).to appear_before(rsl.name)
  end
  # user story 6
  it 'displays the created_at for each team' do
    rsl = Team.create!(name: "Real Salt Lake", city: "Salt Lake City", owner: "some guy", title_holder: false, titles_won: 1, created_at: DateTime.now-2.hours)
    sounders = Team.create!(name: "Sounders FC", city: "Seattle", owner: "Adrian Hanauer", title_holder: false, titles_won: 2)
   
    visit "/teams"

    expect(page).to have_content(sounders.name)
    expect(page).to have_content(sounders.created_at)
  
    expect(sounders.name).to appear_before(sounders.created_at.to_s)
    expect(sounders.created_at.to_s).to appear_before(rsl.name)
    expect(rsl.name).to appear_before(rsl.created_at.to_s)
  end

  # user story 7
  it 'displays the number of players associated with a team on the show page' do
    sounders = Team.create!(name: "Sounders FC", city: "Seattle", owner: "Adrian Hanauer", title_holder: false, titles_won: 2)
    raul = sounders.players.create!(name: "Raul Ruidiaz", salary: 3000000, citizen: false, trade_eligible: false, contract_length_months: 39)
    
    visit "teams/#{sounders.id}"

    expect(page).to have_content("Players On Roster: 1")
  end

  # user story 8
  it 'has a link to the players index at the top of every page' do
    visit "/teams"

    expect(page).to have_link 'Player Index', href: "/players"

    sounders = Team.create!(name: "Sounders FC", city: "Seattle", owner: "Adrian Hanauer", title_holder: false, titles_won: 2)

    visit "teams/#{sounders.id}"

    expect(page).to have_link 'Player Index', href: "/players"
  end

  # user story 9
  it 'has a link to the team index' do
    visit "/teams"
    expect(page).to have_link 'Team Index', href: "/teams"

    sounders = Team.create!(name: "Sounders FC", city: "Seattle", owner: "Adrian Hanauer", title_holder: false, titles_won: 2)
    visit "/teams/#{sounders.id}"
    expect(page).to have_link 'Team Index', href: "/teams"
  end

  # user story 10
  it 'has a link on the team page to the that teams players' do
    sounders = Team.create!(name: "Sounders FC", city: "Seattle", owner: "Adrian Hanauer", title_holder: false, titles_won: 2)
    raul = sounders.players.create!(name: "Raul Ruidiaz", salary: 3000000, citizen: false, trade_eligible: false, contract_length_months: 39)
    roldan = sounders.players.create!(name: "Cristian Roldan", salary: 24500, citizen: true, trade_eligible: true, contract_length_months: 27)

    visit "/teams/#{sounders.id}"
    expect(page).to have_link 'Player List', href: "/teams/#{sounders.id}/players"
  end

  # user story 11
  it 'has a link on the team page that takes me to a page to create a new team' do
    visit "/teams"

    expect(page).to have_link 'Add New Team', href: "/teams/new"
  end

  # user story 11
  it 'has a form to fill out to create a new team' do 
    visit "/teams/new"

    expect(page).to have_content("Enter a New Team Name:")
    fill_in "1", with: "Colorado Rapids"
    fill_in "2", with: "Denver"
    fill_in "3", with: "guy"
    fill_in "4", with: false
    fill_in "5", with: 0
    
    click_on "Create Team"
    
    expect(page).to have_content("Colorado Rapids")
    expect(page).to have_content(Time.now.utc)
  end

  # user story 12
  it 'has a link to update the team on the team show page' do
    sounders = Team.create!(name: "Sounders FC", city: "Seattle", owner: "Adrian Hanauer", title_holder: false, titles_won: 2)
    visit "/teams/#{sounders.id}"

    expect(page).to have_link("Update Team")
    click_on "Update Team"

    expect(current_path).to eq("/teams/#{sounders.id}/edit")
    expect(page).to have_content "Update Team Name:"
    expect(page).to have_content "Update Team City:"
    expect(page).to have_content "Update Team Owner:"
    expect(page).to have_content "Update Team Title Possession (T/F):"
    expect(page).to have_content "Update Number of Titles Won:"
    expect(page).to have_button "Submit"

    fill_in "a", with: "Vancouver Whitecaps"
    fill_in "b", with: "Vancouver"
    fill_in "c", with: "not AH"
    fill_in "d", with: false
    fill_in "e", with: 0

    click_on "Submit"

    expect(current_path).to eq("/teams/#{sounders.id}")
    expect(page).to have_content "Vancouver Whitecaps"
    expect(page).to have_content "City: Vancouver"
    expect(page).to have_content "Owner: not AH"
    expect(page).to have_content "Does Team Hold Title? false"
    expect(page).to have_content "Titles Won: 0"
    expect(page).to_not have_content "Sounders FC"
    expect(page).to_not have_content "City: Seattle"
    expect(page).to_not have_content "Owner: Adrian Hanauer"
    expect(page).to_not have_content "Titles Won: 2"
  end

  # user story 17
  it 'has links to each teams edit page on the index page' do
    sounders = Team.create!(name: "Sounders FC", city: "Seattle", owner: "Adrian Hanauer", title_holder: false, titles_won: 2)
    rsl = Team.create!(name: "Real Salt Lake", city: "Salt Lake City", owner: "some guy", title_holder: false, titles_won: 1)

    visit "/teams"

    expect(page).to have_link("Edit Sounders FC")
    expect(page).to have_link("Edit Real Salt Lake")
    click_link "Edit Sounders FC"
    expect(current_path).to eq("/teams/#{sounders.id}/edit")
    click_link "Team Index"
    expect(current_path).to eq("/teams")
    click_link "Edit Real Salt Lake"
    expect(current_path).to eq("/teams/#{rsl.id}/edit")
  end

  # user story 19
  it 'has a delete button on the team show page that deletes it and all players associated' do
    sounders = Team.create!(name: "Sounders FC", city: "Seattle", owner: "Adrian Hanauer", title_holder: false, titles_won: 2)
    raul = sounders.players.create!(name: "Raul Ruidiaz", salary: 3000000, citizen: false, trade_eligible: false, contract_length_months: 39)
    roldan = sounders.players.create!(name: "Cristian Roldan", salary: 24500, citizen: true, trade_eligible: true, contract_length_months: 27)
    visit "/teams/#{sounders.id}"

    expect(page).to have_link("Delete #{sounders.name}")
    click_link "Delete #{sounders.name}"

    expect(current_path).to eq("/teams")
    expect(page).to_not have_content("#{sounders.name}")

    visit "/players"
    expect(page).to_not have_content("#{raul.name}")
    expect(page).to_not have_content("#{roldan.name}")
  end

  # user story 22
  it 'has a delete link next to each team on the index page' do
    sounders = Team.create!(name: "Sounders FC", city: "Seattle", owner: "Adrian Hanauer", title_holder: false, titles_won: 2)
    rsl = Team.create!(name: "Real Salt Lake", city: "Salt Lake City", owner: "some guy", title_holder: false, titles_won: 1)

    visit "/teams"
    expect(page).to have_content(sounders.name)
    expect(page).to have_content(sounders.name)
    expect(page).to have_link("Delete #{sounders.name}")
    expect(page).to have_link("Delete #{rsl.name}")

    click_link("Delete #{sounders.name}")
    expect(current_path).to eq("/teams")
    expect(page).to_not have_content(sounders.name)
    expect(page).to have_content(rsl.name)
    click_link("Delete #{rsl.name}")
    expect(page).to_not have_content(rsl.name)
  end

  # extension 1
  it 'has a link to sort the teams by the number of players they have' do
    sounders = Team.create!(name: "Sounders FC", city: "Seattle", owner: "Adrian Hanauer", title_holder: false, titles_won: 2)
    rsl = Team.create!(name: "Real Salt Lake", city: "Salt Lake City", owner: "some guy", title_holder: false, titles_won: 1)
    dallas = Team.create!(name: "FC Dallas", city: "Dallas", owner: "some other guy", title_holder: false, titles_won: 0)
    raul = sounders.players.create!(name: "Raul Ruidiaz", salary: 3000000, citizen: false, trade_eligible: false, contract_length_months: 39)
    roldan = sounders.players.create!(name: "Cristian Roldan", salary: 24500, citizen: true, trade_eligible: true, contract_length_months: 27)
    bob = rsl.players.create!(name: "Bobby bob", salary: 300, citizen: false, trade_eligible: false, contract_length_months: 15)
    tom = rsl.players.create!(name: "Tommy tom", salary: 2400, citizen: true, trade_eligible: true, contract_length_months: 23)
    jim = rsl.players.create!(name: "jimmy jim", salary: 30000, citizen: false, trade_eligible: false, contract_length_months: 34)
    will = dallas.players.create!(name: "willy will", salary: 23500, citizen: true, trade_eligible: true, contract_length_months: 21)
    
    visit "/teams"
    expect(page).to have_link("Sort By Number of Players on Roster")
    click_link("Sort By Number of Players on Roster")

    expect(current_path).to eq("/teams")
    expect("#{rsl.name}").to appear_before("Number of Players: #{rsl.player_count}")
    expect("Number of Players: #{rsl.player_count}").to appear_before("#{sounders.name}")
    expect("#{sounders.name}").to appear_before("Number of Players: #{sounders.player_count}")
    expect("Number of Players: #{sounders.player_count}").to appear_before("#{dallas.name}")
    expect("#{dallas.name}").to appear_before("Number of Players: #{dallas.player_count}")
  end

end