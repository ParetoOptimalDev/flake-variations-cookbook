{ ... }: {
  # Root file system and bootloader is required for CI to build system configuration
  boot.loader.grub.devices = [ "nodev" ];
  fileSystems."/" = { device = "test"; fsType = "ext4"; };

  # not ideal to have this in host right???
  users = {
    mutableUsers = false;
    users.morty = {
      password = "hunter2";
      extraGroups = [ "wheel" ];
      isNormalUser = true;
    };
    users.root.password = "root";
  };
  
}
