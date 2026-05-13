*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}        https://pk-movie-hub.vercel.app/
${BROWSER}    headlesschrome

*** Test Cases ***
Verify Homepage and Check Top 10
    [Documentation]    เช็คหน้าแรกและตรวจสอบส่วนของ Top 10 Ranking
    Open Browser    ${URL}    ${BROWSER}
    Set Window Size    1920    2000    # ขยายหน้าจอให้ยาวขึ้นเพื่อเห็น Ranking
    
    # เช็คหัวข้อหน้าแรก
    Wait Until Page Contains Element    xpath=//h1[contains(text(), 'My Personal Series Collection')]    timeout=15s
    Capture Page Screenshot    qa-reports/latest_homepage.png

    # กดปุ่มเข้าหน้า Collection
    Click Element    xpath=//button[contains(text(), "LET'S STARTED")]
    Wait Until Page Contains    PK'FLIX    timeout=15s

    # เลื่อนลงไปหา Ranking และเช็คว่ามี Rank #1 โชว์ไหม
    Scroll Element Into View    xpath=//h2[contains(text(), 'PK Top 10 Ranking')]
    Wait Until Page Contains Element    xpath=//span[contains(text(), '#1')]    timeout=10s
    
    # เช็คว่าเรื่องที่ติดอันดับ 1 คือ Twinkling Watermelon หรือไม่ (ตามข้อมูลที่คุณให้มา)
    Element Should Contain    xpath=//div[contains(@class, 'ranking-card')][1]    Twinkling Watermelon
    
    # บันทึกภาพล่าสุดของ Ranking ไว้ (จะบันทึกทับชื่อเดิมเสมอ ไม่รก)
    Capture Page Screenshot    qa-reports/latest_ranking.png
    
    [Teardown]    Close Browser