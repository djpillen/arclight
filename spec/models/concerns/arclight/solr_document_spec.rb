# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Arclight::SolrDocument do
  let(:document) { SolrDocument.new }

  describe 'custom accessors' do
    it { expect(document).to respond_to(:parent_ids) }
    it { expect(document).to respond_to(:parent_labels) }
    it { expect(document).to respond_to(:eadid) }
  end

  describe '#repository_config' do
    let(:document) { SolrDocument.new(repository_ssm: 'My Repository') }

    it 'is an instance of Arclight::Repository' do
      expect(document.repository_config).to be_a Arclight::Repository
    end

    it 'finds the correct repository' do
      expect(document.repository_config.name).to eq document.repository
    end
  end

  describe '#repository_and_unitid' do
    let(:document) do
      SolrDocument.new(repository_ssm: 'Repository Name', unitid_ssm: 'MS 123')
    end

    it 'joins the repository and unitid with a colon' do
      expect(document.repository_and_unitid).to eq 'Repository Name: MS 123'
    end

    context 'when the document does not have a unitid' do
      let(:document) { SolrDocument.new(repository_ssm: 'Repository Name') }

      it 'just returns the "Repository Name"' do
        expect(document.repository_and_unitid).to eq 'Repository Name'
      end
    end
  end

  describe '#digital_objects' do
    context 'when the document has a digital object' do
      let(:document) do
        SolrDocument.new(
          digital_objects_ssm: [
            { href: 'http://example.com', label: 'Label 1' }.to_json,
            { href: 'http://another-example.com', label: 'Label 2' }.to_json
          ]
        )
      end

      it 'is array of DigitalObjects' do
        expect(document.digital_objects.length).to eq 2
        document.digital_objects.all? do |object|
          expect(object).to be_a Arclight::DigitalObject
        end
      end
    end

    context 'when the document does not have a digital object' do
      let(:document) { SolrDocument.new }

      it 'is a blank array' do
        expect(document.digital_objects).to be_blank
      end
    end
  end

  describe '#normalize_title' do
    let(:document) { SolrDocument.new(normalized_title_ssm: 'My Title, 1990-2000') }

    it 'uses the normalized title from index-time' do
      expect(document.normalized_title).to eq 'My Title, 1990-2000'
    end
  end

  describe '#normalize_date' do
    let(:document) { SolrDocument.new(normalized_date_ssm: '1990-2000') }

    it 'uses the normalized date from index-time' do
      expect(document.normalized_date).to eq '1990-2000'
    end
  end
end
