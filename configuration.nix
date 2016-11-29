# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only
  boot.kernelPackages = pkgs.linuxPackages_4_8;
  boot.kernelParams = [ "quiet" ];

  fonts.fontconfig.ultimate.enable = true;
  fonts.fontconfig.hinting.style = "slight";
  fonts.fontconfig.antialias = true;
  # fonts.fontconfig.dpi = 127;
  networking.hostName = "ike"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.wireless.userControlled.enable = true;
  # networking.connman.enable = true;

  # Select internationalisation properties.
  i18n = {
  #   consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "dvorak";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "US/Central";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    wget
    vim
    chromium
    dmenu
    (import ./emacs.nix { inherit pkgs; })
    rxvt_unicode
    git
    haskellPackages.xmobar
    # haskellPackages.alsa-core
    # haskellPackages.alsa-mixer
    xtitle
    xbanish
    cabal-install
    cabal2nix
    zathura
  ];

  fonts.fonts = with pkgs; [
    noto-fonts-cjk
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "dvorak";
  services.xserver.xkbOptions = "caps:escape";
  # services.xserver.windowManager.xmonad.enable = true;
  # services.xserver.windowManager.xmonad.enableContribAndExtras = true;
  services.xserver.windowManager.bspwm.enable = true;
  services.xserver.synaptics.enable = true;
  services.xserver.synaptics.twoFingerScroll = true;
  services.xserver.synaptics.minSpeed = ".6";
  services.xserver.synaptics.horizTwoFingerScroll = false;
  services.xserver.synaptics.horizEdgeScroll = true;
  services.xserver.synaptics.additionalOptions = ''
    Option "FingerHigh" "60"
    Option "FingerLow" "50"
  '';

  services.emacs.enable = true;
  services.emacs.package = import /etc/nixos/emacs.nix { pkgs = pkgs; };

 

  # services.xbanish.enable = true;
  # services.unclutter.enable = true;
  # services.unclutter.keystroke = true;

  services.xserver.deviceSection = ''
    Option "TearFree" "true"
  '';

  services.compton.enable = true;
  services.compton.inactiveOpacity = "0.9";
  services.compton.shadow = true;
  services.compton.shadowOffsets = [ (-15) (-8) ];
  services.compton.shadowOpacity = ".5";
  services.compton.extraOptions = ''
    shadow-radius = 10;
  '';

  services.logind.extraConfig = "HandlePowerKey=suspend";

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.kdm.enable = true;
  # services.xserver.desktopManager.kde4.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.extraUsers.guest = {
  #   isNormalUser = true;
  #   uid = 1000;
  # };
  users.extraUsers.kai = {
    isNormalUser = true;
    home = "/home/kai";
    description = "Kai Frondorf";
    extraGroups = [ "wheel" "networkmanager" ];
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "16.09";

}
