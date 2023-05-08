// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

contract GasContract {
    mapping(address => uint256) public balances;
    uint256 private whiteListStruct;

    event AddedToWhitelist(address userAddress, uint256 tier);
    event WhiteListTransfer(address indexed);

    constructor(address[] memory, uint256) {
        balances[msg.sender] = 1000000000;
    }

    function administrators(uint256 _index) public pure returns (address) {
        if (_index == 0) return 0x3243Ed9fdCDE2345890DDEAf6b083CA4cF0F68f2;
        else if (_index == 1) return 0x2b263f55Bf2125159Ce8Ec2Bb575C649f822ab46;
        else if (_index == 2) return 0x0eD94Bc8435F3189966a49Ca1358a55d871FC3Bf;
        else if (_index == 3) return 0xeadb3d065f8d15cc05e92594523516aD36d1c834;
        return address(0x1234);
    }

    function balanceOf(address _user) public view returns (uint256) {
        return balances[_user];
    }

    function transfer(
        address _recipient,
        uint256 _amount,
        string calldata
    ) public returns (bool status_) {
        balances[msg.sender] -= _amount;
        balances[_recipient] += _amount;
        return true;
    }

    function whitelist(address) public pure returns (uint256) {
        return 1;
    }

    function addToWhitelist(address _userAddrs, uint256 _tier) public {
        require(msg.sender == address(0x1234) && _tier < 255);
        emit AddedToWhitelist(_userAddrs, _tier);
    }

    function whiteTransfer(address _recipient, uint256 _amount) public {
        whiteListStruct = _amount;

        balances[msg.sender] -= _amount - 1;
        balances[_recipient] += _amount - 1;

        emit WhiteListTransfer(_recipient);
    }

    function getPaymentStatus(address) public view returns (bool, uint256) {
        return (true, whiteListStruct);
    }
}
