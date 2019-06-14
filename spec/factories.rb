FactoryBot.define do
  factory :candidate do
    first_name { "MyString" }
    last_name { "MyString" }
    middle_name { "MyString" }
    nick_name { "MyString" }
    party { "MyString" }
    status { "MyString" }
    district { nil }
    election { "2019-06-06" }
  end

  factory :incumbent do
    first_name { "MyString" }
    last_name { "MyString" }
    middle_name { "MyString" }
    nick_name { "MyString" }
    party { "MyString" }
    elected { "2019-06-06" }
    current_term { 1 }
    district { nil }
  end

  factory :district do
    name { "MyString" }
    number { 1 }
    district_type { "MyString" }
  end

end
