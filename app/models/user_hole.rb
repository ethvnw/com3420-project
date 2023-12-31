# == Schema Information
#
# Table name: user_holes
#
#  id          :bigint           not null, primary key
#  hole_number :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  hole_id     :bigint
#  user_id     :bigint
#
# Indexes
#
#  index_user_holes_on_hole_id  (hole_id)
#  index_user_holes_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (hole_id => holes.id)
#  fk_rails_...  (user_id => users.id)
#
class UserHole < ApplicationRecord
    belongs_to :user
    belongs_to :hole
    has_many :datum, dependent: :destroy 
end
