Write-Host "Use this script to change user password to Bears2020. Type 'exit' when done"
$user = Read-Host "Enter account name"
$user = $user.trim()


while ($user -ne "exit") {

    $ExistingADUser = Get-ADUser -Filter "SamAccountName -eq '$user'"

    if($null -eq $ExistingADUser){
        Write-Host "Sorry, '$user' does not exist in Active Directory" 
    }

    else {
        $confirm = Read-Host "Are you sure you want to change the password for '$user'? (y or n)"

        if ($confirm -eq "y") {
            
            
            Set-ADAccountPassword -Identity "$user" -Server campus.uca.edu -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "Bears2020" -Force)
            Set-ADUser -Identity "$user" -ChangePasswordAtLogon $true

            "Password has been changed!"
            #break 
        }

        else {
            Write-Host "Password will not be changed for user"
        }
    }

    $user = Read-Host "Please enter account name"
    $user = $user.trim()
    
}
