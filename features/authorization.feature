Feature: Authorization using API key
  Scenario: API key was not set in header
    Given I make a "GET" request to "https://api.apilayer.com/exchangerates_data/latest"
    When I receive a response
    Then I expect response should have a status "401"
    And I expect response should have a json
    """
      {
          "message": "No API key found in request"
      }
    """

  Scenario: API key was set to invalid value
    Given I set header "apikey" to "not-valid"
    And I make a "GET" request to "https://api.apilayer.com/exchangerates_data/latest"
    When I receive a response
    Then I expect response should have a status "401"
    And I expect response should have a json
    """
      {
          "message": "Invalid authentication credentials"
      }
    """
