*** Settings ***

Library     SeleniumLibrary
Documentation       Suite description   #automated tests for scouts panel

*** Variables ***
${LOGIN URL}        https://scouts-test.futbolkolektyw.pl/en
${BROWSER}      Chrome
${SIGN IN BUTTON}       xpath=//button[@type='submit']
${EMAILINPUT}       xpath=//input[@name='login']
${PASSWORDINPUT}        xpath=//input[@id='password']
${PAGELOGO}     xpath=//*[@id="__next"]/div[1]/header/div/h6
${REMINDPASSWORD}       xpath=//*[@id="__next"]/form/div/div[1]/a
${SIGN OUT BUTTON}      xpath=//*span[text()='Sign out']
${LANGUAGE BUTTON}      xpath=//div[@role='button']
${LIST DROPDOWN}        xpath=//ul[@role='listbox']
${POLISH LANGUAGE}      xpath=//li[@data-value='pl']

*** Test Cases ***
Login to the system
    Open login page
    Type in email
    Type in password
    Click on the submit button
    Assert dashboard
    [Teardown]  Close Browser

Check the title
    Open browser       ${LOGIN URL}  ${BROWSER}
    Title Should Be     Scouts panel - sign in
    [Teardown]  Close Browser

Test wrong credentials
     Open login page
     Type in wrong email
     Type in wrong password
     Click on the submit button
     Assert remind password
     [Teardown]  Close Browser

Test remind password
    Open login page
    Type in wrong email
    Type in wrong password
    Click on the submit button
    Click on the remind password button
    [Teardown]  Close Browser

Test sign out
    Open login page
    Type in email
    Type in password
    Click on the submit button
    [Teardown]  Close Browser

Test change the lenguage
    Open login page
    Click on the language button
    Assert change language
    [Teardown]  Close Browser







*** Keywords ***

 Open login page
    Open browser       ${LOGIN URL}  ${BROWSER}
    Title Should Be     Scouts panel - sign in
 Type in email
     Input Text     ${EMAILINPUT}  user01@getnada.com
 Type in password
     Input Text     ${PASSWORDINPUT}  Test-1234
 Click on the submit button
     Click Element  ${SIGN IN BUTTON}
 Assert dashboard
     wait until element is visible  ${PAGE LOGO}
     Title Should Be  Scouts panel
     Capture Page Screenshot  alert.png
 Type in wrong email
      Input Text     ${EMAILINPUT}  user@getnada.com
 Type in wrong password
      Input Text     ${PASSWORDINPUT}  Test-12345
 Assert remind password
     wait until element is visible      ${REMINDPASSWORD}
     Page Should Contain     Remind password
     Capture Page Screenshot  alert.png
 Click on the remind password button
     Wait Until Element Is Visible    ${REMINDPASSWORD}
     Click Element    ${REMINDPASSWORD}
     Title Should Be    Remind password
 Sign out from the page
     Title Should Be  Scouts panel
     Click Element   ${SIGN OUT BUTTON}
     Wait Until Element Is Visible   ${SIGN IN BUTTON}
 Click on the language button
     Click Element  ${LANGUAGE BUTTON}
     Wait Until Element Is Visible    ${LIST DROPDOWN}
     Click Element    ${POLISH LANGUAGE}
 Assert change language
     Wait Until Element Is Visible    ${REMINDPASSWORD}
     Page Should Contain    Przypomnij hasło
     Capture Page Screenshot  alert1.png

