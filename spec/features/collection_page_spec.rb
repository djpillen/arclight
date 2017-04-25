# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Collection Page', type: :feature do
  before do
    visit solr_document_path(id: 'aoa271')
  end

  describe 'arclight document header' do
    it 'includes a div with the repository and collection ID' do
      within('.al-document-title-bar') do
        expect(page).to have_content '1118 Badger Vine Special Collections'
        expect(page).to have_content 'Collection ID: MS C 271'
      end
    end
  end

  describe 'custom metadata sections' do
    it 'summary has configured metadata' do
      within '#summary' do
        expect(page).to have_css('dt', text: 'Creator')
        expect(page).to have_css('dd', text: 'Alpha Omega Alpha')
        expect(page).to have_css('dt', text: 'Abstract')
        expect(page).to have_css('dd', text: /was founded in 1902/)
        expect(page).to have_css('dt', text: 'Extent')
        expect(page).to have_css('dd', text: /15.0 linear feet/)
        expect(page).to have_css('dt', text: 'Preferred citation')
        expect(page).to have_css('dd', text: /Medicine, Bethesda, MD/)
      end
    end
    it 'access and use has configured metadata' do
      within '#access-and-use' do
        expect(page).to have_css('dt', text: 'Conditions Governing Access')
        expect(page).to have_css('dd', text: 'No restrictions on access.')
        expect(page).to have_css('dt', text: 'Terms Of Use')
        expect(page).to have_css('dd', text: /Copyright was transferred/)
      end
    end

    it 'background has configured metadata' do
      within '#background' do
        expect(page).to have_css('dt', text: 'Biographical / Historical')
        expect(page).to have_css('dd', text: /^Alpha Omega Alpha Honor Medical Society was founded/)
      end
    end

    it 'scope and arrangement has configured metadata' do
      within '#scope-and-arrangement' do
        expect(page).to have_css('dt', text: 'Scope and Content')
        expect(page).to have_css('dd', text: /^Correspondence, documents, records, photos/)

        expect(page).to have_css('dt', text: 'Arrangement')
        expect(page).to have_css('dd', text: /^Arranged into seven series\./)
      end
    end

    it 'related has configured metadata' do
      within '#related' do
        expect(page).to have_css('dt', text: 'Related material')
        expect(page).to have_css('dd', text: /^An unprocessed collection includes/)

        expect(page).to have_css('dt', text: 'Separated material')
        expect(page).to have_css('dd', text: /^Birth, Apollonius of Perga brain/)

        expect(page).to have_css('dt', text: 'Other finding aids')
        expect(page).to have_css('dd', text: /^Li Europan lingues es membres del/)

        expect(page).to have_css('dt', text: 'Alternative form available')
        expect(page).to have_css('dd', text: /^Rig Veda a mote of dust suspended/)

        expect(page).to have_css('dt', text: 'Location of originals')
        expect(page).to have_css('dd', text: /^Something incredible is waiting/)
      end
    end

    it 'indexed terms has configured metadata' do
      within '#indexed-terms' do
        expect(page).to have_css('dt', text: 'Subjects')
        expect(page).to have_css('dd', text: 'Societies')
        expect(page).to have_css('dd', text: 'Mindanao Island (Philippines)')
      end
    end

    it 'adminstrative information has configured metadata' do
      within '#administrative-information' do
        expect(page).to have_css('dt', text: 'Acquisition information')
        expect(page).to have_css('dd', text: 'Donated by Alpha Omega Alpha.')

        expect(page).to have_css('dt', text: 'Appraisal information')
        expect(page).to have_css('dd', text: /^Corpus callosum something incredible/)

        expect(page).to have_css('dt', text: 'Custodial history')
        expect(page).to have_css('dd', text: 'Maintained by Alpha Omega Alpha and the family of William Root.')

        expect(page).to have_css('dt', text: 'Processing information')
        expect(page).to have_css('dd', text: /^Processed in 2001\. Descended from astronomers\./)
      end
    end
  end
  describe 'navigation bar' do
    it 'has configured links' do
      within '.al-sidebar-navigation-overview' do
        expect(page).to have_css 'a[href="#summary"]', text: 'Summary'
        expect(page).to have_css 'a[href="#access-and-use"]', text: 'Access and Use'
        expect(page).to have_css 'a[href="#background"]', text: 'Background'
        expect(page).to have_css 'a[href="#related"]', text: 'Related'
        expect(page).to have_css 'a[href="#administrative-information"]', text: 'Administrative Information'
      end
    end
    describe 'context_sidebar' do
      it 'has a terms and conditions card' do
        within '#accordion' do
          expect(page).to have_css '.card-header h5', text: 'Terms & Conditions'
          expect(page).to have_css '.card-block dt', text: 'Restrictions:'
          expect(page).to have_css '.card-block dd', text: 'No restrictions on access.'
          expect(page).to have_css '.card-block dt', text: 'Terms of Access:'
          expect(page).to have_css '.card-block dd', text: /^Copyright was transferred/
        end
      end

      it 'has a how to cite card' do
        within '#accordion' do
          expect(page).to have_css '.card-header h5', text: 'How to cite this collection'
          expect(page).to have_css '.card-block dt', text: 'Preferred citation'
          expect(page).to have_css '.card-block dd', text: /Omega Alpha Archives\. 1894-1992/
        end
      end
    end
  end
  describe 'search within' do
    it 'has only items from this collection' do
      click_button 'search'
      within '#facet-collection_sim' do
        expect(page).to have_css 'li', count: 1
      end
    end
  end
end
