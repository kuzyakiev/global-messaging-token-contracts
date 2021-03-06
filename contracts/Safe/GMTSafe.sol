pragma solidity 0.4.17;

import 'contracts/Tokens/StandardToken.sol';

// @title GMT Safe contract - Contract to record employee token allocations
// @author Preethi Kasireddy - <preethi@mercuryprotocol.com>

// Need to deposit 100,450,000 GMT here
contract GMTSafe {

  /*
  *  GMTSafe parameters
  */
  mapping (address => uint256) allocations;
  uint256 public unlockDate;
  StandardToken public gmtAddress;


  function GMTSafe(StandardToken _gmtAddress) public {
    require(address(_gmtAddress) != 0x0);

    gmtAddress = _gmtAddress;
    unlockDate = now + 6 * 30 days;

    // Add allocations (must store the token grain amount to be transferred, i.e. 7000 * 10**18)
    allocations[0x6Ab16B4CF38548A6ca0f6666DEf0b7Fb919E2fAb] = 1500000 * 10**18;
    allocations[0x18751880F17E2cdfbb96C2385A82694ff76C9fb4] = 8000000 * 10**18;
    allocations[0x80e97B28f908A49887463e08005A133F7488FcCb] = 6000000 * 10**18;
    allocations[0x68981694e0a4140Db93B1F4f29DCCbB7E63127cf] = 6000000 * 10**18;
    allocations[0xF9a5876A076266b8362A85e26c3b7ce4a338ca6A] = 5500000 * 10**18;
    allocations[0x6FCC6070180E25CBb08a4BF4d2d841914fE3F4D3] = 6000000 * 10**18;
    allocations[0xa0580E8404e07415459cA8E497A9a14c0c9e674e] = 6000000 * 10**18;
    allocations[0x41C341147f76dDe749061A7F114E60B087f5417a] = 3000000 * 10**18;
    allocations[0x53163423D3233fCaF79F3E5b29321A9dC62F7c1b] = 6000000 * 10**18;
    allocations[0x9D8405E32d64F163d4390D4f2128DD20C5eFd2c5] = 6500000 * 10**18;
    allocations[0xe5070738809A16E21146D93bd1E9525539B0537F] = 6000000 * 10**18;
    allocations[0x147c39A17883D1d5c9F95b32e97824a516F02938] = 4000000 * 10**18;
    allocations[0x90dA392F16dBa254C8Ebb2773394A9E2a4693996] = 4000000 * 10**18;
    allocations[0xfd965026631CD4235f7a9BebFcF9B2063A93B89d] = 4000000 * 10**18;
    allocations[0x51d3Fa7e2c61a96C0B93737A6f866F7D92Aaaa64] = 4000000 * 10**18;
    allocations[0x517A577e51298467780a23E3483fD69e617C417d] = 4000000 * 10**18;
    allocations[0x4FdD9136Ccff0acE084f5798EF4973D194d5096a] = 4000000 * 10**18;
    allocations[0x684b9935beA0B3d3FD7Dcd3805E4047E94F753Be] = 4000000 * 10**18;
    allocations[0x753e324cfaF03515b6C3767895F4db764f940c36] = 2000000 * 10**18;
    allocations[0xD2C3b32c3d23BE008a155eBEefF816FA30E9FD33] = 2000000 * 10**18;
    allocations[0x5e8fE6bCdb699837d27eD8F83cD5d822261C9477] = 2000000 * 10**18;
    allocations[0xbf17d390DFBa5543B9BD43eDa921dACf44d5B938] = 2000000 * 10**18;
    allocations[0x13B46bEA905dC7b8BA5A0cc3384cB67af62bBD5d] = 1000000 * 10**18;
    allocations[0xfdB892D3C0dA81F146537aBE224E92d104Ca0FCf] = 1000000 * 10**18;
    allocations[0xc0D51078dfe76238C80b44f91053887a61eF5bC8] = 500000 * 10**18;
    allocations[0xfe1864D700899D9d744BC8d1FC79693E7d184556] = 500000 * 10**18;
    allocations[0xEA836E0A52423ad49c234858016d82a40C2bd103] = 500000 * 10**18;  
    allocations[0xAA989BE25a160d4fb83b12d238133d86f9C1f388] = 450000 * 10**18;
  }

  /// @notice transfer `allocations[msg.sender]` tokens to `msg.sender` from this contract
  /// @dev The GMT allocations given to the msg.sender are transfered to their account if the lockup period is over
  /// @return boolean indicating whether the transfer was successful or not
  function unlock() external {
    require(now >= unlockDate);

    uint256 entitled = allocations[msg.sender];
    require(entitled > 0);
    allocations[msg.sender] = 0;

    if (!StandardToken(gmtAddress).transfer(msg.sender, entitled)) {
        revert();  // Revert state due to unsuccessful refund
    }
  }
}
