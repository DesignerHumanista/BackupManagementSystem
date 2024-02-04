#We add the set of System.Windows.Forms
Add-Type -AssemblyName System.Windows.Forms

#Create main window
$mainForm = New-Object System.Windows.Forms.Form
$mainForm.Text = "Menu Options"
$mainForm.Size = New-Object System.Drawing.Size(1000, 535)
$mainForm.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#23214B")

#Create username box panel
$userNameBox = New-Object System.Windows.Forms.Panel
$userNameBox.Size = New-Object System.Drawing.Size(235, 75)
$userNameBox.Location = New-Object System.Drawing.Point(0, 0)  #Set the location to the left
$userNameBox.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#141536")

#Set user's name in the userNameBox
$login = New-Object System.Windows.Forms.Label
$login.Text = $env:COMPUTERNAME #Get current name of the user from environment variable
$login.ForeColor = [System.Drawing.Color]::White
$centerX = ($userNameBox.Width - $login.Width) / 2 #Get center of x axis
$centerY = ($userNameBox.Height - $login.Height) / 2 #Get center of y axis
$login.Location = New-Object System.Drawing.Point($centerX, $centerY) #Set label in the center
$login.Size = New-Object System.Drawing.Size(110, 30) #Set size of the whole box with label
$login.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Bold)  #Set size and font style
$userNameBox.Controls.Add($login)

#Create header panel
$header = New-Object System.Windows.Forms.Panel
$header.Size = New-Object System.Drawing.Size(765, 75) #We set width and height of the header
$header.Location = New-Object System.Drawing.Point($userNameBox.Width, 0)  #Set the location to the right of the username box
$header.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#191A3F")

#Add controls to the main form
$mainForm.Controls.Add($userNameBox)
$mainForm.Controls.Add($header)

#Add panel in which we have a menu with options
$sidePanel = New-Object System.Windows.Forms.Panel
$sidePanel.Dock = [System.Windows.Forms.DockStyle]::left #Set panel on the left side of the window
$sidePanel.Width = 235 
$mainForm.Controls.Add($sidePanel) # Add menu to form

#Create menu and set the background color
$menu = New-Object System.Windows.Forms.MenuStrip
$menu.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#1E1F45")

#Set margin at the top of the menu
$menu.Padding = New-Object System.Windows.Forms.Padding(0, 75, 0, 0)

#Function to create option buttons
function CreateDashboardBox()
{
    $option = New-Object System.Windows.Forms.ToolStripMenuItem
    $option.Text = "DASHBOARD"
    $option.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
    $option.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#141536")
    $option.Padding = New-Object System.Windows.Forms.Padding(0, 35, 0, 0)
    $menu.Items.Add($option) #Add option to menu, we use Items instead Controls
    return $option
}

function ClickSimplyBackup()
{
    $simplyBackupForm = New-Object Windows.Forms.Form
    $simplyBackupForm.Text = "Simply Backup"
    $simplyBackupForm.Size = New-Object Drawing.Size(500, 200)

    $labelSource = New-Object Windows.Forms.Label
    $labelSource.Text = "Source path:"
    $labelSource.Location = New-Object Drawing.Point(20, 20)
    $labelSource.Size = New-Object Drawing.Size(100, 30)
    $simplyBackupForm.Controls.Add($labelSource)

    $textBoxSource = New-Object Windows.Forms.TextBox
    $textBoxSource.Location = New-Object Drawing.Point(150, 20)
    $textBoxSource.Size = New-Object Drawing.Size(200, 20)
    $simplyBackupForm.Controls.Add($textBoxSource)

    $labelDestination = New-Object Windows.Forms.Label
    $labelDestination.Text = "Destination path:"
    $labelDestination.Location = New-Object Drawing.Point(20, 50)
    $labelDestination.Size = New-Object Drawing.Size(100, 30)
    $simplyBackupForm.Controls.Add($labelDestination)

    $textBoxDestination = New-Object Windows.Forms.TextBox
    $textBoxDestination.Location = New-Object Drawing.Point(150, 50)
    $textBoxDestination.Size = New-Object Drawing.Size(200, 20)
    $simplyBackupForm.Controls.Add($textBoxDestination)

    $buttonBrowseSource = New-Object Windows.Forms.Button
    $buttonBrowseSource.Text = "Browse"
    $buttonBrowseSource.Add_Click({
    $folderBrowser = New-Object Windows.Forms.FolderBrowserDialog

    $result = $folderBrowser.ShowDialog()

    if ($result -eq [Windows.Forms.DialogResult]::OK) 
    {
        $textBoxSource.Text = $folderBrowser.SelectedPath
    }

    })

    $buttonBrowseSource.Location = New-Object Drawing.Point(360, 20)
    $simplyBackupForm.Controls.Add($buttonBrowseSource)

    $buttonBrowseDestination = New-Object Windows.Forms.Button
    $buttonBrowseDestination.Text = "Browse"
    $buttonBrowseDestination.Add_Click({
    $folderBrowser = New-Object Windows.Forms.FolderBrowserDialog
    $result = $folderBrowser.ShowDialog()

    if ($result -eq [Windows.Forms.DialogResult]::OK) {
        $textBoxDestination.Text = $folderBrowser.SelectedPath
    }

    })

    $buttonBrowseDestination.Location = New-Object Drawing.Point(360, 50)
    $simplyBackupForm.Controls.Add($buttonBrowseDestination)

    $buttonBackup = New-Object Windows.Forms.Button
    $buttonBackup.Text = "Backup"
    $buttonBackup.Add_Click({
    $sourcePath = $textBoxSource.Text
    $destinationPath = $textBoxDestination.Text
    $backupFolder = Join-Path -Path $destinationPath -ChildPath (Get-Date -Format "yyyyMMddHHmmss")

    if (Test-Path $sourcePath -PathType Container) 
    {
        New-Item -ItemType Directory -Path $backupFolder | Out-Null
        Copy-Item -Path $sourcePath\* -Destination $backupFolder -Recurse
        [System.Windows.Forms.MessageBox]::Show("Backup was created in: $backupFolder", "Information")
    }
    else 
    {
        [System.Windows.Forms.MessageBox]::Show("Source path is not exist or is not right or is not a folder.", "Error", [Windows.Forms.MessageBoxButtons]::OK, [Windows.Forms.MessageBoxIcon]::Error)
    }

    })

    $buttonBackup.Location = New-Object Drawing.Point(20, 100)
    $simplyBackupForm.Controls.Add($buttonBackup)

    $simplyBackupForm.ShowDialog()
}

#Function to create option buttons with optional onClick activity
function CreateButton($optionText, [ScriptBlock]$onClick = $null)
{
    $option = New-Object System.Windows.Forms.ToolStripMenuItem
    $option.Text = $optionText
    $option.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
    $option.Padding = New-Object System.Windows.Forms.Padding(0, 35, 0, 0) # We set button more height
    $option.Add_Click($onClick)  #Assign the click event
    $menu.Items.Add($option) #Add option to menu, we use Items instead Controls

    return $option
}

#Function to create delete button
function CreateDeleteButton($optionText, $buttonEnabled)
{
    $option = New-Object System.Windows.Forms.ToolStripMenuItem
    $option.Text = $optionText
    $option.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
    $option.Padding = New-Object System.Windows.Forms.Padding(0, 62, 0, 0) #Set text padding to grow our button
    $option.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#BD1616")
    $menu.Items.Add($option) #Add option to menu, we use Items instead Controls
    return $option
}

$dashboard = CreateDashboardBox
$simplyBackup = CreateButton "Simply Backup" { ClickSimplyBackup }
$encryptedBackup = CreateButton "..."
$cloud = CreateButton "..."
$reports = CreateButton "..."
$delLastBackup = CreateDeleteButton "..."

#Set orientation of the menu on vertical
$menu.LayoutStyle = [System.Windows.Forms.ToolStripLayoutStyle]::VerticalStackWithOverflow

#Add menu to sidePanel 
$sidePanel.Controls.Add($menu)

#Show the main form
$mainForm.ShowDialog()
