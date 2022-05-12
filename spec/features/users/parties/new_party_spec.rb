require 'rails_helper'

RSpec.describe "New Party Page" do 

  describe "As a Visitor" do 

    it 'it has the movie title and a form to create a new party' do
      skeeter = User.create!(name: 'Skeeter', email: 'skeeter@example.com')
      jaws_id = 578
      # date = DateTime.now.strftime("%m/%d/%y")
      visit "/users/#{skeeter.id}/movies/#{jaws_id}/party/new"
     
      expect(page).to have_content("Create a Movie Party for Jaws")
      expect(page).to have_field('Duration of Party', with: '124')
      expect(page).to have_field('Day')
      expect(page).to have_field('Start Time', with: '7:00')

    end 

    it 'the new party form has a checkbox list of all users to add them to the party' do
      skeeter = User.create!(name: 'Skeeter', email: 'skeeter@example.com')
      lugnut = User.create!(name: 'LugNut', email: 'fatdog@corgi.com')
      hazel = User.create!(name: 'Hazel', email: 'hazelthehut@food.com')
      ruby = User.create!(name: 'Ruby', email: 'rubythehut@food.com')
      woobie = User.create!(name: 'Woobie', email: 'woobiethehut@food.com')
      jaws_id = 578
     
      visit "/users/#{skeeter.id}/movies/#{jaws_id}/party/new"
    
      expect(page).to have_content('Invite Other Users')
      expect(page).to have_field('LugNut', checked: false) 
      expect(page).to have_field('Hazel', checked: false) 
      expect(page).to have_field('Ruby', checked: false) 
      expect(page).to have_field('Woobie', checked: false) 
    end 

    it 'when a new party is created, I am redirected to my dashboard with new party shown' do
      skeeter = User.create!(name: 'Skeeter', email: 'skeeter@example.com')
      lugnut = User.create!(name: 'LugNut', email: 'fatdog@corgi.com')
      hazel = User.create!(name: 'Hazel', email: 'hazelthehut@food.com')

      jaws_id = 578
     
      visit "/users/#{skeeter.id}/movies/#{jaws_id}/party/new"
      fill_in "Duration of Party", with: 124
      # fill_in "Day", with "2022/05/14"
      page.find('#start_time').set("2022-04-05")


      fill_in "Start Time", with: "8:00"
      check("invites_#{lugnut.id}")

      click_on "Create Party"
    end 

  end 

end 

