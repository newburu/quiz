json.data do
  json.question @question, :category1, :category2, :category3, :msg
  json.answers do
    json.array! @question.answers, :msg, :correct
  end
end
