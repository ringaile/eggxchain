pragma solidity ^0.4.18;

contract SupplyChainList {
  // state variable
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

    function createEggBox(uint barcode, uint longitude, uint latitude) public{
        var eggBox = eggBoxes[eggBoxCounter];

        eggBox.barcode = barcode;
        eggBox.farmer = msg.sender;
        eggBox.timestamp = now;
        eggBox.longitude = longitude;
        eggBox.latitude = latitude;

        eggBoxCounter++;
    }

    function getEggBox(uint id) view public returns (
        uint , address , uint , uint , uint ) {
            return (eggBoxes[id].barcode, eggBoxes[id].farmer, eggBoxes[id].timestamp, eggBoxes[id].longitude, eggBoxes[id].latitude);
    }

}
