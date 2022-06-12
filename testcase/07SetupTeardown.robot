*** Settings ***
suite setup    log    suite setup
suite teardown    log    suite teardown
test setup    log    test setup
test teardown    log    test teardown
test timeout    3s

*** Test Cases ***
TC_0701 test
     log    start
     fail    force to fail
     log    finish
TC_0702 test
    [setup]    log   override test setup
    [teardown]    log   override test teardown
    log    start
    log    finish
TC_0703 test
    log    start
    sleep    4
    log    finish
TC_0704 test
    [timeout]    5s
    log    start
    sleep    4
    log    finish
