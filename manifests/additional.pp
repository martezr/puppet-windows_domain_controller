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
#  include 'windows_domain_controller::param::powershell'
#  
#
#    # If the operating is server 2012 then run the appropriate powershell commands if not revert back to the cmd commands
#  
#  if $kernel_ver =~ /^6\.2/ {
#   # Deploy Server 2012 Active Directory
#  exec {'Deploy ADDS':
#      command   => "${windows_domain_controller::param::powershell::command} -Command \"Import-Module ADDSDeployment; Install-ADDSDomainController -DomainName $replicadomainname -SafeModeAdministratorPassword $dsrmpassword\"",
#      path      => "${windows_domain_controller::param::powershell::path};${::path}",
#      
#       }
#}
#  else {
# # Deploy Server 2008 Active Directory
# exec {'Deploy ADDS 2008':
#       command  => "cmd.exe /c dcpromo /unattend /InstallDNS:yes /confirmGC:$globalcatalog /ReplicaOrNewDomain:$installtype /replicaDomainDNSName:$replicadomainname /databasePath:$databasepath /logPath:$logpath /sysvolPath:$sysvolpath /UserDomain:$userdomain /UserName:$username /Password:$password /SafeModeAdminPassword:$dsrmpassword",
#       path     => 'C:\windows\sysnative',
#}
#       }
  
  
  
 }