<!DOCTYPE html>
<html lang="en">
<%@include file="Header.jsp"%>
<head>
     <meta charset="UTF-8">
     <meta name="viewport" content="width=device-width, initial-scale=1.0">
     <title>About the Author</title>
     <!-- Add your stylesheets and other meta tags here -->
</head>
<body class="bg-gray-100">

     <!-- Navigation Bar -->
     <header class="bg-blue-500 text-white p-4">
         <div class="container mx-auto flex justify-between items-center">
             <div class="flex items-center">
                 <img src="./images/logo.svg" alt="Logo" class="h-12">
                 <span class="text-xl font-semibold ml-2">task management</span>
             </div>
             <nav>
                 <ul class="flex space-x-4">
                     <li><a href="index.jsp" class="hover:underline">Home</a></li>
                     <li><a href="login.jsp" class="hover:underline">login</a></li>
                     <%--  --%>
                     <!-- Add more navigation links if needed -->
                 </ul>
             </nav>
         </div>
     </header>

     <!-- Author Information -->
     <div class="container mx-auto mt-8 flex flex-col items-center">
         <img src="./img/pfp.jpg" alt="Author Avatar" class="w-32 h-32 rounded-full mb-4">
         <h1 class="text-3xl font-semibold mb-2">Ron Elgazar</h1>
         <p class="text-gray-500">Software Developer, Captain Tim Coy and Realist</p>
         <p class="text-base md:text-lg text-center mt-4">Hi, my name is Ron, I'm 17 years old from Jerusalem and I study at Ort Givat Ram . I am interested in software development and fullstack and in addition I am captain of the robotics group team koi 6230. In addition I am a student in the national cyber program - Magshimim </p>

            <a href="about.jsp" class="bg-blue-500 hover:bg-blue-600 text-white px-4 py-2 rounded-full mt-4">About</a>
         <div class="flex space-x-4 mt-4">
             <!-- Add social media links or any other relevant links -->
             <a href="https://www.linkedin.com/in/ron-elgazar-3989131b6/" class="text-blue-500 hover:underline">LinkedIn</a>
             <a href="https://github.com/ronelgazar" class="text-blue-500 hover:underline">GitHub</a>
         </div>
     </div>

     <!-- Footer Section -->
     <footer class="bg-gray-800 text-white p-4 mt-8">
         <div class="container mx-auto text-center">
             <!-- Add footer content, links, or any other information -->
             <p> 2023 Personal Task Tracker. All rights reserved
         </div>
     </footer>

</body>
</html>