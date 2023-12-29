pragma solidity >= 0.8.2 < 0.9.0;

import "./Mainchain.sol";

contract Sidechain {
    Mainchain public mainchain;
    address public owner;

    constructor(address _mainchainAddress) {
        mainchain = Mainchain(_mainchainAddress);
        owner = msg.sender;
    }

    event Locked(address indexed sender, uint256 amount);
    event Unlocked(address indexed sender, uint256 amount);

    function lock(uint256 amount) external {
        // Lock tokens in the sidechain
        require(mainchain.balances(address(this)) >= amount, "Insufficient balance in mainchain");
        mainchain.withdraw(amount);
        emit Locked(msg.sender, amount);
    }

    function unlock(uint256 amount) external {
        // Unlock tokens in the sidechain
        mainchain.deposit(amount);
        emit Unlocked(msg.sender, amount);
    }
}
