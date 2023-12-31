# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  user_role              :integer          default("user")
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
FactoryBot.define do
  factory :user do
    email { "1@gmail.com" }
    encrypted_password { "123456" }
    user_role { "user" }
    
  end

  factory :map_creator, class: User do
    email { "mapcr@gmail.com" }
    encrypted_password { "123456" }
    user_role { "map_creator" }
  end

  factory :admin, class: User do
    email { "admin@gmail.com" }
    encrypted_password { "123456" }
    user_role { "admin" }
  end
end
