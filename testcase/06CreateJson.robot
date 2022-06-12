*** Settings ***
Library    OperatingSystem
Library    Collections

*** Test Cases ***
TC_0601 create json from data file
    # get file อ้างอิงจากไฟล์ที่เรารัน robot
    # CURDIR จะ return จาก current path
    ${content}=    get file    ${CURDIR} /../resources/test data.json
    log    ${content}

TC_0602 create json from template file
    # อะไรใช้ร่วมกันได้ก็จะแชร์กัน
    ${content}=    get file    ${CURDIR} /../resources/test data template.json
    log    ${content}
    ${name}=    set variable    Kate
    ${age}=    set variable    null
    ${sex}=    set variable    female
    ${replace content}=    replace variables    ${content}
    log    ${replace content}

TC_0603 create json at run time
    # สร้างจาก leaf ลูก
    ${marry}=    create dictionary    name=Marry    age=${30}
    ${david}=    create dictionary    name=David    age=${32}

    ${friends}=    create list    ${marry}    ${david}

    ${dict}=    create dictionary    name=John    age=${34}    sex=${None}    friends=${friends}
    # ps. None in robot = null in python

    # convert dictionary to json text
    ${json}=    evaluate    json.dumps($dict)    modules=json

TC_0604 test update json
    ${content}=    get file    ${CURDIR} /../resources/test data.json

    # convert json text to dictionary
    ${dict}=    evaluate    json.loads($content)    modules=json

    # prepare data
    ${charles}=    create dictionary    name=Charles    age=${22}

    # get list value from dict (key = friends)
    ${friends}=    get from dictionary    ${dict}    friends

    # append to list
    append to list    ${friends}    ${charles}
    log    ${dict}

    # convert from dict to json
    ${json}=    evaluate    json.dumps($dict)    modules=json
    log    ${json}