require 'rails_helper'

RSpec.feature do

  context "guest user permissions" do
    scenario "root path" do
      visit root_url
      within("#main-nav") do
        expect(page).to have_link("Log In")
        expect(page).to have_no_content("Business Admin Dashboard")
        expect(page).to have_no_content("Platform Admin Dashboard")
      end
    end

    scenario "sessions#new path" do
      visit login_path

      within('#login') do
        expect(page).to have_content("Username")
        expect(page).to have_content("Password")
      end
    end

    scenario "users#new path" do
      visit new_user_path

      within('#site_content') do
        expect(page).to have_content("Username")
        expect(page).to have_content("Password")
        expect(page).to have_content("Confirm Password")
        expect(page).to have_content("Email")
        expect(page).to have_content("Confirm Email")
        expect(page).to have_content("Full Name")
        expect(page).to have_content("Address")
        expect(page).to have_content("City")
        expect(page).to have_content("State")
      end
    end

    scenario "users#create path" do
      visit new_user_path

      within('#site_content') do
        fill_in "Username", with: "Frank"
        fill_in "Password", with: "password"
        fill_in "Confirm Password", with: "password"
        fill_in "Email", with: "joe@gmail.com"
        fill_in "Confirm Email", with: "joe@gmail.com"
        fill_in "Full Name", with: "Joe So"
        fill_in "Address", with: "2125 Anywhere"
        fill_in "City", with: "Denver"
        fill_in "State", with: "CO"
        fill_in "Zip", with: "80123"
      end
      click_button "Create Account"

      within(".flash_message") do
        expect(page).to have_content("Thanks for creating an account!")
      end
      within("#site_content") do
        expect(page).to have_content("Welcome, Joe So")
      end
    end

    scenario "businesses#index path" do
      business1 = create(:business, active: true)
      business2 = create(:business, active: true)
      business3 = create(:business, active: true)

      visit root_url

      click_link "Browse By Business"
      expect(current_path).to eq(businesses_path)

      within("#site_content") do
        expect(page).to have_content(business1.name)
        expect(page).to have_content(business2.name)
        expect(page).to have_content(business3.name)
      end
    end


    scenario 'items#show' do
      business = create(:business, active: true)
      item = create(:item)
      business.items << item

      visit business_path(business.slug)

      click_link(item.name)

      expect(current_path).to eq(item_path(id: item.id))
      within('#site_content') do
        expect(page).to have_content(item.name)
        expect(page).to have_content(item.description)
        expect(page).to have_link("Login or Create Account to Bid")
      end
    end
  end

  context "registered user" do
    scenario "sessions#create path" do
      user = create(:user)
      visit root_url
      click_link "Log In"
      fill_in "Username", with: user.username
      fill_in "Password", with: user.password
      click_button "Log In"

      expect(current_path).to eq(dashboard_path)

      within('#site_content') do
        expect(page).to have_content("Welcome, #{user.name}")
      end
      within("#main-navbar") do
        expect(page).to have_content("Logged in as #{user.username}")
        expect(page).to have_content("Log Out")
        expect(page).not_to have_content("Log In")
      end
    end

    scenario 'session#delete path' do
      user = create(:user)
      visit login_path
      fill_in "Username", with: user.username
      fill_in "Password", with: user.password
      click_button "Log In"

      click_link "Log Out"

      within(".flash_message") do
        expect(page).to have_content("You are now logged out")
      end
    end

    scenario 'users#edit path' do
      user = create(:user)
      visit login_path
      fill_in "Username", with: user.username
      fill_in "Password", with: user.password
      click_button "Log In"

      click_link("Update Personal Account Information")

      expect(current_path).to eq(user_edit_path)

      within('#site_content') do
        expect(page).to have_content("Username")
        expect(page).to have_content("Password")
        expect(page).to have_content("Confirm Password")
        within('h2') do
          expect(page).to have_content("Update Personal Information")
        end
      end
    end

    scenario 'users#update path' do
      user = create(:user)
      new_username = 'hoorah!'
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit(user_edit_path)

      within('#site_content') do
        fill_in "Username", with: new_username
        fill_in "Password", with: "password"
        fill_in "Confirm Password", with: "password"
        click_button "Update Information"
      end
      expect(user.username).to eq('hoorah!')
      expect(current_path).to eq(dashboard_path)
      within("#main-navbar") do
        expect(page).to have_content("Logged in as hoorah!")
      end
    end

    scenario 'businesses#new path' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit(dashboard_path)

      click_link("Create A New Business")
      expect(current_path).to eq(new_business_path)

      within('#site_content') do
        expect(page).to have_content('Business Name')
        expect(page).to have_content('Description')
      end
    end

    scenario 'businesses#create path' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit(dashboard_path)

      click_link("Create A New Business")

      within('#site_content') do
        fill_in 'Business Name', with: "What a biz"
        fill_in 'Description', with: "It's a business!"
        click_button 'Create Business'
      end

      expect(current_path).to eq(dashboard_path)
      within(".flash_message") do
        expect(page).to have_content("What a biz has been created and is pending approval. Approval process on average takes 1-2 business days.")
      end
    end

    scenario 'items#show' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      business = create(:business, active: true)
      item = create(:item)
      business.items << item

      visit business_path(business.slug)

      click_link(item.name)

      expect(current_path).to eq(item_path(id: item.id))
      within('#site_content') do
        expect(page).to have_content(item.name)
        expect(page).to have_content(item.description)
        expect(page).to have_button("Place Bid")
      end
    end

    scenario 'bids#create' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      business = create(:business)
      item = create(:item)
      business.items << item

      visit item_path(id: item.id)

      fill_in "bid[price]", with: 10.00
      click_button "Place Bid"

      expect(current_path).to eq(item_path(id: item.id))
      within(".flash_message") do
        expect(page).to have_content("Sucessfully placed bid! $10.00")
      end
      within("#site_content") do
        expect(page).to have_content("Highest Bid: $10.00")
      end
    end

    scenario 'bids#create' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      business = create(:business)
      item = create(:item)
      business.items << item

      visit item_path(id: item.id)

      fill_in "bid[price]", with: 10.00
      click_button "Place Bid"

      expect(current_path).to eq(item_path(id: item.id))
      within(".flash_message") do
        expect(page).to have_content("Sucessfully placed bid! $10.00")
      end
      within("#site_content") do
        expect(page).to have_content("Highest Bid: $10.00")
      end
    end
  end

  context "platform admin" do
    scenario 'platform_admin/dashboard#show' do
      user = create(:user, platform_admin: true)

      visit root_url
      click_link "Log In"
      fill_in "Username", with: user.username
      fill_in "Password", with: user.password
      click_button "Log In"

      expect(current_path).to eq(platform_admin_dashboard_path)
      within('#site_content') do
        expect(page).to have_content('Platform Admin Dashboard')
      end
    end

    scenario 'businesses#edit' do
      user = create(:user, platform_admin: true)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      business = create(:business)
      item = create(:item)
      business.items << item

      visit business_edit_path(slug: business.slug)
      within('#site_content') do
        expect(page).to have_content("Edit Business Information")
        expect(page).to have_content("Business Name")
        expect(page).to have_content("Description")
      end
    end

    scenario 'items#edit' do
      user = create(:user, platform_admin: true)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      business = create(:business)
      item = create(:item)
      business.items << item

      visit edit_business_item_path(slug: business.slug, id: item.id)

      within('#site_content') do
        expect(page).to have_content("Edit Item Information")
        expect(page).to have_content("Name")
        expect(page).to have_content("Description")
      end
    end

    scenario 'business#show' do
      user = create(:user, platform_admin: true)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      business1 = create(:business, active: true)
      business2 = create(:business)
      item1 = create(:item)
      item2 = create(:item)
      business1.items << item1
      business2.items << item2

      visit business_path(slug: business1.slug)
      within('#site_content') do
        expect(page).to have_content("View Business Dashboard")
        expect(page).to have_content(business1.name)
        expect(page).to have_content(business1.description)
        expect(page).to have_content(item1.name)
      end

      visit business_path(slug: business2.slug)
      within('#site_content') do
        expect(page).to have_content("View Business Dashboard")
        expect(page).to have_content(business2.name)
        expect(page).to have_content(business2.description)
        expect(page).to have_content("This business is pending approval.")
        expect(page).to have_no_content(item2.name)
      end
    end

    scenario 'business_admin/users#show' do
      user = create(:user, platform_admin: true)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      business1 = create(:business, active: true)
      business2 = create(:business)
      item1 = create(:item)
      item2 = create(:item)
      business1.items << item1
      business2.items << item2

      visit business_admin_dashboard_path
      within('#site_content') do
        expect(page).to have_content("Business Admin Dashboard")
        expect(page).to have_content("Welcome, #{user.name}")
        expect(page).to have_content("All Businesses")
        expect(page).to have_content(business1.name)
        expect(page).to have_content(business1.description)
        expect(page).to have_content(business2.name)
        expect(page).to have_content(business2.description)
      end
    end
  end
end
