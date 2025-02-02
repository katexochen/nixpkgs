{
  lib,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  wheel,
  azure-core,
  fixedint,
  msrest,
  opentelemetry-api,
  opentelemetry-sdk,
  psutil,
}:

buildPythonPackage rec {
  pname = "azure-monitor-opentelemetry-exporter";
  version = "1.0.0b33";
  pyproject = true;

  src = fetchPypi {
    pname = "azure_monitor_opentelemetry_exporter";
    inherit version;
    hash = "sha256-HLvUG0y0SireAWQIsjohdiWDudqRPYriWfKTVtOm0K4=";
  };

  build-system = [
    setuptools
    wheel
  ];

  dependencies = [
    azure-core
    fixedint
    msrest
    opentelemetry-api
    opentelemetry-sdk
    psutil
  ];

  pythonImportsCheck = [
    "azure_monitor_opentelemetry_exporter"
  ];

  meta = {
    description = "Microsoft Azure Monitor Opentelemetry Exporter Client Library for Python";
    homepage = "https://pypi.org/project/azure-monitor-opentelemetry-exporter/";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
  };
}
