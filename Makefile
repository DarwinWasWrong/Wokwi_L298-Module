name: Build Chip

on:
  push:
  workflow_dispatch:

jobs:
  build:
    name: Build
    runs-on: self-hosted
    steps:
      - name: Check out repository
        uses: actions/checkout@v4
      - name: Build chip
        uses: wokwi/wokwi-chip-clang-action@main
        with:
          sources: "src/L298-module.chip.c"
      - name: Copy chip.json
        run: sudo cp src/L298-module.chip.json dist
      - name: 'Upload Artifacts'
        uses: actions/upload-artifact@v4
        with:
          name: chip
          path: |
            dist/L298-module.chip.json
            dist/chip.wasm

  # The release job only runs when you push a tag starting with "v", e.g. v1.0.0 