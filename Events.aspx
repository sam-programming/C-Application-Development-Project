<%@ Page Title="" Language="C#" MasterPageFile="~/Events.Master" AutoEventWireup="true" CodeBehind="Events.aspx.cs" Inherits="AppDev2.Events" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EventMainContent" runat="server">
    <asp:Label ID="Label1" runat="server" style="font-size: x-large" Text="Welcome to the Event Management Page"></asp:Label>
    <div _designerregion="0">
        <asp:Label ID="Label2" runat="server" Text="Add, Edit, View, Delete Events here"></asp:Label>
        <br />
        <br />
        <h4>
        <asp:Label ID="Label3" runat="server" Text="Current Events"></asp:Label>
        </h4>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Event] WHERE [event_id] = @event_id" InsertCommand="INSERT INTO [Event] ([game_id], [event_name], [event_venue], [event_date], [event_end], [event_start], [event_desc]) VALUES (@game_id, @event_name, @event_venue, @event_date, @event_end, @event_start, @event_desc)" SelectCommand="SELECT [event_id], [game_id], [event_name], [event_venue], [event_date], [event_end], [event_start], [event_desc] FROM [Event]" UpdateCommand="UPDATE [Event] SET [game_id] = @game_id, [event_name] = @event_name, [event_venue] = @event_venue, [event_date] = @event_date, [event_end] = @event_end, [event_start] = @event_start, [event_desc] = @event_desc WHERE [event_id] = @event_id">
            <DeleteParameters>
                <asp:Parameter Name="event_id" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:ControlParameter ControlID="txtGameID" Name="game_id" PropertyName="Text" Type="Int32" />
                <asp:ControlParameter ControlID="txtEvent" Name="event_name" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txtVenue" Name="event_venue" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txtDate" DbType="Date" Name="event_date" PropertyName="Text" />
                <asp:ControlParameter ControlID="txtEndTime" Name="event_end" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txtStartTime" Name="event_start" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txtDesc" Name="event_desc" PropertyName="Text" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="game_id" Type="Int32" />
                <asp:Parameter Name="event_name" Type="String" />
                <asp:Parameter Name="event_venue" Type="String" />
                <asp:Parameter DbType="Date" Name="event_date" />
                <asp:Parameter Name="event_end" Type="String" />
                <asp:Parameter Name="event_start" Type="String" />
                <asp:Parameter Name="event_desc" Type="String" />
                <asp:Parameter Name="event_id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <div style="overflow-x:scroll">
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="event_id" DataSourceID="SqlDataSource1" AllowPaging="True" AllowSorting="True" OnDataBound="GridView1_DataBound" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" CssClass="gridview">
                <Columns>
                    <asp:CommandField ShowDeleteButton="True" ShowSelectButton="True" />
                    <asp:BoundField DataField="event_id" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="event_id" />
                    <asp:TemplateField HeaderText="Game" SortExpression="game_id">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("game_id") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("game_id") %>' Visible="False"></asp:Label>
                            <asp:Label ID="lblGameName" runat="server" Text="Label"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="event_name" HeaderText="Event Name" SortExpression="event_name" />
                    <asp:BoundField DataField="event_venue" HeaderText="Venue" SortExpression="event_venue" />
                    <asp:TemplateField HeaderText="Date" SortExpression="event_date">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Eval("event_date","{0:dd/MM/yyyy}") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("event_date") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="event_start" HeaderText="Start Time" SortExpression="event_start" />
                    <asp:BoundField DataField="event_end" HeaderText="End Time" SortExpression="event_end" />
                    <asp:BoundField DataField="event_desc" HeaderText="Description" SortExpression="event_desc" />
                </Columns>
                <EmptyDataTemplate>
                    <asp:Label ID="Label16" runat="server" Text="No data to display"></asp:Label>
                </EmptyDataTemplate>
            </asp:GridView>
          </div>
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True" ShowSummary="False" ValidationGroup="add_valid" />
            <asp:Panel ID="Panel1" runat="server" GroupingText="Add New Event" Height="323px" Width="585px">
                <br />
                <asp:Label ID="Label5" runat="server" Text="Game: "></asp:Label>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;<asp:DropDownList ID="ddGame" runat="server" AutoPostBack="True" DataSourceID="sqlGames" DataTextField="game_name" DataValueField="game_dur_hrs" Height="25px" OnDataBound="ddGame_DataBound" OnSelectedIndexChanged="ddGame_SelectedIndexChanged" Width="146px">
                </asp:DropDownList>
                <asp:Repeater ID="Repeater1" runat="server" DataSourceID="sqlGames">
                    <ItemTemplate>

                    </ItemTemplate>
                </asp:Repeater>
                <asp:CustomValidator ID="CustomValidator1" runat="server" ControlToValidate="ddGame" ErrorMessage="Game must be selected" OnServerValidate="CustomValidator1_ServerValidate" ValidationGroup="add_valid">*</asp:CustomValidator>
                &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;<asp:Label ID="lblstart" runat="server" Text="Start Time: "></asp:Label>
                <asp:TextBox ID="txtStartTime" runat="server" BorderStyle="Groove" AutoPostBack="True" OnTextChanged="txtStartTime_TextChanged"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtStartTime" ErrorMessage="Start Time is a required field" ValidationGroup="add_valid">*</asp:RequiredFieldValidator>
                <br />
                <asp:Label ID="Label6" runat="server" Text="Event Name: "></asp:Label>
                <asp:TextBox ID="txtEvent" runat="server" BorderStyle="Groove"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEvent" ErrorMessage="Event is a required field" ValidationGroup="add_valid">*</asp:RequiredFieldValidator>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Label ID="Label10" runat="server" Text="End Time: "></asp:Label>
                <asp:TextBox ID="txtEndTime" runat="server" BorderStyle="Groove"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtEndTime" ErrorMessage="End Time is a required field" ValidationGroup="add_valid">*</asp:RequiredFieldValidator>
                <br />
                <asp:Label ID="Label7" runat="server" Text="Venue: "></asp:Label>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:TextBox ID="txtVenue" runat="server" BorderStyle="Groove"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtVenue" ErrorMessage="Venue is a required field" ValidationGroup="add_valid">*</asp:RequiredFieldValidator>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label11" runat="server" Text="Event Description: "></asp:Label>
                <asp:TextBox ID="txtDesc" runat="server" BorderStyle="Groove" MaxLength="100"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtEvent" ErrorMessage="Event is a required field" ValidationGroup="add_valid">*</asp:RequiredFieldValidator>
                <br />
                <asp:Label ID="Label8" runat="server" Text="Date: "></asp:Label>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:TextBox ID="txtDate" runat="server" BorderStyle="Groove" Width="131px"></asp:TextBox>
                <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="txtDate" ErrorMessage="Date is invalid" Operator="DataTypeCheck" Type="Date" ValidationGroup="add_valid">*</asp:CompareValidator>
                &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtDate" ErrorMessage="Date is a required field" ValidationGroup="add_valid">*</asp:RequiredFieldValidator>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Label runat="server" Text="Photo Tags: "></asp:Label>
                &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;<asp:TextBox ID="txtTags" runat="server" BorderStyle="Groove"></asp:TextBox>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;<br />
                
                <asp:Label ID="lblGameID" runat="server" Text="ID: "></asp:Label>
                <asp:TextBox ID="txtGameID" runat="server" ReadOnly="True" Width="25px"></asp:TextBox>
                
                <br />
                <asp:Label ID="Label12" runat="server" Text="Upload event photo"></asp:Label>
                <asp:FileUpload ID="FileUpload1" runat="server" />
                <asp:Label ID="lblUploadStatus" runat="server" Text="Upload Successful" Visible="False"></asp:Label>
                <asp:Label ID="lblExtension" runat="server" Text="File extension not valid: Only .jpg and .png allowed" Visible="False"></asp:Label>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="FileUpload1" ErrorMessage="Event Photo is a required field" ValidationGroup="add_valid">*</asp:RequiredFieldValidator>
                <asp:SqlDataSource ID="sqlGames" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [game_name], [game_dur_hrs], [game_id] FROM [Game]"></asp:SqlDataSource>
                <asp:SqlDataSource ID="sqlEventPhoto" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Event_Photo] WHERE [photo_id] = @photo_id" InsertCommand="INSERT INTO [Event_Photo] ([photo_id], [event_photo], [photo_tags], [event_id]) VALUES (@photo_id, @event_photo, @photo_tags, @event_id)" SelectCommand="SELECT [photo_id], [event_photo], [photo_tags], [event_id] FROM [Event_Photo]" UpdateCommand="UPDATE [Event_Photo] SET [event_photo] = @event_photo, [photo_tags] = @photo_tags, [event_id] = @event_id WHERE [photo_id] = @photo_id">
                    <DeleteParameters>
                        <asp:Parameter Name="photo_id" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="photo_id" Type="Int32" />
                        <asp:Parameter Name="event_photo" Type="String" />
                        <asp:Parameter Name="photo_tags" Type="String" />
                        <asp:Parameter Name="event_id" Type="Int32" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="event_photo" Type="String" />
                        <asp:Parameter Name="photo_tags" Type="String" />
                        <asp:Parameter Name="event_id" Type="Int32" />
                        <asp:Parameter Name="photo_id" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:Button ID="btnAddEvent" runat="server" Text="Add Event" OnClick="btnAddEvent_Click" ValidationGroup="add_valid" />
            </asp:Panel>
            <br />
            <asp:Panel ID="Panel2" runat="server" GroupingText="Event Results" Height="221px" style="margin-top: 3px" Width="586px">
                Select an event to enter results<br />
                <br />
                <asp:Label ID="Label13" runat="server" Text="Event ID: "></asp:Label>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:TextBox ID="txtEventID" runat="server" ReadOnly="True" Width="31px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtEventID" ErrorMessage="Event ID is a required field. Please select event"></asp:RequiredFieldValidator>
                <br />
                <asp:Label ID="Label15" runat="server" Text="Competitor: "></asp:Label>
                &nbsp;&nbsp;
                <asp:DropDownList ID="ddComp" runat="server" DataSourceID="SqlDataSource2" DataTextField="comp_name" DataValueField="comp_id" Height="25px" Width="197px">
                </asp:DropDownList>
                <br />
                <asp:Label ID="Label14" runat="server" Text="Position: "></asp:Label>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:DropDownList ID="ddPosition" runat="server" AutoPostBack="True" Height="25px" OnSelectedIndexChanged="ddPosition_SelectedIndexChanged" Width="195px">
                    <asp:ListItem>-- Select a Position --</asp:ListItem>
                    <asp:ListItem>1</asp:ListItem>
                    <asp:ListItem>2</asp:ListItem>
                    <asp:ListItem>3</asp:ListItem>
                    <asp:ListItem>4</asp:ListItem>
                    <asp:ListItem>5</asp:ListItem>
                    <asp:ListItem>6</asp:ListItem>
                    <asp:ListItem>7</asp:ListItem>
                    <asp:ListItem>8</asp:ListItem>
                </asp:DropDownList>
                &nbsp;&nbsp;&nbsp;&nbsp;
                <br />
                <asp:CheckBox ID="CheckBox1" runat="server" Text="World Record?" Visible="False" />
                <br />
                <asp:Button ID="btnAddEventResult" runat="server" OnClick="btnAddEventResult_Click" Text="Add Result" />
                <asp:Label ID="lblInsertStatus" runat="server" Text="Label" Visible="False"></asp:Label>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [comp_id], [comp_name] FROM [Competitor]"></asp:SqlDataSource>
        </asp:Panel>
            <br />
            <br />        
    </div>
</asp:Content>
