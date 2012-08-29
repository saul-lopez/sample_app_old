FactoryGirl.define do
  factory :user do
    name    "Saul Lopez"
    email   "saul@mi.net"
    password "foobar"
    password_confirmation "foobar"
  end
end