# == Schema Information
#
# Table name: users
#
#  id            :bigint           not null, primary key
#  role          :integer
#  user_name     :string
#  user_password :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
