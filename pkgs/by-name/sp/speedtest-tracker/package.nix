{
  lib,
  php,
  speedtest-cli,
  fetchFromGitHub,
}:

php.buildComposerProject (finalAttrs: {
  pname = "speedtest-tracker";
  version = "0.21.5";

  src = fetchFromGitHub {
    owner = "alexjustesen";
    repo = "speedtest-tracker";
    rev = "v${finalAttrs.version}";
    hash = "sha256-cmTguBwR1u7vQS6fb5mhXjyZGm0Cwm++nbRL/VL/iI0=";
  };

  vendorHash = "sha256-IyP5yMrnohP4SIFfTQoRxZQdmd4N5XWx1osce6LE2tw=";

  propagatedBuildInputs = [ speedtest-cli ];

  meta = {
    description = "self-hosted internet performance tracking application that runs speedtest checks against Ookla's Speedtest service";
    homepage = "https://github.com/alexjustesen/speedtest-tracker";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ katexochen ];
    platforms = lib.platforms.all;
  };
})
