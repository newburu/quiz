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
    Slack.chat_postMessage(text: msg, channel: ENV["SLACK_CHANNEL_NAME"], username: ENV["SLACK_BOT_NAME"])
  end
end
