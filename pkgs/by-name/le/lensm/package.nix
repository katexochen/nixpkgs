{
  lib,
  buildGoModule,
  fetchFromGitHub,
  pkg-config,
  vulkan-headers,
  libX11,
  libGL,
  libxkbcommon,
  libXcursor,
  libXfixes,
  wayland,
  x11Support ? true,
  waylandSupport ? true,
  nix-update-script,
  stdenv,
}:

buildGoModule rec {
  pname = "lensm";
  version = "0.0.3";

  src = fetchFromGitHub {
    owner = "loov";
    repo = "lensm";
    rev = "v${version}";
    hash = "sha256-kkthT77OhlWlnoHf0k+I5mb+oDfSdMD/x0C7UHoi3G8=";
  };

  vendorHash = "sha256-C6aFVS0NizDVSoCkiYKT0hFqljs0V1mYpHaEzKBwfks=";

  tags = lib.optionals (!x11Support) [ "nox11" ] ++ lib.optionals (!waylandSupport) [ "nowayland" ];

  nativeBuildInputs = [ pkg-config ];

  buildInputs =
    [
      vulkan-headers
      libGL
      libxkbcommon
    ]
    ++ lib.optionals x11Support [
      libX11
      libXcursor
      libXfixes
    ]
    ++ lib.optionals waylandSupport [ wayland ];

  passthru.updateScript = nix-update-script { attrPath = pname; };

  meta = with lib; {
    # gioui.org/internal/cocoainit fails with:
    #  fatal error: could not build module 'CoreFoundation'
    # even when it's included as dependency.
    broken = stdenv.isDarwin;

    description = "Go assembly and source viewer";
    homepage = "https://github.com/loov/lensm";
    license = licenses.mit;
    maintainers = with maintainers; [ viraptor ];
  };
}
