# == Schema Information
#
# Table name: data
#
#  id            :bigint           not null, primary key
#  terrain_type  :integer
#  x_coordinates :string
#  y_coordinates :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  hole_id       :integer
#  user_hole_id  :integer
#
require 'rails_helper'

RSpec.describe Datum, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
