pragma solidity ^0.4.18;

contract SupplyChainList {
  // state variable
  address contractOwner;
  uint eggBoxCounter;

  struct EggBox {
      uint id;
      uint barcode;
      address farmer;
      bool isInfected;
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

        eggBox.farmer = msg.sender;
        eggBox.barcode = barcode;
        eggBox.isInfected = false;
        TrackRecord memory trackedRecord = TrackRecord(now, longitude, latitude);
        eggBox.trackRecord.push(trackedRecord);

        eggBoxCounter++;
    }

    function getEggBox(uint id) view public returns (
        uint, address , bool, uint , uint , uint ) {
            return (eggBoxes[id].barcode, eggBoxes[id].farmer, eggBoxes[id].isInfected, eggBoxes[id].trackRecord[0].timestamp, eggBoxes[id].trackRecord[0].longitude, eggBoxes[id].trackRecord[0].latitude);
    }

    function setTrackRecord(uint id, uint timestamp, uint longitude, uint latitude) public{
            var noOfTracks = eggBoxes[id].trackRecord.length;
            
            TrackRecord memory trackedRecord = TrackRecord(timestamp, longitude, latitude);
            eggBoxes[id].trackRecord.push(trackedRecord);
    }

    function getTrackRecordOfEggBox(uint idOfEgg, uint idOfTrack) view public returns(uint, uint, uint){
            return(eggBoxes[idOfEgg].trackRecord[idOfTrack].timestamp, eggBoxes[idOfEgg].trackRecord[idOfTrack].longitude, eggBoxes[idOfEgg].trackRecord[idOfTrack].latitude);
    }

    function setEggBoxInfected(uint id) public{
        eggBoxes[id].isInfected = true;
    }

    function isEggBoxInfected(uint id) view public returns (bool){
        return eggBoxes[id].isInfected;
    }
    
    function updateAllInfectedEggBoxes(uint idOfEgg, uint idOfTrack) public {
        TrackRecord memory trackedRecord = TrackRecord(eggBoxes[idOfEgg].trackRecord[idOfTrack].timestamp, eggBoxes[idOfEgg].trackRecord[idOfTrack].longitude, eggBoxes[idOfEgg].trackRecord[idOfTrack].latitude);

        for (uint i =0; i < eggBoxCounter; i++){
            EggBox memory eb = eggBoxes[i];
            for (uint y = 0; y < eb.trackRecord.length; y++){
                if (eb.trackRecord[y].latitude == trackedRecord.latitude && 
                    eb.trackRecord[y].longitude == trackedRecord.longitude &&
                    eb.trackRecord[y].timestamp == trackedRecord.timestamp){
                        eggBoxes[i].isInfected = true;
                    }
            }
        }
    }

}
