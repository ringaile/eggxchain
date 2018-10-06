pragma solidity ^0.4.18;

contract SupplyChainList {
  // state variable
  address seller;
  string name;
  string description;
  uint256 price;
  address contractOwner;
  uint eggBoxCounter;

  struct EggBox {
      uint id;
      uint barcode;
      address farmer;
      uint timestamp;
      uint longitude;
      uint latitude;
  }

  mapping (uint => EggBox) public eggBoxes;

  //constructor
  constructor() public {
      contractOwner = msg.sender;
      eggBoxCounter = 0;
  }

  //
  function createEggBox(uint _barcode, uint _longitude, uint _latitude) public{
      eggBoxes[eggBoxCounter] = EggBox(
          eggBoxCounter,
          _barcode,
          msg.sender,
          now,
          _longitude,
          _latitude
      );
      eggBoxCounter++;
    }


    function getEggBox(uint id) public view returns (
        uint _id,
        uint _barcode,
        address _farmer,
        uint _timestamp,
        uint _longitude,
        uint _latitude) {
            EggBox memory eggbox = eggBoxes[id];
            return (eggbox.id, eggbox.barcode, eggbox.farmer, eggbox.timestamp, eggbox.longitude, eggbox.latitude);
    }

}
