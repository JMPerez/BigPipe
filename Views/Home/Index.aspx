<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Import Namespace="BigPipe.Helpers" %>
<%@ Import Namespace="BigPipe.Models" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Home Page
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="line">
        <div class="unit size1of4">
            Here will be loaded pagelet1
            <%  HttpRequest req = HttpContext.Current.Request;
                Html.RegisterPagelet(new Pagelet(
                    "pagelet1-pagelet",
		            () => Html.RenderActionToString(req, "home", "pagelet1"),
                    new []{"../../Content/Pagelet1.css"},
                    new []{"http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js",                           
                            "../../Scripts/Pagelet1.js"}
                )); %> 
        </div>
        <div class="unit size1of2">
        <h1>BigPipe Sample</h1>
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eros risus, vulputate sed aliquet congue, 
        venenatis adipiscing erat. Mauris sed est velit, in fermentum lectus. Sed fringilla, neque nec hendrerit 
        molestie, odio eros bibendum nulla, et fermentum risus ipsum at nisi. In at elit nulla. In elementum tempor 
        quam a imperdiet. Quisque nec tortor elit, sit amet volutpat mauris. Nullam sagittis vehicula massa sit amet 
        pellentesque. Aenean id lectus nec eros tristique hendrerit eget suscipit justo. Phasellus scelerisque ornare 
        augue non scelerisque. Aliquam ligula enim, convallis in placerat in, scelerisque sit amet augue. Vivamus 
        cursus pellentesque augue eu iaculis. Duis at magna sed ipsum posuere posuere. Vivamus vitae facilisis urna. 
        Vestibulum aliquet leo vitae mi eleifend at placerat erat volutpat. In id ligula non odio luctus vulputate 
        vitae in tellus. Nullam sit amet justo leo, in tempor mauris. Quisque facilisis, ipsum vel dapibus pulvinar, 
        sem sapien euismod mauris, vitae commodo mauris eros non magna. Donec eget lectus vel purus semper sodales 
        a at mauris.</p>

        <p>Cras convallis lacinia nulla eget lobortis. Nullam nec lorem sem. Aliquam id sodales purus. Nullam 
        vestibulum ullamcorper nisi et molestie. Sed eget dignissim mauris. Duis ullamcorper odio nec nibh feugiat 
        et fermentum neque accumsan. Suspendisse non lectus elit. Sed porta tristique ante, ut suscipit metus 
        ultrices in. In imperdiet dolor et enim faucibus mollis. Praesent vel leo quis ante congue tincidunt in ac 
        magna. Donec hendrerit ligula non leo pretium eu blandit tortor vulputate. Phasellus id mi in felis rhoncus 
        ullamcorper lacinia a diam. Suspendisse at mi vel nulla blandit imperdiet. Pellentesque imperdiet tempor 
        ultricies. Duis imperdiet hendrerit nibh sed adipiscing. Fusce sodales mi id risus iaculis ac tincidunt 
        lacus bibendum. Fusce porttitor quam sed turpis tempus vitae molestie nunc lacinia. Sed aliquam pharetra 
        urna quis vehicula. Cras iaculis laoreet sapien sit amet consequat.</p>        
        </div>
        <div class="unit lastUnit size1of4">
        Here will be loaded pagelet2

        <% Html.RegisterPagelet(new Pagelet(
                "pagelet2-pagelet",
		        () => Html.RenderActionToString(req, "home", "pagelet2"),
                new[] { "../../Content/Pagelet2.css" },
                null
                )); %> 
        </div>
    </div>
</asp:Content>
