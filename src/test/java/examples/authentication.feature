Feature: Tests for example purposes

    Background: Background name
        * url base_url
        # * def tokenResponse = callonce read() 
        # * def token = tokenResponse.authorization_token
        * def articleRequestBody = read('classpath:examples/json/newArticleRequest.json')
        * def dataGenerator = Java.type('helpers.DataGenerator')
        * set articleRequestBody.article.title = dataGenerator.getRandomArticleInfo().title
        * set articleRequestBody.article.description = dataGenerator.getRandomArticleInfo().description
        * set articleRequestBody.article.body = dataGenerator.getRandomArticleInfo().body

    @debugg
    Scenario: Authentication
        # Given path 'users/login'
        # And request {"user": {"email":"kar1@test.com", "password": "Karate123"}}
        # When method Post
        # Then status 200
        # * def token = response.user.token
        # Given header Authorization = 'Token ' + token
        Given path 'articles'
        # And request {"article": {"tagList": [], "title": "Fer sfdsfdsdf123231321312", "description": "testing", "body": "body"}}
        And request articleRequestBody
        When method Post
        Then status 200
        And match response.article.title == articleRequestBody.article.title

    Scenario: Sign Up
        * def randomEmail = dataGenerator.getRandomEmail()
        * def randomUsername = dataGenerator.getRandomUsername()
        Given path 'users'
        And request
        """
            {
                "user":{
                    "email": #(randomEmail),
                    "password": "123karate",
                    "username":#(randomUsername)
                }
            }
        """
            When method Post
            Then status 200



# To reuse the token for other Scenarios 
#     Feature: Tests for example purposes

#     Background: Background name
#         Given url 'https://conduit.productionready.io/api/'
#         Given path 'users/login'
#         And request {"user": {"email":"kar1@test.com", "password": "Karate123"}}
#         When method Post
#         Then status 200
#         * def token = response.user.token

#     Scenario: Authentication
#         Given header Authorization = 'Token ' + token
#         Given path 'articles'
#         And request {"article": {"tagList": [], "title": "Fer testing223232", "description": "testing", "body": "body"}}
#         When method Post
#         Then status 200
#         And match response.article.title == "Fer testing223232"