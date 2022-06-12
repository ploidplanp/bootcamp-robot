*** Settings ******
Library    SeleniumLibrary
Test Teardown    close browser

*** Test Cases ***
TC_0901 test selenium
    open browser    https://en.wikipedia.org/wiki/Thailand    chrome
    sleep   3

TC_0902 test calculator online
    open browser    http://www.math.com/students/calculators/source/basic.htm    chrome
    click button    //input[@name="one"]
    click button    two
    click button    plus
    click button    two
    click button    DoIt
    ${actual result}=    get value    Input
    should be equal as integers    ${actual result}    14
    sleep    5

*** Keywords ***
