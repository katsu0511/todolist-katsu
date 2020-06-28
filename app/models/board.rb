class Board < ApplicationRecord
  validates :title, {presence: true, length: {minimum: 3}}
  validates :title, {length: {maximum: 50}}
  validates :content, {presence: true, length: {minimum: 3}}
  validates :content, {length: {maximum: 140}}

  belongs_to :user

  def author_name
    user.display_name
  end
end
