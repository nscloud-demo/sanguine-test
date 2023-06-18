// Code generated by "stringer -type=ContractType -linecomment"; DO NOT EDIT.

package types

import "strconv"

func _() {
	// An "invalid array index" compiler error signifies that the constant values have changed.
	// Re-run the stringer command to generate them again.
	var x [1]struct{}
	_ = x[OriginContract-1]
	_ = x[DestinationContract-2]
	_ = x[LightInboxContract-3]
	_ = x[InboxContract-4]
	_ = x[Other-5]
}

const _ContractType_name = "OriginContractDestinationContractLightInboxContractInboxContractOther"

var _ContractType_index = [...]uint8{0, 14, 33, 51, 64, 69}

func (i ContractType) String() string {
	i -= 1
	if i < 0 || i >= ContractType(len(_ContractType_index)-1) {
		return "ContractType(" + strconv.FormatInt(int64(i+1), 10) + ")"
	}
	return _ContractType_name[_ContractType_index[i]:_ContractType_index[i+1]]
}
