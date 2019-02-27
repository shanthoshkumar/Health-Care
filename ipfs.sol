pragma solidity ^0.4.21;
contract ipfs
{
    struct patient_data_base
    {
        string file_name;
        string data_hash;
    }
    mapping(uint256 =>mapping(uint256 => patient_data_base)) public patient_data_base_map;// key1: patient id  key2: file number
    
    function get_data(uint256 _patient_id, uint256 _file_number, string memory _file_name, string memory _ipfs_hash) public payable returns(bool)
    {
        patient_data_base_map[_patient_id][_file_number].file_name = _file_name;     
        patient_data_base_map[_patient_id][_file_number].data_hash = _ipfs_hash;
        return true;
    }
    
    function show_datas(uint256 _patient_id, uint256 _file_number) public constant returns(string,string)
    {
      return (patient_data_base_map[_patient_id][_file_number].file_name, patient_data_base_map[_patient_id][_file_number].data_hash);
    }
    
}

// 0xc35cd5bdb1f12a21d4c21888c04787f43db55336