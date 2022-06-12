*** Settings ***
Library    Collections
Variables    ../resources/data.yaml
Variables    ../resources/${env}/config.yaml

*** Variables ***
${x0}    100
${y0}    ${100}
${z0}    ${100.0}
@{new list}    1    2
&{new dict}    a=100    b=200    c=300

*** Test Cases ***
TC_0401 test scalar varible
    ${x}=    set variable    100
    ${y}=    set variable    ${100}
    ${z}=    set variable    ${100.0}

    # check type
    should be true    type($x) == str
    should be true    type($y) == int
    should be true    type($z) == float

TC_0402 test list variable
    # creat list : keyword for create list
    ${list}=    create list    100    200    300    ${202.2}    400    ${300}
    log    ${list}[3] # log 202.2
    # or maybe like this
    log    ${list[2]}
    # slicing like python
    log    ${list}[::2]

    # need to include lib in setting
    append to list
    append to list    ${list}    600    700    800
    log    ${list}

    # insert in to list
    insert in to list    ${list}    1    insert here
    # log list : log list โดยเฉพาะ
    log list    ${list}

    # update value
    set list value    ${list}    1    303
    log list    ${list}

    # remove from list
    remove from list    ${list}    0
    log list    ${list}

    ## loop list
    # loop by length
    # ตัวแปร i เป็นเพียงแค่ index
    ${len}=    get length    ${list}
    FOR    ${i}    IN RANGE    0    ${len}
        log    index = ${i} : item = ${list}[${i}]
    END

    # loop by iterator
    # ตัวแปร i ที่ได้เป็น item ใน list
    FOR    ${i}    IN    @{list}
        log    item = ${i}
    END

TC_0403 test dictionary variable
    ${dict}=    create dictionary    a=100    b=200    c=300    d=400    e=600
    log dictionary    ${dict}

    log    ${dict}[c]
    log    ${dict["c"]}

    # set to dictionary ครอบคลุมทั้ง append update
    set to dictionary    ${dict}    f=700    g=800    c=350
    log dictionary    ${dict}

    remove from dictionary    ${dict}    d    e
    log dictionary    ${dict}

    ## loop dictionary
    # v.1
    FOR    ${i}    IN    @{dict}
        # ได้ i เป็น key
        log    key = ${i}, item = ${dict}[${i}]
    END

    # v.2
    FOR    ${i}    IN    &{dict}
        # ได้ i เป็น tuple ('a', 100)
        log    i = ${i}
        log    key = ${i}, item = ${i}[1]
    END

    # v.3
    FOR    ${k}    ${v}    IN    &{dict}
        # เอาตัวแปรมารับ
        log    key = ${k}, item = ${v}
    END

    # v.4 เหมือน v.3 เลย แต่สามารถนำไปประยุกต์กับตัวอื่นได้
    FOR    ${k}    ${v}    IN ZIP    ${dict.keys()}    ${dict.values()}
        log    key = ${k}, item = ${v}
    END

TC0404 test nested structure
    # 2 dimensions list
    ${sublist1}=    create list    11    12    13    14
    ${sublist2}=    create list    21    22    23    24
    ${sublist3}=    create list    31    32    33    34
    ${sublist4}=    create list    41    42    43    44
    ${mainlist}=    create list    ${sublist1}    ${sublist2}    ${sublist3}    ${sublist4}
    log list    ${mainlist}
    log    ${mainlist}[3][2]
    # log    ${mainlist}[3][2] --> 43

    # dict of dict
    ${subdict1}=    create dictionary    a=11    b=12    c=13    d=14
    ${subdict2}=    create dictionary    a=21    b=22    c=23    d=24
    ${subdict3}=    create dictionary    a=31    b=32    c=33    d=34
    ${subdict4}=    create dictionary    a=41    b=42    c=43    d=44
    ${maindict}=    create dictionary    dict1=${subdict1}    dict2=${subdict2}    dict3=${subdict3}    dict4=${subdict4}
    log dictionary    ${maindict}
    log    ${maindict}[dict3][c]
    # log    ${maindict}[dict3][c] --> 33

    # hybrid
    ${subdict1}=    create dictionary    a=11    b=12    c=13    d=14
    ${subdict2}=    create dictionary    a=21    b=22    c=23    d=24
    ${subdict3}=    create dictionary    a=31    b=32    c=33    d=34
    ${subdict4}=    create dictionary    a=41    b=42    c=43    d=44
    ${sublist1}=    create list    100    200
    ${sublist2}=    create list    ${subdict3}    ${subdict4}
    ${maindict}=    create dictionary    item1=ITEM1    item2=${subdict1}    item3=${subdict2}    item4=${sublist1}    item5=${sublist2}
    log dictionary    ${maindict}
    ${pp}=    evaluate    pprint.pformat(${maindict})    modules=pprint
    log    ${pp}

    log    ${maindict}[item5][1][c]
    #log    ${maindict}[item5][1][c] --> subdict4 c = 43

TC_0405 test variables from YAML
    # include data.yaml file @ settings
    log    ${string}
    log    ${integer}
    log    ${list}[1]
    log    ${dict}[two]

TC_0406 test variable from command line
    # include ../resources/${env}/config.yaml @settings
    # -v env:SIT : พิมใน command line ตอนรัน
    log    ${env}
    log    username = ${username}