---
title: Web User Interface Design Techniques
author: Purbayan Chowdhury(@shivishbrahma)
created_ts: 2024-06-29 20:56:32
edited_ts: 2024-07-07 15:47:04
tags: ["UI design", web]
course_id: 57714
---

- [Basic UI Elements](#basic-ui-elements)
    - [Menu](#menu)
    - [Accordion](#accordion)
    - [Navigation Bar](#navigation-bar)
    - [Dropdown](#dropdown)
    - [Modal](#modal)
    - [Tooltip](#tooltip)
    - [Input Autocomplete](#input-autocomplete)
- [Handling Images](#handling-images)
    - [Mouse Hover](#mouse-hover)
    - [Magnification of Image on Mouse-Hover](#magnification-of-image-on-mouse-hover)
    - [Lightbox](#lightbox)
    - [Image Carousel](#image-carousel)
    - [Lazy Loading Images](#lazy-loading-images)
- [Designing Layouts](#designing-layouts)
    - [Grids in a Web Page](#grids-in-a-web-page)
    - [Using Grid to Make a Mosaic Layout](#using-grid-to-make-a-mosaic-layout)
    - [Using Flex to Divide Web Pages into Sections](#using-flex-to-divide-web-pages-into-sections)
    - [Responsive Sectors within a Web Page](#responsive-sectors-within-a-web-page)
    - [Grid or Flex](#grid-or-flex)
- [Animations](#animations)
    - [Animated Menu Buttons](#animated-menu-buttons)
    - [Animated Repeating Background](#animated-repeating-background)
    - [Floating Elements and Shadow Effect](#floating-elements-and-shadow-effect)
    - [Using JavaScript to Trigger Animations](#using-javascript-to-trigger-animations)
- [Animated Icons](#animated-icons)
    - [Animated Icons: Battery Charging](#animated-icons-battery-charging)
    - [Animated Icons: Menu to Close](#animated-icons-menu-to-close)
    - [Loaders](#loaders)
- [Building Accessible UI](#building-accessible-ui)
    - [Defining Web Accessible UI](#defining-web-accessible-ui)
    - [Operable Accessibility](#operable-accessibility)
    - [Controlling Focus with Tabindex](#controlling-focus-with-tabindex)
    - [Tab-Order](#tab-order)
    - [Custom Element and Using Tabindex](#custom-element-and-using-tabindex)
    - [Using Native Elements](#using-native-elements)
    - [The Aria Attribute](#the-aria-attribute)
    - [The "aXe" Tool](#the-axe-tool)
    - [Restricting Access to a Part of a Web Page](#restricting-access-to-a-part-of-a-web-page)
    - [Hands On 1 (JavaScript-Data Collector)](#hands-on-1-javascript-data-collector)
    - [Hands On 2 (Filter App)](#hands-on-2-filter-app)
    - [Hands On 3 - Worklist](#hands-on-3---worklist)

## Basic UI Elements

### Menu

Menu is a group of commands that are to be executed to perform actions on a web page.  Two different types of menus are widely used, which are given below:

- DROPDOWN menus: A toggle-enabled menu that allows the user to choose one value from a list of values.  
- CONTEXT menus, also known as POPUP menus: The menu that appears when a user right-clicks on an element.

### Accordion

If we want to toggle between hiding or showing large texts in your web pages, accordions will come to our rescue. If we are thinking how is it possible; then check out a demonstration of accordions below.

### Navigation Bar  

Navigation bar is a set of buttons or images that are arranged in a row or column such that when a user clicks on that image or button which leads to a separate section.

- Basic Navigation Bar: Simple Navigation Bar from where users may access information.
- Vertical and Horizontal Navigation Bar: Vertical Navigation refer to a navigation bar on the left side of the web page. Horizontal Navigation Bar refers to the bar present in the top of a page.
- Fixed Navigation: On scrolling down a long web page, it may be required to access the navigation bar from every part of the web page. That is when we need Fixed Navigation Bar so that the Navigation Bar sticks to the top of the web page even if we scroll down.

### Dropdown  

This refers to the contents hidden behind a categorized topic in a list that one may need to view to understand the topic better.  

- A container (e.g.`<div>`) tag is used to create dropdown content.
- `<span>` or `<button>` tags are used to open the dropdown content.

There are two types of dropdown:

- Click Dropdown
- Hover Dropdown

### Modal

### Tooltip

### Input Autocomplete

## Handling Images

Images help to improve the design and readability of a web page.

Working with images makes a web page interactive and responsive.

### Mouse Hover

### Magnification of Image on Mouse-Hover

### Lightbox

### Image Carousel

An Image Carousel refers to an Image slide-show. The user has the controls to move to the previous or next image as well as to move to a particular image. The Image Carousel finds its use to demonstrate one particular item or various items.

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <style>
      .carousel-container {
        width: 500px;
        overflow: hidden;
        position: relative;
      }
      .carousel-slide {
        display: flex;
        transition: transform 0.2s ease-in-out;
      }
      .carousel-image {
        width: 100%;
        object-fit: cover;
      }
      .carousel-button {
        cursor: pointer;
      }
    </style>
  </head>
  <body>
    <h2>Image Carousel</h2>
    <div class="carousel-container">
      <div class="carousel-slide">
        <img class="carousel-image" src="image1.png" alt="Image 1" />
        <img class="carousel-image" src="image2.png" alt="Image 2" />
        <img class="carousel-image" src="image3.png" alt="Image 3" />
      </div>
    </div>
    <br />
    <button class="carousel-button" onclick="prevSlide()">Previous</button>
    <button class="carousel-button" onclick="nextSlide()">Next</button>
    <script>
      const slideContainer = document.querySelector(".carousel-slide");
      const prevButton = document.querySelector(".carousel-button:nth-of-type(1)");
      const nextButton = document.querySelector(".carousel-button:nth-of-type(2)");
      let currentIndex = 0;
      const prevSlide = () => {
        currentIndex = (currentIndex - 1 + 3) % 3;
        updateSlidePosition();
      };
      const nextSlide = () => {
        currentIndex = (currentIndex + 1) % 3;
        updateSlidePosition();
      };
      const updateSlidePosition = () => {
        slideContainer.style.transform = `translateX(-${currentIndex * 100}%)`;
      };
      setInterval(nextSlide, 4000);
    </script>
  </body>
</html>
```

### Lazy Loading Images

Lazy Loading of Images suggests loading of the Images only when the user wants to view it (scrolls down to visit the part of the page where the image is embedded).

```html
<!DOCTYPE html>
<html lang="en">
  <body>
    <h1>Lazy Loading Images</h1>
    <img src="" alt="Placeholder Image" width="100%" data-src="image1.png" />
    <div style="height: 100vh"></div>
    <img src="" alt="Placeholder Image" width="100%" data-src="image2.png" />
    <div style="height: 100vh"></div>
    <img src="" alt="Placeholder Image" width="100%" data-src="image3.png" />
    <script>
      document.addEventListener("DOMContentLoaded", () => {
        const lazyImages = document.querySelectorAll("img[data-src]");
        const options = {
          rootMargin: "0px",
          threshold: 0.1,
        };
        const intersectionObserver = new IntersectionObserver((entries, observer) => {
          entries.forEach((entry) => {
            if (entry.isIntersecting) {
              const img = entry.target;
              img.src = img.getAttribute("data-src");
              img.removeAttribute("data-src");
              intersectionObserver.unobserve(img);
            }
          });
        }, options);
        lazyImages.forEach((img) => {
          intersectionObserver.observe(img);
        });
      });
    </script>
  </body>
</html>
```

## Designing Layouts  

### Grids in a Web Page  

A website can be divided into grids in two ways:

- using Float
- using Flex

### Using Grid to Make a Mosaic Layout

`Mosaic Layout` refers to diving a web page into Rectangular Blocks (generally of different sizes) where each *Rectangular Block* will hold one particular type of content.

### Using Flex to Divide Web Pages into Sections

Divide web pages into sections using Flexbox.

### Responsive Sectors within a Web Page

### Grid or Flex

## Animations

Simple Animations can be created using HTML5 and CSS3 only. JavaScript can be used to trigger animations manually.

### Animated Menu Buttons

What if a Menu button gradually changed its color on mouse-hover giving it a gradual lit-up feel!

```html
<!DOCTYPE html>
<html>
<head>
<style>
body{ background:#000; margin:0px; }
div#menubar1{ padding: 24px; border:#999 1px dashed; }
div#menubar1 > a{
    font-family:Arial, Helvetica, sans-serif;
    font-size:17px;
    background: #333;
    padding: 12px 24px;
    color:#999;
    margin-right: 10px;
    text-decoration:none;
    border-radius: 3px;
    transition: background 0.3s linear 0s, color 0.3s linear 0s;
}
div#menubar1 > a:hover{
    background: #6F8A00;
    color:#FFF;
}
</style>
</head>
<body>
<div id="menubar1">
  <a href="#">Home</a><a href="#">About us</a><a href="#">Services</a><a href="#">Staff</a><a href="#">Contact</a>
</div>
</body>
</html>
```

### Animated Repeating Background

Animated Background gives a feeling that the background image of the web page is in never-ending motion.

```html
<!DOCTYPE html>
<html>
<head>
<style>
body{ margin:48px; background:#000; font-family: Arial, Helvetica, sans-serif; }
div#banner{
    width: 1000px;
    height: 200px;
    margin: 0px auto;
    border: #639 1px solid;
    overflow: hidden;
}
div#banner > #banner_backdrop{
    position: relative;
    background: url(repeater.jpg) repeat-x;
    width: 1320px;
    height: 200px;
    animation: backdrop_roll linear 12s infinite;
}
@keyframes backdrop_roll { from { right: 0px; } to { right: 320px; } }
div#banner > #banner_content{
    position: relative;
    width: 96%;
    height: 160px;
    margin: 20px auto;
    top:-200px;
    color:#FFF;
    font-size:27px;
}
</style>
</head>
<body>
  <div id="banner">
    <div id="banner_backdrop"></div>
    <div id="banner_content">
      Put anything you want inside this box...
    </div>
  </div>
</body>
</html>
```

### Floating Elements and Shadow Effect

Insert Floating Elements into a web page that casts shadows.

```html
<!DOCTYPE html>
<html>
<head>
<style>
div.bot_container{
	width:285px;
	height:420px;
	margin:0px auto;
}
div.bot{
	background: url(adam.png);
	width: 285px;
	height: 302px;
}
div.bot_shadow{
	height:16px;
	background: #999;
	opacity:0.1;
	border-radius:100%;
	margin:32px 0px 0px 0px;
	top:100px;
}
</style>
</head>
<body>
<div class="bot_container">
  <div class="bot"></div>
  <div class="bot_shadow"></div>
</div>
</body>
</html>
```

### Using JavaScript to Trigger Animations

```html
<!DOCTYPE html>
<html>
<head>
<style>
    .square {
        display: inline-block;
        width: 75px;
        height: 75px;
        background: #950000;
    }

    .circle {
        display: inline-block;
        width: 75px;
        height: 75px;
        background: #009578;
        border-radius: 50%;
    }
</style>
</head>
<body>
    <div class="square supports-hidden"></div>
    <button type="button" class="btn-hide-square">Hide Square</button>
    <br>
    <div class="circle supports-hidden"></div>
    <button type="button" class="btn-pulse-circle">Pulse Circle</button>

    <script type="text/javascript">
        const square = document.querySelector(".square");
        const circle = document.querySelector(".circle");
        const btnHideSquare = document.querySelector(".btn-hide-square");
        const btnPulseCircle = document.querySelector(".btn-pulse-circle");
    </script>
</body>
</html>
```

## Animated Icons

Icons are beautifully crafted symbols for some common actions or items. Adding animation to the icons makes a web page lively and helps to provide a friendly and comfortable user interface.

### Animated Icons: Battery Charging

The function animation_charge_battery() takes care of replacing and displaying the icons.

```html
<!DOCTYPE html>
<html>
<style>
#mybatdiv {
  font-size:60px;
}
</style>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<body>
<div id="mybatdiv" class="fa"></div>
<script>
function animation_charging_battery() {
  var battery;
  battery = document.getElementById("mybatdiv");
  battery.innerHTML = "&#xf244;";
  setTimeout(function () {
      battery.innerHTML = "&#xf243;";
    },2000);
  setTimeout(function () {
      battery.innerHTML = "&#xf242;";
    }, 4000);
  setTimeout(function () {
      battery.innerHTML = "&#xf241;";
    }, 6000);
  setTimeout(function () {
      battery.innerHTML = "&#xf240;";
    }, 8000);
}
animation_charging_battery();
setInterval(animation_charging_battery, 10000);
</script>
<div><h2>Animating a Battery Icon</h2></div>
</body>
</html>
```

### Animated Icons: Menu to Close

The Menu Icon transforms into a Close Icon when the menu is accessed.

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <style>
      body{
        padding: 45vh 47%;
      }
      a#menu-icon .bar {
        margin: 6px;
        width: 50px;
        height: 6px;
        background: #000;
        border-radius: 1.5px;
        transition: margin 0.2s, transform 0.2s;
      }
      a#menu-icon.close .bar:first-child {
        transform: translateY(12px) rotate(45deg);
      }
      a#menu-icon.close .bar:nth-child(2) {
        opacity: 0;
      }
      a#menu-icon.close .bar:last-child {
        transform: translateY(-12px) rotate(-45deg);
      }
    </style>
  </head>
  <body>
    <a href="#" id="menu-icon">
      <div class="bar"></div>
      <div class="bar"></div>
      <div class="bar"></div>
    </a>
    <script>
      const menuButton = document.querySelector("a#menu-icon");
      menuButton.addEventListener("click", (e) => {
        e.preventDefault();
        menuButton.classList.toggle("close");
      });
    </script>
  </body>
</html>
```

### Loaders

While buffering or processing a request of the user, loaders can be used to show the in-progress status so that users may feel like something is happening.

Eg:

- The basic loader is a circular one with internal arc-rotating numerous times.
- The border size and the border color is specified by the border property.
- border-top property defines the green arc that spins around inside the border.
- height and width defines the size of the loader.
- animation tag is added to the loader for it to spin numerous times.

```html
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
.myloader {
  border: 8px solid #245331;
  border-radius: 50%;
  border-top: 8px solid #68f127;
  width: 20px;
  height: 20px;
  -webkit-animation: spin 2.5s linear infinite; /* Safari */
  animation: spin 2.5s linear infinite;
  border-bottom: 8px solid yellow;
    border-right: 8px solid red;
    border-left: 8px solid blue;
}
@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}
/* for Safari */
@-webkit-keyframes spin {
  0% { -webkit-transform: rotate(0deg); }
  100% { -webkit-transform: rotate(360deg); }
}
</style>
</head>
<body>
<h3>Creating A Loader</h3>
<div class="myloader"></div>
</body>
</html>
```

## Building Accessible UI

### Defining Web Accessible UI

Making an Accessible Website means everyone will have the same (almost same) experience while visiting and working on it.

### Operable Accessibility

This mostly refers to accessing the elements in a web page using a keyboard, making sure that the contents are accessible by the physically disabled, restricting access to some parts of the web page when needed, defining the sequence of the accessibility of the elements, creation of custom elements.

These are mostly done by using the `tabindex`, `role` and `aria` attributes.

### Controlling Focus with Tabindex

The video gives an insight into traversal of the elements using `tabindex`.

`focus()` is used to focus on the element.

### Tab-Order

The sequence in which the DOM elements are focused is called the Tab-order.

The tab-order depends on DOM-order. The only time DOM-order is not followed is when the styling is changed using CSS.

```html
<a href="#" style="float:right;">Right aligned link</a> 

<a href="#">Link 1</a> 

<a href="#">Link 2</a>
```

The tab-order will be from right to left. This can be fixed by

```html
<a href="#">Link 1</a> 

<a href="#">Link 2</a> 

<a href="#" style="float:right;">Right aligned link</a>
```

### Custom Element and Using Tabindex

Define a custom element and use tabindex with it.

```js
class RadioButton extends HTMLElement {
  constructor() {
      super();
  }   

  connectedCallback() {
    this.setAttribute('role', 'radio');
    this.setAttribute('tabindex', '-1');
    this.setAttribute('aria-checked', 'false');
  }
}
window.customElements.define('radio-button', RadioButton);
```

```js
// Define values for keycodes
const VK_LEFT   = 37;
const VK_UP     = 38;
const VK_RIGHT  = 39;
const VK_DOWN   = 40;

class RadioGroup extends HTMLElement {
  constructor() {
      super();
  }

  handleKeydown(e) {
      switch(e.keyCode) {
          case VK_UP:
          case VK_LEFT: {
            e.preventDefault();

            if(this.selected === 0) {
                this.selected = this.radios.length - 1;
            } else {
                this.selected--;
            }
            break;
          }

          case VK_DOWN:
          case VK_RIGHT: {
            e.preventDefault();

            if(this.selected === this.radios.length - 1) {
                this.selected = 0;
            } else {
                this.selected++;
            }
            break;
          }
      }
  }

  handleClick() {
      // TODO
  }

  set selected(idx) {
    if(isFinite(this.selected)) {
        // Set the old button to tabindex -1
        let previousSelected = this.radios[this.selected];
        previousSelected.tabIndex = -1;
        previousSelected.setAttribute('aria-checked', 'false');
    }

    // Set the new button to tabindex 0 and focus it
    let newSelected = this.radios[idx];
    newSelected.tabIndex = 0;
    newSelected.setAttribute('aria-checked', 'true');
    newSelected.focus();

    this.setAttribute('selected', idx);
    this._selected = idx;
  }

  get selected() {
    return this._selected;
  }
}
```

### Using Native Elements

Native elements have a compatibility with the browsers by default. The accessibility of the web page works best with Native Elements.

Ex: button vs div as button

### The Aria Attribute

The written code has a semantic representation known as accessibility tree. Assistive tools, like screen readers, make use of this accessibility tree to compute the various properties of the element.
`aria` is an attribute that helps the browser to compute the value of an element.

### The "aXe" Tool

It is an amazing tool to identify accessibility gaps in a web page.

### Restricting Access to a Part of a Web Page

It may be required to deliberately restrict the user access to some part of a web page. The inclusion of inner.js script is one way to do it.

<https://github.com/wicg/inert>

### Hands On 1 (JavaScript-Data Collector)

```html
<!DOCTYPE html>
<html>
  <head>
    <title>Data Collector</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="index.css" />
  </head>

  <body>
    <div class="container">
      <form id="formvalue" onsubmit="onFormSubmit()" >
        <h2 id="title">Data Collector</h2>
        <label for="fname" id="firstname">First Name</label>
        <input
          type="text"
          id="fname"
          name="firstname"
          placeholder="Your first name.."
        />

        <label for="lname" id="lastname">Last Name</label>
        <input
          type="text"
          id="lname"
          name="lastname"
          placeholder="Your last name.."
        />

        <label for="location" id="officelocation">Office Location</label>
        <input
          type="text"
          id="location"
          name="lastname"
          placeholder="Your office location"
        />

        <input id="btn" type="submit" value="Submit" />
      </form>
      <br /><br />
      <table class="list" id="employeeList">
        <thead>
          <tr>
            <th id="h1">First Name</th>
            <th id="h2">Last Name</th>
            <th id="h3">Location</th>
          </tr>
        </thead>
        <tbody id="tabledata"></tbody>
      </table>
    </div>
    <script type="text/javascript" src="index.js"></script>
  </body>
</html>
```

```js
function onFormSubmit(event) {
  // call all the below functions here to use this function in the form while implementing onsubmit.
  const data = readFormData();
  insertNewRecord(data);
  resetForm();
}

function readFormData() {
  // return all the input values from three input fields here.
  const fname = document.getElementById("fname").value;
  const lname = document.getElementById("lname").value;
  const location = document.getElementById("location").value;
  if(fname === "" || lname === "" || location === "")
    window.alert("input field cannot be empty")
  return {fname, lname, location};
}

function insertNewRecord(data) {
  // this function should insert a new row with data in the table.
  const dataTable = document.getElementById("tabledata");
  dataTable.innerHTML = dataTable.innerHTML + `<tr><td>${data.fname}</td><td>${data.lname}</td><td>${data.location}</td></tr>`;
}
function resetForm() {
  // this function should reset the form fields.
  document.getElementById("fname").value = "";
  document.getElementById("lname").value = "";
  document.getElementById("location").value = "";
}
if (typeof exports !== "undefined") {
  module.exports = {
    onFormSubmit,
    readFormData,
    insertNewRecord,
    resetForm,
  };
}
```

### Hands On 2 (Filter App)

```html
<html>

<head>
    <link rel="stylesheet" href="./css/style.css" />
    <title>StudentDetails</title>
</head>

<body onload="onPageLoad()">
    <h1>Student Details</h1>
    <div>
        <label>Subject</label>
        <select id="subjects">
            <option id="opt0" value="">-- Select Subject --</option>
            <option id="opt1" value="English">English</option>
            <option id="opt2" value="Maths">Maths</option>
            <option id="opt3" value="Science">Science</option>
            <option id="opt4" value="SocialScience">Social Science</option>
        </select>
        <label>Filter By</label>
        <input type="radio" id="above" name="mode" value="above" onclick="filterBy()" checked />
        <label for="above">above</label>
        <input type="radio" id="below" name="mode" value="below" onclick="filterBy()" />
        <label for="below">below</label>
        <input type="radio" id="between" name="mode" value="between" onclick="filterBy()" />
        <label for="between">between</label>
        <input id="mark" type="number">
        <label id="to" style="display: none;">to</label>
        <input id="maxMark" type="number" style="display: none;" id="inputMark">
        <button id="filter" onclick="filterClick()">Filter</button>
        <button id="clear" onclick="Clear()">Clear</button>
    </div>
    <table id="studentTable">
        <thead>
            <tr>
                <th>S.No</th>
                <th>Name</th>
                <th>English</th>
                <th>Maths</th>
                <th>Science</th>
                <th>Social Science</th>
            </tr>
        </thead>
        <tbody id="studentData">

        </tbody>
    </table>

</body>
<script src="./js/script.js"></script>

</html>
```

```js
var data = [
    {
        id: 0,
        name: "Janu",
        English: 50,
        Maths: 86,
        Science: 77,
        SocialScience: 88
    },
    {
        id: 1,
        name: "Thanu",
        English: 75,
        Maths: 96,
        Science: 67,
        SocialScience: 91
    },
    {
        id: 2,
        name: "Tara",
        English: 90,
        Maths: 35,
        Science: 86,
        SocialScience: 100
    },
    {
        id: 3,
        name: "Glen",
        English: 79,
        Maths: 68,
        Science: 77,
        SocialScience: 78
    },
    {
        id: 4,
        name: "Zara",
        English: 80,
        Maths: 85,
        Science: 96,
        SocialScience: 68
    }
]

function onPageLoad() {
    // code goes here to display table on page loads
    const dataTable = document.querySelector("#studentData");
    dataTable.innerHTML = data.map((e, i) =>
        `<tr>
    <td>${i + 1}</td>
    <td>${e.name}</td>
    <td>${e.English}</td>
    <td>${e.Maths}</td>
    <td>${e.Science}</td>
    <td>${e.SocialScience}</td>
    </tr>`).join("");
}

function filterBy() {
    // code goes here to select filter by option
    const mode = document.querySelector('input[name="mode"]:checked').value;
    if (mode === "between") {
        document.querySelector("#to").style['display'] = 'initial';
        document.querySelector("#maxMark").style['display'] = 'initial';
    } else {
        document.querySelector("#to").style['display'] = 'none';
        document.querySelector("#maxMark").style['display'] = 'none';
    }
}

function Clear() {
    // code goes here to clear filter
    const dataTable = document.querySelector("#studentData");
    document.querySelector("#subjects").value = "";
    document.querySelector("#above").checked = true;
    dataTable.innerHTML = data.map((e, i) =>
        `<tr>
    <td>${i + 1}</td>
    <td>${e.name}</td>
    <td>${e.English}</td>
    <td>${e.Maths}</td>
    <td>${e.Science}</td>
    <td>${e.SocialScience}</td>
    </tr>`).join("");
}

function filterClick() {
    // code goes here to handle filter button
    const mode = document.querySelector('input[name="mode"]:checked').value;
    const subject = document.querySelector("#subjects").value;
    const mark = document.querySelector("#mark").value;
    const maxMark = document.querySelector("#maxMark").value;
    const dataTable = document.querySelector("#studentData");
    if (subject === "") {
        Clear();
        return;
    }

    let filteredData = [];
    if (mode === "above")
        filteredData = data.filter((e) => e[subject] > parseInt(mark));
    if (mode === "below")
        filteredData = data.filter((e) => e[subject] < parseInt(mark));
    if (mode === "between")
        filteredData = data.filter((e) => e[subject] > parseInt(mark) && e[subject] < parseInt(maxMark));

    dataTable.innerHTML = filteredData.map((e, i) =>
        `<tr>
    <td>${i + 1}</td>
    <td>${e.name}</td>
    <td>${e.English}</td>
    <td>${e.Maths}</td>
    <td>${e.Science}</td>
    <td>${e.SocialScience}</td>
    </tr>`).join("");
}
```

### Hands On 3 - Worklist

```html
<html>

<head>
  <link rel="stylesheet" href="./css/style.css" />
  <title>Worklist</title>
</head>

<body>
  <div id="header">
    <h1>Today's Worklist</h1>
    <button id="clear" onclick="clearWorkList()">Clear The Worklist</button>
    <div>
      <input type="radio" id="addWork" name="mode" value="add" onclick="changeMode()" checked />
      <label for="addWork">Add Work</label>
      <input type="radio" id="editTitle" name="mode" value="edit" onclick="changeMode()" />
      <label for="editTitle">Change Card Title</label>
      <input type="radio" id="delete" name="mode" value="delete" onclick="changeMode()" />
      <label for="delete">Delete Work</label>
    </div>
  </div>
  <hr />
  <div id="add">
    <input type="text" id="work" placeholder="Write Your Work To Do" />
    <button id="btnAdd" onClick="addWork()">Add</button>
  </div>
  <div id="edit">
    <input type="text" id="cardTitle" placeholder="Write your card title" />
    <button id="btnUpdate" onClick="update()">Update</button>
  </div>
  <section>
    <div class="card1" id="selected">
      <input type="radio" id="card1Selected" name="cardSelected" value="card1Selected" checked
        onclick="selectCard('card1')" />
      <h2>Home</h2>
      <ul></ul>
    </div>
    <div class="card2" id="">
      <input type="radio" id="card2Selected" name="cardSelected" value="card2Selected" onclick="selectCard('card2')" />
      <h2>Shopping</h2>
      <ul></ul>
    </div>
    <div class="card3" id="">
      <input type="radio" id="card3Selected" name="cardSelected" value="card3Selected" onclick="selectCard('card3')" />
      <h2>Office</h2>
      <ul></ul>
    </div>
  </section>
  <script src="./js/script.js"></script>
</body>

</html>
```

```js
function selectCard(card) {
    // code goes here to select a card 
    const mode = document.querySelector("input[name='mode']:checked").value;
    if (mode === 'edit')
        document.querySelector("#cardTitle").value = document.querySelector("." + card + " h2").innerText;

    if (mode === 'delete') {
        document.querySelectorAll("#selected ul li").forEach(e => {
            const btn = e.querySelector('button');
            if (btn) {
                btn.style.display = 'none';
            }
        });
    }

    document.querySelector("#selected").id = "";
    document.querySelector("." + card).id = "selected";

    if (mode === 'delete') {
        deleteMode();
    }
}

function addWork() {
    // code goes here for add work mode
    const workEle = document.querySelector("#work");
    if (workEle.value === "") return;
    document.querySelector("#selected ul").innerHTML += `<li>${workEle.value}</li>`;
    workEle.value = "";
}

function deleteWork(id) {
    // code goes here to delete a work in a card
    document.getElementById(id).parentNode.remove();
    deleteMode();
}

function update() {
    // code goes here to update card title
    const cardTitleEle = document.querySelector("#cardTitle");
    if (cardTitleEle.value === "") return;
    document.querySelector("#selected h2").innerHTML = cardTitleEle.value;
    cardTitleEle.value = "";
    document.querySelector("#addWork").click();
}

function clearWorkList() {
    //code goes here to clear workList
    document.querySelector(".card1 ul").remove();
    document.querySelector(".card2 ul").remove();
    document.querySelector(".card3 ul").remove();
}

function changeMode() {
    // code goes here switch between add work, update card title and delete work
    const mode = document.querySelector("input[name='mode']:checked").value;
    if (mode === 'add') {
        document.getElementById('add').style.display = 'initial';
        document.getElementById('edit').style.display = 'none';
    }
    if (mode === 'edit') {
        document.getElementById('add').style.display = 'none';
        document.getElementById('edit').style.display = 'initial';
        document.querySelector("#cardTitle").value = document.querySelector("#selected h2").innerText;
    }
    if (mode === 'delete') {
        document.getElementById('add').style.display = 'none';
        document.getElementById('edit').style.display = 'none';
        deleteMode();
    }
}

function deleteMode() {
    // code goes here for delete Mode
    document.querySelectorAll("#selected ul li").forEach((e, i) => {
        let btn = e.querySelector('button');
        if (btn) {
            btn.style.display = 'block';
        } else {
            btn = document.createElement("button");
            btn.setAttribute("type", "button");
            btn.addEventListener("click", function(event){
                deleteWork(event.target.id)
            });
            btn.innerText = "X";
            e.prepend(btn);
        }
        btn.id = "deleteBtn" + (i + 1).toString();
    });
}
```
