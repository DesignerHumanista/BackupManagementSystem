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
$userNameBox.BackColor = "Black"
$userNameBox.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#141536")

#Create header panel
$header = New-Object System.Windows.Forms.Panel
$header.Size = New-Object System.Drawing.Size(765, 75)
$header.Location = New-Object System.Drawing.Point($userNameBox.Width, 0)  # Set the location to the right of the username box
$header.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#191A3F")

#Add controls to the main form
$mainForm.Controls.Add($userNameBox)
$mainForm.Controls.Add($header)

#Show the main form
$mainForm.ShowDialog()