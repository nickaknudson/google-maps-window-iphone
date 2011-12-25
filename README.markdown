# iPhone Window for Google Maps JS API

Requires:

* [Google Maps JS API v3](http://code.google.com/apis/maps/documentation/javascript/)
* [jQuery](http://jquery.com/)

```javascript
// create a new iPhoneWindow
body = "body text";
tsub = "sub text";
options = { timestamp:false, arrow:false, arrowdown:true };
info = new google.maps.iPhoneWindow(body, tsub, options);

// openInfoWindow
info.open(map, marker);

// closeInfoWindow
info.close();
```
## Timestamp feature

Requires:

* [easydate](http://easydate.parshap.com/)

```javascript
// create a new iPhoneWindow
body = "body text";
tsub = new Date();
options = { timestamp:true, arrow:false, arrowdown:true };
info = new google.maps.iPhoneWindow(body, tsub, options);
```
