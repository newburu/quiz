class History < ApplicationRecord
  belongs_to :question

  enum status: {do: 0, done: 1}
end
