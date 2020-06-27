class Board < ApplicationRecord
  validates :title, {presence: true}
  validates :title, {length: {minimum: 3}}
  validates :title, {length: {maximum: 50}}
  validates :content, {presence: true}
  validates :content, {length: {minimum: 3}}
  validates :content, {length: {maximum: 140}}
end
