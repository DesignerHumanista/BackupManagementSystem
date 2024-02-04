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
$userNameBox.Location = New-Object System.Drawing.Point(0, 0)  # Set the location to the left
$userNameBox.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#141536")

#Create header panel
$header = New-Object System.Windows.Forms.Panel
$header.Size = New-Object System.Drawing.Size(765, 75) #We set width and height of header
$header.Location = New-Object System.Drawing.Point($userNameBox.Width, 0)  # Set the location to the right of the username box
$header.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#191A3F")

#Add controls to the main form
$mainForm.Controls.Add($userNameBox)
$mainForm.Controls.Add($header)

#Add panel in which we have menu with options
$sidePanel = New-Object System.Windows.Forms.Panel
$sidePanel.Dock = [System.Windows.Forms.DockStyle]::left #Set panel on the left side of window
$sidePanel.Width = 235 
$mainForm.Controls.Add($sidePanel) #Add menu to form

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

#Function to create option buttons
function CreateButton($optionText)
{
    $option = New-Object System.Windows.Forms.ToolStripMenuItem
    $option.Text = $optionText
    $option.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
    $option.Padding = New-Object System.Windows.Forms.Padding(0, 35, 0, 0) #We set button more height
    $menu.Items.Add($option) #Add option to menu, we use Items instead Controls
    return $option
}

#Function to create delete button
function CreateDeleteButton($optionText)
{
    $option = New-Object System.Windows.Forms.ToolStripMenuItem
    $option.Text = $optionText
    $option.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
    $option.Padding = New-Object System.Windows.Forms.Padding(0, 62, 0, 0) #Set text padding to grow our button
    $option.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#BD1616")
    $menu.Items.Add($option) #Add option to menu, we use Items instead Controls
    return $option
}


$dashboard = CreateDashboardBox("DASHBOARD")
$simplyBackup = CreateButton("Simply Backup")
$encryptedBackup = CreateButton("Backup Schedule")
$cloud = CreateButton("Cloud")
$reports = CreateButton("Reports")
$delLastBackup = CreateDeleteButton("Delete Last Backup")

#Set orientation of the menu on vertical
$menu.LayoutStyle = [System.Windows.Forms.ToolStripLayoutStyle]::VerticalStackWithOverflow

#Add menu to sidePanel 
$sidePanel.Controls.Add($menu)

#Show the main form
$mainForm.ShowDialog()