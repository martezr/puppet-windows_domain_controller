# == Class: windows_domain_controller::tree
#
# Create a new tree (does not appear to do anything at all)
#
class windows_domain_controller::tree (
  $installtype       = $windows_domain_controller::installtype,
  $replicadomainname = $windows_domain_controller::replicadomainname,
  $globalcatalog     = $windows_domain_controller::globalcatalog,
  $databasepath      = $windows_domain_controller::databasepath,
  $logpath           = $windows_domain_controller::logpath,
  $sysvolpath        = $windows_domain_controller::sysvolpath,
  $dsrmpassword      = $windows_domain_controller::dsrmpassword,
  $kernel_ver        = $windows_domain_controller::kernel_ver,
  # User Information
  $username          = undef, # Username to join existing domain
  $password          = undef, # Password to join existing domain
  $userdomain        = undef, # Existing domain name
) {

}
