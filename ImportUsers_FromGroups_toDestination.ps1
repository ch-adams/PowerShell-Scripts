Import-Module AzureAD
Connect-AzureAD

$GroupNames = @("Group1","Group2","Group3","Group4")
$DestGroup = (Get-AzureADGroup -SearchString "EnterGroupTarget").objectID

foreach($GroupName in $GroupNames){
    $UserIDs = Get-AzureADGroupMember -ObjectId (Get-AzureADGroup -SearchString $GroupName -all $true).objectID|select -ExpandProperty objectID

    ForEach($UserID in $UserIDs){
        Try{
            Add-AzureADGroupMember -ObjectId $DestGroup -RefObjectId $UserIDs
        }
        Catch{
            Write-Host "User is already a member.."
        }
    }
}