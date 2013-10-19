  # Install Active Directory Domain Services Feature
  
  class windows_domain_controller::install(
    $kernel_ver = $windows_domain_controller::kernel_ver,
  )
  {
    
    if $kernel_ver =~ /^6\.2/ {
# Install Server 2012 Active Directory Domain Services w/Management Tools      
  exec {'Install ADDS':
      command   => "${windows_domain_controller::param::powershell::command} -Command \"Import-Module ServerManager; Add-WindowsFeature AD-Domain-Services -IncludeManagementTools\"",
      path      => "${windows_domain_controller::param::powershell::path};${::path}",    
       }
                               }
   else {
# Install Server 2008 Active Directory Domain Services
    exec {'Install ADDS':
      command   => "${windows_domain_controller::param::powershell::command} -Command \"Import-Module ServerManager; Add-WindowsFeature AD-Domain-Services\"",
      path      => "${windows_domain_controller::param::powershell::path};${::path}",    
         }
        }
   }