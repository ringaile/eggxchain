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
      uint trackCounter;
      TrackRecord[] trackRecord;
  }

  struct TrackRecord{
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
        eggBox.trackCounter = 0;

        eggBoxCounter++;
    }

    function getEggBox(uint id) view public returns (
        uint , address , uint , uint , uint ) {
            return (eggBoxes[id].barcode, eggBoxes[id].farmer, eggBoxes[id].timestamp, eggBoxes[id].longitude, eggBoxes[id].latitude);
    }

    function setTrackRecord(uint id, uint timestamp, uint longitude, uint latitude) public{
            var noOfTracks = eggBoxes[id].trackCounter;
            
            TrackRecord memory trackedRecord = TrackRecord(timestamp, longitude, latitude);
            eggBoxes[id].trackRecord.push(trackedRecord);
            eggBoxes[id].trackCounter = noOfTracks + 1;
    }

    function getTrackRecordOfEggBox(uint idOfEgg, uint idOfTrack) view public returns(uint, uint, uint){
            return(eggBoxes[idOfEgg].trackRecord[idOfTrack].timestamp, eggBoxes[idOfEgg].trackRecord[idOfTrack].longitude, eggBoxes[idOfEgg].trackRecord[idOfTrack].latitude);
    }

}
