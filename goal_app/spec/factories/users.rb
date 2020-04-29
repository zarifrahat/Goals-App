FactoryBot.define do
  factory :user do
    username { Faker::Movies::HarryPotter.character }
    password { 'firebolt' }
    session_token { 'firebolt' }
    
    # first :location refers to assocation, second :location refers to location factory
  end
end