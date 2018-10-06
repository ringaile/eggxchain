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

  event LogCreateEggBoxPoint(
    uint _id,
    uint _barcode,
    address _farmer,
    uint indexed _timestamp,
    uint indexed _longitude,
    uint indexed _latitude
  );

  //constructor
  constructor() public {
      contractOwner = msg.sender;
  }

  function createEggBox(uint _barcode, uint _longitude, uint _latitude) public{
    uint _timestamp;
    _timestamp = now;

    eggBoxes[eggBoxCounter] = EggBox(
      eggBoxCounter,
      _barcode,
      msg.sender,
      now,
      _longitude,
      _latitude
    );
    emit LogCreateEggBoxPoint(eggBoxCounter, _barcode, msg.sender, _timestamp, _longitude, _latitude);
    eggBoxCounter++;
  }

  function getEggBox(uint id) view public returns (
      uint , address , uint , uint , uint ) {
          return (eggBoxes[id].barcode, eggBoxes[id].farmer, eggBoxes[id].timestamp, eggBoxes[id].longitude, eggBoxes[id].latitude);
  }
}
