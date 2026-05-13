*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}        https://pk-movie-hub.vercel.app/
${BROWSER}    headlesschrome

*** Test Cases ***
Verify PK Movie Hub Full Flow
    [Documentation]    ตรวจสอบหน้าแรกและโครงสร้างตาราง Ranking ในหน้า Collection
    Open Browser    ${URL}    ${BROWSER}
    Set Window Size    1440    2500    # ตั้งความยาวหน้าจอให้ครอบคลุมเนื้อหาทั้งหมด
    
    # --- STEP 1: หน้าแรก ---
    Wait Until Page Contains    My Personal Series Collection    timeout=30s
    Capture Page Screenshot    qa-reports/latest_homepage.png

    # --- STEP 2: เข้าหน้า Collection ---
    Click Element    xpath=//button[contains(text(), "LET'S STARTED")]
    Wait Until Page Contains    PK'FLIX    timeout=30s
    
    # --- STEP 3: เช็คโครงสร้าง Ranking (Table/List) ---
    # เลื่อนไปที่ส่วน Ranking
    Scroll Element Into View    class:tier-title
    Wait Until Element Is Visible    class:ranking-list    timeout=15s
    
    # ตรวจสอบว่ามี Ranking Card อย่างน้อย 10 ใบ (เช็คความครบถ้วนของข้อมูล)
    Page Should Contain Element    xpath=//div[contains(@class, 'ranking-card')]    limit=10
    
    # ตรวจสอบโครงสร้างภายใน Card อันดับ 1 (ต้องมีเลข Rank, ชื่อเรื่อง, และเรตติ้ง)
    Element Should Contain    xpath=//div[contains(@class, 'ranking-card')][1]    #1
    Element Should Contain    xpath=//div[contains(@class, 'ranking-card')][1]    Twinkling Watermelon
    Element Should Contain    xpath=//div[contains(@class, 'ranking-card')][1]    10.0
    
    # --- STEP 4: เก็บภาพผลลัพธ์ ---
    Capture Page Screenshot    qa-reports/latest_ranking_structure.png
    
    [Teardown]    Close Browser