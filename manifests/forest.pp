# Create a new forest

class windows_domain_controller::forest (
  
  $domainname         = $windows_domain_controller::domainname,
  $globalcatalog      = $windows_domain_controller::globalcatalog,
  $databasepath       = $windows_domain_controller::databasepath,
  $logpath            = $windows_domain_controller::logpath,
  $sysvolpath         = $windows_domain_controller::sysvolpath,
  $dsrmpassword       = $windows_domain_controller::dsrmpassword,
  $kernel_ver         = $windows_domain_controller::kernel_ver,
  $domainlevel        = $windows_domain_controller::domainlevel,
  $forestlevel        = $windows_domain_controller::forestlevel,    
  $secure_string_pwd  = $windows_domain_controller::secure_string_pwd
  )

{

# If the operating is server 2012 then run the appropriate powershell commands if not revert back to the cmd commands
  
  if $kernel_ver =~ /^6\.2|^6\.3/ {
   
   # Deploy Server 2012 Active Directory
   exec {'Deploy ADDS':
      command   => "Import-Module ADDSDeployment; Install-ADDSForest -Force -DomainName $domainname -DomainMode $domainlevel -ForestMode $forestlevel -DatabasePath $databasepath -LogPath $logpath -SysvolPath $sysvolpath -SafeModeAdministratorPassword (convertto-securestring '$dsrmpassword' -asplaintext -force)",
      provider  => powershell, 
      unless    => test,
       }
}
  else {
 # Deploy Server 2008 Active Directory
 exec {'Deploy ADDS 2008':
       command  => "cmd.exe /c dcpromo /unattend /InstallDNS:yes /confirmGC:$globalcatalog /NewDomain:forest /NewDomainDNSName:$domainname /domainLevel:$domainlevel /forestLevel:$forestlevel /ReplicaOrNewDomain:domain /databasePath:$databasepath /logPath:$logpath /sysvolPath:$sysvolpath /SafeModeAdminPassword:$dsrmpassword",
       path     => 'C:\windows\sysnative',
}
       }
       }