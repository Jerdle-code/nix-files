# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs,... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./imports/hardware-configuration.nix
      ./imports/users.nix
    ];

  # Bootloader.
 # boot.loader.systemd-boot.enable = true;
boot.loader.grub = {
enable = true;
efiSupport = true;
device = "nodev";
useOSProber = true;
};
  boot.loader.efi.canTouchEfiVariables = true;
boot.loader.efi.efiSysMountPoint = "/boot/efi";
boot.kernel.sysctl = {"net.ipv4.ip_forward" = 1;};
boot.kernelPackages = pkgs.linuxPackages_latest;
  networking.hostName = "Jeskai"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
programs.hyprland.enable = true;
services.geoclue2.enable = true;
users.users.geoclue.extraGroups = [ "networkmanager" ];
hardware.opengl.extraPackages = with pkgs; [
  rocmPackages.clr.icd
  amdvlk
];
# For 32 bit applications 
hardware.opengl.extraPackages32 = with pkgs; [
  driversi686Linux.amdvlk
];
hardware.opengl.driSupport32Bit = true; # For 32 bit applications

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "uk";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  programs.dconf.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
virtualisation.libvirtd.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
      winetricks
      wineWowPackages.full
      nix-search-cli
      mesa-demos
      clinfo
      vulkan-tools
      links2
      tmux
      jdk21
      virt-manager
      lxqt.lxqt-openssh-askpass
      lxqt.lxqt-policykit
      upower
      kdePackages.partitionmanager
      git
  ];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  system.autoUpgrade.enable  = true;
  programs.zsh.enable = true;
programs.steam.enable = true;
nix.settings.auto-optimise-store = true;
services.power-profiles-daemon.enable = true;
services.upower.enable=true;
services.xserver.gdk-pixbuf.modulePackages = [ pkgs.librsvg ];
services.udisks2.enable = true;
security.polkit.enable = true;
# List services that you want to enable:
#  services.auto-cpufreq.enable = true;
#   virtualisation.virtualbox.host.enable = true;
#   virtualisation.virtualbox.host.enableExtensionPack = true;
#services.fprintd.enable = true;
fonts.packages = with pkgs; [
   noto-fonts
   lmodern
   nerdfonts
   font-awesome
   powerline
];
#services.fprintd.tod.enable = true;

#services.fprintd.tod.driver = pkgs.libfprint-2-tod1-vfs0090;
  # Enable the OpenSSH daemon.
   services.openssh.enable = true;
   programs.ssh.askPassword = "lxqt-openssh-askpass";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
nix.settings.experimental-features = ["nix-command" "flakes"];
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
