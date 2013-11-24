require 'spec_helper'

describe 'Static pages' do

  subject { page }

  # describe 'Home page' do
  #   before { visit root_path }

  #   it { should have_content('Sample App') }
  #   it { should have_title(full_title('')) }
  #   it { should_not have_title('| Home') }
  # end

  shared_examples_for 'all static pages' do
    it { should have_selector('h1', text: heading) }
    it { should have_title(full_title(page_title)) }
  end

  context 'Home page' do
    before { visit root_path }
    let(:heading) { 'Sample App' }
    let(:page_title) { '' }

    it_should_behave_like 'all static pages'
    it { should_not have_title('| Home') }
  end


  context 'Help page' do
    before { visit help_path }
    let(:heading) { 'Help' }
    let(:page_title) { 'Help' }

    # it { should have_content('Help') }
    # it { should have_title(full_title('Help')) }
    it_should_behave_like 'all static pages'
  end

  context 'About page' do
    before { visit about_path }
    let(:heading) { 'About Us' }
    let(:page_title) { 'About Us' }

    # it { should have_content('About Us') }
    # it { should have_title(full_title('About Us')) }
    it_should_behave_like 'all static pages'
  end

  context 'Contact page' do
    before { visit contact_path }
    let(:heading) { 'Contact' }
    let(:page_title) { 'Contact' }

    # it { should have_content('Contact') } == it { should have_selector('h1', text: 'Contact') }
    # it { should have_title(full_title('Contact')) }
    it_should_behave_like 'all static pages'
  end

  context 'has the right links on the layout' do
    before { visit root_path }

    context 'when click on About link' do
      it 'goes to About page' do
        click_link 'About'
        expect(page).to have_title(full_title('About Us'))
      end
    end

    context 'when click on Help' do
      it 'goes to Help page' do
        click_link 'Help'
        expect(page).to have_title(full_title('Help'))
      end
    end

    context 'when click on Contact' do
      it 'goes to Contact page' do
        click_link 'Contact'
        expect(page).to have_title(full_title('Contact'))
      end
    end

    # click_link 'Home'
    # click_link 'Sign up now!'
    # expect(page).to have_title(full_title('xxxxxxxxx'))
    # click_link 'sample app'
    # expect(page).to have_title(full_title('xxxxxxxxx'))
  end

end
