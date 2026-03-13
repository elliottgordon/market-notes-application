# == Schema Information
#
# Table name: insights
#
#  id         :bigint           not null, primary key
#  body       :text
#  category   :string
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
class Insight < ApplicationRecord
  belongs_to :user, counter_cache: true

  has_many :note_insights, dependent: :destroy
  has_many :notes, through: :note_insights
end
