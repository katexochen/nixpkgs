{
  lib,
  stdenv,
  fetchFromGitLab,
  makeWrapper,
  installShellFiles,
  coreutils,
  util-linux,
  cpio,
  gzip,
  zstd,
  xz,
  lz4,
  bzip2,
  lzop,
  gnugrep,
}:

let
  # Only a subset of scripts is supported for now.
  scripts = [
    "unmkinitramfs"
    "lsinitramfs"
  ];
in

stdenv.mkDerivation rec {
  pname = "initramfs-tools";
  version = "0.143.1";

  src = fetchFromGitLab {
    domain = "salsa.debian.org";
    owner = "kernel-team";
    repo = "initramfs-tools";
    rev = "v${version}";
    hash = "sha256-WZy0WoOo+C5LY5aoyZKnKYhFHL7dU1Pd+YkaGf406Ew=";
  };

  nativeBuildInputs = [
    makeWrapper
    installShellFiles
  ];

  installPhase = ''
    runHook preInstall

    install -m755 -Dt $out/bin ${lib.concatStringsSep " " scripts}
    installManPage {${lib.concatStringsSep "," scripts}}.8

    runHook postInstall
  '';

  postFixup = ''
    for script in ${lib.concatStringsSep " " scripts}; do
      wrapProgram $out/bin/$script \
          --prefix PATH : ${
            lib.makeBinPath [
              coreutils
              cpio
              util-linux
              gzip
              zstd
              xz
              lz4
              bzip2
              lzop
              gnugrep
            ]
          }
    done
  '';

  meta = {
    description = "Tools for working with initramfs";
    homepage = "https://salsa.debian.org/kernel-team/initramfs-tools";
    changelog = "https://salsa.debian.org/kernel-team/initramfs-tools/-/blob/v${version}/debian/NEWS";
    license = lib.licenses.gpl2Plus;
    maintainers = with lib.maintainers; [ katexochen ];
    mainProgram = "initramfs-tools";
    platforms = lib.platforms.all;
  };
}
