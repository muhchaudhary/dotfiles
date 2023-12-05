{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [inputs.ags.homeManagerModules.default];

  programs.ags = {
    enable = true;
    configDir = "~/.config/ags";
    extraPackages = [pkgs.libsoup_3];
  };
}
