pragma solidity ^0.4.21;
import "./ipfs.sol";
contract healthcare
{
    ipfs contract_address;
    
    // address public admin;
    
    constructor(ipfs _contract_address) public
    {
        contract_address = _contract_address;
        // admin = msg.sender;
    }
    
    uint256 public patient_ids;
    
    struct Patient_detail
    {
        string patient_name;
        uint256 patient_birth_date;
        string place_of_birth;
        bool gender; //true: male, false: female
        uint256 file_number;
    }
    mapping(uint256 => Patient_detail) public Patient_detail_map;  //key: patient_id
    
    function get_info(string memory _patient_name, uint256 _patient_birth_date, string _place_of_birth, bool _gender) public payable returns(uint256) //successfully got the information
    {
        patient_ids += 1;
        Patient_detail_map[patient_ids].patient_name = _patient_name;
        Patient_detail_map[patient_ids].patient_birth_date = _patient_birth_date;
        Patient_detail_map[patient_ids].place_of_birth = _place_of_birth;
        if(_gender == true)
        {
            Patient_detail_map[patient_ids].gender = _gender;
        }
        
        return patient_ids;
    }
    
    function store_info(uint256 _patient_id, string memory _file_name, string memory _ipfs_hash) public payable returns(bool)
    {
        require(_patient_id>0 && _patient_id <= patient_ids);
        Patient_detail_map[_patient_id].file_number += 1;
        ipfs(contract_address).get_data(_patient_id, Patient_detail_map[_patient_id].file_number, _file_name, _ipfs_hash);  
        return true;
    }
    
    function show_data(uint256 _patient_id, uint256 _file_number) public constant returns(string, string)
    {
        require(_patient_id>0 && _patient_id <= patient_ids);
        return ipfs(contract_address).show_datas(_patient_id, _file_number);
    }
}




//  0x3bc7c9706f21e734114ab6efb2f40230ddd7758d   