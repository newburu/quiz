require 'slack'

Slack.configure do |config|
  config.token = ENV["SLACK_API_TOKEN"]  # BOTのトークンは公開できない為、環境変数で設定します。
end

namespace :slack_bot do
  desc 'ランダムに問題をSlackに書き込む'
  task :random_question => :environment do
    question = Question.random
    source = "出典：#{question.category1}年度 #{question.category2} 基本情報技術者試験 午前 問#{question.category3}"
    msg = "【問題】\n#{question.msg}\n\nア　#{question.answers[0].msg}\nイ　#{question.answers[1].msg}\nウ　#{question.answers[2].msg}\nエ　#{question.answers[3].msg}\n\n#{source}"

    # text:出力テキスト、channel:出力先のチャンネル名、username:表示ユーザ名
    ret = Slack.chat_postMessage(text: msg, channel: ENV["SLACK_CHANNEL_NAME"], username: ENV["SLACK_BOT_NAME"])

    History.create(question: question, slack_ts: ret['ts'], status: :do)
  end

  desc '解答をSlackに書き込む'
  task :answer => :environment do
    # 未解答の履歴一覧を取得
    History.where(status: :do).each do |history|
      question = history.question
      answers = question.answers.where(correct: true)

      # 解答テキスト
      # HACK:ちょっと無理やり感があるので、リファクタ候補
      answer_msg = []
      first_answer = question.answers.order(:id).first
      answers.each do |a|
        answer_msg << "#{%w(ア イ ウ エ)[a.id - first_answer.id]}"
      end
      msg = "【解答】" + answer_msg.join("、")

      # thread_ts:投稿先スレッドTS、text:出力テキスト、channel:出力先のチャンネル名、username:表示ユーザ名
      Slack.chat_postMessage(thread_ts: history.slack_ts, text: msg, channel: ENV["SLACK_CHANNEL_NAME"], username: ENV["SLACK_BOT_NAME"])

      # 解答済みに変更
      history.update(status: :done)
    end
  end
end
