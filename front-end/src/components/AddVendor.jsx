import React, { useEffect, useState } from 'react'
import emblem from '../images/emblem.svg'
import '../css/SuperAdmin.css'
import { NavLink } from 'react-router-dom';

const AddVendor = (props) => {

  const { provider, web3, contract } = props.myWeb3Api;
  const account = props.account;

  const [vendorData, setvendorData] = useState({
    address: "", state: "M", district: "N", city: "Y", fullName: "", gender: "Male", email: "", contact: "", resendencialAddr: "", vendortype: "", year: "", state1: "", district1: "", city1: ""
  });

  const [Validated, setValidated] = useState(false)

  const onChangeFunc = (event) => {
    const { name, value } = event.target;
    setvendorData({ ...vendorData, [name]: value });
  }

  const handleSubmit = async () => {

    await contract.addVendor(vendorData.address, vendorData.state, vendorData.district, vendorData.city, vendorData.fullName, vendorData.gender, vendorData.email, vendorData.contact, vendorData.resendencialAddr + ", "+vendorData.city1 +", "+ vendorData.district1+", "+ vendorData.state1, vendorData.year, vendorData.vendortype, {
      from: account
    })

    console.log('Vendor details submitted');
    setvendorData({ address: "", state1: "", district1: "", city1: "", fullName: "", gender: "", email: "", contact: "", resendencialAddr: "", vendortype: "", year: "" });
  }





  return (
    <div className='container superAdmin-mainDiv'>
      <div className='superAdmin-heading-div'>
        <NavLink to='/'>
          <img src={emblem} alt="emblem" className="emblem" />
        </NavLink>
        <h1>Super Admin</h1>
      </div>

      <h1 className='superAdmin-p' style={{ display: 'block', marginLeft: "30px", width: "fit-content" }}>Add Vendor Details</h1>

      <form method='POST' className='admin-form form_area' >

        <div style={{ display: "flex", flexDirection: 'column' }}>

          <div className='form_group'>
            <label className="sub_title">Vendor Wallet Address</label>
            <input type="text" className="form-control form_style" name="address" placeholder="Enter vendor wallet address"
              autoComplete="off" value={vendorData.address} onChange={onChangeFunc} />
          </div>
          <div className='form_group'>
            <label className="sub_title">State</label>
            <select
              name="state1"
              className="form-control form_style"
              value={vendorData.state1}
              onChange={onChangeFunc}
              style={{ height: '50px' }}
            >
              <option value="Andhra Pradesh">Andhra Pradesh</option>
              <option value="Andaman and Nicobar Islands">Andaman and Nicobar Islands</option>
              <option value="Arunachal Pradesh">Arunachal Pradesh</option>
              <option value="Assam">Assam</option>
              <option value="Bihar">Bihar</option>
              <option value="Chandigarh">Chandigarh</option>
              <option value="Chhattisgarh">Chhattisgarh</option>
              <option value="Dadar and Nagar Haveli">Dadar and Nagar Haveli</option>
              <option value="Daman and Diu">Daman and Diu</option>
              <option value="Delhi">Delhi</option>
              <option value="Lakshadweep">Lakshadweep</option>
              <option value="Puducherry">Puducherry</option>
              <option value="Goa">Goa</option>
              <option value="Gujarat">Gujarat</option>
              <option value="Haryana">Haryana</option>
              <option value="Himachal Pradesh">Himachal Pradesh</option>
              <option value="Jammu and Kashmir">Jammu and Kashmir</option>
              <option value="Jharkhand">Jharkhand</option>
              <option value="Karnataka">Karnataka</option>
              <option value="Kerala">Kerala</option>
              <option value="Madhya Pradesh">Madhya Pradesh</option>
              <option value="Maharashtra">Maharashtra</option>
              <option value="Manipur">Manipur</option>
              <option value="Meghalaya">Meghalaya</option>
              <option value="Mizoram">Mizoram</option>
              <option value="Nagaland">Nagaland</option>
              <option value="Odisha">Odisha</option>
              <option value="Punjab">Punjab</option>
              <option value="Rajasthan">Rajasthan</option>
              <option value="Sikkim">Sikkim</option>
              <option value="Tamil Nadu">Tamil Nadu</option>
              <option value="Telangana">Telangana</option>
              <option value="Tripura">Tripura</option>
              <option value="Uttar Pradesh">Uttar Pradesh</option>
              <option value="Uttarakhand">Uttarakhand</option>
              <option value="West Bengal">West Bengal</option>
            </select>

          </div>
          <div className='form_group'>
            <label className="sub_title">District</label>
            <input type="text" className="form-control form_style" name="district1" placeholder="Enter district"
              autoComplete="off" value={vendorData.district1} onChange={onChangeFunc} />
          </div>
          <div className='form_group'>
            <label className="sub_title">City</label>
            <input type="text" className="form-control form_style" name="city1" placeholder="Enter city"
              autoComplete="off" value={vendorData.city1} onChange={onChangeFunc} />
          </div>
          <div className='form_group'>
            <label className="sub_title">Vendor Name</label>
            <input type="text" className="form-control form_style" name="fullName" placeholder="Enter full name"
              autoComplete="off" value={vendorData.fullName} onChange={onChangeFunc} />
          </div>
        </div>

        {/* --------------------------------------------- */}

        <div style={{ display: "flex", flexDirection: 'column' }}>
          <div className='form_group'>
            <label className="sub_title ">Email</label>
            <input type="text" className="form-control form_style" name="email" placeholder="Enter email"
              autoComplete="off" value={vendorData.email} onChange={onChangeFunc} />
          </div>
          <div className='form_group'>
            <label className="sub_title ">Contact</label>
            <input type="text" className="form-control form_style" name="contact" placeholder="Enter contact"
              autoComplete="off" pattern="[789][0-9]{9}" value={vendorData.contact} onChange={onChangeFunc}
            />

          </div>
          <div className='form_group'>
            <label className="sub_title ">Address</label>
            <input type="text" className="form-control form_style" name="resendencialAddr" placeholder="Enter address"
              autoComplete="off" value={vendorData.resendencialAddr} onChange={onChangeFunc} />
          </div>
          <div className='form_group'>
            <label className="sub_title ">Establishment Date</label>
            <input type="date" className="form-control form_style" name="year" placeholder="Enter year of establishment"
              autoComplete="off" value={vendorData.year} onChange={onChangeFunc} />
          </div>
          <div className='form_group'>
            <label className="sub_title">Vendor Type</label>
            <input type="text" className="form-control form_style" name="vendortype" placeholder="Enter type of the vendor"
              autoComplete="off" value={vendorData.vendortype} onChange={onChangeFunc} />

          </div>
        </div>
      </form>
      <button className='btn' onClick={handleSubmit}>Submit</button>
    </div>

  )
}

export default AddVendor