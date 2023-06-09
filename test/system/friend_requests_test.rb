require "application_system_test_case"

class FriendRequestsTest < ApplicationSystemTestCase
  setup do
    @friend_request = friend_requests(:one)
  end

  test "visiting the index" do
    visit friend_requests_url
    assert_selector "h1", text: "Friend requests"
  end

  test "should create friend request" do
    visit friend_requests_url
    click_on "New friend request"

    check "Accepted" if @friend_request.accepted
    click_on "Create Friend request"

    assert_text "Friend request was successfully created"
    click_on "Back"
  end

  test "should update Friend request" do
    visit friend_request_url(@friend_request)
    click_on "Edit this friend request", match: :first

    check "Accepted" if @friend_request.accepted
    click_on "Update Friend request"

    assert_text "Friend request was successfully updated"
    click_on "Back"
  end

  test "should destroy Friend request" do
    visit friend_request_url(@friend_request)
    click_on "Destroy this friend request", match: :first

    assert_text "Friend request was successfully destroyed"
  end
end
