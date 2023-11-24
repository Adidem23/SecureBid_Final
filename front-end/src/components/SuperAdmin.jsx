import React, { useEffect, useState } from 'react'
import emblem from '../images/emblem.svg'
import '../css/SuperAdmin.css'
import { NavLink, useNavigate } from 'react-router-dom';
import bg from '../images/Removed.png';


const SuperAdmin = (props) => {
  const navigator = useNavigate()
  const { provider, web3, contract } = props.myWeb3Api;
  const account = props.account;

  const [adminData, setAdminData] = useState({
    address: "", state: "", district: "", city: "", fullName: "", gender: "", email: "", contact: "", resendencialAddr: ""
  });

  const onChangeFunc = (event) => {
    const { name, value } = event.target;
    setAdminData({ ...adminData, [name]: value });
  }

  const handleSubmit = async () => {
    await contract.addAdmin(adminData.address, adminData.state, adminData.district, adminData.city, adminData.fullName, adminData.gender, adminData.email, adminData.contact, adminData.resendencialAddr, {
      from: account
    })

    console.log('admin details submitted');
    setAdminData({ address: "", state: "", district: "", city: "", fullName: "", gender: "", email: "", contact: "", resendencialAddr: "" });
  }

  const handleAdmin = () => {
    navigator("/AddAdmin")

  }
  const handleVendor = () => {
    navigator("/AddVendor")

  }
  return (
    <div className='container superAdmin-mainDiv'>
      <div className='superAdmin-heading-div'>
        <NavLink to='/'>
          <img src={emblem} alt="emblem" className="emblem" />
        </NavLink>
        <h1>Super Admin</h1>
      </div>

      <p className='superAdmin-p'>Choose the option</p>

      <div style={{ display: "flex", flexDirection: 'row' }}>

        <div class="card">
          <img src={bg} style={{height:"100px" , width:'100px'}}/>
          <div class="header">Add Admin</div>
          <button class="App-button" onClick={handleAdmin}>Add</button>
        </div>

        <div class="card" style={{marginLeft:'50px'}}>
          <img src={bg} style={{height:"100px" , width:'100px'}}/>
          <div class="header">Add Vendors</div>
          <button class="App-button" onClick={handleVendor}>Add</button>
        </div>

      </div>

     
    </div>

  )
}

export default SuperAdmin