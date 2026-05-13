*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}        https://pk-movie-hub.vercel.app/
${BROWSER}    headlesschrome

*** Test Cases ***
Verify PK Movie Hub Homepage Loads Successfully
    [Documentation]    ทดสอบว่าหน้าแรกโหลดขึ้นมาและมีหัวข้อหลักครบถ้วน
    Open Browser    ${URL}    ${BROWSER}
    Set Window Size    1920    1080
    Wait Until Page Contains Element    xpath=//h1[contains(text(), 'My Personal Series Collection')]    timeout=10s
    Page Should Contain Element    xpath=//button[contains(text(), "LET'S STARTED")]

Navigate To Collection Page
    [Documentation]    ทดสอบการกดปุ่ม LET'S STARTED เพื่อเข้าสู่หน้า Collection
    Click Element    xpath=//button[contains(text(), "LET'S STARTED")]
    Wait Until Page Contains Element    xpath=//div[contains(@class, 'collection-container')]    timeout=10s
    Wait Until Page Contains Element    xpath=//a[contains(text(), "PK'FLIX")]    timeout=10s
    Page Should Contain Element    xpath=//button[contains(@class, 'category-btn') and contains(text(), 'Series')]
    [Teardown]    Close Browser