*** Settings ***
Library    ../lib/helper.py

*** Test Cases ***
TC_0501 test say hello to robot
    ${msg}=    say_hello_to_friend    ploid
    # or ตัด _ 
    # ${msg}=    say hello to friend    ploid
    log    ${msg}

TC_0502 test call python inline
    # modules import ให้
    ${result}=    evaluate    random.randint(0, 10)    modules=random
    log    ${result}