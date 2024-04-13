{pkgs, ...}: {
  home.pointerCursor = {
    package = pkgs.apple-cursor;
    name = "macOS-Monterey";
    size = 24;
    gtk.enable = true;
  };

  gtk = {
    enable = true;
    # font = {
    #   package = pkgs.nerdfonts.override {fonts = ["Mononoki"];};
    #   name = "Mononoki Nerd Font Regular";
    #   size = 18;
    # };
    iconTheme = {
      # package = pkgs.kora-icon-theme;
      package = pkgs.gruvbox-plus-icons;
      name = "Gruvbox-Plus-Dark";
    };
    theme = {
      package = pkgs.gruvbox-gtk-theme;
      name = "Gruvbox-Dark-B";
    };
  };
}
