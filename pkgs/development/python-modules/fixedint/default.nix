{
  lib,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  wheel,
}:

buildPythonPackage rec {
  pname = "fixedint";
  version = "0.2.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-ruoMejpU5Tce1jL5qXcZMWaZ9k+GP/zkQU7w+SUlXRc=";
  };

  build-system = [
    setuptools
    wheel
  ];

  pythonImportsCheck = [
    "fixedint"
  ];

  meta = {
    description = "Simple fixed-width integers";
    homepage = "https://pypi.org/project/fixedint/";
    license = lib.licenses.unfree; # FIXME: nix-init did not find a license
    maintainers = with lib.maintainers; [ ];
  };
}
