require "json"
require "net/http"

class Slack
  def initialize(score, error_count)
    @score       = score
    @error_count = error_count
    @uri         = URI.parse(ENV["SLACK_URL"])
  end

  def success_message
    request build_data(true)
  end

  def fail_message
    request build_data(false)
  end

  private

  def build_data(is_success)
    {
      attachments: [
        {
          color: is_success ? "good" : "danger",
          fields: [
            { title: "Score", value: @score, short: true },
            { title: "Errors", value: @error_count, short: true },
            { title: "Build", value: "<#{ENV["CIRCLE_BUILD_URL"]}|##{ENV["CIRCLE_BUILD_NUM"]}>", short: true },
            { title: "Status", value: is_success ? ":o: Success" : ":x: Failed", short: true }
          ],
          footer: "<#{ENV["CIRCLE_PULL_REQUEST"]}|#{ENV["CIRCLE_BRANCH"]}> | <!date^#{Time.now.to_i}^{date_short_pretty}|date>"
        }
      ]
    }
  end

  def request(data)
    Net::HTTP.start(@uri.host, @uri.port, { use_ssl: true }) do |connection|
      connection.finish if connection.started?
      connection.post(@uri.to_s, "payload=#{data.to_json}", {})
    end
  end
end

class Result
  def self.check_and_notify
    new.check_and_notify
  end

  def check_and_notify
    slack = Slack.new(score, error_count)
    success? ? slack.success_message : slack.fail_message
  end

  private

  def json_data
    @json_data ||= JSON.load(File.read("#{ENV["HOME"]}/log/result.json"))
  end

  def success?
    json_data["message"] == "ok"
  end

  def score
    json_data["score"]
  end

  def error_count
    json_data["error"].count
  end
end

Result.check_and_notify
