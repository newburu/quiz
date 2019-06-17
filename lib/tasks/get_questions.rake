require "open-uri"
namespace :get_questions do
  desc "問題をスクレイピングして登録するタスク"

  task :import, [:url, :category1, :category2, :category3] => :environment do |task, args|
    now_date = Time.now.strftime("%Y%m%d")

    url = args.url
    category1 = args.category1
    category2 = args.category2
    category3 = args.category3
    p url
    p category1
    p category2
    p category3
    sleep(5)
    doc = Nokogiri::HTML(open(url))
    # 問題
    div_question = doc.xpath('//h3[@class="qno"]/following-sibling::div')[0]
    p "div_question=========="
    #p div_question
    p div_question.text
    next if div_question.text.blank?
    # 解答ア
    div_select_a = doc.xpath('//div[@id="select_a"]')
    p "div_select_a=========="
    #p div_select_a
    p div_select_a.text
    next if div_select_a.text.blank?
    # 解答イ
    div_select_i = doc.xpath('//div[@id="select_i"]')
    p "div_select_i=========="
    #p div_select_i
    p div_select_i.text
    next if div_select_i.text.blank?
    # 解答ウ
    div_select_u = doc.xpath('//div[@id="select_u"]')
    p "div_select_u=========="
    #p div_select_u
    p div_select_u.text
    next if div_select_u.text.blank?
    # 解答エ
    div_select_e = doc.xpath('//div[@id="select_e"]')
    p "div_select_e=========="
    #p div_select_e
    p div_select_e.text
    next if div_select_e.text.blank?
    # 答え
    span_answerChar = doc.xpath('//span[@id="answerChar"]')
    p "span_answerChar=========="
    #p span_answerChar
    p span_answerChar.text

    question = Question.new(category1: category1, category2: category2, category3: category3, msg: div_question.text)
    correct_a = (span_answerChar.text == 'ア')
    correct_i = (span_answerChar.text == 'イ')
    correct_u = (span_answerChar.text == 'ウ')
    correct_e = (span_answerChar.text == 'エ')
    answer_a = Answer.new(msg: div_select_a.text, correct: correct_a)
    answer_i = Answer.new(msg: div_select_i.text, correct: correct_i)
    answer_u = Answer.new(msg: div_select_u.text, correct: correct_u)
    answer_e = Answer.new(msg: div_select_e.text, correct: correct_e)

    question.answers << answer_a
    question.answers << answer_i
    question.answers << answer_u
    question.answers << answer_e

    question.save!

  end

end
