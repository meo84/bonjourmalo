FactoryBot.define do
  factory :article do
    uuid { Faker::Internet.uuid }
    visibility { 'public' }
  end
end
