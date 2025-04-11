{
  lib,
  buildGoModule,
  fetchFromGitHub,
  nix-update-script,
  versionCheckHook,
}:

buildGoModule (finalAttrs: {
  pname = "gofumpt";
  version = "0.7.0";

  src = fetchFromGitHub {
    owner = "mvdan";
    repo = "gofumpt";
    rev = "v${finalAttrs.version}";
    hash = "sha256-mJM0uKztX0OUQvynnxeKL9yft7X/Eh28ERg8SbZC5Ws=";
  };

  vendorHash = "sha256-kJysyxROvB0eMAHbvNF+VXatEicn4ln2Vqkzp7GDWAQ=";

  env.CGO_ENABLED = "0";

  ldflags = [
    "-s"
    "-X main.version=v${finalAttrs.version}"
  ];

  nativeCheckInputs = [ versionCheckHook ];

  checkFlags = [
    # Requires network access (Error: module lookup disabled by GOPROXY=off).
    "-skip=^TestScript/diagnose$"
  ];

  passthru.updateScript = nix-update-script { };

  meta = with lib; {
    description = "Stricter gofmt";
    homepage = "https://github.com/mvdan/gofumpt";
    changelog = "https://github.com/mvdan/gofumpt/releases/tag/v${version}";
    license = licenses.bsd3;
    maintainers = with maintainers; [
      rvolosatovs
      katexochen
    ];
    mainProgram = "gofumpt";
  };
})
