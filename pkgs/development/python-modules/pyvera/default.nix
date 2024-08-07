{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  poetry-core,
  pytest-cov-stub,
  pytest-asyncio,
  pytest-timeout,
  responses,
  pytestCheckHook,
  requests,
}:

buildPythonPackage rec {
  pname = "pyvera";
  version = "0.3.15";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "pavoni";
    repo = pname;
    rev = version;
    hash = "sha256-1+xIqOogRUt+blX7AZSKIiU8lpR4AzKIIW/smCSft94=";
  };

  nativeBuildInputs = [ poetry-core ];

  propagatedBuildInputs = [ requests ];

  nativeCheckInputs = [
    pytest-asyncio
    pytest-timeout
    pytest-cov-stub
    pytestCheckHook
    responses
  ];

  pythonImportsCheck = [ "pyvera" ];

  meta = with lib; {
    description = "Python library to control devices via the Vera hub";
    homepage = "https://github.com/pavoni/pyvera";
    license = with licenses; [ gpl2Only ];
    maintainers = with maintainers; [ fab ];
  };
}
