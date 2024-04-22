import React from "react";
import ServiceCard from "./ServiceCard";
import {Col} from "reactstrap";

import weatherImg from './../assets/weather.png'
import guideImg from './../assets/guide.png'
import customizationImg from './../assets/customization.png'

const servicesData =[
    {
        imgUrl: weatherImg,
        title: "Calculate Weather",
        description: "Loremispum Loremispum Loremispum Loremispum Loremispum Loremispum Loremispum",
    },
    {
        imgUrl: guideImg,
        title: "Best Tour Guide",
        description: "Loremispum Loremispum Loremispum Loremispum Loremispum Loremispum Loremispum",
    },
    {
        imgUrl: customizationImg,
        title: "Customization",
        description: "Loremispum Loremispum Loremispum Loremispum Loremispum Loremispum Loremispum",
    },
]

const ServiceList = () =>{
    return (

        servicesData.map((item,index) => (
            <Col lg="3" key={index}>
                <ServiceCard item={item}/>
            </Col>)
    )
    );
}

export default ServiceList;