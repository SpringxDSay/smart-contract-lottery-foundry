// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from 'forge-std/Script.sol';
import {Raffle} from 'src/Raffle.sol';
import {HelperConfig} from 'script/HelperConfig.s.sol';
import {CreateSubId, FundSubscription, AddConsumer} from 'script/Interactions.s.sol';

contract DeployRaffle is Script {
    function run() public {
        deployContract();
    }

    function deployContract() public returns(Raffle, HelperConfig) {
        HelperConfig helperConfig = new HelperConfig();
        // local => deploy mocks => get local config
        // sepolia => get sepolia config
        HelperConfig.NetworkConfig memory config  = helperConfig.getConfig();

        if(config.subscriptionId == 0){
            // Create Subscription
            CreateSubId createSubId = new CreateSubId();
            (config.subscriptionId, config.vrfCoordinator) = createSubId.createSubscription(config.vrfCoordinator, config.account);
            // Fund Subscription
            FundSubscription fundSubscription = new FundSubscription();
            fundSubscription.fundSubscription(config.vrfCoordinator, config.subscriptionId, config.link, config.account);
        }

        vm.startBroadcast(config.account);
        Raffle raffle = new Raffle(
            config.entranceFee,
            config.interval,
            config.vrfCoordinator,
            config.gasLane,
            config.subscriptionId,
            config.callbackGasLimit
        );
        vm.stopBroadcast();

        AddConsumer addConsumer = new AddConsumer();
        addConsumer.addConsumer(address(raffle), config.vrfCoordinator, config.subscriptionId, config.account);

        return (raffle, helperConfig);
    }
}

