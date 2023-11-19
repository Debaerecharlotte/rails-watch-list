class Review < ApplicationRecord
  belongs_to :list
  validates :title, presence: true
  validates :content, presence: true
  validates :rating, inclusion: { in: (1..5) }
end
