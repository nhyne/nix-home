{ config, lib, ... }:

let
  shellAliases = {
    kubeami = "kubectl config current-context";
    ls = "exa";
    ll = "exa -lah";
    wthr = "curl wttr.in";
    find = "fd";
    ghpr = "gh pr create";
    grep = "rg";
    ecrlogin = "$(aws ecr get-login --no-include-email)";
    vi = "nvim";
    vim = "nvim";
    pbcopy = "xclip -selection clipboard";
    pbpaste = "xclip -selection clipboard -o";
  };

in {

  programs.zsh = {
    enable = true;
    autocd = true;
    inherit shellAliases;
    enableCompletion = true;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "kubectl"
      ];
  };
  sessionVariables = {
    EDITOR="vim";
    SDKMAN_DIR="$HOME/.sdkman";
    PATH="$HOME/.cargo/bin:$HOME/.jenv/bin:$GOBIN:$PATH";
    #SBT_OPTS="-XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=2G -Xmx2G $SBT_OPTS";
  };
  history = {
    ignoreSpace = true;
    ignoreDups = true;
    extended = true;
    share = false;
    size = 100000;
    save = 100000;
  };
	profileExtra = ''
if [ -e ''$HOME/.nix-profile/etc/profile.d/nix.sh ]; then . ''$HOME/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

export NIX_PATH=''$HOME/.nix-defexpr/channels''${NIX_PATH:+:}''$NIX_PATH
	'';
  initExtraBeforeCompInit = ''
#eval "$(jenv init -)"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
source ~/.keys/github_api_token.bash
source ~/.peloton_zshrc
  '';
  };
}
