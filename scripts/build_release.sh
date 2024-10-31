#!/bin/bash

mix deps.get --only prod
MIX_ENV=prod mix compile
MIX_ENV=prod mix assets.deploy
MIX_ENV=prod mix phx.digest 
mix phx.gen.release
MIX_ENV=prod mix release
