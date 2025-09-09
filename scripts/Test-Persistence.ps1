# 永続化メカニズムシミュレーションスクリプト
# このスクリプトは、実際の悪意のあるアクティビティを実行するものではなく、
# Microsoft Defender for Serversのアラートをトリガーするためのテスト用です。

Write-Host "永続化メカニズムシミュレーションを開始します..." -ForegroundColor Yellow

# 一般的な永続化レジストリキーのシミュレーション
Write-Host "レジストリ永続化のシミュレーション中..." -ForegroundColor Cyan
$registryPersistencePaths = @(
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run",
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnce",
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run",
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders\Startup"
)

foreach ($path in $registryPersistencePaths) {
    $testPath = $path -replace "HKCU:", "HKCU:\Software\TestPersistence"
    if (-not (Test-Path $testPath)) {
        New-Item -Path $testPath -Force | Out-Null
    }
    
    New-ItemProperty -Path $testPath -Name "TestPersistenceSimulation" -Value "cmd.exe /c echo 'This is a persistence test'" -PropertyType String -Force | Out-Null
    Write-Host "テストレジストリパスを作成しました: $testPath" -ForegroundColor Cyan
}

# スタートアップフォルダ永続化のシミュレーション
Write-Host "スタートアップフォルダ永続化のシミュレーション中..." -ForegroundColor Cyan
$startupFolder = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"
$testStartupBatPath = "$startupFolder\test_persistence.txt"
"このファイルはテスト用です。実際のマルウェアではありません。" | Out-File -FilePath $testStartupBatPath
Write-Host "テストスタートアップファイルを作成しました: $testStartupBatPath" -ForegroundColor Cyan

# スケジュールタスク永続化のシミュレーション
Write-Host "スケジュールタスク永続化のシミュレーション中..." -ForegroundColor Cyan
$taskName = "TestPersistenceTask"
$taskCommands = @(
    "schtasks /create /tn `"$taskName`" /tr `"cmd.exe /c echo Test`" /sc daily /st 12:00",
    "schtasks /query /tn `"$taskName`""
)

foreach ($cmd in $taskCommands) {
    Write-Host "[偽のスケジュールタスク] > $cmd" -ForegroundColor DarkYellow
    Start-Sleep -Seconds 2
}

# WMI永続化のシミュレーション
Write-Host "WMI永続化のシミュレーション中..." -ForegroundColor Cyan
$wmiCommands = @(
    "wmic /NAMESPACE:\\\\root\\subscription PATH __EventFilter CREATE Name=`"TestFilter`", EventNameSpace=`"root\\cimv2`", QueryLanguage=`"WQL`", Query=`"SELECT * FROM __InstanceModificationEvent WITHIN 60 WHERE TargetInstance ISA 'Win32_PerfFormattedData_PerfOS_System'`"",
    "wmic /NAMESPACE:\\\\root\\subscription PATH CommandLineEventConsumer CREATE Name=`"TestConsumer`", ExecutablePath=`"C:\\Windows\\System32\\cmd.exe`", CommandLineTemplate=`"cmd.exe /c echo Test`""
)

foreach ($cmd in $wmiCommands) {
    Write-Host "[偽のWMI永続化] > $cmd" -ForegroundColor DarkYellow
    Start-Sleep -Seconds 2
}

# サービス永続化のシミュレーション
Write-Host "サービス永続化のシミュレーション中..." -ForegroundColor Cyan
$serviceCommands = @(
    "sc create TestPersistenceService binpath= `"cmd.exe /c echo Test`" start= auto",
    "sc query TestPersistenceService"
)

foreach ($cmd in $serviceCommands) {
    Write-Host "[偽のサービス永続化] > $cmd" -ForegroundColor DarkYellow
    Start-Sleep -Seconds 2
}

# クリーンアップ
$registryPersistencePaths | ForEach-Object {
    $testPath = $_ -replace "HKCU:", "HKCU:\Software\TestPersistence"
    if (Test-Path $testPath) {
        Remove-Item -Path $testPath -Recurse -Force
    }
}

if (Test-Path $testStartupBatPath) {
    Remove-Item -Path $testStartupBatPath -Force
}

Write-Host "永続化メカニズムシミュレーションが完了しました。Microsoft Defender for Serversのアラートが発生するはずです。" -ForegroundColor Green
Write-Host "注意: アラートが表示されるまでに15〜30分かかる場合があります。" -ForegroundColor Yellow
