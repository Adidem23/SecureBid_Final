import React from 'react'

const DisplayRequested = (props) => {
  return (
    <>
        <div className='explore-result'>
          <div className='row'>
            <div className='col-12 col-md-6'>
                <p><b>Department  Address:</b> {props.owner}</p>
                <p><b>Tender ID:</b> {props.tenderId}</p>
                <p><b>Market Value:</b> {props.marketValue}</p>
                <p style={{marginTop:"10px"}}><b>Tender File:</b> <button className='btn' style={{ height: '40px', width: '110px' , marginLeft:"10px"}} onClick={()=>{
                window.open(props.ipfsuri,"_blank");
              }}> View File </button></p>
              </div>
              
              <div className='col-12 col-md-6'>
                <p><b>Department Name :</b> {props.ownerName}</p>
                <p><b>Tender Name:</b> {props.tendorName}</p>
                <p><b>Tender Type:</b> {props.tendortype}</p>
            </div>
          </div>

            <button className='btn' style={{color:'white',backgroundColor:"red"}}><b>Request Pending</b></button>
        </div>
    </>
  )
}

export default DisplayRequested