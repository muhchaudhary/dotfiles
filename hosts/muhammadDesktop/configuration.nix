# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./services.sunshine.nix
    ../shared.nix
    ./nvidia-gpu.nix
  ];

  # Enable sunshine
  services.sunshine.enable = true;

  # Use Docker
  virtualisation.docker = {
    enable = true;
    enableNvidia = true;
  };

  #Kernel perams
  boot.kernelParams = ["module_blacklist=nouveau" "nvidia.NVreg_PreserveVideoMemoryAllocations=1"];
  boot.kernelModules = ["i2c-dev" "i2c-piix4"];

  # Session
  environment.sessionVariables = rec {
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  networking.hostName = "muhammadDesktop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.muhammad = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = "Muhammad Chaudhary";
    extraGroups = ["networkmanager" "wheel" "input" "docker"];
  };
  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment.systemPackages = with pkgs; [
    python311
    python310

    openrgb
    i2c-tools
    gcc
    gperftools
    glibc
    glib
    nix-index
    unetbootin
    gtk2
    ventoy
    appimage-run
  ];

  environment.etc."sysconfig/lm_sensors".text = ''
    # Generated by sensors-detect on Thu Dec  7 22:17:04 2023
    # This file is sourced by /etc/init.d/lm_sensors and defines the modules to
    # be loaded/unloaded.
    #
    # The format of this file is a shell script that simply defines variables:
    # HWMON_MODULES for hardware monitoring driver modules, and optionally
    # BUS_MODULES for any required bus driver module (for example for I2C or SPI).

    HWMON_MODULES="lm83 nct6775"
  '';

  services.udev.packages = with pkgs; [
    openrgb
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  # This is to enable flatpak support
  # services.flatpak.enable = true;
}
