{ lib, runCommand }:

pkg:

let
  applyDefaults =
    pkg:
    pkg.overrideAttrs (prevAttrs: {
      CGO_ENABLED = 1;
      ldflags = lib.filter (flag: flag != "-s" && flag != "-w" && flag != "-s -w") prevAttrs.ldflags;
      dontStrip = false;
    });
  disableCGO =
    pkg:
    pkg.overrideAttrs (prevAttrs: {
      CGO_ENABLED = 0;
    });
  disableStrip =
    pkg:
    pkg.overrideAttrs (prevAttrs: {
      dontStrip = true;
    });
  setLdflagS =
    pkg:
    pkg.overrideAttrs (prevAttrs: {
      ldflags = prevAttrs.ldflags ++ [ "-s" ];
    });
  setLdflagW =
    pkg:
    pkg.overrideAttrs (prevAttrs: {
      ldflags = prevAttrs.ldflags ++ [ "-w" ];
    });

  testConfig = lib.cartesianProduct {
    cgo = [
      false
      true
    ];
    strip = [
      false
      true
    ];
    ldflagS = [
      false
      true
    ];
    ldflagW = [
      false
      true
    ];
  };

  tests = lib.map (
    conf:
    lib.pipe pkg (
      [ applyDefaults ]
      ++ lib.optional conf.strip disableStrip
      ++ lib.optional conf.ldflagS setLdflagS
      ++ lib.optional conf.ldflagW setLdflagW
      ++ lib.optional conf.cgo disableCGO
    )
  ) testConfig;

  testStr =
    test:
    lib.concatStringsSep "," [
      (lib.getExe test)
      (builtins.toString test.CGO_ENABLED)
      (if test.dontStrip then "true" else "false")
      (lib.concatStringsSep "\\ " (lib.filter (flag: flag == "-s" || flag == "-w") test.ldflags))
    ];
in
runCommand "go-pkg-strip-report" { } ''
  mkdir -p $out
  echo '### Report for ${pkg.pname}' >> $out/report.md
  echo '| CGO_ENABLED | dontStrip | ldflags | size | file |' >> $out/report.md
  echo '| --- | --- | --- | --- | --- |' >> $out/report.md
  count=0
  for test in ${lib.concatStringsSep " " (lib.map testStr tests)}; do
    echo $test
    testExe=$(cut -d, -f1 <<< $test)
    testCGO=$(cut -d, -f2 <<< $test)
    testDontStrip=$(cut -d, -f3 <<< $test)
    ldflags=$(cut -d, -f4 <<< $test)
    size=$(stat -c %s $testExe)
    sizeHuman=$(numfmt --to=iec-i --suffix=B $size)
    file=$(file $testExe | sed 's/,/\n/g' | grep -E 'stripped|debug_info|linked' | tr '\n' ',')
    echo "| $testCGO | $testDontStrip | $ldflags | $size ($sizeHuman) | $file |" >> $out/report.md
  done
''
