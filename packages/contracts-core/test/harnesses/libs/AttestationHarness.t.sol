// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import { Attestation } from "../../../contracts/libs/Attestation.sol";
import { TypedMemView } from "../../../contracts/libs/TypedMemView.sol";

/**
 * @notice Exposes Attestation methods for testing against golang.
 */
contract AttestationHarness {
    using Attestation for bytes;
    using Attestation for bytes29;
    using TypedMemView for bytes;
    using TypedMemView for bytes29;

    /*╔══════════════════════════════════════════════════════════════════════╗*\
    ▏*║                               GETTERS                                ║*▕
    \*╚══════════════════════════════════════════════════════════════════════╝*/

    function castToAttestation(uint40, bytes memory _payload)
        public
        view
        returns (uint40, bytes memory)
    {
        // Walkaround to get the forge coverage working on libraries, see
        // https://github.com/foundry-rs/foundry/pull/3128#issuecomment-1241245086
        bytes29 _view = Attestation.castToAttestation(_payload);
        return (_view.typeOf(), _view.clone());
    }

    function attestationData(uint40 _type, bytes memory _payload)
        public
        view
        returns (uint40, bytes memory)
    {
        bytes29 _view = _payload.ref(_type).attestationData();
        return (_view.typeOf(), _view.clone());
    }

    function notarySignature(uint40 _type, bytes memory _payload)
        public
        view
        returns (uint40, bytes memory)
    {
        bytes29 _view = _payload.ref(_type).notarySignature();
        return (_view.typeOf(), _view.clone());
    }

    function attestedDomain(uint40 _type, bytes memory _payload) public pure returns (uint32) {
        return _payload.ref(_type).attestedDomain();
    }

    function attestedNonce(uint40 _type, bytes memory _payload) public pure returns (uint32) {
        return _payload.ref(_type).attestedNonce();
    }

    function attestedRoot(uint40 _type, bytes memory _payload) public pure returns (bytes32) {
        return _payload.ref(_type).attestedRoot();
    }

    function isAttestation(bytes memory _payload) public pure returns (bool) {
        return _payload.castToAttestation().isAttestation();
    }

    /*╔══════════════════════════════════════════════════════════════════════╗*\
    ▏*║                              FORMATTERS                              ║*▕
    \*╚══════════════════════════════════════════════════════════════════════╝*/

    function formatAttestation(
        uint32 _domain,
        uint32 _nonce,
        bytes32 _root,
        bytes memory _signature
    ) public pure returns (bytes memory) {
        return formatAttestation(formatAttestationData(_domain, _nonce, _root), _signature);
    }

    function formatAttestation(bytes memory _data, bytes memory _signature)
        public
        pure
        returns (bytes memory)
    {
        return Attestation.formatAttestation(_data, _signature);
    }

    function formatAttestationData(
        uint32 _domain,
        uint32 _nonce,
        bytes32 _root
    ) public pure returns (bytes memory) {
        return Attestation.formatAttestationData(_domain, _nonce, _root);
    }

    /*╔══════════════════════════════════════════════════════════════════════╗*\
    ▏*║                           CONSTANT GETTERS                           ║*▕
    \*╚══════════════════════════════════════════════════════════════════════╝*/

    function attestationDataLength() public pure returns (uint256) {
        return Attestation.ATTESTATION_DATA_LENGTH;
    }

    function offsetOrigin() public pure returns (uint256) {
        return Attestation.OFFSET_ORIGIN_DOMAIN;
    }

    function offsetNonce() public pure returns (uint256) {
        return Attestation.OFFSET_NONCE;
    }

    function offsetRoot() public pure returns (uint256) {
        return Attestation.OFFSET_ROOT;
    }

    function offsetSignature() public pure returns (uint256) {
        return Attestation.OFFSET_SIGNATURE;
    }
}