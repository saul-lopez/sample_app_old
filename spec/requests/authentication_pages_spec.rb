require 'spec_helper'

describe "Authentication" do
  subject { page }
  describe "signin" do
    before { visit signin_path }


    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        # Esta función se define en spec/support/utilities.rb
        valid_signin(user)
      end

      it { should have_selector('title', text: user.name) }
      it { should have_link('Profile', href: user_path(user)) }
      it { should have_link('Settings', href: edit_user_path(user)) }
      it { should have_link('Sign out', href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }
    end

    describe "with invalid information" do
      before { click_button "Sign in" }
      it { should have_selector('title', text: 'Sign in') }
      # Este matcher personalizado se define en spec/support/utilities.rb
      it { should have_error_message('Invalid') }
      describe "after visiting another page" do
        before { click_link "Home"}
        it { should_not have_error_message('Invalid') }
      end
    end
  end

  describe "authorization" do
    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      describe "visiting the edit page" do
        before { visit edit_user_path(user) }
        it { should have_selector('title', text: 'Sign in') }
      end
      describe "submitting to the update action" do
        before { put user_path(user) }
        specify { response.should redirect_to (signin_path) }
      end
    end
  end
end
