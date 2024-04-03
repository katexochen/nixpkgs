#!/usr/bin/env bash

set -eou pipefail

readonly imgName="appliance-gpt-image_1-rc1.raw"

rm -rf build*
rm -f result

nix build --builders "" .#nixosTests.appliance-repart-image.nodes.machine.system.build.image
mkdir build-a
cp result/* build-a

resultPath=$(readlink result)
rm result
nix store delete "$resultPath"

nix build --builders "" .#nixosTests.appliance-repart-image.nodes.machine.system.build.image
mkdir build-b
cp result/* build-b

for part in "root" "efi"; do
    extract ${part} "build-a/${imgName}" "build-a/${part}"
    extract ${part} "build-b/${imgName}" "build-b/${part}"
done

sumsA=$(sha256sum build-a/* | rev | sort | rev)
sumsB=$(sha256sum build-b/* | rev | sort | rev)

echo
while IFS= read -r new && IFS= read -r old <&3; do
  sumA=$(echo "${old}" | cut -d' ' -f1)
  sumB=$(echo "${new}" | cut -d' ' -f1)
  if [[ "${sumA}" != "${sumB}" ]]; then
    echo "${new}"
    echo "${old}"
    echo
    exitcode=1
  fi
done <<< "${sumsA}" 3<<< "${sumsB}"

exit "${exitcode}"
