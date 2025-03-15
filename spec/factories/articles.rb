FactoryBot.define do
  factory :article do
    uuid { Faker::Internet.uuid }
  end
end
