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
    rsl = Team.create!(name: "Real Salt Lake", city: "Salt Lake City", owner: "some guy", title_holder: false, titles_won: 1)
    sounders = Team.create!(name: "Sounders FC", city: "Seattle", owner: "Adrian Hanauer", title_holder: false, titles_won: 2)
    binding.pry
    visit "/teams"
save_and_open_page
    expect(sounders.name).to appear_before(sounders.created_at)
    # expect(sounders.created_at).to appear_before(rsl.name)
    # expect(rsl.name).to appear_before(rsl.created_at)
  end



end