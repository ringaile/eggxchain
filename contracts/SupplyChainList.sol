pragma solidity ^0.4.18;

contract SupplyChainList {

    struct EggBox {
        uint id;
        uint barcode;
        address farmer;
        uint timestamp;
        uint longitude;
        uint latitude;
    }

    mapping (uint => EggBox) public eggBoxes;
    uint eggBoxCounter;

    address contractOwner;

    function SupplyChainList() public {
        contractOwner = msg.sender;
        eggBoxCounter = 0;
    }

    function createEggBox(uint barcode, uint longitude, uint latitude) public{
        eggBoxCounter++;
        eggBoxes[eggBoxCounter] = EggBox(
            eggBoxCounter,
            barcode,
            msg.sender,
            now,
            longitude,
            latitude
        );
    }

    function getEggBox(uint id) public returns (
        uint barcode, address farmer, uint timestamp, uint longitude, uint latitude) {
            EggBox memory eggbox = eggBoxes[id];
            return (eggbox.barcode, eggbox.farmer, eggbox.timestamp, eggbox.longitude, eggbox.latitude);
    }
}