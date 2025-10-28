# 権限昇格シミュレーションスクリプト
# このスクリプトは、実際の悪意のあるアクティビティを実行するものではなく、
# Microsoft Defender for Serversのアラートをトリガーするためのテスト用です。

Write-Host "権限昇格シミュレーションを開始します..." -ForegroundColor Yellow

# UACバイパスのシミュレーション
Write-Host "UACバイパスのシミュレーション中..." -ForegroundColor Cyan
$uacBypassCommands = @(
    "eventvwr.exe",
    "fodhelper.exe",
    "computerdefaults.exe"
)

foreach ($cmd in $uacBypassCommands) {
    Write-Host "[偽のUACバイパス] > $cmd" -ForegroundColor DarkYellow
    Start-Sleep -Seconds 2
}

# レジストリ操作のシミュレーション
Write-Host "特権昇格のためのレジストリ操作をシミュレーション中..." -ForegroundColor Cyan
$registryPaths = @(
    "HKCU:\Software\Classes\ms-settings\Shell\Open\Command",
    "HKCU:\Software\Classes\mscfile\Shell\Open\Command",
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"
)

foreach ($path in $registryPaths) {
    $testPath = $path -replace "HKCU:", "HKCU:\Software\TestPrivEsc"
    if (-not (Test-Path $testPath)) {
        New-Item -Path $testPath -Force | Out-Null
    }
    
    New-ItemProperty -Path $testPath -Name "TestPrivEscSimulation" -Value "cmd.exe /c echo 'This is a test'" -PropertyType String -Force | Out-Null
    Write-Host "テストレジストリパスを作成しました: $testPath" -ForegroundColor Cyan
}

# シミュレーション用の実行プロセス
Write-Host "特権コマンドの実行をシミュレーション中..." -ForegroundColor Cyan
$privilegedCommands = @(
    "net localgroup administrators",
    "net user administrator /active:yes",
    "reg query HKU\S-1-5-19"
)

foreach ($cmd in $privilegedCommands) {
    Write-Host "[偽の特権コマンド] > $cmd" -ForegroundColor DarkYellow
    Start-Sleep -Seconds 1
}

# クリーンアップ
$registryPaths | ForEach-Object {
    $testPath = $_ -replace "HKCU:", "HKCU:\Software\TestPrivEsc"
    if (Test-Path $testPath) {
        Remove-Item -Path $testPath -Recurse -Force
    }
}

Write-Host "権限昇格シミュレーションが完了しました。Microsoft Defender for Serversのアラートが発生するはずです。" -ForegroundColor Green
Write-Host "注意: アラートが表示されるまでに15〜30分かかる場合があります。" -ForegroundColor Yellow
