# プロセスインジェクションシミュレーションスクリプト
# このスクリプトは、実際の悪意のあるアクティビティを実行するものではなく、
# Microsoft Defender for Serversのアラートをトリガーするためのテスト用です。
# 
# 【Defender のアラート発生条件と想定される動作について】
# このスクリプトは、プロセスインジェクションに関連するAPIコールやコマンドのシミュレーションを行い、
# Defender for Servers が疑わしい挙動を検知してアラートを発生させることを目的としています。
# 実際に悪意のあるコードやインジェクションは行われません。
# アラートは通常、スクリプト実行後15〜30分以内にMicrosoft Defender セキュリティセンターで表示されます。
# 環境や設定によってはアラートが発生しない場合もありますので、事前にDefenderのポリシーや監視設定をご確認ください。

Write-Host "プロセスインジェクションシミュレーションを開始します..." -ForegroundColor Yellow

# プロセスインジェクション関連の疑わしいAPIコールのシミュレーション
Write-Host "プロセスインジェクション関連APIのシミュレーション中..." -ForegroundColor Cyan
$apiCalls = @(
    'VirtualAllocEx',
    'WriteProcessMemory',
    'CreateRemoteThread',
    'NtMapViewOfSection',
    'QueueUserAPC'
)

foreach ($api in $apiCalls) {
    Write-Host "[偽のAPIコール] > $api" -ForegroundColor DarkYellow
    Start-Sleep -Seconds 1
}

# 通常のプロセスへのアクセスのシミュレーション
Write-Host "通常プロセスへのアクセスをシミュレーション中..." -ForegroundColor Cyan
$targetProcesses = @(
    'explorer',
    'svchost',
    'spoolsv'
)

foreach ($procName in $targetProcesses) {
    $process = Get-Process -Name $procName -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($process) {
        Write-Host "ターゲットプロセス: $procName (PID: $($process.Id))" -ForegroundColor DarkYellow
        Write-Host '[偽のインジェクション] プロセスの列挙のみを実行。実際のインジェクションは行いません。' -ForegroundColor DarkYellow
    }
    else {
        Write-Host "プロセス '$procName' は存在しません。" -ForegroundColor Red
    }
}

# 疑わしいコード実行パターンのシミュレーション
Write-Host "疑わしいコード実行パターンをシミュレーション中..." -ForegroundColor Cyan
$suspiciousCommands = @(
    'rundll32.exe shell32.dll,Control_RunDLL',
    'regsvr32 /s /u /i:test.sct scrobj.dll',
    'cmd.exe /c echo "MSHTA Process Injection Test"'
)

foreach ($cmd in $suspiciousCommands) {
    Write-Host "[偽のコマンド] > $cmd" -ForegroundColor DarkYellow
    Start-Sleep -Seconds 2
}

# シェルコードのシミュレーション
Write-Host "シェルコードのシミュレーション中..." -ForegroundColor Cyan
# $testShellcode は実際の悪意あるシェルコードではなく、Defenderの検知テスト用のダミーデータです。
$testShellcode = 'FC4883E4F0E8C000000041514150525156'
Write-Host "[偽のシェルコード] $testShellcode..." -ForegroundColor DarkYellow

Write-Host "プロセスインジェクションシミュレーションが完了しました。Microsoft Defender for Serversのアラートが発生するはずです。" -ForegroundColor Green
Write-Host "注意: アラートが表示されるまでに15〜30分かかる場合があります。" -ForegroundColor Yellow
