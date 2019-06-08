class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers, allow_destroy: true

  def self.random()
    Question.find( Question.pluck(:id).sample )
  end

end
