# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Search Navbar', type: :feature do
  describe 'collection link' do
    it 'is not active when collection search is not activated' do
      visit search_catalog_path q: 'a brief', search_field: 'all_fields'
      within '.navbar-search' do
        expect(page).not_to have_css 'li.nav-item.active', text: 'Collections'
      end
    end
    it 'is active when collection search is activated' do
      visit search_catalog_path f: { level_sim: ['Collection'] }, search_field: 'all_fields'
      within '.navbar-search' do
        expect(page).to have_css 'li.nav-item.active', text: 'Collections'
      end
    end
  end
end
