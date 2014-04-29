# Class: windows_domain_controller
#
# This module is used to automate the installation and configuration of the windows active directory domain services role
#
# == Parameters: 
# 
#  $domain:: The type of domain controller installation - new forest, new domain in an existing forest, child domain, etc 
#     Defaults to undefined which simply installs the AD DS role without any configuration
#     Valid values: forest, tree, child, replica, readonly
#
#  $domainname:: The fully qualified domain name for the new domain
#     Defaults to undefined
#     Valid values: any accepted character string
#
#  
# Actions:
#
# Requires: see Modulefile
#
# == Sample Usage:
#
# New Forest
# 
#  class {'windows_domain_controller':
#   domain        => 'forest',      #REQUIRED#
#   domainname    => 'test.local',  #REQUIRED#
#   domainlevel   => '4',
#   forestlevel   => '4',
#   databasepath  => 'e:\ntds,
#   logpath       => 'e:\windows\ntds',
#   sysvolpath    => 'e:\sysvol'
#   }
#
#

class windows_domain_controller (
  $domain            = undef,  # Installation type { forest | tree | child | replica | readonly }
  $domainname        = undef,  # FQDN
  $netbiosname       = undef,  # NetBIOS name
  $domainlevel       = '2',    # Domain level {2 - Server 2003 | 3 - Server 2008 | 4 - Server 2008 R2 | 5 - Server 2012}
  $forestlevel       = '2',    # Forest level {2 - Server 2003 | 3 - Server 2008 | 4 - Server 2008 R2 | 5 - Server 2012}
  $installdns        = 'yes',  # Add DNS Server Role
  $globalcatalog     = 'yes',  # Add Global Catalog functionality
  $sitename          = undef,  # Site Name
  $domaintype        = undef,  # Type of domain {Tree | Child | Forest} (New domain tree in an existing forest, child domain, or new forest)
  $parentdomainname  = undef,  # Parent FQDN
  $installtype       = undef,  # New domain or replica of existing domain {replica | domain}
  $replicadomainname = undef,  # Existing domain FQDN
  $secure_string_pwd = undef,  # Server 2012 secure dsrm password
  
  # Installation Directories
  $databasepath  = 'c:\\windows\\ntds',   # Active Directory database path
  $logpath       = 'c:\\windows\\ntds',   # Active Directory log path
  $sysvolpath    = 'c:\\windows\\sysvol', # Active Directory sysvol path
  
  # User Information
  $username      = undef, # Username to join existing domain
  $password      = undef, # Password to join existing domain
  $userdomain    = undef, # Existing domain name 
  
  $dsrmpassword  = 'password', # Directory Service Recovery Mode password
  $kernel_ver = $::kernelmajversion # Windows Kernel Version (Used to determine the platform)
) 

{
  # Select the desired domain type
   case $domain {
        'forest':       { include windows_domain_controller::forest }
        'child':        { include windows_domain_controller::child }
        'replica':      { include windows_domain_controller::additional }
        'readonly':     { include windows_domain_controller::rodc }
        'tree':         { include windows_domain_controller::tree }
        default:        { }
} 
}
