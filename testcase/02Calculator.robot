*** Settings ***
# include file keywords
resource    ../keywords/CalculatorKeywords.robot

*** Variables ***

*** Test Cases ***
TC_0201 test add operation
    # 1) prepare test data
    ${x}=    set variable    7
    ${y}=    set variable    4
    ## string
    ${expected}=    set variable    11
    ## int
    ## ${expected}=    set variable    ${11}

    # 2) execute test
    ${actual result}=    evaluate    ${x} + ${y}

    # 3) validate result
    ## should be equal as integers มัน convert ค่าให้เลยผ่าน
    should be equal as integers    ${actual result}    ${expected}
    # should be equal    ${actual result}    ${expected}

TC_0202 test subtraction operation
    # 1) prepare test data
    ${x}=    set variable    7
    ${y}=    set variable    4
    ${expected}=    set variable    3

    # 2) execute test
    ${actual result}=    do subtraction    ${x}    ${y}

    # 3) validate result
    should be equal as integers    ${actual result}    ${expected}

TC_0203 test multiply operation v.1
    # ใช้ keywords ไหน เป็น template
    [template]    test multiply operation
    # data driven : ถ้า test แล้ว fail ก็ยังรันต่อได้
    7    4    28
    7    -4    -28
    -7    4    -28
    -7    -4    28

TC_0203 test multiply operation v.2
    # not data driven : ถ้า test แล้วเจอ fail จะไม่ run ข้อหลังจากที่ fail ต่อ
    test multiply operation    7    4    28

TC_0204 test divide operation gherkins
    # GHERKINS : ทำให้เห็นภาพรวม เห็นภาพใหญ่ แต่ยังรันไม่ได้
    # ต้องไปเขียน keyword support แต่ละข้ออีกที
    # prepare data
    Given user input 8 and 4
    # execute
    When user click divide button 
    # validate result
    Then monitor should show 2


*** Keywords ***
test multiply operation
    # 1) prepare test data
    [arguments]    ${x}   ${y}    ${expected result}

    # 2) execute test
    ${actual result}=    evaluate    ${x} * ${y}

    # 3) validate result
    should be equal as integers    ${actual result}    ${expected result}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# สามารถตัด Given, When, Then ข้างหน้าได้
# พวก test data ตัวแปร ปรับให้เลย
user input ${x} and ${y}
    log    x=${x}, y=${y}
    # set test variable : ขยาย scope ให้มองเห็นทั้งหมดภายใต้ testcase เดียวกัน
    set test variable    ${x}
    set test variable    ${y}
    # set suit variable 


user click divide button
    ${actual result}=    evaluate    ${x}/${y}
    set test variable    ${actual result}

monitor should show ${expected result}
    should be equal as integers    ${actual result}    ${expected result}