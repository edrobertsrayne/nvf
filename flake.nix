{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nvf.url = "github:notashelf/nvf";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = {
    nixpkgs,
    nvf,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages = {
        default =
          (nvf.lib.neovimConfiguration {
            inherit pkgs;
            modules = [
              {
                vim = {
                  theme.enable = true;
                  theme.name = "tokyonight";
                  theme.style = "night";
                  options = {
                    autoindent = true;
                    shiftwidth = 2;
                    tabstop = 2;
                  };
                  lsp = {
                    formatOnSave = true;
                  };
                  languages = {
                    nix.enable = true;
                    enableLSP = true;
                    enableTreesitter = true;
                    enableFormat = true;
                  };
                  binds = {
                    whichKey.enable = true;
                    cheatsheet.enable = true;
                  };
                  autocomplete.nvim-cmp.enable = true;
                  telescope.enable = true;
                };
              }
            ];
          })
          .neovim;
      };
    });
}
