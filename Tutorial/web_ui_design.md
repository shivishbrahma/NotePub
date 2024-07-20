---
title: Web User Interface Design Techniques
author: Purbayan Chowdhury(@shivishbrahma)
created_ts: 2024-06-29 20:56:32
edited_ts: 2024-07-07 15:47:04
tags: ["UI design", web]
---

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

## Creating Animations

Simple Animations can be created using HTML5 and CSS3 only. JavaScript can be used to trigger animations manually.

### Animated Menu Buttons

What if a Menu button gradually changed its color on mouse-hover giving it a gradual lit-up feel!

### Animated Repeating Background

Animated Background gives a feeling that the background image of the web page is in never-ending motion.
