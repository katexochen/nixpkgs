{ python3
, fetchFromGitHub
, findutils
}:
python3.pkgs.buildPythonPackage {
  fromat = "setuptools";

  pname = "unpushed";
  version = "2018-03-15";

  src = fetchFromGitHub {
    owner = "nailgun";
    repo = "unpushed";
    rev = "6e4ff18ddce89b8010a64c41625eb5322604fbc4";
    hash = "sha256-ce8EpUvJmiVRWfWWRXiSbg+fR+Wes+j/jeIQ9LShEuw=";
  };

  propagatedBuildInputs = [
    findutils.locate
  ];

}
