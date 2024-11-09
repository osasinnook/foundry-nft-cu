// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Encoding {
    function combineStrings() public pure returns (string memory) {
        return string(abi.encodePacked("Hi Mom! ", "Miss you."));
    }

   
       function encodeNumber() public pure returns (bytes memory) {
        bytes memory number = abi.encode(1);
        return number;
    }

    // You'd use this to make calls to contracts
    function encodeString() public pure returns (bytes memory) {
        bytes memory someString = abi.encode("some string");
        return someString;
    }
    // This is great if you want to save space, not good for calling functions.
    // You can sort of think of it as a compressor for the massive bytes object above.
    function encodeStringPacked() public pure returns (bytes memory) {
        bytes memory someString = abi.encodePacked("some string");
        return someString;
    }

    // This is just type casting to string
    // It's slightly different from below, and they have different gas costs
    function encodeStringBytes() public pure returns (bytes memory) {
        bytes memory someString = bytes("some string");
        return someString;
    }

    function decodeString() public pure returns (string memory) {
        string memory someString = abi.decode(encodeString(), (string));
        return someString;
    }

    function multiEncode() public pure returns (bytes memory) {
        bytes memory someString = abi.encode("some string", "it's bigger!");
        return someString;
    }

    // Gas: 24612
    function multiDecode() public pure returns (string memory, string memory) {
        (string memory someString, string memory someOtherString) = abi.decode(multiEncode(), (string, string));
        return (someString, someOtherString);
    }

    function multiEncodePacked() public pure returns (bytes memory) {
        bytes memory someString = abi.encodePacked("some string", "it's bigger!");
        return someString;
    }

    // This doesn't work!
    function multiDecodePacked() public pure returns (string memory) {
        string memory someString = abi.decode(multiEncodePacked(), (string));
        return someString;
    }

    // This does!
    // Gas: 22313
    function multiStringCastPacked() public pure returns (string memory) {
        string memory someString = string(multiEncodePacked());
        return someString;
    }

    

    function withdraw(address recentWinner) public {
        (bool success,) = recentWinner.call{value: address(this).balance}("");
        require(success, "Transfer Failed");
    }

}