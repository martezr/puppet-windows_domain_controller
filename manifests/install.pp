# Install Active Directory Domain Services Feature
  
  class windows_domain_controller::install(
    $kernel_ver = $windows_domain_controller::kernel_ver,
  )
  {
    
    if $kernel_ver =~ /^6\.2|^6\.3/ {
# Install Server 2012 Active Directory Domain Services w/Management Tools      
  exec {'Install ADDS':
      command   => "Import-Module ServerManager; Add-WindowsFeature AD-Domain-Services -IncludeManagementTools",    
      provider  => powershell,
      unless    => "(Get-WindowsFeature -name adds).Installed",
       }
                               }
   else {
# Install Server 2008 Active Directory Domain Services
    exec {'Install ADDS':
      command   => "Import-Module ServerManager; Add-WindowsFeature AD-Domain-Services",
      provider  =>  powershell,
      unless    =>  "(Get-WindowsFeature -name adds).Installed",
         }
        }
   }