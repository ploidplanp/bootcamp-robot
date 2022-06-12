*** Settings ***
Library    RequestsLibrary
Library    OperatingSystem
Library    Collections

*** Test Cases ***
TC_0801 test get request
    #### old v.
    create session    wiki    https://en.wikipedia.org
    ${headers}=    create dictionary    myheaders=hello wiki
    ${body}=    set variable    wiki wiki
    # ส่ง method get ไป
    ${response}=    get on session    wiki    /wiki/Thailand    headers=${headers}    data=${body}

    log    ${response.headers}
    log    ${response.text}
    should be equal as integers    ${response.status_code}    200

TC_0802 get friend balance (API)

    ${balance}=    set variable    0

    create session    accounting    http://18.140.235.9:8001
    ${headers}=    create dictionary    secret-key=$2b$10$a5pPzFpI0FUDLGbUCBwc4./npTSp.U2nrULweVf8DJ28HCZWhqlse
    ${response}=    get on session    accounting    /accounting    headers=${headers} 
    log    ${response.text}

    ${data}=    set variable    ${response.text}

    ${final}=    evaluate    json.loads($data)    modules=json

    FOR    ${i}    IN    @{final}
        log    ${i}[friends]
        ${myfriend}=    set variable    ${i}[friends]
        FOR    ${j}    IN    @{myfriend}
            ${balance}=    evaluate    ${balance} + ${j}[balance]
        END
    END

    log    result balance : ${balance}

TC_0803 re get friend balance (file version)
    ${balance}=    set variable    0

    ${content}=    get file    ${CURDIR} /../resources/balance.json
    # convert json text to dictionary
    ${content dict}=    evaluate    json.loads($content)    modules=json

    FOR    ${i}    IN    @{content dict}
        FOR    ${j}    IN    @{i}[friends]
            ${balance}=    evaluate    ${balance} + ${j}[balance]
        END
    END

    log    ALL FRIENDS'S BALANCE : ${balance}