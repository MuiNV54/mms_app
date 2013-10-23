namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Example User",
                 age: 23,
                 email: "example@railstutorial.org",
                 password: "foobar",
                 password_confirmation: "foobar"   )
    99.times do |n|
      name  = Faker::Name.name
      age = 23
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   age: age,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

    users = User.all(limit: 6)
    50.times do
      name = Faker::Lorem.sentence(5)
      users.each { |user| user.teams.create!(name: name) }
    end

    teams = Team.all(limit: 10)
    teams.each { |team| 
                20.times do
                user = User.first(:offset => rand(User.count))
                Relationship.create!(team_id: team.id, user_id:  user.id) if Relationship.find_by(team_id: team.id, user_id:  user.id).nil?
            end
    }
  end
end