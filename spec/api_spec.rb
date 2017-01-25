require 'spec_helper'

describe Spinitron::Api do

  context 'when requesting the booty tunes jan 20, 2017 show' do
    it 'works without error' do
      allow(Spinitron::Api).to receive(:request) { File.read('spec/fixtures/wdrt_689_01202017.xml')}
      expect { Spinitron::Api.playlist('wdrt','689','Jan 20 2017') }.to_not raise_error
    end

    it 'response contains all the tracks for the specified date' do
      allow(Spinitron::Api).to receive(:request) { File.read('spec/fixtures/wdrt_689_01202017.xml')}
      response = Spinitron::Api.playlist('wdrt','689','Jan 20 2017')
      expect(response).not_to be_nil
      expect(response[0].title).to eq("Gorillaz: 'feel Good Inc'")
      expect(response[30].title).to eq("Subculture Sage: '1=1=1'")
      expect(response.count).to eq(31)
    end

  end
end
