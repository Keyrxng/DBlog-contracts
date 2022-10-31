// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {De_Blogs} from '../src/De_Blogs.sol';

contract De_BlogsTest is Test {

      struct BlogPost {
    string title;
    string desc;
    string content;
    string img;
    string tags;
    uint256 date;
  }


    De_Blogs blogPosts;
        address eoa = 0xD0CE7E521d26CAc35a7B10d31d6CCc7ffFF8B15e;
    function setUp() public {
        vm.startPrank(eoa);
        blogPosts = new De_Blogs();
        blogPosts.mint("test", "test", "test", "test", 'lol,at,you');
        blogPosts.mint("test", "test", "test", "test", 'lol,at,you');
        blogPosts.mint("test", "test", "test", "test", 'lol,at,you');
    }

    function testBlogsLen() public {
        uint i = blogPosts.getBlogsLen();
        assertTrue(i != 0);
        assertTrue(i == 3);
        assertTrue(i != 4);
    }


    function testMint() public {
        blogPosts.mint(
            '<p>This is the initial content of the editor.</p>',
            'Tokenized Blogging',
            'Decentralized on-chain blogging with a twist',
            'ipfs://QmUvSpj7Rr1XkMzA7H9N9Yweh7XfLVVwXNVjxmnmbi7B2P/0',
            'lol,at,you');
        
        assertTrue(blogPosts.balanceOf(eoa) == 4);
            
    }

    function testEditContent() public {
        blogPosts.mint(
            '<p>This is the initial content of the editor.</p>',
            'Tokenized Blogging',
            'Decentralized on-chain blogging with a twist',
            'ipfs://QmUvSpj7Rr1XkMzA7H9N9Yweh7XfLVVwXNVjxmnmbi7B2P/0',
            'lol,at,you');
        vm.warp(1);
        
        string memory first = blogPosts.getContent(4);
        blogPosts.updatePostContent(4, 'The standard Lorem Ipsum passage, used since the 1500s "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."  Section 1.10.32 of "de Finibus Bonorum et Malorum", written by Cicero in 45 BC "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"  1914 translation by H. Rackham "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain some advantage from it? But who has any right to find fault with a man who chooses to enjoy a pleasure that has no annoying consequences, or one who avoids a pain that produces no resultant pleasure?"');
        vm.warp(1);
        string memory second = blogPosts.getContent(4);
    
    }

    function testEditContentReturned() public {

        blogPosts.mint(
            '<p>This is the initial content of the editor.</p>',
            'Tokenized Blogging',
            'Decentralized on-chain blogging with a twist',
            'ipfs://QmUvSpj7Rr1XkMzA7H9N9Yweh7XfLVVwXNVjxmnmbi7B2P/0',
            'lol,at,you');
        vm.warp(1);
        blogPosts.updatePostContent(4, 'The standard Lorem Ipsum passage, used since the 1500s "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."  Section 1.10.32 of "de Finibus Bonorum et Malorum", written by Cicero in 45 BC "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"  1914 translation by H. Rackham "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain some advantage from it? But who has any right to find fault with a man who chooses to enjoy a pleasure that has no annoying consequences, or one who avoids a pain that produces no resultant pleasure?"');
        vm.warp(1);
        string memory second = blogPosts.getContent(4);
        

        string memory res = blogPosts.generatePost(4);
        string memory rez = blogPosts.getTokenUri(4);
        console.log(rez);

    }

    function testReturn() public {
        uint256 returned = blogPosts.getBlogsLen();
        
        assertTrue(returned == 3);



    }
    
    }
