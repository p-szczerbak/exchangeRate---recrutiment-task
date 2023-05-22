Feature: Endpoint '/latest' returns exchange rate data in real-time for all available currencies or for a specific set
  Scenario: GET request with default parameters returns exchange rates for EUR as a base and corresponding set of rates
    Given I use a valid API key
    And I make a "GET" request to "https://api.apilayer.com/exchangerates_data/latest"
    When I receive a response
    Then I expect response should have a status "200"
    And I expect response should have a json like
    """
      {
          "success": true,
          "base": "EUR",
          "rates": {}
      }
    """
    And I expect response should have a json schema at "rates"
    """
    {
        "type": "object",
        "properties": {
            "EUR": {
                "type": "number"
            },
            "GBP": {
                "type": "number"
            },
            "USD": {
                "type": "number"
            },
            "AED": {
                "type": "number"
            },
            "PLN": {
                "type": "number"
            },
            "BTC": {
                "type": "number"
            }
        }
    }
    """

  Scenario: GET request with specified and valid parameters
    Given I use a valid API key
    And I make a "GET" request to "https://api.apilayer.com/exchangerates_data/latest?symbols=EUR,GBP,USD&base=PLN"
    When I receive a response
    Then I expect response should have a status "200"
    And I expect response should have a json like
    """
      {
          "success": true,
          "base": "PLN",
          "rates": {}
      }
    """
    And I expect response should have a json schema at "rates"
    """
    {
        "type": "object",
        "properties": {
            "EUR": {
                "type": "number"
            },
            "GBP": {
                "type": "number"
            },
            "USD": {
                "type": "number"
            }
        }
    }
    """

  Scenario: GET request with symbols separated by comma and space
    Given I use a valid API key
    And I make a "GET" request to "https://api.apilayer.com/exchangerates_data/latest?symbols=EUR,%20%20GBP,%20USD%20&base=PLN"
    When I receive a response
    Then I expect response should have a status "200"

  Scenario: GET request with invalid base currency
    Given I use a valid API key
    And I make a "GET" request to "https://api.apilayer.com/exchangerates_data/latest?symbols=EUR,GBP,USD&base=PLN,USD,EUR"
    When I receive a response
    Then I expect response should have a status "400"
    And I expect response should have a json
    """
      {
          "error": {
              "code": "invalid_base_currency",
              "message": "An unexpected error ocurred. [Technical Support: support@apilayer.com]"
          }
      }
    """

  Scenario: GET request with invalid symbols: a number instead of set of symbols
    Given I use a valid API key
    And I make a "GET" request to "https://api.apilayer.com/exchangerates_data/latest?symbols=123&base=PLN"
    When I receive a response
    Then I expect response should have a status "400"
      And I expect response should have a json
    """
      {
          "error": {
              "code": "invalid_currency_codes",
              "message": "You have provided one or more invalid Currency Codes. [Required format: currencies=EUR,USD,GBP,...]"
          }
      }
    """

  Scenario: GET request with invalid symbols: symbols are space-separated
    Given I use a valid API key
    And I make a "GET" request to "https://api.apilayer.com/exchangerates_data/latest?symbols=EUR%20USD%20GBP&base=PLN"
    When I receive a response
    Then I expect response should have a status "400"
      And I expect response should have a json
    """
      {
          "error": {
              "code": "invalid_currency_codes",
              "message": "You have provided one or more invalid Currency Codes. [Required format: currencies=EUR,USD,GBP,...]"
          }
      }
    """

  Scenario: DELETE request with no body returns 404 - Not Found
    Given I use a valid API key
    And I make a "DELETE" request to "https://api.apilayer.com/exchangerates_data/latest"
    When I receive a response
    Then I expect response should have a status "404"
      And I expect response should have a json
    """
      {
          "message": "no Route matched with those values"
      }
    """

  Scenario: PUT request with no body returns 404 - Not Found
    Given I use a valid API key
    And I make a "PATCH" request to "https://api.apilayer.com/exchangerates_data/latest"
    When I receive a response
    Then I expect response should have a status "404"
      And I expect response should have a json
    """
      {
          "message": "no Route matched with those values"
      }
    """

  Scenario: OPTIONS request returns 403 - Forbidden
    Given I use a valid API key
    And I make a "OPTIONS" request to "https://api.apilayer.com/exchangerates_data/latest"
    When I receive a response
    Then I expect response should have a status "403"
      And I expect response should have a json
    """
      {
          "message": "You cannot consume this service"
      }
    """

  Scenario: POST request returns 403 - Forbidden
    Given I use a valid API key
    And I make a "POST" request to "https://api.apilayer.com/exchangerates_data/latest"
    When I receive a response
    Then I expect response should have a status "403"
      And I expect response should have a json
    """
      {
          "message": "You cannot consume this service"
      }
    """


#    //Ensure that api codes 200, 400, 401, 403, 404 are covered
