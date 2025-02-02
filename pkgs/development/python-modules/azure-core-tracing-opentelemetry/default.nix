{
  lib,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  wheel,
  azure-core,
  opentelemetry-api,
}:

buildPythonPackage rec {
  pname = "azure-core-tracing-opentelemetry";
  version = "1.0.0b11";
  pyproject = true;

  src = fetchPypi {
    pname = "azure-core-tracing-opentelemetry";
    inherit version;
    hash = "sha256-ojDRVVg4tdB7dZQiHNY56nvCTinIgeVnXjEcYGe61PU=";
  };

  build-system = [
    setuptools
    wheel
  ];

  dependencies = [
    azure-core
    opentelemetry-api
  ];

  pythonImportsCheck = [
    "azure_core_tracing_opentelemetry"
  ];

  meta = {
    description = "Microsoft Azure Azure Core OpenTelemetry plugin Library for Python";
    homepage = "https://pypi.org/project/azure-core-tracing-opentelemetry/";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
  };
}
