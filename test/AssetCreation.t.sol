// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "ds-test/src/test.sol";
import "../src/AssetCreation.sol";

interface CheatCodes {
    function warp(uint256) external;
}

contract AssetCreationTest is DSTest {
    CheatCodes constant cheats = CheatCodes(HEVM_ADDRESS);

    AssetCreation public eg;

    uint256 constant amount = 100;
    uint256 constant raisedAmount = 300;
    address public user = 0xeCf6d20544D0e84ca3Ab683F0394158E6c75eAaE; //vault address atm
    address private creator;

    function setUp() public {
        eg = new AssetCreation(amount, raisedAmount, user);
        creator = 0x1234567890123456789012345678901234567890;
        eg.startContract(creator, 50);
    }

    function testStartContract() public {
        assertEq(creator, eg.getCreator());
    }

    function testCheckIfUser() public {
        assertEq(user, eg.getUser());
    }

    function testTimeRemaining() public view {
        eg.checkTimeRemaining();
    }

    function testCheckUpkeep() public {
        bytes memory data = '';
        bool upkeepNeeded = false;
        (upkeepNeeded, ) = eg.checkUpkeep(data);
        assertTrue(upkeepNeeded == false);
        cheats.warp(block.timestamp + 100);
        (upkeepNeeded, ) = eg.checkUpkeep(data);
        assertTrue(upkeepNeeded);
    }

    function testPerformUpkeep() public {
        bytes memory data = '';
        
        cheats.warp(block.timestamp + 100);
        eg.performUpkeep(data);

        assertTrue(true);
        //check variables true
    }
}
