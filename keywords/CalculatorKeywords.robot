*** Keywords ***
do subtraction
    [arguments]    ${x}    ${y}
    ${result}=    evaluate    ${x} - ${y}
    return from keyword    ${result}