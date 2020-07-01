class Comment < ApplicationRecord
  validates :content, {presence: true, length: {maximum: 140}}

  belong_to :user
  belong_to :task
end
