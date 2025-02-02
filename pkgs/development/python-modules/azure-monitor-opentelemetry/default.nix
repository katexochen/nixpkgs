{
  lib,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  wheel,
  azure-core,
  azure-core-tracing-opentelemetry,
  azure-monitor-opentelemetry-exporter,
  opentelemetry-instrumentation-django,
  opentelemetry-instrumentation-fastapi,
  opentelemetry-instrumentation-flask,
  opentelemetry-instrumentation-psycopg2,
  opentelemetry-instrumentation-requests,
  opentelemetry-instrumentation-urllib,
  opentelemetry-instrumentation-urllib3,
  opentelemetry-resource-detector-azure,
  opentelemetry-sdk,
}:

buildPythonPackage rec {
  pname = "azure-monitor-opentelemetry";
  version = "1.6.4";
  pyproject = true;

  src = fetchPypi {
    pname = "azure_monitor_opentelemetry";
    inherit version;
    hash = "sha256-n1zkxmbK8fm1NvirTuIH3/lHd9VoUXx08m4zJ/dcP8M=";
  };

  build-system = [
    setuptools
    wheel
  ];

  dependencies = [
    azure-core
    azure-core-tracing-opentelemetry
    azure-monitor-opentelemetry-exporter
    opentelemetry-instrumentation-django
    opentelemetry-instrumentation-fastapi
    opentelemetry-instrumentation-flask
    opentelemetry-instrumentation-psycopg2
    opentelemetry-instrumentation-requests
    opentelemetry-instrumentation-urllib
    opentelemetry-instrumentation-urllib3
    opentelemetry-resource-detector-azure
    opentelemetry-sdk
  ];

  pythonImportsCheck = [
    "azure_monitor_opentelemetry"
  ];

  meta = {
    description = "Microsoft Azure Monitor Opentelemetry Distro Client Library for Python";
    homepage = "https://pypi.org/project/azure-monitor-opentelemetry/";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
  };
}
