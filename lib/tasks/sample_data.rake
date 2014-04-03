namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Ruby Doo",
                 email: "rubydoo@dogs.com",
                 password: "foobar",
                 password_confirmation: "foobar",
                 admin: true)
    99.times do |n|
      name  = Faker::Name.name
      email = Faker::Internet.email
      password  = "foobar"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  

  users = User.all(limit: 6)
    50.times do
  title = Faker::Lorem.sentence
  url = Faker::Internet.url
  users.each {|user| user.stories.create!(title: title, url:url)}
  end  
end


end