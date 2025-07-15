//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {MockV3Aggregator} from "../test/mocks/MockAggregatorV3.sol";
contract HelperConfig is Script {



uint8 public constant DECIMALS = 8;
int256 public constant INITIAL_PRICE = 2000e8; // 2000 USD
NetworkConfig public activeNetworkConfig;
struct NetworkConfig{
    address PriceFeed;
}

constructor() {
    if(block.chainid == 11155111){
        activeNetworkConfig = getSepoliaEthConfig();
    }

    else if(block.chainid == 1){
        activeNetworkConfig = getMainNetEthConfig();
    }
    else{
        activeNetworkConfig = getOrCreateAnvilEthConfig();
    }
}

function getSepoliaEthConfig() public pure returns (NetworkConfig memory) {

    NetworkConfig memory sepoliaConfig = NetworkConfig({
        PriceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306 // Sepolia ETH/USD price feed
    });
    return sepoliaConfig;

}

function getOrCreateAnvilEthConfig() public returns (NetworkConfig memory) {
    if (activeNetworkConfig.PriceFeed != address(0)) {
        return activeNetworkConfig; 
    }

    vm.startBroadcast();
    MockV3Aggregator mockPriceFeed = new MockV3Aggregator(DECIMALS,INITIAL_PRICE);
    vm.stopBroadcast();

    NetworkConfig memory anvilConfig = NetworkConfig({
        PriceFeed: address(mockPriceFeed) // Anvil ETH/USD price feed
    });
    return anvilConfig;

}

function getMainNetEthConfig() public pure returns (NetworkConfig memory) {

    NetworkConfig memory sepoliaConfig = NetworkConfig({
        PriceFeed:0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419  // Mainnet ETH/USD price feed
    });
    return sepoliaConfig;}

}