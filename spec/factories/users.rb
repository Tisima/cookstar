FactoryBot.define do
  factory :user do
    email                           {Faker::Internet.free_email}
    password                        {'abc1234'}
    password_confirmation           {'abc1234'}
    name                        {Faker::Name.initials(number: 2)}
  end
end
