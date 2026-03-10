{ 
  pkgs ? import (fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/dc098c7be91d9dea662c396b6192862d3463ee04.tar.gz";
    sha256 = "07lf1mx4f61zb9l37igy0h8z2d06z2jczd1viqck7bqhzzayh1np";
  }) { }
}:

{
  montecarlo-pi = pkgs.stdenv.mkDerivation {
    name = "montecarlo-pi";

    src = ./src;

    buildPhase = ''
      $CC montecarlo-pi.c -o montecarlo-pi
    '';

    installPhase = ''
      install -D montecarlo-pi $out/bin/montecarlo-pi
    '';
  };
}