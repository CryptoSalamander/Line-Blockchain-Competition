/// This is made for Line Hackerton in 2018.
/// Made by Team Chainerator
/// Ver 0.1
pragma solidity ^0.4.0;
contract Pediblock{
    
   enum AnimalType { None, Dog, Cat, Horse }
   enum CAList { None, KKF, FCI, KRA }
   struct Pedigree{
       uint index;
       AnimalType animal;
       string species;
       string picURL;
       string name;
       uint masterID;
       CAList CA;
       uint mID;
       uint fID;
       bool onsale;
   }
   
   struct Master{
       uint index;
       string nation;
       string name;
       string email;
       string phone;
       address ID;
   }
   
   mapping(uint => Pedigree) pedigrees;
   mapping(uint => Master) masters;
   uint numPedigrees;
   uint numMasters;
   address owner;

   function constuctor() public {
   numPedigrees = 1;
   numMasters = 1;
   owner = msg.sender;
   }

   function GetPedigree(uint _index) public constant returns (AnimalType _animal, string _species, string _picURL, string _name, uint _masterID, CAList _CA, uint _mID, uint _fID, bool _onsale) {
     _animal = pedigrees[_index].animal;
     _species = pedigrees[_index].species;
     _picURL = pedigrees[_index].picURL;
     _name = pedigrees[_index].name;
     _masterID = pedigrees[_index].masterID;
     _CA = pedigrees[_index].CA;
     _mID = pedigrees[_index].mID;
     _fID = pedigrees[_index].fID;
     _onsale = pedigrees[_index].onsale;
   }
   function RegistPedigree(AnimalType _animal, string _species, string _picURL, string _name, uint _masterID, CAList _CA, uint _mID, uint _fID) public returns(uint index){
       if(msg.sender != owner)
       {
           return;
       }
       index = numPedigrees++;
       pedigrees[index] = Pedigree(index,_animal,_species,_picURL,_name,_masterID,_CA,_mID,_fID,false);
   }
   
   function RegistMaster(string _nation, string _name, string _address, string _phone,address _ID) public returns(uint index){
       if(msg.sender != owner)
       {
           return;
       }
       index = numMasters++;
       masters[index] = Master(index,_nation,_name,_address,_phone,_ID);
       
   }

   function GetMaster(uint _index) public constant returns (string _nation, string _name, string _email, string _phone, address _ID){
      /* _nation = masters[pedigrees[_index].masterID].nation;
       _name = masters[pedigrees[_index].masterID].name;
       _email = masters[pedigrees[_index].masterID].email;
       _phone = masters[pedigrees[_index].masterID].phone;
       _ID = masters[pedigrees[_index].masterID].ID; */
       _nation = masters[_index].nation;
       _name = masters[_index].name;
       _email = masters[_index].email;
       _phone = masters[_index].phone;
       _ID = masters[_index].ID;
       
   }
   
   function changeMaster(uint _PedigreeID, uint _changeID) public
   {
       if(msg.sender != owner)
       {
           return;
       }
       pedigrees[_PedigreeID].masterID = _changeID;
   }
   
   function getIndex() public constant returns(uint _numPedigrees,uint _numMasters) 
   {
       _numPedigrees = numPedigrees;
       _numMasters = numMasters;
   }
   


}