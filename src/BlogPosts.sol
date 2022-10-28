// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract BlogPosts is ERC721URIStorage {
    using Strings for uint256;
    using Strings for uint8;
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    mapping(uint256 => BlogPost) public idToPost;

    struct BlogPost {
        string title;
        string desc;
        uint date;
        string content;
    }

    BlogPost[] public blogPosts;

    constructor() ERC721("DBlog Posts", "DBlog") {}

    function generatePost(uint256 _tokenId)
        public
        view
        returns (string memory)
    {

            bytes memory svg = abi.encodePacked(
        '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350">',
        '<style>.base { fill: white; font-family: serif; font-size: 14px; }</style>',
        '<rect width="80%" height="80%" fill="white" />',
        '<text x="50%" y="20%" class="base" dominant-baseline="middle" text-anchor="middle">',
            getTitle(_tokenId),
            "</text>",
            '<text x="50%" y="50%" class="base" dominant-baseline="middle" text-anchor="middle">',
            getDesc(_tokenId),
            "</text>",
        '</svg>'
            );
    
        return
            string(
                abi.encodePacked(
            "data:image/svg+xml;base64,",
            Base64.encode(svg)
                )
            );
    }

    function getTokenUri(uint256 _tokenId) public view returns (string memory) {
        bytes memory dataURI = abi.encodePacked(
            "{",
            '"name": "Blog Post #', _tokenId.toString(),'",',
            '"title": "', getTit(_tokenId),'"',
            '"description": "', getDesc(_tokenId),'"',
            '"image": "', generatePost(_tokenId), '"',
            "}"
        );
        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(dataURI)
                )
            );
    }

    function getTitle(uint256 _tokenId) public view returns (string memory) {
        blogPosts memory post = idToPost[_tokenId];
        return post.title;
    }

    function getDesc(uint256 _tokenId) public view returns (string memory) {
        blogPosts memory post = idToPost[_tokenId];
        return post.desc;
    }

    function getDate(uint256 _tokenId) public view returns (string memory) {
        blogPosts memory post = idToPost[_tokenId];
        return post.date;
    }

        function getContent(uint256 _tokenId) public view returns (string memory) {
        blogPosts memory post = idToPost[_tokenId];
        return post.content;
    }

    function mint(string calldata _title, string calldata _description, string calldata _content) public {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _safeMint(msg.sender, newItemId);
        BlogPost memory post = BlogPost(_title, _description, block.timestamp, );
        blogPosts.push(post);
        idToPost[newItemId] = post;
        _setTokenURI(newItemId, getTokenUri(newItemId));
    }

    function train(uint256 _tokenId, string calldata _title, string calldata _desc, string calldata _content) public {
        require(_exists(_tokenId), "ID doesn't exist");
        require(ownerOf(_tokenId) == msg.sender, "non-ownership");
        BlogPost storage post = idToPost[_tokenId];
        if(_title.length != 0) {
        post.title = _title;
        }

        if(_desc.length != 0) {
            post.desc = _desc;
        }
        
        if(_content.length != 0) {
        post.content = _content;
        }

        _setTokenURI(_tokenId, getTokenUri(_tokenId));
    }
}
