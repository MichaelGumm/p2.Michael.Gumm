<p style="color: red; font-weight: bold">>>>>>  gd2md-html alert:  ERRORs: 0; WARNINGs: 0; ALERTS: 1.</p>
<ul style="color: red; font-weight: bold"><li>See top comment block for details on ERRORs and WARNINGs. <li>In the converted Markdown or HTML, search for inline alerts that start with >>>>>  gd2md-html alert:  for specific instances that need correction.</ul>

<p style="color: red; font-weight: bold">Links to alert messages:</p><a href="#gdcalert1">alert1</a>

<p style="color: red; font-weight: bold">>>>>> PLEASE check and correct alert issues and delete this message and the inline alerts.<hr></p>


**<span style="text-decoration:underline;">Sketch</span>**



<p id="gdcalert1" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image1.jpg). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert2">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image1.jpg "image_tooltip")


	My original plan for the interface of the mirror. I wanted to leave the middle open so the mirror can still function well as a mirror, so all of the information was to be displayed on the sides of the interface. As I began working on the final project, I made some redesigns to improve visibility of the interface and to keep it uncluttered. I was able to condense the information into widgets that only display the desired information once clicked. Because of this, I was able to keep the widgets on one side and free up even more open space. Some information, such as Sleep and Exercise was omitted to focus on more necessary data and not to overload the user with information.

**<span style="text-decoration:underline;">Final Design</span>**

**Functionality:**

As a general overview of the layout, the final design displays the current date and time in the top left corner, as well as the current weather and temperature in the top right corner. On the left side of the interface are five buttons that display various information or carry out specific functions.

The Events button loads data from the corresponding .JSON file and displays the information in a black box drawn when the button is pressed. Clicking anywhere else on the interface will close the Events popup.

The Activity button displays the user’s time spent in front of the mirror, separated into day activity and night activity. Clicking anywhere else on the interface will close the Activity popup.

The Health button loads data from the corresponding .JSON file, such as the user’s current weight, and their weight on the same day of last week. It then displays this data in a black popup that appears when the button is clicked. Clicking anywhere else on the interface will close the Health popup.

The News button will load various articles from a .JSON file containing the data, and display it in a black popup that appears when the button is clicked. Clicking anywhere else on the interface will close the News popup.

Finally, the Light button will increment the currently active color for the lights on the outer border of the mirror. This is done by using an array to store the various possible color values, then using the counter to cycle through them as the button is pressed. The possible color values are White (default), Red, Orange, Yellow, Green, Blue, Purple, and Pink.

The time is accurately acquired using Processing functions such as “hour()” and “minute()” to obtain the current time in a 24 hour format. Simple math is then used to convert this into the standard time using AM or PM.

The weather data is obtained through the use of openweathermap, a free to use weather api that returns a .JSON file of weather data when called. The program calls the api, then uses JSON parsing statements to select the necessary data such as current temperature and weather, then displays the data on the interface.
