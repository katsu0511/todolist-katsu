class Task < ApplicationRecord
  validates :expiration, presence: true

  belongs_to :user
  belongs_to :board
end
