require 'rails_helper'

RSpec.describe 'the teams index page' do

  it 'displays the team names' do
    sounders = Team.create!(name: "Sounders FC", city: "Seattle", owner: "Adrian Hanauer", title_holder: false, titles_won: 2)
    visit "/teams"
   
    expect(page).to have_content(sounders.name)
  end

  it 'displays the team name and attributes when i navigate to its ID page' do
    sounders = Team.create!(name: "Sounders FC", city: "Seattle", owner: "Adrian Hanauer", title_holder: false, titles_won: 2)
    
    visit "/teams/#{sounders.id}"
    
    expect(page).to have_content(sounders.name)
    expect(page).to have_content(sounders.owner)
    expect(page).to have_content(sounders.city)
    expect(page).to have_content(sounders.title_holder)
    expect(page).to have_content(sounders.titles_won)
  end

  it 'displays the team names by most recently created' do
    rsl = Team.create!(name: "Real Salt Lake", city: "Salt Lake City", owner: "some guy", title_holder: false, titles_won: 1)
    sounders = Team.create!(name: "Sounders FC", city: "Seattle", owner: "Adrian Hanauer", title_holder: false, titles_won: 2)
    
    visit "/teams"
  
    expect(sounders.name).to appear_before(rsl.name)
  end

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

  it 'displays the number of players associated with a team on the show page' do
    sounders = Team.create!(name: "Sounders FC", city: "Seattle", owner: "Adrian Hanauer", title_holder: false, titles_won: 2)
    raul = sounders.players.create!(name: "Raul Ruidiaz", salary: 3000000, citizen: false, trade_eligible: false, contract_length_months: 39)
    
    visit "teams/#{sounders.id}"

    expect(page).to have_content("Players On Roster: 1")
  end

  it 'has a link to the players index at the top of every page' do
    visit "/teams"

    expect(page).to have_link 'Player Index', href: "/players"

    sounders = Team.create!(name: "Sounders FC", city: "Seattle", owner: "Adrian Hanauer", title_holder: false, titles_won: 2)

    visit "teams/#{sounders.id}"

    expect(page).to have_link 'Player Index', href: "/players"
  end

  it 'has a link to the team index' do
    visit "/teams"
    expect(page).to have_link 'Team Index', href: "/teams"

    sounders = Team.create!(name: "Sounders FC", city: "Seattle", owner: "Adrian Hanauer", title_holder: false, titles_won: 2)
    visit "/teams/#{sounders.id}"
    expect(page).to have_link 'Team Index', href: "/teams"
  end

  it 'has a link on the team page to the that teams players' do
    sounders = Team.create!(name: "Sounders FC", city: "Seattle", owner: "Adrian Hanauer", title_holder: false, titles_won: 2)
    raul = sounders.players.create!(name: "Raul Ruidiaz", salary: 3000000, citizen: false, trade_eligible: false, contract_length_months: 39)
    roldan = sounders.players.create!(name: "Cristian Roldan", salary: 24500, citizen: true, trade_eligible: true, contract_length_months: 27)

    visit "/teams/#{sounders.id}"
    expect(page).to have_link 'Player List', href: "/teams/#{sounders.id}/players"
  end

  it 'has a link on the team page that takes me to a page to create a new team' do
    visit "/teams"

    expect(page).to have_link 'Add New Team', href: "/teams/new"
  end

  it 'has a form to fill out to create a new team' do 
    visit "/teams/new"

    expect(page).to have_content("Enter a New Team Name:")
    


  end

end