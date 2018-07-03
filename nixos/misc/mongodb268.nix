#{ stdenv, lib, fetchurl
#}:
with import <nixpkgs> {};

let version = "2.6.8";
in stdenv.mkDerivation rec {
  name = "mongodb-${version}";

  src = fetchurl {
    url = "http://downloads.mongodb.org/linux/mongodb-linux-x86_64-${version}.tgz";
    sha256 = "2cd8c77af8f9a668dfe70fe499fd722e499f9c480f61b7ccc20198465f982d4d";
  };

  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
    mkdir -p $out
    cp -r bin $out

    for file in $out/bin/*; do
      echo $file
      patchelf \
        --set-interpreter $(cat $NIX_CC/nix-support/dynamic-linker) \
        --set-rpath "$rpath" \
        $file
    done
  '';

  dontStrip    = true;
  dontPatchELF = true;

  rpath = lib.makeLibraryPath [ stdenv.cc.cc ];
}
