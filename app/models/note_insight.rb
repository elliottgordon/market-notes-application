# == Schema Information
#
# Table name: note_insights
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  insight_id :integer
#  note_id    :integer
#
class NoteInsight < ApplicationRecord
  belongs_to(:note)
  belongs_to(:insight)
end
