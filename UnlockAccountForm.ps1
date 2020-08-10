[void][System.Reflection.Assembly]::LoadWithPartialName('presentationframework')
[xml]$XAML = @"

<Window 
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        Title="Unlock Account" Height="456.338" Width="701.308" Background="#FFF7F7F7">
        <Grid Margin="0,0,0,-7" Background="#FFF7F7F7">
        <Grid.ColumnDefinitions>
            <ColumnDefinition Width="193*"/>
            <ColumnDefinition Width="500*"/>
        </Grid.ColumnDefinitions>
        <Label Name="Prompt" Content="Enter Account Username:" HorizontalAlignment="Left" Height="31" Margin="22,225,0,0" VerticalAlignment="Top" Width="190" FontSize="14" FontWeight="Bold" Grid.ColumnSpan="2" IsEnabled="False"/>
        <TextBox Name="UsernamePrompt" HorizontalAlignment="Left" Height="20" Margin="15.125,230,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="197" SpellCheck.IsEnabled="True" Background="#FFF7F7F7" Grid.Column="1" IsEnabled="True"/>
        <TextBox Name="Result" HorizontalAlignment="Left" Height="38" Margin="7.125,271,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="196" SpellCheck.IsEnabled="True" Grid.Column="1" BorderThickness="0" Background="#FFF7F7F7"/>
        <Rectangle Fill="#FF707070" HorizontalAlignment="Left" Height="168" Stroke="Black" VerticalAlignment="Top" Width="693" Grid.ColumnSpan="205"/>
        <Button Name="Search" Content="Search" Grid.Column="1" HorizontalAlignment="Left" Height="30" Margin="233,225,0,0" VerticalAlignment="Top" Width="90"/>
        <Button Name="Back" Content="Back" Grid.Column="1" HorizontalAlignment="Left" Height="34" Margin="345,364,0,0" VerticalAlignment="Top" Width="87"/>
        <Image Grid.Column="1" HorizontalAlignment="Left" Height="150" Margin="89,10,0,0" VerticalAlignment="Top" Width="180" Source="C:\Users\dthornton5\Desktop\HelpDesk\UCA.png"/>
    </Grid>
</Window>

"@




#Read XAML
$reader=(New-Object System.Xml.XmlNodeReader $xaml) 
try{$Form=[Windows.Markup.XamlReader]::Load( $reader )}
catch{Write-Host "Unable to load Windows.Markup.XamlReader"; exit}
 
# Store Form Objects In PowerShell
$xaml.SelectNodes("//*[@Name]") | ForEach-Object {Set-Variable -Name ($_.Name) -Value $Form.FindName($_.Name)}



$Back.Add_Click({
    $form.Close()
})



$Search.Add_Click({
    $Username = $UsernamePrompt.text.trim()
    $ExistingADUser = Get-ADUser -Filter "SamAccountName -eq '$Username'"
        if($null -eq $ExistingADUser){
            $Result.text = "Sorry, '$Username' does not exist in Active Directory." 
        }

        else {
            Unlock-ADAccount $Username
            $Result.text = "User account has been unlocked!"
        }  
})

#Show Form
$Form.ShowDialog() | out-null