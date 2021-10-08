// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

//import "@chainlink/contracts/src/v0.6/VRFConsumerBase.sol"
contract AdvanceCollectibles is ERC721 {
    //pragma solidity >=0.6.0 <0.8.0;conLi
    bytes32 internal keyHash;
    uint256 internal fee;
    uint256 public randomResult;
    uint256 public tokenCounter;
    address public LinkToken;
    string public checkEx;
    uint256 public randNum;

    enum Breed {
        PUG,
        PUG2,
        SHIBA_INU,
        ST_BERNARD
    }

    event RequestedRandomness(bytes32 requestId);
    event RequestCollectible(bytes32 indexed requestId);

    mapping(uint256 => address) public requestIdToSender;
    mapping(uint256 => string) public requestIdToTokenURI;
    mapping(uint256 => Breed) public tokenIdToBreed;
    mapping(uint256 => uint256) public requestIdToTokenId;

    constructor(
        address _vrfCoordinatorAddress,
        address _linkTokenAddress,
        bytes32 _keyHash
    ) public ERC721("Doggies", "DOG") {
        keyHash = _keyHash;
        LinkToken = _linkTokenAddress;
        fee = 1.0 * 10**18;
        tokenCounter = 0;
    }

    string public mockVar;
    event myEvent(bytes32 requestId);

    // function getrequestIdToSender(bytes32 requestId)
    //     public
    //     view
    //     returns (address)
    // {
    //     return requestIdToSender[requestId];
    // }

    // function getrequestIdToTokenURI(bytes32 requestId)
    //     public
    //     view
    //     returns (string memory)
    // {
    //     return requestIdToTokenURI[requestId];
    // }

    // function gettokenIdToBreed(uint32 tokenId) public view returns (Breed) {
    //     return tokenIdToBreed[tokenId];
    // }

    // function gettokenIdToBreedStr(uint32 tokenId)
    //     public
    //     view
    //     returns (string memory)
    // {
    //     Breed breed = Breed(tokenId);

    //     if (Breed.PUG == breed) return "PUG";
    //     if (Breed.SHIBA_INU == breed) return "SHIBA_INU";
    //     if (Breed.ST_BERNARD == breed) return "ST_BERNARD";
    // }

    // function getrequestIdToTokenId(bytes32 requestId)
    //     public
    //     view
    //     returns (uint256)
    // {
    //     return requestIdToTokenId[requestId];
    // }

    // function check4(string memory str) public payable returns (bytes32) {
    //     require(
    //         LINK.balanceOf(address(this)) > fee,
    //         "Not enough LINK - fill contract with Link"
    //     );
    //     bytes32 requestId;
    //     checkEx = str;

    //     for (int256 i = 0; i < 4; i++) {
    //         require(
    //             LINK.balanceOf(address(this)) > fee,
    //             "Not enough LINK - fill contract with Link"
    //         );
    //         requestId = requestRandomness(keyHash, fee);
    //         requestIdToSender[requestId] = msg.sender;
    //         requestIdToTokenURI[requestId] = str;
    //         emit RequestCollectible(requestId);
    //     }
    //     return requestId;
    // }

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

    /**
     * Callback function used by VRF Coordinator
     */
    // function fulfillRandomness(bytes32 requestId, uint256 randomNumber)
    //     internal
    //     override
    // {
    //     address dogOwner = requestIdToSender[requestId];
    //     string memory tokenURI = requestIdToTokenURI[requestId];
    //     randNum = randomNumber;
    //     uint256 newItemId = tokenCounter;

    //     _safeMint(dogOwner, newItemId);
    //     _setTokenURI(newItemId, tokenURI);

    //     Breed breed = Breed(newItemId);
    //     tokenIdToBreed[newItemId] = breed;
    //     requestIdToTokenId[requestId] = newItemId;
    //     tokenCounter = tokenCounter + 1;
    //     //randomResult = randomNumber;
    // }

    function setTokenURI(uint256 tokenId, string memory tokenURI) public {
        require(
            _isApprovedOrOwner(_msgSender(), tokenId),
            "ERC721: caller owner or approved"
        );
        _setTokenURI(tokenId, tokenURI);
    }

    /**
     * Requests randomness from a user-provided seed
     */
    // function getRandomNumber() public returns (bytes32 requestId) {
    //     requestId = requestRandomness(keyHash, fee);
    //     emit RequestedRandomness(requestId);
    // }

    // /**
    //  * Requests the address of the Chainlink Token on this network
    //  */
    // function getChainlinkToken() public view returns (address) {
    //     return address(LINK);
    // }
}
