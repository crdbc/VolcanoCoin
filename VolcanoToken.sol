// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract VolcanoToken is ERC721, Ownable {

    struct TokenData {
    uint256 time;
    uint256 tokenId;
    string tokenUri;
  }

  uint256 tokenId;

  mapping(address => TokenData[]) public token_ownership;

  constructor() ERC721("VolcanoToken", "VOL"){

  }

  function mintToken() public {

    string memory uri = tokenURI(tokenId);

    TokenData memory newTokenData = TokenData(block.timestamp, tokenId, uri);

    _safeMint(msg.sender, tokenId);

    token_ownership[msg.sender].push(newTokenData);

    tokenId += 1;
  }

  function burnToken(uint256 _tokenId) public {

    require(owner() == msg.sender, "Only the owner can burn tokens");

    _burn(_tokenId);
    removeBurnedTokenId(_tokenId);
  }

  function removeBurnedTokenId(uint256 _tokenId) internal {
    
    TokenData[] memory userPayments = token_ownership[msg.sender];

    for(uint256 i = 0; i < userPayments.length; i++){

      if(token_ownership[msg.sender][i].tokenId == _tokenId){
        delete token_ownership[msg.sender][i];
      }
    }
  }
}
