import React from 'react'
import '../css/DisplayDetails.css'


const DisplayTenderDetails = (props) => {

  
  return (
    
    <>
      {
        <div className='explore-result'>
          <div className='row'>
            <div className='col-12 col-md-6'>
              
              <p><b>Assignend To:</b> {props.userName}</p>
              <p><b>Address:</b> {props.owner}</p>
              <p><b>Tender ID:</b> {props.surveyNo}</p>
              {/* <p><b>Market Value:</b> {props.marketValue}</p> */}
            </div>

            <div className='col-12 col-md-6'>
              <p><b>Tender Name:</b> {props.tendorName}</p>
              <p><b>Tender Type:</b> {props.tendortype}</p>
              <p><b>Tender File:</b> <button className='btn' style={{ height: '50px', width: '120px' }} onClick={()=>{
                window.open(props.ipfsuri,"_blank");
              }}> View File </button></p>
            </div>
          </div>
          {/* {
            (props.available) ? 
              <button className='marked-available'><b>Marked Available</b></button>
              :
              <button className='mark-available-btn' onClick={() => {props.markAvailable(props.index)}} ><b>Mark Available</b></button>
            } */}
        </div>
      }
    </>
  )
}

export default DisplayTenderDetails