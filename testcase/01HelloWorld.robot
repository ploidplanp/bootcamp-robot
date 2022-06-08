*** Variables ***
# no need to use 'set variable' in Variables
${old friend}    James

*** Test Cases ***
TC_0101 test hello world
    [tags]    regression    sprint1
    log    hello world

TC_0102 test hello to friend
    [tags]    regression    sprint2
    say hello to    David

TC_0103 test get my friend
    [tags]    sprint1
    ${my friend1}    ${my friend2}    ${my friend3}=    get my friend
    log    hello my friend, ${my friend1}, ${my friend2} and ${my friend3}

TC_0104 test say hello to friends
    [tags]    sprint2
    say hello to my friends    John    David    Max
    say hello to my friends    John    David
    say hello to my friends    John    David    Thomas
    say hello to my friends    friend2=John    friend3=David    friend1=Thomas
    # กฎทางขวา
    

*** Keywords ***
say hello to
    [arguments]    ${friend}
    log    hello my friend, ${friend}

get my friend
    ${friend}=    set variable    John
    return from keyword    ${friend}    David    ${old friend}
    # or
    # [return]    ${friend}    David    ${old friend}

say hello to my friends
    [arguments]    ${friend1}    ${friend2}    ${friend3}=Mary
    log    hello my friend, ${friend1}, ${friend2} and ${friend3}