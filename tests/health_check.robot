*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}        https://pk-movie-hub.vercel.app/
${BROWSER}    headlesschrome

*** Test Cases ***
Verify Homepage and Check Top 10
    [Documentation]    เช็คหน้าแรกและตรวจสอบส่วนของ Top 10 Ranking
    Open Browser    ${URL}    ${BROWSER}
    Set Window Size    1920    2000
    
    # 1. เช็คหน้าแรก (เพิ่มการรอ)
    Wait Until Page Contains    My Personal Series Collection    timeout=20s
    Capture Page Screenshot    qa-reports/latest_homepage.png

    # 2. กดเข้าหน้า Collection
    Click Element    xpath=//button[contains(text(), "LET'S STARTED")]
    
    # 3. รอให้หน้า Collection โหลด (เช็คคำว่า Series หรือ PK'FLIX)
    Wait Until Page Contains    PK'FLIX    timeout=20s
    Sleep    3s    # ให้เวลา JavaScript เรนเดอร์ข้อมูลจาก Supabase แป๊บนึงครับ
    
    # 4. บันทึกภาพ Ranking (เซฟไว้ก่อนเลย เผื่อหาตัวอักษรไม่เจอ จะได้มีไฟล์ภาพไป Commit)
    Capture Page Screenshot    qa-reports/latest_ranking.png

    # 5. ตรวจสอบเนื้อหา (ถ้าพังตรงนี้ บอทจะหยุด แต่เราได้ภาพจากข้อ 4 แล้ว)
    Page Should Contain    PK Top 10 Ranking
    Page Should Contain    Twinkling Watermelon
    
    [Teardown]    Close Browser
