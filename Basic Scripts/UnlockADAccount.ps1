$user = Read-Host "Ener account name"
$user = $user.trim()


while ($user -ne "exit") {

    $ExistingADUser = Get-ADUser -Filter "SamAccountName -eq '$user'"

    if($null -eq $ExistingADUser){
        write-host "Sorry, '$user' does not exist in Active Directory" 
    }

    else {
        Unlock-ADAccount $user
        Write-Host "User Account has been unlocked!"
    }

    $user = Read-Host "Please Enter Account Name"
    $user = $user.trim()
    
}
