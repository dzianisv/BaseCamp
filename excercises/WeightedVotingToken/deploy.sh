#!/bin/sh

export $(< ../.env)
forge create --private-key=$ETH_KEY ./src/WeightedVotingToken.sol:WeightedVotingToken --verify