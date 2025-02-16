{
  lib,
  buildPythonPackage,
  fetchPypi,
  hatchling,
  opentelemetry-api,
  opentelemetry-instrumentation,
  opentelemetry-semantic-conventions,
  opentelemetry-util-http,
  wrapt,
  urllib3,
}:

buildPythonPackage rec {
  pname = "opentelemetry-instrumentation-urllib3";
  version = "0.50b0";
  pyproject = true;

  src = fetchPypi {
    pname = "opentelemetry_instrumentation_urllib3";
    inherit version;
    hash = "sha256-LEodnxKOr3U4cbHZBlnHRGkdA5pmAbpUYIE0euGSvQ4=";
  };

  build-system = [
    hatchling
  ];

  dependencies = [
    opentelemetry-api
    opentelemetry-instrumentation
    opentelemetry-semantic-conventions
    opentelemetry-util-http
    wrapt
  ];

  pythonRelaxDeps = [
    "opentelemetry-instrumentation"
    "opentelemetry-semantic-conventions"
    "opentelemetry-util-http"
  ];

  optional-dependencies = {
    instruments = [
      urllib3
    ];
  };

  pythonImportsCheck = [
    "opentelemetry.instrumentation.urllib3"
  ];

  meta = {
    description = "OpenTelemetry urllib3 instrumentation";
    homepage = "https://pypi.org/project/opentelemetry-instrumentation-urllib3/";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ ];
  };
}
