Feature: Tests for example purposes

    Background: Background name
        Given url base_url


    Scenario: Get - Validate  simple string
        Given path 'tags'
        When method Get
        Then status 200
        And match response.tags contains 'welcome'
        And match response.tags !contains 'baby'

    Scenario: Get - Validate EACH value
        Given path 'tags'
        When method Get
        Then status 200
        And match each response.tags == "#string"


    Scenario: Get - Validate  array strings
        Given path 'tags'
        When method Get
        Then status 200
        And match response.tags contains ['welcome', 'introduction']

    Scenario: Get - Validate structure type
        Given path 'tags'
        When method Get
        Then status 200
        And match response.tags == '#array'

    Scenario: Get- Validate structure
        Given params {limit: 10, offset: 0}
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles == '#[10]' //validate quantity
        And match response.articlesCount == 256
        And match response.articlesCount != 100
        And match response == {"articles":"#array", "articlesCount": 256}
        And match response.articles[0].createdAt contains '2023'   // [*] this means that it is going to loop the array. True if any of the objects in the array contais '1'
        And match response.articles[*].favoritesCount contains 0
        And match each response..following == "#boolean"
        And match each response..favoritesCount == "#number"
        And match each response..bio == "##string" //## means optional

        Scenario: Get- Validate structure
            * def timeValidatorRegex = read('classpath:helpers/timeValidator.js')
            Given params {limit: 10, offset: 0}
            Given path 'articles'
            When method Get
            Then status 200
            And match each response.articles ==
            """
                {
                    "slug":"#string",
                    "title":"#string",
                    "description":"#string",
                    "body":"#string",
                    "tagList":"#array",
                    "createdAt":"#? timeValidatorRegex(_)",
                    "updatedAt":"#? timeValidatorRegex(_)",
                    "favorited":"#boolean",
                    "favoritesCount":"#number",
                    "author": {
                        "username":"#string",
                        "bio":"##string",
                        "image":"#string",
                        "following":"#boolean",
                    }
                }
            """
    
        @debugretry
        Scenario: retry request
            * configure retry = {count: 10, interval: 5000}
            Given params {limit:10, offset:0}
            Given path 'articles'
            And retry until response.articles[0].favoritesCount == 1
            When method Get
            Then status 200

        @debugretry
        Scenario: Sleep request
            * def sleep = function(pause){java.lang.Thread.sleep(pause)}
            Given params {limit:10, offset:0}
            Given path 'articles'
            When method Get
            * eval sleep(5000)
            Then status 200


            #JSON - transforms -> go to documentation