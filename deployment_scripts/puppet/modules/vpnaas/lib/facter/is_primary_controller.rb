Facter.add('is_primary_controller') do
  setcode do
    Facter::Util::Resolution.exec("bash -c \"if [ -f /etc/primary-controller.yaml ]; then echo yes; fi\"")
  end
end
