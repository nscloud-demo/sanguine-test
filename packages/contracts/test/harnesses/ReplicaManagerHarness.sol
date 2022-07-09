// SPDX-License-Identifier: MIT

pragma solidity 0.8.13;

import { ReplicaManager } from "../../contracts/ReplicaManager.sol";

import { ReplicaLib } from "../../contracts/libs/Replica.sol";

contract ReplicaManagerHarness is ReplicaManager {
    using ReplicaLib for ReplicaLib.Replica;

    uint256 public sensitiveValue;

    constructor(
        uint32 _localDomain,
        uint256 _processGas,
        uint256 _reserveGas
    ) ReplicaManager(_localDomain, _processGas, _reserveGas) {}

    function setSensitiveValue(uint256 _newValue) external onlySystemMessenger {
        sensitiveValue = _newValue;
    }

    function setMessageStatus(
        uint32 _remoteDomain,
        bytes32 _messageHash,
        bytes32 _status
    ) external {
        allReplicas[activeReplicas[_remoteDomain]].setMessageStatus(_messageHash, _status);
    }
}
