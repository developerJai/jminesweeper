class Board < ApplicationRecord
  belongs_to :user
  validates_presence_of :name, :width, :height, :mines
  accepts_nested_attributes_for :user
end
