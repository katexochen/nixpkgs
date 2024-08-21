{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule {
  pname = "pefile";
  version = "0.1.0-unstable-2029-12-25";

  src = fetchFromGitHub {
    owner = "folbricht";
    repo = "pefile";
    rev = "782fabb1d5dcbf8934a15719e609166be3a16b00";
    hash = "sha256-rfyt/n+7TMxrONQn7CLrolxjSL3XakifFOPHbGQsc3E=";
  };

  vendorHash = "sha256-+6O+X6cxuxrzVgZgEWMw4KddudUszxZlGVykC02Dx0w=";

  CGO_ENABLED = "0";

  ldflags = [ "-s" ];

  meta = {
    description = "Extract resources from PE files";
    homepage = "https://github.com/folbricht/pefile";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ katexochen ];
    mainProgram = "pe";
  };
}
