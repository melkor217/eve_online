# frozen_string_literal: true

require 'spec_helper'

describe EveOnline::ESI::Alliance do
  let(:options) { { alliance_id: 99_005_443 } }

  subject { described_class.new(options) }

  specify { expect(subject).to be_a(EveOnline::ESI::Base) }

  specify { expect(described_class::API_PATH).to eq('/v3/alliances/%<alliance_id>s/?datasource=%<datasource>s') }

  describe '#initialize' do
    its(:token) { should eq(nil) }

    its(:parser) { should eq(JSON) }

    its(:_read_timeout) { should eq(60) }

    its(:_open_timeout) { should eq(60) }

    its(:datasource) { should eq('tranquility') }

    its(:alliance_id) { should eq(99_005_443) }
  end

  describe '#model' do
    context 'when @model set' do
      let(:model) { instance_double(EveOnline::ESI::Models::Alliance) }

      before { subject.instance_variable_set(:@model, model) }

      specify { expect(subject.model).to eq(model) }
    end

    context 'when @model not set' do
      let(:response) { double }

      before { expect(subject).to receive(:response).and_return(response) }

      let(:model) { instance_double(EveOnline::ESI::Models::Alliance) }

      before do
        #
        # EveOnline::ESI::Models::Alliance.new(response) # => model
        #
        expect(EveOnline::ESI::Models::Alliance).to receive(:new).with(response).and_return(model)
      end

      specify { expect { subject.model }.not_to raise_error }

      specify { expect { subject.model }.to change { subject.instance_variable_get(:@model) }.from(nil).to(model) }
    end
  end

  describe '#as_json' do
    let(:model) { instance_double(EveOnline::ESI::Models::Alliance) }

    before { subject.instance_variable_set(:@model, model) }

    before { expect(model).to receive(:as_json) }

    specify { expect { subject.as_json }.not_to raise_error }
  end

  describe '#creator_corporation_id' do
    let(:model) { instance_double(EveOnline::ESI::Models::Alliance) }

    before { subject.instance_variable_set(:@model, model) }

    before { expect(model).to receive(:creator_corporation_id) }

    specify { expect { subject.creator_corporation_id }.not_to raise_error }
  end

  describe '#creator_id' do
    let(:model) { instance_double(EveOnline::ESI::Models::Alliance) }

    before { subject.instance_variable_set(:@model, model) }

    before { expect(model).to receive(:creator_id) }

    specify { expect { subject.creator_id }.not_to raise_error }
  end

  describe '#date_founded' do
    let(:model) { instance_double(EveOnline::ESI::Models::Alliance) }

    before { subject.instance_variable_set(:@model, model) }

    before { expect(model).to receive(:date_founded) }

    specify { expect { subject.date_founded }.not_to raise_error }
  end

  describe '#executor_corporation_id' do
    let(:model) { instance_double(EveOnline::ESI::Models::Alliance) }

    before { subject.instance_variable_set(:@model, model) }

    before { expect(model).to receive(:executor_corporation_id) }

    specify { expect { subject.executor_corporation_id }.not_to raise_error }
  end

  describe '#faction_id' do
    let(:model) { instance_double(EveOnline::ESI::Models::Alliance) }

    before { subject.instance_variable_set(:@model, model) }

    before { expect(model).to receive(:faction_id) }

    specify { expect { subject.faction_id }.not_to raise_error }
  end

  describe '#name' do
    let(:model) { instance_double(EveOnline::ESI::Models::Alliance) }

    before { subject.instance_variable_set(:@model, model) }

    before { expect(model).to receive(:name) }

    specify { expect { subject.name }.not_to raise_error }
  end

  describe '#ticker' do
    let(:model) { instance_double(EveOnline::ESI::Models::Alliance) }

    before { subject.instance_variable_set(:@model, model) }

    before { expect(model).to receive(:ticker) }

    specify { expect { subject.ticker }.not_to raise_error }
  end

  describe '#scope' do
    specify { expect(subject.scope).to eq(nil) }
  end

  describe '#url' do
    specify do
      expect(subject.url).to eq('https://esi.evetech.net/v3/alliances/99005443/?datasource=tranquility')
    end
  end
end
