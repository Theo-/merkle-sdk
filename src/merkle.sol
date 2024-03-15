// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Vm} from "forge-std/Vm.sol";

interface mvm is Vm {
    // additional vm methods
    struct TxDetails {
        bytes data;
        uint256 maxFeePerGas;
        uint256 maxPriorityFeePerGas;
        uint256 gasLimit;
        address to;
        uint256 value;
    }

    // create a new signer
    function createSigner() external returns (address);

    // broadcast tx with signer
    // returns a hash of the tx
    function broadcastTx(
        address signer,
        TxDetails calldata details
    ) external returns (bytes32);

    // broadcast a bundle of signed txs
    function broadcastRawBundle(
        bytes[] calldata txs
    ) external returns (bytes32);

    // broadcast a raw signed tx
    function broadcastRawTx(bytes calldata tx) external returns (bytes32);

    // get the current base fee
    function baseFee() external view returns (uint256);
}

library merkle {
    function vm() public pure returns (mvm) {
        address vmAddr = address(
            uint160(uint256(keccak256("hevm cheat code")))
        );

        return mvm(vmAddr);
    }
}
