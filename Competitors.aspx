<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Competitors.aspx.cs" Inherits="AppDev2.Competitors" %>
<asp:Content ID="Content1" ContentPlaceHolderID="AdminMainContent" runat="server">
    <p>
        <asp:Label ID="lblheading" runat="server" style="font-size: x-large" Text="Competitors Management"></asp:Label>
    </p>
    <p>
        <asp:Label ID="Label1" runat="server" Text="View, Add, Edit, Update, Delete, and Search for Competitors "></asp:Label>
    </p>
    <p>
        <asp:SqlDataSource ID="SqlCompView" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [comp_id], [comp_name], [comp_salutation], [comp_dob], [comp_email], [comp_desc], [comp_country], [comp_gender], [comp_ph], [comp_website], [comp_photo] FROM [Competitor]" DeleteCommand="DELETE FROM [Competitor] WHERE [comp_id] = @original_comp_id" InsertCommand="INSERT INTO [Competitor] ([comp_name], [comp_salutation], [comp_dob], [comp_email], [comp_desc], [comp_country], [comp_gender], [comp_ph], [comp_website], [comp_photo]) VALUES (@comp_name, @comp_salutation, @comp_dob, @comp_email, @comp_desc, @comp_country, @comp_gender, @comp_ph, @comp_website, @comp_photo)" OldValuesParameterFormatString="original_{0}" UpdateCommand="UPDATE [Competitor] SET [comp_name] = @comp_name, [comp_salutation] = @comp_salutation, [comp_dob] = @comp_dob, [comp_email] = @comp_email, [comp_desc] = @comp_desc, [comp_country] = @comp_country, [comp_gender] = @comp_gender, [comp_ph] = @comp_ph, [comp_website] = @comp_website, [comp_photo] = @comp_photo WHERE [comp_id] = @original_comp_id">
            <DeleteParameters>
                <asp:Parameter Name="original_comp_id" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:ControlParameter ControlID="txtName" Name="comp_name" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txtSal" Name="comp_salutation" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txtDob" DbType="Date" Name="comp_dob" PropertyName="Text" />
                <asp:ControlParameter ControlID="txtEmail" Name="comp_email" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txtDesc" Name="comp_desc" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txtCountry" Name="comp_country" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txtGender" Name="comp_gender" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txtContact" Name="comp_ph" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txtWebsite" Name="comp_website" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="FileUpload1" Name="comp_photo" PropertyName="FileName" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="comp_name" Type="String" />
                <asp:Parameter Name="comp_salutation" Type="String" />
                <asp:Parameter DbType="Date" Name="comp_dob" />
                <asp:Parameter Name="comp_email" Type="String" />
                <asp:Parameter Name="comp_desc" Type="String" />
                <asp:Parameter Name="comp_country" Type="String" />
                <asp:Parameter Name="comp_gender" Type="String" />
                <asp:Parameter Name="comp_ph" Type="String" />
                <asp:Parameter Name="comp_website" Type="String" />
                <asp:Parameter Name="comp_photo" Type="String" />
                <asp:Parameter Name="original_comp_id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
</p>
    <asp:ValidationSummary ID="ValidationSummary3" runat="server" ShowMessageBox="True" ShowSummary="False" ValidationGroup="edit_validation" />
    
    <div Class="divGrid" Style="overflow-x:scroll"  >
        <asp:GridView ID="gvCompView" runat="server" AutoGenerateColumns="False" DataKeyNames="comp_id,comp_name" DataSourceID="SqlCompView" AllowSorting="True" AllowPaging="True" CellPadding="0" HorizontalAlign="Center" OnSelectedIndexChanged="gvCompView_SelectedIndexChanged" Width="500px" CssClass="gridview">
            <Columns>
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowSelectButton="True" ValidationGroup="edit_validation" />
                <asp:TemplateField HeaderText="Photo" SortExpression="comp_photo">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("comp_photo") %>' Visible="False"></asp:TextBox>
                        <asp:Image ID="Image2" runat="server" ImageUrl='<%# Eval("comp_photo", "/CompPhotos/{0}") %>' />
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("comp_photo") %>' Visible="False"></asp:Label>
                        <asp:Image ID="Image1" runat="server" AlternateText="No Image Available" ImageUrl='<%# Eval("comp_photo", "/CompPhotos/{0}") %>' Height="75px" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="comp_id" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="comp_id" />
                <asp:TemplateField HeaderText="Title" SortExpression="comp_salutation">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("comp_salutation") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator26" runat="server" ControlToValidate="TextBox2" ErrorMessage="Salutation is a required field" ValidationGroup="edit_validation">*</asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("comp_salutation") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Name" SortExpression="comp_name">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("comp_name") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator27" runat="server" ControlToValidate="TextBox3" ErrorMessage="Name is a required field">*</asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("comp_name") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="DoB" SortExpression="comp_dob">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtDob" runat="server" Text='<%# Bind("comp_dob") %>' DataFormatString="{0:dd/MM/yyyy}" ></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator28" runat="server" ControlToValidate="txtDob" ErrorMessage="Email is a required field">*</asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="CompareValidator3" runat="server" ControlToValidate="txtDob" ErrorMessage="Date must be valid date" Operator="DataTypeCheck" Type="Date" ValidationGroup="edit_validation">*</asp:CompareValidator>
                    </EditItemTemplate>
                    <ItemTemplate>                        
                        <asp:Label ID="lblDob" runat="server" Text='<%# Eval("comp_dob","{0:dd/MM/yyyy}") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Email" SortExpression="comp_email">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtEditEmail" runat="server" Text='<%# Bind("comp_email") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator30" runat="server" ControlToValidate="txtEditEmail" ErrorMessage="Email is a required field" ValidationGroup="edit_validation">*</asp:RequiredFieldValidator>
                        <asp:CustomValidator ID="CustomValidator1" runat="server" OnServerValidate="CustomValidator_ServerValidate" ControlToValidate="txtEditEmail" ErrorMessage="Email must be unique" ValidationGroup="edit_validation"></asp:CustomValidator>
                        &nbsp;
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblCompEmail" runat="server" Text='<%# Bind("comp_email") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Description" SortExpression="comp_desc">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("comp_desc") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator31" runat="server" ControlToValidate="TextBox5" ErrorMessage="Description is a required field" ValidationGroup="edit_validation">*</asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("comp_desc") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Country" SortExpression="comp_country">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("comp_country") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator32" runat="server" ControlToValidate="TextBox6" ErrorMessage="Country is a required field" ValidationGroup="edit_validation">*</asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("comp_country") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Gender" SortExpression="comp_gender">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("comp_gender") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator33" runat="server" ControlToValidate="TextBox7" ErrorMessage="Gender is a required field" ValidationGroup="edit_validation">*</asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label7" runat="server" Text='<%# Bind("comp_gender") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Phone" SortExpression="comp_ph">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("comp_ph") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator34" runat="server" ControlToValidate="TextBox8" ErrorMessage="Website is a required field" ValidationGroup="edit_validation">*</asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label8" runat="server" Text='<%# Bind("comp_ph") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Website" SortExpression="comp_website">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox9" runat="server" Text='<%# Bind("comp_website") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label9" runat="server" Text='<%# Bind("comp_website") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <SelectedRowStyle BackColor="#CCCCCC" />
        </asp:GridView>
        </div>

    <p>
        <asp:Label ID="lblInsertError" runat="server" Text="Label" Visible="False"></asp:Label>
    <p>
    <asp:ValidationSummary ID="ValidationSummary2" runat="server" ShowMessageBox="True" ShowSummary="False" ValidationGroup="add_validation" />
    <p>
    <asp:Panel ID="Panel2" runat="server" GroupingText="Add new Competitor" Height="345px" Width="672px" BackColor="#E4E4E4" BorderStyle="None">
&nbsp;
        <br />
        <asp:Label ID="Label10" runat="server" Text="Salutation: "></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtSal" runat="server" BorderStyle="Groove"></asp:TextBox>
        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator16" runat="server" ControlToValidate="txtSal" ErrorMessage="Salutation is a required Field" ValidationGroup="add_validation">*</asp:RequiredFieldValidator>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="Label16" runat="server" Text="Country: "></asp:Label>
        <asp:TextBox ID="txtCountry" runat="server" BorderStyle="Groove"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator21" runat="server" ControlToValidate="txtCountry" ErrorMessage="Country is a required field" ValidationGroup="add_validation">*</asp:RequiredFieldValidator>
        <br />
        <asp:Label ID="Label11" runat="server" Text="Name:                        "></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtName" runat="server" BorderStyle="Groove"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator17" runat="server" ControlToValidate="txtName" ErrorMessage="Name is a required field" ValidationGroup="add_validation">*</asp:RequiredFieldValidator>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="Label18" runat="server" Text="Gender: "></asp:Label>
        <asp:TextBox ID="txtGender" runat="server" BorderStyle="Groove"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator22" runat="server" ControlToValidate="txtGender" ErrorMessage="Gender is a required field" ValidationGroup="add_validation">*</asp:RequiredFieldValidator>
        <br />
        <asp:Label ID="Label12" runat="server" Text="Date of Birth:"></asp:Label>
        &nbsp;&nbsp;<asp:TextBox ID="txtDob" runat="server" BorderStyle="Groove"></asp:TextBox>
        <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="txtDob" ErrorMessage="Dob must be in dd/mm/yyyy format" Operator="DataTypeCheck" Type="Date" ValidationGroup="add_validation">*</asp:CompareValidator>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator18" runat="server" ControlToValidate="txtDob" ErrorMessage="DoB is a required field" ValidationGroup="add_validation">*</asp:RequiredFieldValidator>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;
        <asp:Label ID="Label19" runat="server" Text="Contact Number"></asp:Label>
        <asp:TextBox ID="txtContact" runat="server" BorderStyle="Groove"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator23" runat="server" ControlToValidate="txtContact" ErrorMessage="Contact is a required field" ValidationGroup="add_validation">*</asp:RequiredFieldValidator>
        <br />
        <asp:Label ID="Label13" runat="server" Text="Email:  "></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtEmail" runat="server" OnTextChanged="txtEmail_TextChanged" BorderStyle="Groove"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator19" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email is a required field" ValidationGroup="add_validation">*</asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email must be a valid email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="add_validation">*</asp:RegularExpressionValidator>
        <asp:CustomValidator ID="CustomValidator2" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email must be unique" OnServerValidate="CustomValidator_ServerValidate" ValidationGroup="add_validation">*</asp:CustomValidator>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="Label20" runat="server" Text="Website: "></asp:Label>
        <asp:TextBox ID="txtWebsite" runat="server" BorderStyle="Groove"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator24" runat="server" ControlToValidate="txtWebsite" ErrorMessage="Website is a required field" ValidationGroup="add_validation">*</asp:RequiredFieldValidator>
        <br />
        <asp:Label ID="Label14" runat="server" Text="Description"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:TextBox ID="txtDesc" runat="server" BorderStyle="Groove" Width="120px"></asp:TextBox>
        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator20" runat="server" ControlToValidate="txtDesc" ErrorMessage="Description is a required field" ValidationGroup="add_validation">*</asp:RequiredFieldValidator>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;
        <asp:Label ID="Label22" runat="server" Text="Game Played:"></asp:Label>
        <asp:DropDownList ID="ddGames" runat="server" DataSourceID="SqlGames" DataTextField="game_name" DataValueField="game_name" Height="25px" Width="128px">
        </asp:DropDownList>
        <br />
        <asp:Label ID="Label21" runat="server" Text="Photo:"></asp:Label>
        <asp:FileUpload ID="FileUpload1" runat="server" />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator25" runat="server" ControlToValidate="FileUpload1" ErrorMessage="Photo is a required field" ValidationGroup="add_validation">*</asp:RequiredFieldValidator>
        <asp:Label ID="lblInvalidFile" runat="server" Text="Invalid file extension" Visible="False"></asp:Label>
        <asp:Label ID="lblUploadStatus" runat="server" Text="File Uploaded" Visible="False"></asp:Label>
        <asp:Button ID="btnAddComp" runat="server" OnClick="btnAddComp_Click" Text="Add Competitor" ValidationGroup="add_validation" BorderStyle="Groove" />
        <br />
        <asp:SqlDataSource ID="SqlGames" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [game_name] FROM [Game]"></asp:SqlDataSource>
        <br />
        <br />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    </asp:Panel>
    <br />
    <br />
    <asp:Panel ID="Panel3" runat="server" GroupingText="Upload Photo" Height="196px" Width="669px" BackColor="#DFDFDF">
        &nbsp;If you have added competitors using an excel file, add their photo&#39;s here:<br />
        <br />
        <asp:Label ID="lblSelectCompetitor" runat="server" Text="Select Competitor"></asp:Label>
        <asp:FileUpload ID="FileUpload2" runat="server" />
        <asp:Button ID="btnUploadExPhoto" runat="server" OnClick="btnUploadExPhoto_Click" Text="Upload photo" />
        <asp:Label ID="lblInvalidEx" runat="server" Text="Invalid Extension" Visible="False"></asp:Label>
        <asp:Label ID="lblFileStatus" runat="server" Text="Photo Uploaded" Visible="False"></asp:Label>
    </asp:Panel>
    <br />
    <asp:Panel ID="Panel1" runat="server" Height="166px" Width="469px" BackColor="#DFDFDF">
        <asp:Label ID="Label2" runat="server" Text="Import Excel File" style="font-size: large"></asp:Label>
        <br />
        <asp:Label ID="Label3" runat="server" style="font-size: small" Text="Excel files must match the correct column headings.  Photos can be uploaded after import using the edit photo form below."></asp:Label>
        <br />
        <asp:FileUpload ID="fuExcel" runat="server" />
        <asp:Label ID="lblInvalidExtension" runat="server" Text="Invalid Extension" Visible="False"></asp:Label>
        <asp:Label ID="lblErrorMsg" runat="server" Text="Error" Visible="False"></asp:Label>
        <br />
        <asp:Button ID="btnUploadExcel" runat="server" OnClick="btnUploadExcel_Click" Text="Import File" />
    </asp:Panel>
    <p>
        &nbsp;</p>
</asp:Content>
