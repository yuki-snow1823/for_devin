class Response < ApplicationRecord
  belongs_to :player
  belongs_to :question
  validates :answer_text, presence: true
end
