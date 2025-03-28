Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# App List (App Name, Official Link, Backup Link)
$apps = @(
    @{ Name = "VSCodium"; Official = "https://github.com/VSCodium/vscodium/releases/download/1.98.2.25078/VSCodiumUserSetup-x64-1.98.2.25078.exe"; Backup = "https://qi.gs.is-a.dev/Installers/VSCodium.exe" },
    @{ Name = "Brave Browser"; Official = ""; Backup = "https://qi.gs.is-a.dev/Installers/Brave.exe" },
    @{ Name = "Audacity"; Official = ""; Backup = "https://qi.gs.is-a.dev/Installers/" },
    @{ Name = "WaterFox"; Official = ""; Backup = "https://qi.gs.is-a.dev/Installers/" },
    @{ Name = "Wireshark"; Official = ""; Backup = "https://qi.gs.is-a.dev/Installers/" },
    @{ Name = "GIMP"; Official = ""; Backup = "https://qi.gs.is-a.dev/Installers/" },
    @{ Name = "GitHub Desktop"; Official = ""; Backup = "https://qi.gs.is-a.dev/Installers/" },
    @{ Name = "Git"; Official = ""; Backup = "https://qi.gs.is-a.dev/Installers/Git.exe" },
    @{ Name = "Git LFS"; Official = ""; Backup = "https://qi.gs.is-a.dev/Installers/GitLFS.exe" },
    @{ Name = "Python 3"; Official = "x"; Backup = "https://qi.gs.is-a.dev/Installers/Python3.exe" },
    @{ Name = "Python 2"; Official = ""; Backup = "https://qi.gs.is-a.dev/Installers/" },
    @{ Name = "Node"; Official = ""; Backup = "https://qi.gs.is-a.dev/Installers/Node.msi" },
    @{ Name = "PeaZip"; Official = "https://github.com/peazip/PeaZip/releases/download/10.3.0/peazip-10.3.0.WIN64.exe"; Backup = "https://qi.gs.is-a.dev/Installers/Peazip.exe" },
    @{ Name = "Signal"; Official = ""; Backup = "https://qi.gs.is-a.dev/Installers/" },
    @{ Name = "VeraCrypt"; Official = ""; Backup = "https://qi.gs.is-a.dev/Installers/VeraCrypt.exe" },
    @{ Name = "Steam"; Official = ""; Backup = "https://qi.gs.is-a.dev/" },
    @{ Name = "CloseAll"; Official = ""; Backup = "https://qi.gs.is-a.dev/Installers/CloseAll.exe" },
    @{ Name = "Everything"; Official = ""; Backup = "https://qi.gs.is-a.dev/Installers/Everything.exe" },
    @{ Name = "NoIP"; Official = ""; Backup = "https://qi.gs.is-a.dev/Installers/NoIP.exe" },
    @{ Name = "Discord"; Official = ""; Backup = "https://example.com/unfinished.exe" },
    @{ Name = "BitDefender"; Official = ""; Backup = "https://example.com/unfinished.exe" },
    @{ Name = "Malwarebytes"; Official = ""; Backup = "https://example.com/unfinished.exe" },
    @{ Name = "HWMonitor"; Official = ""; Backup = "https://qi.gs.is-a.dev/Installers/HWMonitor.exe" },
    @{ Name = "ShareX"; Official = ""; Backup = "https://qi.gs.is-a.dev/Installers/ShareX.exe" }
)

# GUI Window
$form = New-Object System.Windows.Forms.Form
$form.Text = "Quick Installer"
$form.Size = New-Object System.Drawing.Size(500,600)
$form.StartPosition = "CenterScreen"

# Scrollable Panel
$panel = New-Object System.Windows.Forms.Panel
$panel.Size = New-Object System.Drawing.Size(480, 500)
$panel.Location = New-Object System.Drawing.Point(10, 10)
$panel.AutoScroll = $true
$form.Controls.Add($panel)

# Install Button
$installButton = New-Object System.Windows.Forms.Button
$installButton.Text = "Install Selected"
$installButton.Size = New-Object System.Drawing.Size(150, 30)
$installButton.Location = New-Object System.Drawing.Point(175, 520)
$form.Controls.Add($installButton)

# UI Elements Storage
$selections = @{}

# Generate App List
$yPos = 10
foreach ($app in $apps) {
    $groupBox = New-Object System.Windows.Forms.GroupBox
    $groupBox.Text = $app.Name
    $groupBox.Size = New-Object System.Drawing.Size(450, 50)
    $groupBox.Location = New-Object System.Drawing.Point(10, $yPos)

    # Create Radio Buttons
    $radioPrimary = New-Object System.Windows.Forms.RadioButton
    $radioPrimary.Text = "Primary"
    $radioPrimary.Location = New-Object System.Drawing.Point(10, 20)
    $radioPrimary.Checked = $false

    $radioBackup = New-Object System.Windows.Forms.RadioButton
    $radioBackup.Text = "Backup"
    $radioBackup.Location = New-Object System.Drawing.Point(100, 20)
    $radioBackup.Checked = $false

    $radioNone = New-Object System.Windows.Forms.RadioButton
    $radioNone.Text = "None"
    $radioNone.Location = New-Object System.Drawing.Point(200, 20)
    $radioNone.Checked = $true

    $groupBox.Controls.Add($radioPrimary)
    $groupBox.Controls.Add($radioBackup)
    $groupBox.Controls.Add($radioNone)
    $panel.Controls.Add($groupBox)

    # Store selections
    $selections[$app.Name] = @{ Primary = $radioPrimary; Backup = $radioBackup; None = $radioNone }

    $yPos += 60
}

# Install Button Click Event
$installButton.Add_Click({
    foreach ($app in $apps) {
        $selected = $selections[$app.Name]
        
        if ($selected.Primary.Checked) {
            $url = if ($app.Official -match "\.exe$|\.msi$") { $app.Official } else { "https://example.com/unfinished.exe" }
        } elseif ($selected.Backup.Checked) {
            $url = if ($app.Backup -match "\.exe$|\.msi$") { $app.Backup } else { "https://example.com/unfinished.exe" }
        } else {
            continue
        }

        Write-Host "Downloading: $app.Name from $url"
        Start-Process "cmd.exe" -ArgumentList "/c start $url"
    }
})

# Run Form
$form.ShowDialog()
