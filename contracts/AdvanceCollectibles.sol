// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract AdvanceCollectibles is ERC721 {
    uint256 public randomResult;
    uint256 public tokenCounter;
    uint256 public randNum;

    event RequestedRandomness(bytes32 requestId);
    event RequestCollectible(bytes32 indexed requestId);

    mapping(uint256 => address) public requestIdToSender;
    mapping(uint256 => string) public requestIdToTokenURI;
    mapping(uint256 => uint256) public requestIdToTokenId;

    constructor(
        address _vrfCoordinatorAddress,
        address _linkTokenAddress,
        bytes32 _keyHash
    ) public ERC721("SportStars Punk", "SSP") {
        tokenCounter = 0;
    }

    function mint(string memory tokenURI) public payable {
        uint256 newItemId = tokenCounter;

        // //sudo random number
        // uint256 randomNumber = uint256(
        //     keccak256(
        //         abi.encodePacked(msg.sender, block.difficulty, block.timestamp)
        //     )
        // );
        // requestIdToSender[randomNumber] = msg.sender;
        // requestIdToTokenURI[randomNumber] = tokenURI;
        _safeMint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);

        tokenCounter = tokenCounter + 1;
    }

    function setTokenURI(uint256 tokenId, string memory tokenURI) public {
        require(
            _isApprovedOrOwner(_msgSender(), tokenId),
            "ERC721: caller owner or approved"
        );
        _setTokenURI(tokenId, tokenURI);
    }
}
