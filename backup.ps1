$StorageAccountContext = New-AzureStorageContext -StorageAccountName 'aranski' -StorageAccountKey 'XeMp78dqsIP9TA+6+G93J1fM9snMBMQqLnCKSHCFIwv+7lE5/Ko0VWqVNFKhS7nq9jDjCWoEBILo64v3ncm5DA=='
Set-AzureStorageBlobContent -File 'C:\inetpub\wwwroot\index.html' -Container 'server1backup' -Context $StorageAccountContext -Force
