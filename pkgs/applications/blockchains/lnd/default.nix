{ buildGoModule
, fetchFromGitHub
, lib
, go
, tags ? [ "autopilotrpc" "signrpc" "walletrpc" "chainrpc" "invoicesrpc" "watchtowerrpc" "routerrpc" "monitoring" "kvdb_postgres" "kvdb_etcd" ]
}:

buildGoModule rec {
  pname = "lnd";
  version = "0.17.0-beta";

  src = fetchFromGitHub {
    owner = "lightningnetwork";
    repo = "lnd";
    rev = "v${version}";
    hash = "sha256-HndO7vp/sia352hs23xAgrpyJ/CfbRxYAAhLZ4q94Pc=";
  };

  vendorHash = "sha256-4n81AZLKCTEV4+p4kRhZbzYsdRGIztzh6EKPin8W1Z0=";

  subPackages = [ "cmd/lncli" "cmd/lnd" ];

  inherit tags;

  ldflags =
    let
      buildVars = {
        RawTags = lib.concatStringsSep "," tags;
        GoVersion = "go${go.version}";
      };
    in
    (lib.mapAttrsToList (k: v: "-X github.com/lightningnetwork/lnd/build.${k}=${v}") buildVars);

  meta = with lib; {
    description = "Lightning Network Daemon";
    homepage = "https://github.com/lightningnetwork/lnd";
    license = licenses.mit;
    maintainers = with maintainers; [ cypherpunk2140 prusnak ];
  };
}
