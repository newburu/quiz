json.extract! question, :id, :category1, :category2, :category3, :msg, :created_at, :updated_at
json.url question_url(question, format: :json)
