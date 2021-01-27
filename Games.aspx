<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Games.aspx.cs" Inherits="AppDev2.Games" %>
<asp:Content ID="Content1" ContentPlaceHolderID="AdminMainContent" runat="server">
    <h2>
        <asp:Label ID="lblGamesHeading" runat="server" Font-Size="X-Large" Text="Games Managment"></asp:Label>
    </h2>
    <p>
        View, Edit, Delete and Add Games here</p>
    <asp:SqlDataSource ID="SQlGames" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Game] WHERE [game_id] = @original_game_id AND [game_code] = @original_game_code AND [game_name] = @original_game_name AND [game_dur_hrs] = @original_game_dur_hrs AND [game_desc] = @original_game_desc AND [game_rules] = @original_game_rules" InsertCommand="INSERT INTO [Game] ([game_code], [game_name], [game_dur_hrs], [game_desc], [game_rules]) VALUES (@game_code, @game_name, @game_dur_hrs, @game_desc, @game_rules)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [Game]" UpdateCommand="UPDATE [Game] SET [game_code] = @game_code, [game_name] = @game_name, [game_dur_hrs] = @game_dur_hrs, [game_desc] = @game_desc, [game_rules] = @game_rules WHERE [game_id] = @original_game_id AND [game_code] = @original_game_code AND [game_name] = @original_game_name AND [game_dur_hrs] = @original_game_dur_hrs AND [game_desc] = @original_game_desc AND [game_rules] = @original_game_rules">
        <DeleteParameters>
            <asp:Parameter Name="original_game_id" Type="Int32" />
            <asp:Parameter Name="original_game_code" Type="String" />
            <asp:Parameter Name="original_game_name" Type="String" />
            <asp:Parameter Name="original_game_dur_hrs" Type="Int32" />
            <asp:Parameter Name="original_game_desc" Type="String" />
            <asp:Parameter Name="original_game_rules" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="txtGameCode" Name="game_code" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtGameName" Name="game_name" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtDuration" Name="game_dur_hrs" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="txtDesc" Name="game_desc" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="FileUpload1" Name="game_rules" PropertyName="FileName" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="game_code" Type="String" />
            <asp:Parameter Name="game_name" Type="String" />
            <asp:Parameter Name="game_dur_hrs" Type="Int32" />
            <asp:Parameter Name="game_desc" Type="String" />
            <asp:Parameter Name="game_rules" Type="String" />
            <asp:Parameter Name="original_game_id" Type="Int32" />
            <asp:Parameter Name="original_game_code" Type="String" />
            <asp:Parameter Name="original_game_name" Type="String" />
            <asp:Parameter Name="original_game_dur_hrs" Type="Int32" />
            <asp:Parameter Name="original_game_desc" Type="String" />
            <asp:Parameter Name="original_game_rules" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:ValidationSummary ID="ValidationSummary2" runat="server" ShowMessageBox="True" ShowSummary="False" ValidationGroup="add_validation" />
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True" ShowSummary="False" ValidationGroup="edit_validation" />
    <asp:GridView ID="GridGame" OnRowDataBound="GridGame_RowDataBound" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="game_id" DataSourceID="SQlGames" OnSelectedIndexChanged="GridGame_SelectedIndexChanged" CssClass="gridview">
        <Columns>
            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowSelectButton="True" ValidationGroup="edit_validation" />
            <asp:BoundField DataField="game_id" HeaderText="game_id" InsertVisible="False" ReadOnly="True" SortExpression="game_id" />
            <asp:TemplateField HeaderText="game_code" SortExpression="game_code">
                <EditItemTemplate>
                    <asp:TextBox ID="txtCodeEdit" runat="server" Text='<%# Bind("game_code") %>'></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtCodeEdit" ErrorMessage="Required Field" ValidationGroup="edit_validation">*</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtCodeEdit" ErrorMessage="Game code must be comprised of 4 uppercase letters followed by 3 digits" ValidationExpression="^[A-Z]{4}\d{3}$" ValidationGroup="edit_validation">*</asp:RegularExpressionValidator>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblGameCode" runat="server" Text='<%# Bind("game_code") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="game_name" SortExpression="game_name">
                <EditItemTemplate>
                    <asp:TextBox ID="txtNameEdit" runat="server" Text='<%# Bind("game_name") %>'></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtNameEdit" ErrorMessage="Required Field" ValidationGroup="edit_validation">*</asp:RequiredFieldValidator>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("game_name") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="game_dur_hrs" SortExpression="game_dur_hrs">
                <EditItemTemplate>
                    <asp:TextBox ID="txtEditDur" runat="server" Text='<%# Bind("game_dur_hrs") %>'></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtEditDur" ErrorMessage="Required Field" ValidationGroup="edit_validation">*</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtEditDur" ErrorMessage="Duration is a maximum of 3 digits" ValidationGroup="edit_validation" ValidationExpression="[0-9]{1,3}">*</asp:RegularExpressionValidator>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("game_dur_hrs") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="game_desc" SortExpression="game_desc">
                <EditItemTemplate>
                    <asp:TextBox ID="txtEditDesc" runat="server" Text='<%# Bind("game_desc") %>'></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtEditDesc" ErrorMessage="Required Field" ValidationGroup="edit_validation">*</asp:RequiredFieldValidator>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("game_desc") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="game_rules" SortExpression="game_rules">  
                <EditItemTemplate>
                    <asp:Label runat="server" id="lblRulesEdit" Text='<%# Bind("game_rules") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblRules" runat="server" Text='<%# Bind("game_rules") %>' Visible="False"></asp:Label>
                    <asp:HyperLink ID="hlRules" runat="server">HyperLink</asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <br />
    <asp:Panel ID="Panel2" runat="server" GroupingText="Edit Game Rules" Height="196px" style="margin-left: 3px" Width="365px">
        <asp:Label ID="Label10" runat="server" style="font-size: small" Text="To edit game rules booklet, please select the row you would like to edit and upload a new booklet using the control below"></asp:Label>
        .<br /> 
        <asp:Label ID="lblSelectedRow" runat="server" style="font-size: small" Text="Label" Visible="False"></asp:Label>
        &nbsp;<br />
        <br />
        <asp:FileUpload ID="FileUploadEdit" runat="server" />
        <asp:Button ID="BtnUploadNew" runat="server" OnClick="BtnUploadNew_Click" Text="Upload New" />
        <asp:Label ID="lblUploadStatus1" runat="server" Text="File Uploaded" Visible="False"></asp:Label>
        &nbsp;<asp:Label ID="lblInvalidEx" runat="server" Text="Invalid File extension" Visible="False"></asp:Label>
    </asp:Panel>
    <asp:Panel ID="Panel1" runat="server" GroupingText="Add Record" Height="258px" style="margin-top: 19px" Width="357px">
        <br />
        <asp:Label ID="Label5" runat="server" Text="Game Code: "></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtGameCode" runat="server" Wrap="false"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtGameCode" ErrorMessage="Required Field" ValidationGroup="add_validation">*</asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtGameCode" ErrorMessage="Game Code must be 4 uppercase letters followed by 3 digits" ValidationExpression="^[A-Z]{4}\d{3}$" ValidationGroup="add_validation">*</asp:RegularExpressionValidator>
        <br />
        <asp:Label ID="Label6" runat="server" Text="Game Name: "></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtGameName" runat="server" Wrap="false"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtGameName" ErrorMessage="Required Field" ValidationGroup="add_validation">*</asp:RequiredFieldValidator>
        <br />
        <asp:Label ID="Label7" runat="server" Text="Duration (Hours): "></asp:Label>
        &nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtDuration" runat="server" Wrap="false"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtDuration" ErrorMessage="Required Field" ValidationGroup="add_validation">*</asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtDuration" ErrorMessage="Duration must be numeric" ValidationExpression="^\b\d{1,3}\b$" ValidationGroup="add_validation">*</asp:RegularExpressionValidator>
        <br />
        <asp:Label ID="Label8" runat="server" Text="Description: "></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtDesc" runat="server" Wrap="false" MaxLength="99"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtDesc" ErrorMessage="Required Field" ValidationGroup="add_validation">*</asp:RequiredFieldValidator>
        <br />
        <br />
        <asp:Label ID="Label9" runat="server" Text="Rules Booklet: "></asp:Label>
        <asp:FileUpload ID="FileUpload1" runat="server" Wrap="false" />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="FileUpload1" ErrorMessage="Required Field" ValidationGroup="add_validation">*</asp:RequiredFieldValidator>
        <asp:Label ID="lblUploadStatus" runat="server" Text="File Uploaded" Visible="False"></asp:Label>
        &nbsp;<asp:Label ID="lblInvaildExtension" runat="server" Text="Invalid File extension" Visible="False"></asp:Label>
        <br />
        <asp:Button ID="btnAdd" runat="server" OnClick="btnAdd_Click" Text="Add Game" ValidationGroup="add_validation" />
        &nbsp;<asp:Label ID="lblInsertStatus" runat="server" Text="Game added succesfully" Visible="False"></asp:Label>
    </asp:Panel>
    <p>
        </p>
    <p>
        &nbsp;</p>
    <p>
        &nbsp;</p>
    <p>
        &nbsp;</p>
    <p>
        &nbsp;</p>
    <p>
        </p>
    </asp:Content>
