json.extract! answer, :id, :question_id, :msg, :correct, :created_at, :updated_at
json.url answer_url(answer, format: :json)
