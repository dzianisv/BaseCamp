#!/bin/sh

export $(< ../.env)
forge create --private-key=$ETH_KEY ./src/HaikuNFT.sol:HaikuNFT --verify