class Restaurant < ApplicationRecord
    belongs_to :user
    has_many :reviews, dependent: :destroy
    validates :name, length: { minimum: 3 }, uniqueness: true
    validates :user_id, length: { minimum: 1 }, allow_nil: true
end
