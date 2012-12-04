# BigPipe using ASP.NET MVC

This is a project to implement Facebook's BigPipe using ASP.NET MVC.

## What is BigPipe

BigPipe is a website performance technique implemented by Facebook to serve web pages improving user’s perceived load speed. In general, it consists of serving quickly the main content of the page, and then serve the content from other regions of the page called pagelets.

The implementation of these pagelets is performed in parallel on the server and served to the browser as soon as they are generated. This allows:

* Browser can start rendering the page content earlier (early flushing)
* Pagelets are served as soon as they are ready and the browser can render them in their container.
* If one pagelet takes longer to run, it will not delay the generation of the rest of pagelets.
* Pagelets are generated in several concurrent asynchronous threads and when a thread finishes its execution, it flushes the content so the browser can start rendering.

More information on this project and a detailed tutorial can be found on [JMPerez Blog](http://blog.josemanuelperez.es/2010/09/tutorial-how-to-implement-bigpipe-using-asp-net-mvc-part-1/)

## Implementation using ASP.NET MVC

### View structure

Our view structure will be the usual when working with ASP.Net MVC:

* Site.Master: Contains the skeleton of the HTML document. It will also fire the execution of the pagelets.
* SomePage.aspx: Fills the ContentPlaceHolders of the Site.Master. It will include the different pagelets.
* Pagelet1.ascx, Pagelet2.ascx… : The partial views that provides content to some areas that compose the page.

### Pagelets as RenderActions

Our pagelets will be included using RenderActions. Pagelets are supposed to take some time to be executed, so it makes sense that these will need to access data in some way. These data will be retrieved in a controller to keep MVC paradigm.

### Registering pagelets

First of all, we will declare a Pagelet class that is going to be used to register the Pagelets. A pagelet will contain an instance of Data, that will be serialized as JSON.
