*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${APP_URL}      https://channadeshan.github.io/robot-test-project/swag_labs.html
${BROWSER}      Chrome
@{MY_SHOPPING_LIST}    1    3    4 
@{remove_index}    1    2 

*** Test Cases ***
Test Product Purchase Journey
    Open Browser To Login Page
    Enter Credentials    standard_user        secret_sauce
    Add Multiple Items To My Cart    ${MY_SHOPPING_LIST}
    Checking Out Products    ${remove_index}
    Close Browser
    

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${APP_URL}    ${BROWSER}

Enter Credentials
    [Arguments]    ${username}    ${password}
    Sleep    1s
    Input Text    id=username    ${username}
    Sleep    1s
    Input Text    id=password    ${password}
    Sleep    2s
    Click Button    id=login-button

Add Multiple Items To My Cart
    [Arguments]   ${products}
    Sleep    2s
    FOR    ${item}    IN    @{products}
        Add Product To Cart    ${item}
        Sleep    3s
    END

Add Product To Cart 
    [Arguments]    ${product_index}
    ${my_xpath}=    Set Variable    xpath=//*[@id="products-grid"]//div[${product_index}]//button
    Wait Until Element Is Visible    ${my_xpath}    10s
    Click Button  ${my_xpath}

Checking Out Products
    [Arguments]    ${remove_index}
    Sleep    2s
    Click Element  xpath=//*[@id="product-page"]//div[1]//div//div
    Sleep    1s
    FOR    ${item}    IN    @{remove_index}
        Click Button  xpath=(//*[@id="cart-items"]/div/button)[${item}]
        Sleep    1.5s
    END
    Input Text    id=first-name    Channa
    Sleep    1s
    Input Text    id=last-name     Perera
    Sleep    1s
    Input Text    id=postal-code   50100
    Sleep    1s
    Click Button  xpath=//*[@id="checkout-page"]/div[2]/button
    Sleep    3s


    


