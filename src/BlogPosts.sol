// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import '@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol';
import '@openzeppelin/contracts/utils/Counters.sol';
import '@openzeppelin/contracts/utils/Strings.sol';
import '@openzeppelin/contracts/utils/Base64.sol';
import '@openzeppelin/contracts/access/Ownable.sol';

contract BlogPosts is ERC721URIStorage {
  using Strings for uint256;
  using Strings for uint8;
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  mapping(uint256 => BlogPost) public idToPost;

  struct BlogPost {
    string title;
    string desc;
    uint256 date;
    string content;
  }

  BlogPost[] public blogPosts;

  constructor() ERC721('DBlog Posts', 'DBlog') {
    // mint("First Test", "Test description of blog nft", "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.");
  }

  function grabInfo(uint256 _tokenId) public view returns (string memory) {
    bytes memory infos = abi.encodePacked(
        '<text x="50%" y="10%" class="base" dominant-baseline="middle" text-anchor="middle">',
      getTitle(_tokenId),
      '</text>',
      '<text x="50%" y="15%" class="base" dominant-baseline="middle" text-anchor="middle">',
      getDesc(_tokenId),
      '</text>',
      '<foreignObject x="10" y="40" width="95%" height="100%">',
      '<body xmlns="http://www.w3.org/1999/xhtml">',
      getContent(_tokenId),
      '</body>',
      '</foreignObject>');
    return string(infos);
  }

  function generatePost(uint256 _tokenId) public view returns (string memory) {
    bytes memory svg = abi.encodePacked(
      '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350" overflow="auto">',
      '<style>.base { fill: white; font-family: arial; font-size: 14px; }</style>',
      '<rect width="100%" height="100%" fill="black" />',
      grabInfo(_tokenId),
      '</svg>'
    );

    return string(abi.encodePacked('data:image/svg+xml;base64,', Base64.encode(svg)));
  }

  function getTokenUri(uint256 _tokenId) public view returns (string memory) {
    bytes memory dataURI = abi.encodePacked(    
      "{",
      '"name": "Blog Post #',
      _tokenId.toString(),
      '",',
      '"description": "',
      getDesc(_tokenId),
      '",',
      '"image": "',
      generatePost(_tokenId),
      '"',
      "}"
    );
    return string(abi.encodePacked('data:application/json;base64,', Base64.encode(dataURI)));
  }

  function getTitle(uint256 _tokenId) public view returns (string memory) {
    BlogPost memory post = idToPost[_tokenId];
    return post.title;
  }

  function getDesc(uint256 _tokenId) public view returns (string memory) {
    BlogPost memory post = idToPost[_tokenId];
    return post.desc;
  }

  function getDate(uint256 _tokenId) public view returns (uint256) {
    BlogPost memory post = idToPost[_tokenId];
    return post.date;
  }

  function getContent(uint256 _tokenId) public view returns (string memory) {
    BlogPost memory post = idToPost[_tokenId];
    return post.content;
  }

  function mint(
    string calldata _title,
    string calldata _description,
    string calldata _content
  ) public {
    _tokenIds.increment();
    uint256 newItemId = _tokenIds.current();
    _safeMint(msg.sender, newItemId);
    BlogPost memory post = BlogPost(_title, _description, block.timestamp, _content);
    blogPosts.push(post);
    idToPost[newItemId] = post;
    _setTokenURI(newItemId, getTokenUri(newItemId));
  }

  function updatePostTitle(uint256 _tokenId, string memory _title) public {
    require(_exists(_tokenId), "ID doesn't exist");
    require(ownerOf(_tokenId) == msg.sender, 'non-ownership');
    BlogPost storage post = idToPost[_tokenId];
    post.title = _title;

    _setTokenURI(_tokenId, getTokenUri(_tokenId));
  }

  function updatePostDesc(uint256 _tokenId, string memory _desc) public {
    require(_exists(_tokenId), "ID doesn't exist");
    require(ownerOf(_tokenId) == msg.sender, 'non-ownership');
    BlogPost storage post = idToPost[_tokenId];
    post.desc = _desc;

    _setTokenURI(_tokenId, getTokenUri(_tokenId));
  }

  function updatePostContent(uint256 _tokenId, string memory _content) public {
    require(_exists(_tokenId), "ID doesn't exist");
    require(ownerOf(_tokenId) == msg.sender, 'non-ownership');
    BlogPost storage post = idToPost[_tokenId];

    post.content = _content;

    _setTokenURI(_tokenId, getTokenUri(_tokenId));
  }
}
