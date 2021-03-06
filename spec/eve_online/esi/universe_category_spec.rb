# frozen_string_literal: true

require 'spec_helper'

describe EveOnline::ESI::UniverseCategory do
  let(:options) { { id: 6 } }

  subject { described_class.new(options) }

  specify { expect(subject).to be_a(EveOnline::ESI::Base) }

  specify { expect(described_class::API_PATH).to eq('/v1/universe/categories/%<category_id>s/?datasource=%<datasource>s') }

  describe '#initialize' do
    its(:token) { should eq(nil) }

    its(:parser) { should eq(JSON) }

    its(:_read_timeout) { should eq(60) }

    its(:_open_timeout) { should eq(60) }

    its(:datasource) { should eq('tranquility') }

    its(:id) { should eq(6) }
  end

  describe '#model' do
    context 'when @model set' do
      let(:model) { instance_double(EveOnline::ESI::Models::Category) }

      before { subject.instance_variable_set(:@model, model) }

      specify { expect(subject.model).to eq(model) }
    end

    context 'when @model not set' do
      let(:response) { double }

      before { expect(subject).to receive(:response).and_return(response) }

      let(:model) { instance_double(EveOnline::ESI::Models::Category) }

      before do
        #
        # EveOnline::ESI::Models::Category.new(response) # => model
        #
        expect(EveOnline::ESI::Models::Category).to receive(:new).with(response).and_return(model)
      end

      specify { expect { subject.model }.not_to raise_error }

      specify { expect { subject.model }.to change { subject.instance_variable_get(:@model) }.from(nil).to(model) }
    end
  end

  describe '#as_json' do
    let(:model) { instance_double(EveOnline::ESI::Models::Category) }

    before { subject.instance_variable_set(:@model, model) }

    before { expect(model).to receive(:as_json) }

    specify { expect { subject.as_json }.not_to raise_error }
  end

  describe '#category_id' do
    let(:model) { instance_double(EveOnline::ESI::Models::Category) }

    before { subject.instance_variable_set(:@model, model) }

    before { expect(model).to receive(:category_id) }

    specify { expect { subject.category_id }.not_to raise_error }
  end

  describe '#name' do
    let(:model) { instance_double(EveOnline::ESI::Models::Category) }

    before { subject.instance_variable_set(:@model, model) }

    before { expect(model).to receive(:name) }

    specify { expect { subject.name }.not_to raise_error }
  end

  describe '#published' do
    let(:model) { instance_double(EveOnline::ESI::Models::Category) }

    before { subject.instance_variable_set(:@model, model) }

    before { expect(model).to receive(:published) }

    specify { expect { subject.published }.not_to raise_error }
  end

  describe '#group_ids' do
    let(:model) { instance_double(EveOnline::ESI::Models::Category) }

    before { subject.instance_variable_set(:@model, model) }

    before { expect(model).to receive(:group_ids) }

    specify { expect { subject.group_ids }.not_to raise_error }
  end

  describe '#scope' do
    specify { expect(subject.scope).to eq(nil) }
  end

  describe '#url' do
    specify do
      expect(subject.url).to eq('https://esi.evetech.net/v1/universe/categories/6/?datasource=tranquility')
    end
  end
end
