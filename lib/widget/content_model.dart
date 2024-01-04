import 'dart:core';

import 'package:flutter/material.dart';
class UnboardingContent{
   String image;
   String description;
   String title;
   UnboardingContent({
     required this.image,
     required this.title,
     required this.description
   });
}
List<UnboardingContent> contents=[
  UnboardingContent(image: "images/screen1.png",
      title: "Select From Our\n     Best Menu",
      description: "Pick Your Food From Our Menu\n         More Than 35 Times"),
  UnboardingContent(image: "images/screen2.png",
      title: "Easy And Online Payment",
      description: "You Can Pay Cash On Delivery And \n Card Payment are available"),
  UnboardingContent(image: "images/screen3.png",
      title: "Deliver Your Food At Your\n              DoorSteps",
      description: "Quick Delivery At Your DoorSteps"),
];