# frozen_string_literal: true

require 'spec_helper'

describe EveOnline::ESI::CharacterStandings do
  let(:options) { { token: 'token123', character_id: 12_345_678 } }

  subject { described_class.new(options) }

  specify { expect(subject).to be_a(EveOnline::ESI::Base) }

  specify { expect(described_class::API_PATH).to eq('/v1/characters/%<character_id>s/standings/?datasource=%<datasource>s') }

  describe '#initialize' do
    its(:token) { should eq('token123') }

    its(:parser) { should eq(JSON) }

    its(:_read_timeout) { should eq(60) }

    its(:_open_timeout) { should eq(60) }

    its(:datasource) { should eq('tranquility') }

    its(:character_id) { should eq(12_345_678) }
  end

  describe '#standings' do
    context 'when @standings set' do
      let(:standings) { [instance_double(EveOnline::ESI::Models::Standing)] }

      before { subject.instance_variable_set(:@standings, standings) }

      specify { expect(subject.standings).to eq(standings) }
    end

    context 'when @ancestries not set' do
      let(:standing) { instance_double(EveOnline::ESI::Models::Standing) }

      let(:response) do
        [
          {
            'from_id' => 500_001,
            'from_type' => 'faction',
            'standing' => 0.3303719111639991
          }
        ]
      end

      before do
        #
        # subject.response # => [{"from_id"=>500001, "from_type"=>"faction", "standing"=>0.3303719111639991}]
        #
        expect(subject).to receive(:response).and_return(response)
      end

      before do
        #
        # EveOnline::ESI::Models::Standing.new(response.first) # => standing
        #
        expect(EveOnline::ESI::Models::Standing).to receive(:new).with(response.first).and_return(standing)
      end

      specify { expect(subject.standings).to eq([standing]) }

      specify { expect { subject.standings }.to change { subject.instance_variable_get(:@standings) }.from(nil).to([standing]) }
    end
  end

  describe '#scope' do
    specify { expect(subject.scope).to eq('esi-characters.read_standings.v1') }
  end

  describe '#url' do
    specify do
      expect(subject.url).to eq('https://esi.evetech.net/v1/characters/12345678/standings/?datasource=tranquility')
    end
  end
end
