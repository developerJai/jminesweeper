class User < ApplicationRecord
  has_many :boards, dependent: :destroy
  validates :email, uniqueness: true, presence: true
end
