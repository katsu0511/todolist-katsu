class Task < ApplicationRecord
  validates :title, {presence: true, length: {minimum: 3}}
  validates :title, {length: {maximum: 50}}
  validates :content, {presence: true, length: {minimum: 10}}
  validates :content, {length: {maximum: 400}}
  validates :expiration, presence: true

  belongs_to :user
  belongs_to :board
end
