Feature: browser automation 1

Background:
  * configure driver = { type: 'chrome', showDriverLog: true }
# * configure driverTarget = { docker: 'justinribeiro/chrome-headless', showDriverLog: true }
# * configure driverTarget = { docker: 'ptrthomas/karate-chrome', showDriverLog: true }
# * configure driver = { type: 'chromedriver', showDriverLog: true }
# * configure driver = { type: 'geckodriver', showDriverLog: true }
# * configure driver = { type: 'safaridriver', showDriverLog: true }
# * configure driver = { type: 'iedriver', showDriverLog: true, httpConfig: { readTimeout: 120000 } }

@web
Scenario: try to login to github
and then do a google search

  Given driver 'https://google.com'
  And input("input[name=q]", 'karate dsl')
  When submit().click("input[name=btnI]")
  Then waitForUrl('https://github.com/intuit/karate')