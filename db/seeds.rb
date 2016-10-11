# 6 Users
puts "Creating Users..."

User.create!(username: "platform_admin",
             password: "password",
             email: "jorge@turing.io",
             name: "Jorge Tellez",
             address: Faker::Address.street_address,
             city: Faker::Address.city,
             state: Faker::Address.state_abbr,
             zip: Faker::Address.zip,
             platform_admin: true)

User.create!(username: "jmejia",
             password: "password",
             email: "jmejia@turing.io",
             name: "Josh Mejia",
             address: Faker::Address.street_address,
             city: Faker::Address.city,
             state: Faker::Address.state_abbr,
             zip: Faker::Address.zip)

User.create!(username: "user",
             password: "password",
             email: "bsayler@example.com",
             name: "Brian Sayler",
             address: "1510 Blake St",
             city: "Denver",
             state: "CO",
             zip: "80111")

User.create!(username: "jcasimir",
             password: "password",
             email: "jcasimir@example.com",
             name: "Jeff Casimir",
             address: "1510 Blake St",
             city: "Denver",
             state: "CO",
             zip: "80111")

User.create!(username: "mdao",
             password: "password",
             email: "mdao@example.com",
             name: "Mike Dao",
             address: "1510 Denver St",
             city: "Blake",
             state: "CO",
             zip: "80111")

business_admin = User.create!(username: "business_admin",
                              password: "password",
                              email: "nate@turing.io",
                              name: "Nate Allen",
                              address: Faker::Address.street_address,
                              city: Faker::Address.city,
                              state: Faker::Address.state_abbr,
                              zip: Faker::Address.zip)

94.times do
  User.create!(username: Faker::Internet.email,
               password: "password",
               email: Faker::Internet.email,
               name: Faker::Name.name,
               address: Faker::Address.street_address,
               city: Faker::Address.city,
               state: Faker::Address.state_abbr,
               zip: Faker::Address.zip)
end

puts "Created Users"

puts "Creating Businesses..."
20.times do |x|
  business = Business.create!(name: Faker::Company.name,
                  description: Faker::Company.catch_phrase,
                  active: (x <= 15)
                  )
  business_admin.businesses << business
end
puts "Created Businesses"

puts "Creating Items & Categories..."

date = DateTime.now

end_date_1 = date.next_month(6)
end_date_2 = date.next_month(3)
end_date_3 = date.next_day(7)

num_item_1 = 3
num_item_2 = 3
num_item_3 = 3

storage = Category.create!(name: "storage", image_path: "https://static.pexels.com/photos/15798/night-computer-hdd-hard-drive.jpg")
item_1 = storage.items.create!(name: "Laser Disc", description: "Make great plates.", price: "5.99", image: "https://visualhunt.com/photos/m/5/laser-and-video-discs-24.jpg", end_time: end_date_1, status: 0, business_id: 1)
item_2 = storage.items.create!(name: "Floppy Disc", description: "Need to store a whopping 1.44 MB of data? This bad boy has got you covered.", price: "5.99", image: "https://visualhunt.com/photos/m/5/day-037-did-floppy-exist-once.jpg", end_time: end_date_1, status: 0, business_id: 1)
item_3 = storage.items.create!(name: "CD", description: "Like ninja stars but better.", price: "2.99", image: "https://visualhunt.com/photos/m/4/cd-dvd-computer-data-shiny-digital-disk.jpg", end_time: end_date_2, status: 0, business_id: 1)

num_item_1.times do
  storage.items.create!(name: Faker::Hacker.noun.capitalize,
                        description: Faker::Lorem.sentence,
                        price: Faker::Commerce.price,
                        image: "https://visualhunt.com/photos/m/4/cd-dvd-computer-data-shiny-digital-disk.jpg",
                        end_time: end_date_1,
                        business_id: rand(1..14))
end

num_item_2.times do
  storage.items.create!(name: Faker::Hacker.noun.capitalize,
                        description: Faker::Lorem.sentence,
                        price: Faker::Commerce.price,
                        image: "https://visualhunt.com/photos/m/4/cd-dvd-computer-data-shiny-digital-disk.jpg",
                        end_time: end_date_2,
                        business_id: rand(1..14))
end

num_item_3.times do
  storage.items.create!(name: Faker::Hacker.noun.capitalize,
                        description: Faker::Lorem.sentence,
                        price: Faker::Commerce.price,
                        image: "https://visualhunt.com/photos/m/4/cd-dvd-computer-data-shiny-digital-disk.jpg",
                        end_time: end_date_3,
                        business_id: rand(1..14))
end

electronics = Category.create!(name: "electronics", image_path: "https://static.pexels.com/photos/9295/vintage-music-business-shop.jpg")
item_4 = electronics.items.create!(name: "Walkman", description: "Enjoy some tunes on your walkman.", price: "22.99", image: "https://visualhunt.com/photos/m/5/sony-sports-walkman-wm-f5-okinawa.jpg", end_time: end_date_1, status: 0, business_id: rand(1..14))
item_5 = electronics.items.create!(name: "VCR", description: "Now go find some VCR tapes!", price: "100.99", image: "https://visualhunt.com/photos/m/5/vcr.jpg", end_time: end_date_1, status: 0, business_id: rand(1..14))
item_6 = electronics.items.create!(name: "Discman", description: "Listen to all your favorite hits.", price: "10.99", image: "https://c4.staticflickr.com/3/2318/2051407819_794a95d465_b.jpg", end_time: end_date_1, status: 0, business_id: rand(1..14))

num_item_1.times do
  electronics.items.create!(name: Faker::Hacker.ingverb.capitalize,
                            description: Faker::Hacker.say_something_smart,
                            price: Faker::Commerce.price,
                            image: "https://visualhunt.com/photos/m/4/cd-dvd-computer-data-shiny-digital-disk.jpg",
                            end_time: end_date_1,
                            business_id: rand(1..14))
end

num_item_2.times do
  electronics.items.create!(name: Faker::Hacker.ingverb.capitalize,
                            description: Faker::Hacker.say_something_smart,
                            price: Faker::Commerce.price,
                            image: "https://visualhunt.com/photos/m/4/cd-dvd-computer-data-shiny-digital-disk.jpg",
                            end_time: end_date_2,
                            business_id: rand(1..14))
end

num_item_3.times do
  electronics.items.create!(name: Faker::Hacker.ingverb.capitalize,
                            description: Faker::Hacker.say_something_smart,
                            price: Faker::Commerce.price,
                            image: "https://visualhunt.com/photos/m/4/cd-dvd-computer-data-shiny-digital-disk.jpg",
                            end_time: end_date_3,
                            business_id: rand(1..14))
end

game_systems = Category.create!(name: "gaming", image_path: "http://i.imgur.com/sJmuXl7.jpg")
item_7 = game_systems.items.create!(name: "Gameboy", description: "Remember discovering Tetris? Discover it again on this Gameboy.", price: "99.99", image: "https://c4.staticflickr.com/8/7481/16037341171_3db0f52a8d_k.jpg", end_time: end_date_1, status: 0, business_id: rand(1..14))
item_8 = game_systems.items.create!(name: "Atari", description: "Take it back to the 80's and play some Atari on this mint condition system.", price: "800.99", image: "https://c5.staticflickr.com/8/7678/17513196036_a6b2e4889f_k.jpg", end_time: end_date_1, status: 0, business_id: rand(1..14))
item_9 = game_systems.items.create!(name: "Nintendo", description: "Play some games on the original NES.", price: "1999.88", image: "https://visualhunt.com/photos/m/5/nintendo-nes.jpg", end_time: end_date_1, status: 0, business_id: rand(1..14))

num_item_1.times do
  game_systems.items.create!(name: Faker::Hacker.verb.capitalize,
                             description: Faker::StarWars.quote,
                             price: Faker::Commerce.price,
                             image: "https://visualhunt.com/photos/m/4/cd-dvd-computer-data-shiny-digital-disk.jpg",
                             end_time: end_date_1,
                             business_id: rand(1..14))
end

num_item_2.times do
  game_systems.items.create!(name: Faker::Hacker.verb.capitalize,
                             description: Faker::StarWars.quote,
                             price: Faker::Commerce.price,
                             image: "https://visualhunt.com/photos/m/4/cd-dvd-computer-data-shiny-digital-disk.jpg",
                             end_time: end_date_2,
                             business_id: rand(1..14))
end

num_item_3.times do
  game_systems.items.create!(name: Faker::Hacker.verb.capitalize,
                             description: Faker::StarWars.quote,
                             price: Faker::Commerce.price,
                             image: "https://visualhunt.com/photos/m/4/cd-dvd-computer-data-shiny-digital-disk.jpg",
                             end_time: end_date_3,
                             business_id: rand(1..14))
end

# 7 more categories
Category.create!(name: "movies", image_path: "http://finda.photo/image/4637/thumbnail/original")
Category.create!(name: "books", image_path: "http://434985940.r.cdnsun.net/skuawk/photo/objects/fornalczyk-40.jpg")
Category.create!(name: "antiques", image_path: "http://434985940.r.cdnsun.net/skuawk/photo/objects/krivec-22.jpg")
Category.create!(name: "digital", image_path: "http://434985940.r.cdnsun.net/skuawk/photo/technology/braun.jpg")
Category.create!(name: "analog", image_path: "http://434985940.r.cdnsun.net/skuawk/photo/technology/krzysztof-1.jpg")
Category.create!(name: "cars", image_path: "https://c2.staticflickr.com/2/1590/25991857260_1078ecf2fb_o.jpg")
Category.create!(name: "music", image_path: "http://434985940.r.cdnsun.net/skuawk/photo/technology/krzysztof-2.jpg")

(4..Category.count).step do |x|
  num_item_1.times do
    Category.find(x).items.create!(name: Faker::App.name.capitalize,
                                   description: Faker::Hipster.sentence,
                                   price: Faker::Commerce.price,
                                   image: "https://visualhunt.com/photos/m/4/cd-dvd-computer-data-shiny-digital-disk.jpg",
                                   end_time: end_date_1,
                                   business_id: rand(1..14))
  end
  num_item_2.times do
    Category.find(x).items.create!(name: Faker::App.name.capitalize,
                                   description: Faker::Hipster.sentence,
                                   price: Faker::Commerce.price,
                                   image: "https://visualhunt.com/photos/m/4/cd-dvd-computer-data-shiny-digital-disk.jpg",
                                   end_time: end_date_2,
                                   business_id: rand(1..14))
  end
  num_item_3.times do
    Category.find(x).items.create!(name: Faker::App.name.capitalize,
                                   description: Faker::Hipster.sentence,
                                   price: Faker::Commerce.price,
                                   image: "https://visualhunt.com/photos/m/4/cd-dvd-computer-data-shiny-digital-disk.jpg",
                                   end_time: end_date_3,
                                   business_id: rand(1..14))
  end
end
puts "Created Items & Categories"
