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
  # 安装需要的包(用户态工具，无系统级依赖（如内核之类)
  #===================================================
  # home.nix 中
  home.packages = [
    pkgs.git          # Git 版本控制（也可用 apt，但 Nix 版本更灵活）
    pkgs.zsh          # Zsh shell
    pkgs.neovim       # Neovim 编辑器
    pkgs.yazi         # 终端文件管理器
    pkgs.fzf          # 模糊搜索
    pkgs.verilator
    pkgs.ripgrep      # 代码搜索工具
    pkgs.nodejs_24    # Node.js v24（neovim 插件可能需要）
    pkgs.tree-sitter  # Node.js v24（neovim 插件可能需要）
    pkgs.rustc        # Rust 编译器
    pkgs.cargo        # cargo 包管理器
    pkgs.zoxide       # fast cd
    pkgs.clang-tools  # to install clangd
    pkgs.delta        # diff syntax
    pkgs.coursier     # scala工具
    pkgs.circt        # chisel相关; 在flake.nix中通过overlay指定了版本1.62.0
    pkgs.mill         # chisel构建工具
    pkgs.jdk24        # java环境
  ];

  #===================================================
  # 对特别的程序进行配置管理
  #===================================================
  programs.git.enable = false;
  programs.neovim.enable = false;
  programs.zsh.enable = false;
  programs.yazi.enable = false;

}
