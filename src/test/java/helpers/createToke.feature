
Feature: Tests for example purposes

Scenario: Get general token for all
        Given url base_url
        Given path 'users/login'
        And request {"user": {"email":"#(userEmail)", "password": "#(userPassword)"}}
        When method Post
        Then status 200
        * def authorization_token = response.user.token
