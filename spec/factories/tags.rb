FactoryBot.define do
  factory :tag do
    name { "#{Faker::Adjective.positive.capitalize} #{Faker::Book.unique.genre}" }
  end
end
