{
  lib,
  buildPythonPackage,
  fetchPypi,
  hatchling,
  opentelemetry-sdk,
}:

buildPythonPackage rec {
  pname = "opentelemetry-resource-detector-azure";
  version = "0.1.5";
  pyproject = true;

  src = fetchPypi {
    pname = "opentelemetry_resource_detector_azure";
    inherit version;
    hash = "sha256-4LpliofGnuvIBudTmM0On2ioiY6mLembwbcIMTZANxA=";
  };

  build-system = [
    hatchling
  ];

  dependencies = [
    opentelemetry-sdk
  ];

  pythonImportsCheck = [
    "opentelemetry.resource.detector.azure"
  ];

  meta = {
    description = "Azure Resource Detector for OpenTelemetry";
    homepage = "https://pypi.org/project/opentelemetry-resource-detector-azure/";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ ];
  };
}
