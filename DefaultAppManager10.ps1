<# This form was created using POSHGUI.com  a free online gui designer for PowerShell
.NAME
    Untitled
#>

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(400,243)
$Form.text                       = "Default App Manager"
$Form.TopMost                    = $false

$ComboBox1                       = New-Object system.Windows.Forms.ComboBox
$ComboBox1.text                  = "Select an App to Uninstall/ReInstall"
$ComboBox1.width                 = 378
$ComboBox1.height                = 65
$ComboBox1.location              = New-Object System.Drawing.Point(10,42)
$ComboBox1.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Button1                         = New-Object system.Windows.Forms.Button
$Button1.text                    = "Uninstall"
$Button1.width                   = 256
$Button1.height                  = 30
$Button1.location                = New-Object System.Drawing.Point(70,133)
$Button1.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Button2                         = New-Object system.Windows.Forms.Button
$Button2.text                    = "Reinstall"
$Button2.width                   = 256
$Button2.height                  = 30
$Button2.location                = New-Object System.Drawing.Point(70,171)
$Button2.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Form.controls.AddRange(@($ComboBox1,$Button1,$Button2))


$apps = Get-AppxPackage -AllUsers | select Name
$appes = Get-AppxPackage -AllUsers | select PackageFullName
$uninstall = @()

foreach ($app in $apps)

{

[void]$ComboBox1.Items.Add($app.Name);

}

foreach ($appe in $appes)

{

$uninstall+=$appe.Name

}

$ListView1 = New-Object System.Windows.Forms.ListViewItem('Item 1')





$Button1.Add_Click(
        {    
$rem = $ComboBox1.SelectedItem
Get-AppxPackage $ComboBox1.SelectedItem | Remove-AppxPackage
        }
    )


$Button2.Add_Click(
        {
$add = $appes[$ComboBox1.SelectedIndex].PackageFullName
# Get-AppxPackage | Select-String -Pattern $ComboBox1.SelectedItem
$one = 'C:\Program Files\WindowsApps\'
$two = $add
$three = '\appxmanifest.xml'
$four = $one + $two + $three


#$uninstall[$ComboBox1.SelectedIndex] 

Add-AppxPackage -DisableDevelopmentMode -Register $four
        }
    )





[void]$Form.ShowDialog()