*** Settings ***

*** Test Cases ***
TC_0301 test if condition
    # robot 3.0 : ข้อจำกัดคือใส่ keyword ต่อได้ตัวเดียว
    ${x}=    set variable    10
    run keyword if    ${x} > 10    log    x is greater than 10
    # ต่อบบรทัด
    ...    ELSE IF    ${x} == 10    log    x is equal 10
    ...    ELSE    log    x is less than 10

    run keyword if    ${x} > 10    log    x is greater than 10
    ...    ELSE IF    ${x} == 10    run keywords    log    1111    AND    log    2222    AND    log    3333
    ...    ELSE    log    x is less than 10
    # run keywords มีความสามารถคือ สามารถ run ได้หลาย keywords ได้ ~มองเป็น arguments run multiple keyword in if condition
   
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # robot 4.0
    IF    ${x} > 10
        log    1111
        log    2222
        log    3333
    ELSE IF ${x} == 10
        log    4444
        log    5555
        log    6666
    ELSE
        log    7777
        log    8888
        log    9999
    END

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # robot 5.0 : inline if else
    #IF    ${x} > 10    log    1111    ELSE IF    ${x} == 10    log    2222    ELSE    log    3333

    ${text}=    set variable    hello
    # compare string ไม่ต้องครอบ {} เพราะต้องไป run ที่ python
    run keyword if    '$text' == 'helllo'    log    hello man
    ...    ELSE    log    goodbye

TC_0302 test for loop
    ${sum}=    set variable    0
    FOR    ${i}    IN RANGE    0    10    2
        log    i = ${i}
        ${sum}=    evaluate    ${sum} + ${i}
    END
    log    ${sum}

TC_0303 test nested for loop
    ${sum}=    set variable    0
    FOR    ${i}    IN RANGE    0    5
        FOR    ${j}    IN RANGE    ${i}    5
            log    i,j = ${i} ${j}
        END
    END

TC_0304 test continue and exit
    ${sum}=    set variable    0
    FOR    ${i}    IN RANGE    0    10
        log    i = ${i}
        # ถ้าเข้าเงื่อนไข ไม่ต้องทำข้างล่าง
        continue for loop if    ${i} % 2 == 1
        # break / continue
        exit for loop if    ${i} >= 8
            ${sum}=    evaluate    ${sum} + ${i}
    END
    log    ${sum}

TC_0305 test while loop
    ${end}=    set variable    ${FALSE}
    ${sum}=    set variable    0
    WHILE    not ${end}
        log    sum = ${sum}
        ${sum}=    evaluate    ${sum} + 1
        IF    ${sum} > 10
            ${end}=    set variable    ${TRUE}
        END
    END