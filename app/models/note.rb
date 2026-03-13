# == Schema Information
#
# Table name: notes
#
#  id          :bigint           not null, primary key
#  body        :text
#  market_date :date
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#
class Note < ApplicationRecord
  belongs_to :user, counter_cache: true

  has_many :note_insights, dependent: :destroy
  has_many :insights, through: :note_insights
end
