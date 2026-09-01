{ pkgs }:

pkgs.buildGoModule {
  pname = "zli";
  version = "1.0.0";
  src = pkgs.fetchFromGitHub {
    owner = "project-zot"
    repo = "zot";
    rev = "v2.1.20";
    sha256 = "0000000000000000000000000000000000000000000000000000";
  };
}
