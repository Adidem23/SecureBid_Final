import React from 'react'
import '../css/DisplayDetails.css';
// {props.requesterFileURI}
const DisplayRequests = (props) => {
  return (
        <div className='explore-result'>
            <h4><b>Tender ID : {props.tenderId}</b></h4>
            <p><b>Requested by:</b> {props.requester}</p>
            <p><b>Requester Name:</b> {props.requesterName}</p>
            <p><b>Establishment Year:</b> {props.establishmentyear}</p>
            <p><b>Bid Amount:</b> {props.stringBidAmount}</p>
            <p><b>Tender File:  </b> <button className='btn' style={{ height: '40px', width: '110px' , marginLeft:'6px'}} onClick={()=>{
                window.open(props.requesterFileURI,"_blank");
              }}> View File </button></p>
            <p><b>Tender Name:</b> {props.tendorName}</p>
            

            <button className='btn' style={{backgroundColor:"green" , color:"white"}} onClick={() => {props.acceptReq(props.index, props.reqNo)}}><b>Accept Request</b></button>
        </div>
  )
}

export default DisplayRequests