using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Text;
using System.IO;
using System.Web.Mvc.Html;

namespace BigPipe.Helpers
{
    /* By Lorenz Cuno on http://www.klopfenstein.net/lorenz.aspx/render-partial-view-to-string-in-asp-net-mvc */
    public static class RendererHelper
    {
        /// <summary>Renders a view to string.</summary> 
        public static string RenderPartialToString(this HtmlHelper html, string viewName, object viewData)
        {
            return RenderViewToString(html.ViewContext.Controller.ControllerContext, viewName, viewData);
        }
        /// <summary>Renders a view to string.</summary> 
        public static string RenderViewToString(this Controller controller, string viewName, object viewData)
        {
            return RenderViewToString(controller.ControllerContext, viewName, viewData);
        }


        /// <summary>Fake IView implementation, only used to instantiate an HtmlHelper.</summary> 
        public class FakeView : IView
        {
            #region IView Members
            public void Render(ViewContext viewContext, System.IO.TextWriter writer)
            {
                throw new NotImplementedException();
            }
            #endregion
        }

        private static string RenderViewToString(ControllerContext context,
                                                string viewName, object viewData)
        {
            //Create memory writer 
            var sb = new StringBuilder();
            var memWriter = new StringWriter(sb);

            //Create fake http context to render the view 
            var fakeResponse = new HttpResponse(memWriter);
            var fakeContext = new HttpContext(HttpContext.Current.Request, fakeResponse);
            var fakeControllerContext = new ControllerContext(
                new HttpContextWrapper(fakeContext),
                context.RouteData, context.Controller);

            var oldContext = HttpContext.Current;
            HttpContext.Current = fakeContext;

            //Use HtmlHelper to render partial view to fake context 
            var html = new HtmlHelper(new ViewContext(fakeControllerContext,
                new FakeView(), new ViewDataDictionary(), new TempDataDictionary(), memWriter),
                new ViewPage());

            RenderPartialExtensions.RenderPartial(html, viewName, viewData);

            //Restore context 
            HttpContext.Current = oldContext;

            //Flush memory and return output 
            memWriter.Flush();
            return sb.ToString();
        }

        public static string RenderActionToString(this HtmlHelper helper, HttpRequest request, string controller, string action)
        {
            //Create memory writer
            var sb = new StringBuilder();
            var memWriter = new StringWriter(sb);

            //Create fake http context to render the view
            var fakeResponse = new HttpResponse(memWriter);
            var fakeContext = new HttpContext(request, fakeResponse);
            var fakeControllerContext = new ControllerContext(
                new HttpContextWrapper(fakeContext),
                helper.ViewContext.RouteData,
                helper.ViewContext.Controller);

            var oldContext = HttpContext.Current;
            HttpContext.Current = fakeContext;

            //Use HtmlHelper to render partial view to fake context
            var html = new HtmlHelper(new ViewContext(fakeControllerContext,
                new FakeView(), new ViewDataDictionary(), new TempDataDictionary(), memWriter),
                new ViewPage());
            html.RenderAction(action, controller);

            //Restore context
            HttpContext.Current = oldContext;

            //Flush memory and return output
            memWriter.Flush();
            return sb.ToString();
        }
    }
}