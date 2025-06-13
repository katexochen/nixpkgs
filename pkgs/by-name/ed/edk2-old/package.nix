{
  edk2,
  fetchFromGitHub,
  buildPackages,
}:

let
  self =
    (edk2.overrideAttrs (finalAttrs: {
      version = "202411";
      __intentionallyOverridingVersion = true;
      srcWithVendoring = fetchFromGitHub {
        owner = "tianocore";
        repo = "edk2";
        rev = "edk2-stable${finalAttrs.version}";
        fetchSubmodules = true;
        hash = "sha256-KYaTGJ3DHtWbPEbP+n8MTk/WwzLv5Vugty/tvzuEUf0=";
      };
    })).override
      { buildPackages = buildPackages.extend (final: prev: { edk2 = self; }); };
in
self
