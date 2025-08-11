{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {

  #===================================================
  # 基本配置
  #===================================================
  home = {
    username = "awjl";
    homeDirectory = "/home/awjl";
  };
  home.stateVersion = "25.11";

  home.file = {
    # ".zshrc".source = ./dotfile/zsh/.zshrc;
  };

  # Enable home-manager, 让home-manager能够管理自己的配置
  programs.home-manager.enable = true;

  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  #===================================================
  # 安装需要的包
  #===================================================
  home.packages = [
    pkgs.git
    pkgs.zsh
    pkgs.neovim
    pkgs.yazi
  ];

  #===================================================
  # 对特别的程序进行配置管理
  #===================================================
  programs.git.enable = false;
  programs.neovim.enable = false;
  programs.zsh.enable = false;
  programs.yazi.enable = false;

}
