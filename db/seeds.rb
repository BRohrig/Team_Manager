# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Player.delete_all
Team.delete_all


@sounders = Team.create!(name: "Sounders FC", city: "Seattle", owner: "Adrian Hanauer", title_holder: false, titles_won: 2)
@raul = @sounders.players.create!(name: "Raul Ruidiaz", salary: 3000000, citizen: false, trade_eligible: false, contract_length_months: 39)
@roldan = @sounders.players.create!(name: "Cristian Roldan", salary: 24500, citizen: true, trade_eligible: true, contract_length_months: 27)
@lodeiro = @sounders.players.create!(name: "Nicolas Lodeiro", salary: 240500, citizen: false, trade_eligible: true, contract_length_months: 21)

@rsl = Team.create!(name: "Real Salt Lake", city: "Salt Lake City", owner: "some guy", title_holder: false, titles_won: 1)
@jimmy = @rsl.players.create!(name: "Jimmy Jim", salary: 20, citizen: true, trade_eligible: true, contract_length_months: 14)
@bob = @rsl.players.create!(name: "bobby bob", salary: 42, citizen: false, trade_eligible: false, contract_length_months: 4)