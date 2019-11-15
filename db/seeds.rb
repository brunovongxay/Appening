# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#User.destroy_all
#Event.destroy_all
puts "Données existantes supprimées"

#require 'Faker'
#Faker::Config.locale = 'fr'

#Création des Users

10.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = first_name.gsub(' ', '_')+'.'+last_name.gsub(' ', '_')+'@yopmail.com'
  User.create(first_name: first_name, last_name: last_name, email: email, password: "12345678")
end

puts "users créés"

#Création des événements

20.times do
  Event.create(start_date: Time.now + 3600*rand(1..100), duration: rand(1..12)*5 , title: Faker::Book.title, price: rand(15..900), location: Faker::Address.city, admin: User.all.sample, description: Faker::Lorem.paragraph(sentence_count: 8) )
end

puts "Evenements créés"


#Liste des participants par session (entre 1 et 5)

Event.all.each do |my_event|

  rand(1..5).times do

    Participation.create(participant: User.all.sample, event: my_event)

  end

end
puts "Participations créés"
