require 'httparty'

module SplunkPush
  class << self
    def token
      ENV['SPLUNK_TOKEN']
    end

    def collector_url
      ENV['SPLUNK_COLLECTOR_URL']
    end

    def push(payload)
      return if token.to_s.empty? || collector_url.to_s.empty?
      response = HTTParty.post(collector_url, {
         body: payload.to_json,
         headers: {
           'Content-Type'  => 'application/json',
           'Authorization' => "Splunk #{token}"
         }
      })

      validate(response)
      JSON.parse(response.body)
    end

    def validate(res)
      raise SplunkPushError, "Push failed. Splunk returned code #{res.code} and message #{res.body}" if res.code != 200
    end

    def payload(event, time = nil, index = nil, host = nil, source = nil, sourcetype = nil)
      time ||= Time.now.utc.to_i
      payload = {
        time: time,
        event: event
      }
      payload[:index]      = index unless index.nil?
      payload[:host]       = host unless host.nil?
      payload[:source]     = source unless source.nil?
      payload[:sourcetype] = sourcetype unless sourcetype.nil?
      payload
    end
  end
end

class SplunkPushError < StandardError; end
