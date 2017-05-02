require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('adding a new specialty', {:type => :feature}) do
  it('allows a user to click a specialty to see the doctors and details for it') do
    visit('/')
    click_link('Add New Specialty')
    fill_in('specialty_name', :with =>'Gastroenterology')
    click_button('Add Specialty')
    expect(page).to have_content('Gastroenterology')
  end
end

describe('viewing all of the specialties', {:type => :feature}) do
  it('allows a user to see all of the specialties that have been created') do
    specialty = Specialty.new({:name => 'Gastroenterology', :id => 10})
    specialty.save()
    visit('/')
    click_link('View All Specialties')
    expect(page).to have_content(specialty.name)
  end
end
