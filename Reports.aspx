<%@ Page Title="" Language="C#" MasterPageFile="~/Events.Master" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="AppDev2.Reports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EventMainContent" runat="server" >
    <p>
        <asp:Label ID="Label1" runat="server" style="font-size: x-large" Text="Game Results"></asp:Label>
        <asp:SqlDataSource ID="sqlMedal_Country" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="Country_Medal" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
        <asp:Table ID="tblRecords" runat="server">
        </asp:Table>
    </p>
    <h4>
        Medal Tally</h4>
    <asp:GridView ID="gvTally" runat="server" AutoGenerateColumns="False" CssClass="gridview">
        <Columns>
            <asp:BoundField DataField="Standing" HeaderText="Standing" />
            <asp:BoundField DataField="Country" HeaderText="Country" />
            <asp:BoundField DataField="Gold" HeaderText="Gold" />
            <asp:BoundField DataField="Silver" HeaderText="Silver" />
            <asp:BoundField DataField="Bronze" HeaderText="Bronze" />
            <asp:BoundField DataField="Total" HeaderText="Total" />
        </Columns>
    </asp:GridView>
    <p>
        &nbsp;</p>
    <h4>
        Event</h4>
    <p>
        <asp:Label ID="Label2" runat="server" Text="Select an Event to view results"></asp:Label>
    </p>
    <p>
        <asp:DropDownList ID="ddEvent" runat="server" AutoPostBack="True" DataSourceID="sqlEventID" DataTextField="event_name" DataValueField="event_id" Height="24px" Width="176px">
        </asp:DropDownList>
    </p>
    <p>
        <asp:SqlDataSource ID="sqlEventID" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [event_id], [event_name] FROM [Event]"></asp:SqlDataSource>
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="event_id" DataSourceID="sqlEvent">
            <EditItemTemplate>
                event_name:
                <asp:TextBox ID="event_nameTextBox" runat="server" Text='<%# Bind("event_name") %>' />
                <br />
                event_venue:
                <asp:TextBox ID="event_venueTextBox" runat="server" Text='<%# Bind("event_venue") %>' />
                <br />
                event_date:
                <asp:TextBox ID="event_dateTextBox" runat="server" Text='<%# Bind("event_date") %>' />
                <br />
                event_start:
                <asp:TextBox ID="event_startTextBox" runat="server" Text='<%# Bind("event_start") %>' />
                <br />
                event_end:
                <asp:TextBox ID="event_endTextBox" runat="server" Text='<%# Bind("event_end") %>' />
                <br />
                event_desc:
                <asp:TextBox ID="event_descTextBox" runat="server" Text='<%# Bind("event_desc") %>' />
                <br />
                event_id:
                <asp:Label ID="event_idLabel1" runat="server" Text='<%# Eval("event_id") %>' />
                <br />
                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </EditItemTemplate>
            <EmptyDataTemplate>
                Nothing to display
            </EmptyDataTemplate>
            <InsertItemTemplate>
                event_name:
                <asp:TextBox ID="event_nameTextBox" runat="server" Text='<%# Bind("event_name") %>' />
                <br />
                event_venue:
                <asp:TextBox ID="event_venueTextBox" runat="server" Text='<%# Bind("event_venue") %>' />
                <br />
                event_date:
                <asp:TextBox ID="event_dateTextBox" runat="server" Text='<%# Bind("event_date") %>' />
                <br />
                event_start:
                <asp:TextBox ID="event_startTextBox" runat="server" Text='<%# Bind("event_start") %>' />
                <br />
                event_end:
                <asp:TextBox ID="event_endTextBox" runat="server" Text='<%# Bind("event_end") %>' />
                <br />
                event_desc:
                <asp:TextBox ID="event_descTextBox" runat="server" Text='<%# Bind("event_desc") %>' />
                <br />

                <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </InsertItemTemplate>
            <ItemTemplate>
                Event Name:
                <asp:Label ID="event_nameLabel" runat="server" Text='<%# Bind("event_name") %>' />
                <br />
                Venue:
                <asp:Label ID="event_venueLabel" runat="server" Text='<%# Bind("event_venue") %>' />
                <br />
                Date:
                <asp:Label ID="event_dateLabel" runat="server" Text='<%# Eval("event_date", "{0:dd/MM/yyyy}") %>' />
                <br />
                Start Time:
                <asp:Label ID="event_startLabel" runat="server" Text='<%# Bind("event_start") %>' />
                <br />
                End Time:
                <asp:Label ID="event_endLabel" runat="server" Text='<%# Bind("event_end") %>' />
                <br />
                Description:
                <asp:Label ID="event_descLabel" runat="server" Text='<%# Bind("event_desc") %>' />
                <br />
                <asp:Label ID="event_idLabel" runat="server" Text='<%# Eval("event_id") %>' Visible="False" />
                <br />

            </ItemTemplate>
        </asp:FormView>
    </p>
    <p>
        <asp:SqlDataSource ID="sqlEvent" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [event_name], [event_venue], [event_date], [event_start], [event_end], [event_desc], [event_id] FROM [Event] WHERE ([event_id] = @event_id)">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddEvent" Name="event_id" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <p>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="gridview" DataSourceID="sqlEventResults">
            <Columns>
                <asp:BoundField DataField="comp_position" HeaderText="Standing" SortExpression="comp_position" />
                <asp:BoundField DataField="comp_country" HeaderText="Country" SortExpression="comp_country" />
                <asp:BoundField DataField="comp_name" HeaderText="Name" SortExpression="comp_name" />
                <asp:BoundField DataField="comp_medal" HeaderText="Medal" SortExpression="comp_medal" />
            </Columns>
            <EmptyDataTemplate>
                No data to display
            </EmptyDataTemplate>
        </asp:GridView>
    </p>
    <p>
        <asp:SqlDataSource ID="sqlEventResults" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="Event_Standing" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddEvent" Name="event_id" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <p>
        <asp:SqlDataSource ID="sqlWorldRecord" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="World_Record" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddEvent" Name="event_id" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <p>
        <asp:FormView ID="FormView2" runat="server" DataSourceID="sqlWorldRecord" Width="473px">
            <EditItemTemplate>
                comp_name:
                <asp:TextBox ID="comp_nameTextBox" runat="server" Text='<%# Bind("comp_name") %>' />
                <br />
                world_record:
                <asp:CheckBox ID="world_recordCheckBox" runat="server" Checked='<%# Bind("world_record") %>' />
                <br />
                event_name:
                <asp:TextBox ID="event_nameTextBox" runat="server" Text='<%# Bind("event_name") %>' />
                <br />
                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </EditItemTemplate>
            <InsertItemTemplate>
                comp_name:
                <asp:TextBox ID="comp_nameTextBox" runat="server" Text='<%# Bind("comp_name") %>' />
                <br />
                world_record:
                <asp:CheckBox ID="world_recordCheckBox" runat="server" Checked='<%# Bind("world_record") %>' />
                <br />
                event_name:
                <asp:TextBox ID="event_nameTextBox" runat="server" Text='<%# Bind("event_name") %>' />
                <br />
                <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </InsertItemTemplate>
            <ItemTemplate>
                <asp:Label ID="comp_nameLabel" runat="server" Text='<%# Bind("comp_name") %>' />
                is now the world record holder for
                <asp:Label ID="event_nameLabel" runat="server" Text='<%# Bind("event_name") %>' />
                <br />
            </ItemTemplate>
        </asp:FormView>
    </p>
    <h4>
        Event Photo Search</h4>
    <p>
        Enter photo tag to search:
        <asp:TextBox ID="txtPhotoSearch" runat="server"></asp:TextBox>
    </p>
    <p>
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Search Photos" Width="118px" />
        <asp:SqlDataSource ID="sqlSearch" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="Select_Photo" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="txtPhotoSearch" Name="photo_tag" PropertyName="Text" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <p>
        <asp:GridView ID="gvPhoto" runat="server" AutoGenerateColumns="False" DataSourceID="sqlSearch">
            <Columns>
                <asp:TemplateField HeaderText="event_photo" SortExpression="event_photo">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("event_photo") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("event_photo") %>' Visible="False"></asp:Label>
                        <asp:Image ID="Image1" runat="server" Height="300px" ImageUrl='<%# Eval("event_photo", "/EventPhotos/{0}") %>' Width="300px" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="photo_tags" HeaderText="photo_tags" SortExpression="photo_tags" />
            </Columns>
            <EmptyDataTemplate>
                No photo to display
            </EmptyDataTemplate>
        </asp:GridView>
    </p>
    <p>
        &nbsp;</p>
</asp:Content>
