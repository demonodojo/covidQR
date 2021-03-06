require "application_system_test_case"

class CertificationsTest < ApplicationSystemTestCase
  setup do
    @certification = certifications(:one)
  end

  test "visiting the index" do
    visit certifications_url
    assert_selector "h1", text: "Certifications"
  end

  test "creating a Certification" do
    visit certifications_url
    click_on "New Certification"

    fill_in "Category", with: @certification.category
    fill_in "Name", with: @certification.name
    fill_in "Qr code", with: @certification.qr_code
    fill_in "Surname", with: @certification.surname
    click_on "Create Certification"

    assert_text "Certification was successfully created"
    click_on "Back"
  end

  test "updating a Certification" do
    visit certifications_url
    click_on "Edit", match: :first

    fill_in "Category", with: @certification.category
    fill_in "Name", with: @certification.name
    fill_in "Qr code", with: @certification.qr_code
    fill_in "Surname", with: @certification.surname
    click_on "Update Certification"

    assert_text "Certification was successfully updated"
    click_on "Back"
  end

  test "destroying a Certification" do
    visit certifications_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Certification was successfully destroyed"
  end
end
