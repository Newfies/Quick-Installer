# This is a template idea

Add-Type -AssemblyName System.Windows.Forms

# Create the form
$form = New-Object System.Windows.Forms.Form
$form.Text = 'Select Programs to Install'
$form.Size = New-Object System.Drawing.Size(300, 250)
$form.StartPosition = 'CenterScreen'

# Create a checkbox for Program 1
$checkbox1 = New-Object System.Windows.Forms.CheckBox
$checkbox1.Text = "Program 1"
$checkbox1.Location = New-Object System.Drawing.Point(20, 20)
$form.Controls.Add($checkbox1)

# Create a checkbox for Program 2
$checkbox2 = New-Object System.Windows.Forms.CheckBox
$checkbox2.Text = "Program 2"
$checkbox2.Location = New-Object System.Drawing.Point(20, 60)
$form.Controls.Add($checkbox2)

# Create a checkbox for Program 3
$checkbox3 = New-Object System.Windows.Forms.CheckBox
$checkbox3.Text = "Program 3"
$checkbox3.Location = New-Object System.Drawing.Point(20, 100)
$form.Controls.Add($checkbox3)

# Create a Confirm button
$button = New-Object System.Windows.Forms.Button
$button.Text = "Confirm"
$button.Location = New-Object System.Drawing.Point(20, 140)
$button.Size = New-Object System.Drawing.Size(75, 23)

# Define the button click action
$button.Add_Click({
    # Array to store programs selected by user
    $selectedPrograms = @()

    if ($checkbox1.Checked) {
        $selectedPrograms += "Program 1"
    }
    if ($checkbox2.Checked) {
        $selectedPrograms += "Program 2"
    }
    if ($checkbox3.Checked) {
        $selectedPrograms += "Program 3"
    }

    # Display message with selected programs
    if ($selectedPrograms.Count -gt 0) {
        [System.Windows.Forms.MessageBox]::Show("You selected: " + ($selectedPrograms -join ", "), "Programs Selected")
        # Here, you can start the download process for selected programs
        foreach ($program in $selectedPrograms) {
            # Call the download function for each selected program
            Start-DownloadProcess $program
        }
    } else {
        [System.Windows.Forms.MessageBox]::Show("No programs selected!", "Error")
    }
    $form.Close()
})

$form.Controls.Add($button)

# Function to download selected program (example)
function Start-DownloadProcess {
    param($program)
    switch ($program) {
        "Program 1" {
            $url = "https://example.com/program1.exe"
            $path = "$env:TEMP\program1.exe"
        }
        "Program 2" {
            $url = "https://example.com/program2.exe"
            $path = "$env:TEMP\program2.exe"
        }
        "Program 3" {
            $url = "https://example.com/program3.exe"
            $path = "$env:TEMP\program3.exe"
        }
        default {
            return
        }
    }

    # Download the program
    Invoke-WebRequest -Uri $url -OutFile $path
    # Run the installer silently (if applicable)
    Start-Process -FilePath $path -ArgumentList "/silent" -Wait
    # Clean up by removing the installer
    Remove-Item -Path $path
}

# Show the form
$form.ShowDialog()
