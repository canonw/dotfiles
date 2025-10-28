#!/usr/bin/env bash

find $(git rev-parse --show-toplevel) -name "*_settings.json" | xargs -I {} code {}
