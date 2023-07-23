#!/bin/sh

export $(< ../.env)
forge create --private-key=$ETH_KEY ./src/UnburnableToken.sol:UnburnableToken --verify