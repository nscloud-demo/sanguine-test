// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "forge-std/Test.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract SynapseUtilities is Test {
    struct RawAttestation {
        uint32 origin;
        uint32 destination;
        uint32 nonce;
        bytes32 root;
        uint40 blockNumber;
        uint40 timestamp;
        bytes data;
    }

    /*╔══════════════════════════════════════════════════════════════════════╗*\
    ▏*║                              CONSTANTS                               ║*▕
    \*╚══════════════════════════════════════════════════════════════════════╝*/

    bytes internal constant REVERT_ALREADY_INITIALIZED =
        "Initializable: contract is already initialized";
    bytes internal constant REVERT_NOT_OWNER = "Ownable: caller is not the owner";

    uint256 internal constant BLOCK_TIME = 12;

    /*╔══════════════════════════════════════════════════════════════════════╗*\
    ▏*║                                UTILS                                 ║*▕
    \*╚══════════════════════════════════════════════════════════════════════╝*/

    function expectRevertAlreadyInitialized() public {
        vm.expectRevert(REVERT_ALREADY_INITIALIZED);
    }

    function expectRevertNotOwner() public {
        vm.expectRevert(REVERT_NOT_OWNER);
    }

    function skipBlock() public {
        skipBlocks(1);
    }

    function skipBlocks(uint256 blocks) public {
        vm.roll(block.number + blocks);
        skip(blocks * BLOCK_TIME);
    }

    function addressToBytes32(address addr) public pure returns (bytes32) {
        return bytes32(uint256(uint160(addr)));
    }

    function bytes32ToAddress(bytes32 buf) public pure returns (address) {
        return address(uint160(uint256(buf)));
    }

    function castToArray(address addr) public pure returns (address[] memory) {
        if (addr == address(0)) return new address[](0);
        address[] memory array = new address[](1);
        array[0] = addr;
        return array;
    }

    function generateAddress(bytes memory salt) public pure returns (address) {
        return bytes32ToAddress(keccak256(salt));
    }

    function generatePrivateKey(bytes memory salt) public pure returns (uint256) {
        return uint256(keccak256(salt));
    }

    function getActorSuffix(uint256 actorIndex) public pure returns (string memory) {
        return actorIndex == 0 ? "" : string.concat("[", Strings.toString(actorIndex), "]");
    }
}
