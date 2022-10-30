// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {De_Blogs} from '../src/De_Blogs.sol';

contract De_BlogsTest is Test {

    De_Blogs blogPosts;
    function setUp() public {
        vm.startPrank(0xD0CE7E521d26CAc35a7B10d31d6CCc7ffFF8B15e);
        blogPosts = new De_Blogs();
        string[] memory str = new string[](2);
        blogPosts.mint("test", "test", "test", "test", str);
        blogPosts.mint("test", "test", "test", "test", str);
        blogPosts.mint("test", "test", "test", "test", str);
    }

    function testBlogsLen() public {
        uint i = blogPosts.getBlogsLen();
        assertTrue(i != 0);
        assertTrue(i == 3);
        assertTrue(i != 4);
    }


    function testState() public {
    }
}
