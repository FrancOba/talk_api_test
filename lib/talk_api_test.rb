require "talk_api_test/version"
require "faraday"
require "json"
require "dotenv"

# 環境変数読み込み
Dotenv.load

module TalkApiTest
  def self.talk(word)
    res = Faraday.post ENV['API_URL'], {
      apikey: ENV['API_KEY'], # 必須
      query: word #任意
      # callback: 'application/javascript', # 必須 未指定時はapplication/json
    }
    if res.success?
      result = JSON.parse(res.body)
      response = check(result)
    else
      response = "レスポンス200以外"
    end
    return response
  end

  private
  def self.check(result)
    if result['message'] === "ok"
      return result['results'][0]['reply']
    else
      return "レスポンス200以外2"
    end
  end
end
