{
  lib,
  buildPythonPackage,
  fetchPypi,
  hatchling,
  opentelemetry-api,
  opentelemetry-instrumentation,
  opentelemetry-semantic-conventions,
  opentelemetry-util-http,
}:

buildPythonPackage rec {
  pname = "opentelemetry-instrumentation-urllib";
  version = "0.50b0";
  pyproject = true;

  src = fetchPypi {
    pname = "opentelemetry_instrumentation_urllib";
    inherit version;
    hash = "sha256-rz6XEGNcP4pew4rcdy3+8MECLQGWAHuvS3RQTpILXTE=";
  };

  build-system = [
    hatchling
  ];

  dependencies = [
    opentelemetry-api
    opentelemetry-instrumentation
    opentelemetry-semantic-conventions
    opentelemetry-util-http
  ];

  pythonRelaxDeps = [
    "opentelemetry-instrumentation"
    "opentelemetry-semantic-conventions"
    "opentelemetry-util-http"
  ];

  pythonImportsCheck = [
    "opentelemetry.instrumentation.urllib"
  ];

  meta = {
    description = "OpenTelemetry urllib instrumentation";
    homepage = "https://pypi.org/project/opentelemetry-instrumentation-urllib/";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ ];
  };
}
