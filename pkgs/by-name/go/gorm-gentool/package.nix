{
  lib,
  # Build fails with Go 1.25, with the following error:
  # 'vendor/golang.org/x/tools/internal/tokeninternal/tokeninternal.go:64:9: invalid array length -delta * delta (constant -256 of type int64)'
  # Wait for upstream to update their vendored dependencies before unpinning.
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "gorm-gentool";
  version = "0.0.2";

  src = fetchFromGitHub {
    owner = "go-gorm";
    repo = "gen";
    rev = "tools/gentool/v${version}";
    hash = "sha256-8xuprFktGflx/5BR3Sbzx/MWerSp57q2Ky2Yn5P6Y28=";
  };

  modRoot = "tools/gentool";

  proxyVendor = true;
  vendorHash = "sha256-0VU+zGQb6Ob9V2zOsUO5+ObUFdQO26236Ei2/TqjTBs=";

  meta = {
    homepage = "https://github.com/go-gorm/gen";
    description = "Gen: Friendly & Safer GORM powered by Code Generation";
    license = lib.licenses.mit;
    mainProgram = "gentool";
    maintainers = with lib.maintainers; [ tembleking ];
  };
}
