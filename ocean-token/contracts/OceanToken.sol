// contracts/OceanToken.sol
// SPDX-License-Identifier: MIT


//this is  a derived contract :- a derived contract is a contract that is created by inheriting properties and behaviors from another contract



//token design
//  total supply or max supply
//  initial supply 
//  burnabale
//  minitng strategy  
//  block reward   (for example:- for example giving reward to the miner)

            
            ///steps 


//1)initial supply (Send to owner) - 70,000,000
//2) max supply (capped)   - 100,000,000
//3)Make token burnable
//4)reate block reward to distribution new supply to miner 
           ///  we will use  hook _mintMinersReward to mint the token which will be depend on the reward to be given to the miner
//4)make token burnable  





pragma solidity ^0.8.17;


import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract OceanToken is ERC20Capped, ERC20Burnable {
    address payable public owner;
    uint256 public blockReward;


   constructor(uint256 cap, uint256 reward) ERC20("OceanToken", "OCT") ERC20Capped(cap * (10 ** decimals())) {
        owner = payable(msg.sender);
        _mint(owner, 70000000 * (10 ** decimals()));
        // it will give us eighteen decimal points to convert in human redable forma
        blockReward = reward * (10 ** decimals());
    }

 



//override function :- The purpose of overriding functions is to change the behavior of a base contract without having to modify the base contract directly
//it should have same parameter as in the base contract


//to check that the new token minted does not exceed the cap 
  function _mint(address account, uint256 amount) internal virtual override(ERC20Capped, ERC20) {
        require(ERC20.totalSupply() + amount <= cap(), "ERC20Capped: cap exceeded");
        super._mint(account, amount);
    }

    function _mintMinerReward() internal {
        _mint(block.coinbase, blockReward);
    }

    function _beforeTokenTransfer(address from, address to, uint256 value) internal virtual override {
        if(from != address(0) && to != block.coinbase && block.coinbase != address(0)) {
            _mintMinerReward();
        }
        super._beforeTokenTransfer(from, to, value);
    }

    function setBlockReward(uint256 reward) public onlyOwner {
        blockReward = reward * (10 ** decimals());
    }

    function destroy() public onlyOwner {
        selfdestruct(owner);
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }
}