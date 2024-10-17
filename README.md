# Description

This code is to create a proveably randon smart contract lottery. It implements chainlink VRF2.5 to generate a random number which is used to determine the winner.

## What we want it to do

1. Users can enter by paying for a ticket
2. After a period of time, the lottery automatically draws the winner
3. The ticket fees go to the winner after the draw

## Documentation

https://book.getfoundry.sh/

## SetUp

```
git clone https://github.com/SpringxDSay/Smart-Lottery-Contract
```

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
