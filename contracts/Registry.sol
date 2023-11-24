// SPDX-License-Identifier: MIT

pragma solidity >=0.5.0 <0.9.0;

contract Registry {
    address public superAdmin;
    uint256 public totalAdmins;
    uint256 public totalVendors;
    uint256 public totalTendors = 1000;

    struct Admin {
        address adminAddress;
        string city;
        string district;
        string state;
    }

    struct Vendor {
        address vendorAddress;
        string city;
        string district;
        string state;
        string year;
        string vendortype;
        uint256 rating;
        uint256 noofRaters;
    }

    struct TenderDetails {
        address owner;
        string tendertype;
        string tenderName;
        address admin;
        string ipfsuri;
        uint256 tenderId;
        uint256 tenderid1;
        uint256 index;
        bool registered;
        uint256 marketValue;
        bool markAvailable;
        mapping(uint256 => RequestDetails) requests; // reqNo => RequestDetails
        uint256 noOfRequests; 
    }

    struct UserProfile {
        address userAddr;
        string fullName;
        string gender;
        string email;
        string contact;
        string residentialAddr;
        uint256 totalIndices;
        uint256 requestIndices;
    }

    struct OwnerOwns {
        uint256 tenderid1;
        string state;
        string district;
        string city;
    }

    struct AdminOwns {
        uint256 surveyNo;
        string state;
        string district;
        string city;
        address AllocatedTo;
    }

    struct RequestedTenders {
        uint256 tenderid1;
        string state;
        string district;
        string city;
    }

    struct RequestDetails {
        address whoRequested;
        uint256 reqIndex;
        uint256 BidAmount;
        string FileURI;
    }

    mapping(address => Admin) public admins;
    mapping(address => Vendor) public vendors;
    mapping(address => mapping(uint256 => OwnerOwns)) public ownerMapsProperty;
    mapping(address => mapping(uint256 => AdminOwns)) public adminMapsProperty; // ownerAddr => index no. => OwnerOwns
    mapping(address => mapping(uint256 => RequestedTenders))
        public requestedTenders; // ownerAddr => reqIndex => RequestedTenders
    mapping(string => mapping(string => mapping(string => mapping(uint256 => TenderDetails))))
        public tenderDetailsMap; // state => district => city => surveyNo => TenderDetails
    mapping(address => UserProfile) public userProfile;

    constructor() {
        superAdmin = msg.sender;
    }

    modifier onlyAdmin() {
        require(
            admins[msg.sender].adminAddress == msg.sender,
            "Only admin can Register land"
        );
        _;
    }

    // SuperAdmin: Registers new admin
    function addAdmin(
        address _adminAddr,
        string memory _state,
        string memory _district,
        string memory _city,
        string memory _fullName,
        string memory _gender,
        string memory _email,
        string memory _contact,
        string memory _residentialAddr
    ) external {
        Admin storage newAdmin = admins[_adminAddr];
        totalAdmins++;

        newAdmin.adminAddress = _adminAddr;
        newAdmin.city = _city;
        newAdmin.district = _district;
        newAdmin.state = _state;

        UserProfile storage newUserProfile = userProfile[_adminAddr];

        newUserProfile.fullName = _fullName;
        newUserProfile.gender = _gender;
        newUserProfile.email = _email;
        newUserProfile.contact = _contact;
        newUserProfile.residentialAddr = _residentialAddr;
    }

    function addVendor(
        address _vendorAddr,
        string memory _state,
        string memory _district,
        string memory _city,
        string memory _fullName,
        string memory _gender,
        string memory _email,
        string memory _contact,
        string memory _residentialAddr,
        string memory _year,
        string memory _vendortype
    ) external {
        Vendor storage newVendor = vendors[_vendorAddr];
        totalVendors++;

        newVendor.vendorAddress = _vendorAddr;
        newVendor.city = _city;
        newVendor.district = _district;
        newVendor.state = _state;
        newVendor.rating = 5;
        newVendor.noofRaters = 1;
        newVendor.vendortype = _vendortype;
        newVendor.year = _year;

        UserProfile storage newUserProfile = userProfile[_vendorAddr];

        newUserProfile.fullName = _fullName;
        newUserProfile.gender = _gender;
        newUserProfile.email = _email;
        newUserProfile.contact = _contact;
        newUserProfile.residentialAddr = _residentialAddr;
    }

    //function Give Rating
    function GiveRating(address _vendortorating, uint256 _ratenumber) public {
        vendors[_vendortorating].rating =
            vendors[_vendortorating].rating +
            _ratenumber;
        vendors[_vendortorating].noofRaters++;
    }

    // check if it is admin
    function isAdmin() external view returns (bool) {
        if (admins[msg.sender].adminAddress == msg.sender) {
            return true;
        } else return false;
    }

    //Chekc if it is Vendor
    function isVendor() external view returns (bool) {
        if (vendors[msg.sender].vendorAddress == msg.sender) {
            return true;
        } else return false;
    }

     function registerTender(
        string memory _state,
        string memory _district,
        string memory _city,
        uint256 _tenderId,
        uint256 _surveyNo,
        address _owner,
        uint256 _marketValue,
        string memory _tenderName,
        string memory _tendertype,
        string memory _ipfsuri
    ) external onlyAdmin {
        require(
            keccak256(abi.encodePacked(admins[msg.sender].state)) ==
                keccak256(abi.encodePacked(_state)) &&
                keccak256(abi.encodePacked(admins[msg.sender].district)) ==
                keccak256(abi.encodePacked(_district)) &&
                keccak256(abi.encodePacked(admins[msg.sender].city)) ==
                keccak256(abi.encodePacked(_city)),
            "Admin can only register land of same city."
        );

        require(
            tenderDetailsMap[_state][_district][_city][totalTendors].registered ==
                false,
            "Survey Number already registered!"
        );

        TenderDetails storage newTenderRegistry = tenderDetailsMap[_state][_district][
            _city
        ][totalTendors];

        OwnerOwns storage newOwnerOwns = ownerMapsProperty[msg.sender][
            userProfile[msg.sender].totalIndices
        ];

        AdminOwns storage newAdminOwns = adminMapsProperty[msg.sender][
            userProfile[msg.sender].totalIndices
        ];

        newTenderRegistry.owner = _owner;
        newTenderRegistry.admin = msg.sender;
        newTenderRegistry.tenderId = totalTendors;
        newTenderRegistry.tenderid1 = totalTendors;
        newTenderRegistry.index = userProfile[_owner].totalIndices;
        newTenderRegistry.registered = true;
        newTenderRegistry.marketValue = _marketValue;
        newTenderRegistry.markAvailable = true;
        newTenderRegistry.tenderName = _tenderName;
        newTenderRegistry.tendertype = _tendertype;
        newTenderRegistry.ipfsuri = _ipfsuri;

        newOwnerOwns.tenderid1 = totalTendors;
        newOwnerOwns.state = _state;
        newOwnerOwns.district = _district;
        newOwnerOwns.city = _city;

        userProfile[_owner].totalIndices++;

        totalTendors++;
    }

    // User_1: set user profile
    function setUserProfile(
        string memory _fullName,
        string memory _gender,
        string memory _email,
        string memory _contact,
        string memory _residentialAddr
    ) public {
        UserProfile storage newUserProfile = userProfile[msg.sender];

        newUserProfile.fullName = _fullName;
        newUserProfile.gender = _gender;
        newUserProfile.email = _email;
        newUserProfile.contact = _contact;
        newUserProfile.residentialAddr = _residentialAddr;
    }

    // User_1: mark property available
    function markMyPropertyAvailable(uint256 indexNo) external {
        string memory state = ownerMapsProperty[msg.sender][indexNo].state;
        string memory district = ownerMapsProperty[msg.sender][indexNo]
            .district;
        string memory city = ownerMapsProperty[msg.sender][indexNo].city;
        uint256 tenderid1 = ownerMapsProperty[msg.sender][indexNo]
            .tenderid1;

        require(
            tenderDetailsMap[state][district][city][tenderid1].markAvailable ==
                false,
            "Property already marked available"
        );

        tenderDetailsMap[state][district][city][tenderid1].markAvailable = true;
    }

    // User_2: Request for buy  ownerAddress & index = arguements
    function RequestForBuy(
        string memory _state,
        string memory _district,
        string memory _city,
        uint256 _surveyNo,
        uint256 _BidAmount,
        string memory _FileURI
    ) external {
        TenderDetails storage thisTenderDetail = tenderDetailsMap[_state][_district][
            _city
        ][_surveyNo];
        require(
            thisTenderDetail.markAvailable == true,
            "This property is NOT marked for sale!"
        );

        uint256 req_serialNum = thisTenderDetail.noOfRequests;
        thisTenderDetail.requests[req_serialNum].whoRequested = msg.sender;
        thisTenderDetail.requests[req_serialNum].reqIndex = userProfile[
            msg.sender
        ].requestIndices;
        thisTenderDetail.requests[req_serialNum].BidAmount = _BidAmount;
        thisTenderDetail.requests[req_serialNum].FileURI = _FileURI;
        thisTenderDetail.noOfRequests++;

        
        RequestedTenders storage newReqestedTenders = requestedTenders[msg.sender][
            userProfile[msg.sender].requestIndices
        ];
        newReqestedTenders.tenderid1 = _surveyNo;
        newReqestedTenders.state = _state;
        newReqestedTenders.district = _district;
        newReqestedTenders.city = _city;

        userProfile[msg.sender].requestIndices++;
    }

    // User_1: Accept the buy request; sell.
    function AcceptRequest(uint256 _index, uint256 _reqNo) public {
        uint256 _surveyNo = ownerMapsProperty[msg.sender][_index].tenderid1;
        string memory _state = ownerMapsProperty[msg.sender][_index].state;
        string memory _district = ownerMapsProperty[msg.sender][_index]
            .district;
        string memory _city = ownerMapsProperty[msg.sender][_index].city;

        // updating TenderDetails
        address newOwner = tenderDetailsMap[_state][_district][_city][_surveyNo]
            .requests[_reqNo]
            .whoRequested;

        uint256 newOwner_reqIndex = tenderDetailsMap[_state][_district][_city][
            _surveyNo
        ].requests[_reqNo].reqIndex;

        uint256 noOfReq = tenderDetailsMap[_state][_district][_city][_surveyNo]
            .noOfRequests;

        string memory _FileURI = tenderDetailsMap[_state][_district][_city][
                _surveyNo
            ].requests[_reqNo].FileURI;

        uint256 _BidAmount = tenderDetailsMap[_state][_district][_city][
                _surveyNo
            ].requests[_reqNo].BidAmount;

        
        for (uint256 i = 0; i < noOfReq; i++) {
            address requesterAddr = tenderDetailsMap[_state][_district][_city][
                _surveyNo
            ].requests[i].whoRequested;
            uint256 requester_reqIndx = tenderDetailsMap[_state][_district][_city][
                _surveyNo
            ].requests[i].reqIndex;

            delete requestedTenders[requesterAddr][requester_reqIndx];
            delete tenderDetailsMap[_state][_district][_city][_surveyNo].requests[
                i
            ];
        }
        
        

        tenderDetailsMap[_state][_district][_city][_surveyNo].owner = newOwner;
        tenderDetailsMap[_state][_district][_city][_surveyNo].ipfsuri = _FileURI;
        tenderDetailsMap[_state][_district][_city][_surveyNo].marketValue = _BidAmount;
        tenderDetailsMap[_state][_district][_city][_surveyNo].markAvailable = false;
        tenderDetailsMap[_state][_district][_city][_surveyNo].noOfRequests = 0;

        // deleting property from user_1's ownerMapsProperty
        // delete ownerMapsProperty[msg.sender][_index];

        // adding ownerMapsProperty for newOwner
        uint256 newOwnerTotProp = userProfile[newOwner].totalIndices;
        OwnerOwns storage newOwnerOwns = ownerMapsProperty[newOwner][
            newOwnerTotProp
        ];

        newOwnerOwns.tenderid1 = _surveyNo;
        newOwnerOwns.state = _state;
        newOwnerOwns.district = _district;
        newOwnerOwns.city = _city;

        tenderDetailsMap[_state][_district][_city][_surveyNo]
            .index = newOwnerTotProp;

        userProfile[newOwner].totalIndices++;
    }

    //******* GETTERS **********

    function getTenderDetails(
        string memory _state,
        string memory _district,
        string memory _city,
        uint256 _surveyNo
    )
        external
        view
        returns (
            address,
            uint256,
            uint256,
            uint256,
            string memory,
            string memory,
            string memory
        )
    {
        address owner = tenderDetailsMap[_state][_district][_city][_surveyNo]
            .owner;
        uint256 propertyid = tenderDetailsMap[_state][_district][_city][_surveyNo]
            .tenderId;
        uint256 indx = tenderDetailsMap[_state][_district][_city][_surveyNo].index;

        uint256 mv = tenderDetailsMap[_state][_district][_city][_surveyNo]
            .marketValue;

        string memory tendorName = tenderDetailsMap[_state][_district][_city][
            _surveyNo
        ].tenderName;

        string memory tendortype = tenderDetailsMap[_state][_district][_city][
            _surveyNo
        ].tendertype;

        string memory ipfsuri = tenderDetailsMap[_state][_district][_city][
            _surveyNo
        ].ipfsuri;

        return (owner, propertyid, indx, mv, tendorName, tendortype, ipfsuri);
    }

    function getRequestCnt_propId(
        string memory _state,
        string memory _district,
        string memory _city,
        uint256 _surveyNo
    ) external view returns (uint256, uint256) {
        uint256 _noOfRequests = tenderDetailsMap[_state][_district][_city][
            _surveyNo
        ].noOfRequests;
        uint256 _tenderId = tenderDetailsMap[_state][_district][_city][_surveyNo]
            .tenderId;
        return (_noOfRequests, _tenderId);
    }

    function getRequesterDetail(
        string memory _state,
        string memory _district,
        string memory _city,
        uint256 _surveyNo,
        uint256 _reqIndex
    ) external view returns (address) {
        address requester = tenderDetailsMap[_state][_district][_city][_surveyNo]
            .requests[_reqIndex]
            .whoRequested;

        return (requester);
    }

    function getRequesterBidAmount(
        string memory _state,
        string memory _district,
        string memory _city,
        uint256 _surveyNo,
        uint256 _reqIndex
    ) external view returns (uint256) {
        uint256 BidAmount = tenderDetailsMap[_state][_district][_city][_surveyNo]
            .requests[_reqIndex]
            .BidAmount;

        return (BidAmount);
    }

    function getRequesterFileURI(
        string memory _state,
        string memory _district,
        string memory _city,
        uint256 _surveyNo,
        uint256 _reqIndex
    ) external view returns (string memory) {
        string memory RequesterFileURI = tenderDetailsMap[_state][_district][
            _city
        ][_surveyNo].requests[_reqIndex].FileURI;

        return (RequesterFileURI);
    }

    function getRequesterName(
        string memory _state,
        string memory _district,
        string memory _city,
        uint256 _surveyNo,
        uint256 _reqIndex
    ) external view returns (string memory) {
        address requester = tenderDetailsMap[_state][_district][_city][_surveyNo]
            .requests[_reqIndex]
            .whoRequested;

        string memory NameofRequester = userProfile[requester].fullName;
        return (NameofRequester);
    }

    function isAvailable(
        string memory _state,
        string memory _district,
        string memory _city,
        uint256 _surveyNo
    ) external view returns (bool) {
        bool available = tenderDetailsMap[_state][_district][_city][_surveyNo]
            .markAvailable;
        return (available);
    }

    function getOwnerOwns(
        uint256 indx
    )
        external
        view
        returns (string memory, string memory, string memory, uint256)
    {
        uint256 surveyNo = ownerMapsProperty[msg.sender][indx].tenderid1;
        string memory state = ownerMapsProperty[msg.sender][indx].state;
        string memory district = ownerMapsProperty[msg.sender][indx].district;
        string memory city = ownerMapsProperty[msg.sender][indx].city;

        return (state, district, city, surveyNo);
    }

    function getAdminOwns(
        uint256 indx
    )
        external
        view
        returns (string memory, string memory, string memory, uint256)
    {
        uint256 surveyNo = adminMapsProperty[msg.sender][indx].surveyNo;
        string memory state = adminMapsProperty[msg.sender][indx].state;
        string memory district = adminMapsProperty[msg.sender][indx].district;
        string memory city = adminMapsProperty[msg.sender][indx].city;

        return (state, district, city, surveyNo);
    }

    function getRequestedTenders(
        uint256 indx
    )
        external
        view
        returns (string memory, string memory, string memory, uint256)
    {
        uint256 surveyNo = requestedTenders[msg.sender][indx].tenderid1;
        string memory state = requestedTenders[msg.sender][indx].state;
        string memory district = requestedTenders[msg.sender][indx].district;
        string memory city = requestedTenders[msg.sender][indx].city;

        return (state, district, city, surveyNo);
    }

    function getUserProfile()
        external
        view
        returns (
            string memory,
            string memory,
            string memory,
            string memory,
            string memory
        )
    {
        string memory fullName = userProfile[msg.sender].fullName;
        string memory gender = userProfile[msg.sender].gender;
        string memory email = userProfile[msg.sender].email;
        string memory contact = userProfile[msg.sender].contact;
        string memory residentialAddr = userProfile[msg.sender].residentialAddr;

        return (fullName, gender, email, contact, residentialAddr);
    }

    function getUserName(address _addr) external view returns (string memory) {
        string memory fullName = userProfile[_addr].fullName;

        return (fullName);
    }



    function getestablishYear(
        address _addr
    ) external view returns (string memory) {
        string memory year = vendors[_addr].year;

        return (year);
    }

    function getIndices() external view returns (uint256, uint256) {
        uint256 _totalIndices = userProfile[msg.sender].totalIndices;
        uint256 _reqIndices = userProfile[msg.sender].requestIndices;

        return (_totalIndices, _reqIndices);
    }

    function didIRequested(
        string memory _state,
        string memory _district,
        string memory _city,
        uint256 _surveyNo
    ) external view returns (bool) {
        TenderDetails storage thisTenderDetail = tenderDetailsMap[_state][_district][
            _city
        ][_surveyNo];
        uint256 _noOfRequests = thisTenderDetail.noOfRequests;

        if (_noOfRequests == 0) return (false);

        for (uint256 i = 0; i < _noOfRequests; i++) {
            if (thisTenderDetail.requests[i].whoRequested == msg.sender) {
                return (true);
            }
        }

        return (false);
    }

    function getTotalTendors() external view returns (uint256) {
        return (totalTendors);
    }
}
