require 'rails_helper'

RSpec.describe 'the players pages' do
  before :each do
    @sounders = Team.create!(name: "Sounders FC", city: "Seattle", owner: "Adrian Hanauer", title_holder: false, titles_won: 2)
    @raul = @sounders.players.create!(name: "Raul Ruidiaz", salary: 3000000, citizen: false, trade_eligible: false, contract_length_months: 39)
    @roldan = @sounders.players.create!(name: "Cristian Roldan", salary: 24500, citizen: true, trade_eligible: true, contract_length_months: 27)
  end

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

  it 'has a link to the player index' do
    visit "/players"
    expect(page).to have_link 'Player Index', href: "/players"

    visit "/players/#{@raul.id}"
    expect(page).to have_link 'Player Index', href: "/players"
  end

  it 'has a link to the team index' do
    visit "/players"
    expect(page).to have_link 'Team Index', href: "/teams"

    visit "/players/#{@raul.id}"
    expect(page).to have_link 'Team Index', href: "/teams"
  end
end