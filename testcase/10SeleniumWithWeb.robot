*** Settings ******
Library    SeleniumLibrary
Test Teardown    close browser

*** Test Cases ***
TC_1001 test web api
    open browser    https://www.saucedemo.com    chrome
    input text     user-name    standard_user
    input text     password    secret_sauce
    click element    login-button

    # select product
    ${products}=    create list    Sauce Labs Bike Light    Sauce Labs Bolt T-Shirt    Sauce Labs Onesie
    ${product_count}=    get length    ${products}
    
    Wait Until Element Is Visible    //div[text()='${products[0]}']
    FOR    ${p}    IN    @{products}
        click element    //div[text()='${p}']/../../..//button
    END
    ${badge no}=     get text    //span[@class='shopping_cart_badge']
    should be equal as integers    ${badge no}    ${product_count}
    click element    //a[@class='shopping_cart_link']
    # shopping cart
    wait until element is visible    //span[text()='Your Cart']
    FOR    ${p}    IN    @{products}
        page should contain element    //div[text()='${p}']
    END
    # check number of items in cart
    ${count}=    get element count    //div[@class='cart_item']
    should be equal as integers    ${count}    ${product_count}
    click element    checkout
    # information
    wait until element is enabled    //input[@id='first-name']
    input text    //input[@id='first-name']    xxxxxxx
    input text    //input[@id='last-name']    xxxxxxx
    input text    //input[@id='postal-code']    xxxxxxx
    click element    continue
    # overview
    wait until element is enabled    //button[@id='finish']
    ${no of items}=    get element count    //div[@class='inventory_item_price']
    ${sum price}=    set variable    0
    FOR    ${i}    IN RANGE    1    ${no of items}+1
        ${text}=    get text    (//div[@class='inventory_item_price'])[${i}]
        ${price}=    fetch from right    ${text}    $
        ${sum price}=    evaluate    ${sum price}+${price}
    END
    # validate price
    ${text}=    get text    //div[@class='summary_subtotal_label']
    ${price}=    fetch from right    ${text}    $
    should be equal as strings    ${price}    ${sum price}
    # validate tax
    ${expected tax}=    evaluate    round(${sum price}*0.08, 2)
    ${text}=    get text    //div[@class='summary_tax_label']
    ${tax}=    fetch from right    ${text}    $
    should be equal as strings    ${tax}    ${expected tax}
    # validate total price
    ${expected total}=    evaluate    ${sum price}+${expected tax}
    ${text}=    get text    //div[@class='summary_total_label']
    ${total}=    fetch from right    ${text}    $
    should be equal as strings    ${total}    ${expected total}
    click element    //button[@id='finish']
    wait until element is visible    //h2[text()='THANK YOU FOR YOUR ORDER']