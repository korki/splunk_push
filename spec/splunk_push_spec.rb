require 'spec_helper'

describe SplunkPush do
  let(:payload) do
    {
      index: 'test_index',
      source: 'gem_test',
      event: { hello: 'world' }
    }
  end

  describe 'building payload' do
    it 'builds proper payload with only event given' do
      result = SplunkPush.payload({ hello: 'world' })
      expect(result[:time]).not_to be_nil
      expect(result[:event][:hello]).to eq 'world'
    end
  end

  describe 'without ENVs' do
    it 'doesnt do anything without proper ENVs' do
      result = SplunkPush.push(payload)
      expect(result).to be_nil
    end
  end

  describe 'with proper ENVs' do
    before do
      ENV['SPLUNK_TOKEN'] = 'xxxxxx'
      ENV['SPLUNK_COLLECTOR_URL'] = 'https://splunk.io/collector/event'
    end
    it 'reads token and url properly' do
      expect(SplunkPush.token).to eq 'xxxxxx'
      expect(SplunkPush.collector_url).to eq 'https://splunk.io/collector/event'
    end

    it 'sends proper data to splunk' do
      VCR.use_cassette("push data") do
        result = SplunkPush.push(payload)
        expect(result['code']).to eq 0
        expect(result['text']).to eq 'Success'
      end
    end
  end
end
