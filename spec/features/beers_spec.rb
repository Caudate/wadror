require 'rails_helper'

describe "Beer page" do
  describe "when breweries exists" do
    before :each do
      @breweries = ["Koff", "Karjala", "Schlenkerla"]
      year = 1896
      @breweries.each do |brewery_name|
        FactoryGirl.create(:brewery, name: brewery_name, year: year += 1)
      end
    end     
 
    it "can make new beer" do
      visit beers_path
      click_link "New Beer"
      fill_in('Name', with:'Kalja')
      fill_in('Style', with:'Litku')
      click_button('Create Beer')
      expect(page).to have_content "Kalja"
      expect(page).to have_content "Litku"
    end
   
    it "produces the right error when empty name" do
      visit beers_path
      visit beers_path
      click_link "New Beer"
      fill_in('Name', with:'')
      fill_in('Style', with:'Litku') 
      click_button('Create Beer')
      expect(page).to have_content "Name can't be blank"      
    end  
  end
end 
