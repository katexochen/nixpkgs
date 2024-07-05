{ lib
, buildGoModule
, fetchFromGitHub
}:

buildGoModule rec {
  pname = "gomtree";
  version = "0.5.4";

  src = fetchFromGitHub {
    owner = "vbatts";
    repo = "go-mtree";
    rev = "v${version}";
    hash = "sha256-MDX16z4H1fyuV5atEsZHReJyvC+MRdeA54DORCFtpqI=";
  };

  vendorHash = null;

  ldflags = [
    "-s"
    "-X main.Version=${version}"
  ];

  subPackages = [ "cmd/gomtree" ];

  checkFlags = [
    "-skip=^TestXattr$"
  ];

  meta = {
    description = "File systems verification utility and library, in likeness of mtree(8";
    homepage = "https://github.com/vbatts/go-mtree";
    changelog = "https://github.com/vbatts/go-mtree/releases/tag/v${version}";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ katexochen ];
    mainProgram = "gomtree";
  };
}
