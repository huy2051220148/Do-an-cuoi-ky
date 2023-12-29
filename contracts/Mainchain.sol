pragma solidity >= 0.8.2 < 0.9.0;

contract Mainchain {
    mapping(address => uint256) public balances;

    event Deposit(address indexed user, uint256 amount);
    event Withdrawal(address indexed user, uint256 amount);

    function deposit(uint256 amount) external {
        // Transfer tokens from user to this contract
        balances[msg.sender] += amount;
        emit Deposit(msg.sender, amount);
    }

    function withdraw(uint256 amount) external {
        // Transfer tokens from this contract to user
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        emit Withdrawal(msg.sender, amount);
    }
}
