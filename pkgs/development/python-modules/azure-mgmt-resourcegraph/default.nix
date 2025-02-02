{
  lib,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  wheel,
  azure-common,
  azure-mgmt-core,
  azure-mgmt-nspkg,
  msrest,
}:

buildPythonPackage rec {
  pname = "azure-mgmt-resourcegraph";
  version = "8.1.0b3";
  pyproject = true;

  src = fetchPypi {
    pname = "azure-mgmt-resourcegraph";
    inherit version;
    hash = "sha256-ZTdPfHhWWYAimuVSri4ALSMRpZ3ga4L8jsAQZ9Qv6vU=";
    extension = "zip";
  };

  build-system = [
    setuptools
    wheel
  ];

  dependencies = [
    azure-common
    azure-mgmt-core
    azure-mgmt-nspkg
    msrest
  ];

  pythonImportsCheck = [
    "azure_mgmt_resourcegraph"
  ];

  meta = {
    description = "Microsoft Azure Resource Graph Client Library for Python";
    homepage = "https://pypi.org/project/azure-mgmt-resourcegraph/";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
  };
}
