# Add an additional domain controller to an existing domain

class windows_domain_controller::additional (
  
  $installtype        = $windows_domain_controller::installtype,
  $replicadomainname  = $windows_domain_controller::replicadomainname,
  $globalcatalog      = $windows_domain_controller::globalcatalog,
  $databasepath       = $windows_domain_controller::databasepath,
  $logpath            = $windows_domain_controller::logpath,
  $sysvolpath         = $windows_domain_controller::sysvolpath,
  $dsrmpassword       = $windows_domain_controller::dsrmpassword,
  $kernel_ver         = $windows_domain_controller::kernel_ver,
  
  # User Information
  $username      = undef, # Username to join existing domain
  $password      = undef, # Password to join existing domain
  $userdomain    = undef, # Existing domain name 
)
{
  
    # If the operating is server 2012 then run the appropriate powershell commands if not revert back to the cmd commands
  
  if $kernel_ver =~ /^6\.2|^6\.3/ {
   # Deploy Server 2012/2012 R2 Active Directory
  exec {'Deploy Additional 2012':
      command   => "Import-Module ADDSDeployment; Install-ADDSDomainController -DomainName $replicadomainname -DatabasePath $databasepath -LogPath $logpath -SafeModeAdministratorPassword $dsrmpassword -SysvolPath $sysvolpath",
      provider  => powershell,
      unless    => "(Get-WindowsFeature -name adds).Installed", 
       }
}
  else {
 # Deploy Server 2008 Active Directory
 exec {'Deploy Additional 2008':
       command  => "cmd.exe /c dcpromo /unattend /InstallDNS:yes /confirmGC:$globalcatalog /ReplicaOrNewDomain:$installtype /replicaDomainDNSName:$replicadomainname /databasePath:$databasepath /logPath:$logpath /sysvolPath:$sysvolpath /UserDomain:$userdomain /UserName:$username /Password:$password /SafeModeAdminPassword:$dsrmpassword",
       path     => 'C:\windows\sysnative',
}
       }  
 }