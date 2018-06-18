/// This is made for Line Hackerton in 2018.
/// Made by Team Chainerator
/// Ver 0.1
pragma solidity ^0.4.0;
contract Pediblock{
    struct Postman{
        string code;
        string name;
        string phone;
    }
    struct Delivery {
        string code;
        uint postman_index;
        uint longitude;
        uint latitude;
        uint temperature;
        uint humidity;
        uint damage;
        address to;
        bool damaged;
        bool success;
        bool unnormal;
    }
    mapping(uint => Delivery) deliverys;
    mapping(uint => Postman) postmans;
    uint numPostmans;
    uint numDeliverys;
    address owner;
    
    function constuctor() public {
    numPostmans = 1;
    numDeliverys = 1;
    owner = msg.sender;
    }
    
    function GetPostman(uint _index) public constant returns (string _mycode, string _name, string _phone) {
        _mycode = postmans[_index].code;
        _name = postmans[_index].name;
        _phone = postmans[_index].phone;
    }
    function RegistPostman(string _code,string _name,string _phone) public returns(uint index){
        if(msg.sender != owner)
        {
            return;
        }
        index = numPostmans++;
        postmans[index] = Postman(_code,_name,_phone);
    }
    
    function NewDelivery(string _code,address _to) public returns(uint index){
        if(msg.sender != owner)
        {
            return;
        }
        index = numDeliverys++;
        deliverys[index] = Delivery(_code,0,0,0,0,0,0,_to,false,false,false);
    }
    
    function GetDelivery(uint _index) public constant returns (string _mycode, uint _postman_index,uint _longi, uint _lati,uint _temperature,uint _humidity,bool _damaged){
        _mycode = deliverys[_index].code;
        _postman_index = deliverys[_index].postman_index;
        _longi = deliverys[_index].longitude;
        _lati = deliverys[_index].latitude;
        _temperature = deliverys[_index].temperature;
        _humidity = deliverys[_index].humidity;
        _damaged = deliverys[_index].damaged;
        
    }
    
    function SetGPS(uint _index,uint longitude, uint latitude) public{
        deliverys[_index].longitude = longitude;
        deliverys[_index].latitude = latitude;
    }
    
    function SetTemperature(uint _index,uint temperature) public{
        if(temperature > 30 || temperature < 10)
        {
            deliverys[_index].unnormal = true;
        }
        deliverys[_index].temperature = temperature;
    }
    
    function SetHumidity(uint _index, uint humidity) public{
        if(humidity > 50)
        {
            deliverys[_index].unnormal = true;
        }
        deliverys[_index].humidity = humidity;
    }
    
    function SetDamage(uint _index, uint damage) public{
        if(damage > 50)
        {
            deliverys[_index].damaged = true;
        }
        deliverys[_index].damage = damage;
    }
    
    function DeliveryComplete(uint _index) public{
        if(msg.sender != deliverys[_index].to)
        {
            return;
        }
        deliverys[_index].success = true;
    }
}