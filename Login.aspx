<%@ page title="" language="C#" masterpagefile="~/Global.master" autoeventwireup="true" inherits="Login, App_Web_ludy2q0l" enableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script src="js/Login1231RL.js" type="text/javascript"></script>
   <%-- <script src="js/quagga.min.js" type="text/javascript"></script>
    <script src="js/live_w_locator.js" type="text/javascript"></script>--%>

    <script type="text/javascript">

        var Company = '1';
        var Config_Object;
        var stack = "document.onReady (Login.aspx)";
        var Settings_Object;
        var passwordConst = 'none';
        var tempUserID = '';
        /////////////////THESE GLOBAL VARIABLES ARE ONLY USED FOR DESKTOP SIGNATURES/////////////////////////
        var IframeApprovalTimecardArray = [];
        var IframeApprovalLevel = 1;
        var IframeApprovedBy = '';
        var DesktopSigData = {};
        var useApprovalReport = true;
        //////////////////////////////////////////


        document.addEventListener('DOMContentLoaded', function ()
        {
            if (document.URL.indexOf('Login.aspx') != -1)
            {
                buildMenu('Document.ready() (Login.aspx)');
                load_menu_strip('Document.ready() (Login.aspx)');
            }
            onDOMContentLoaded('DOMContentLoaded() (Login.aspx)');
        });

        $(document).ready(function ()
        {
            registerDesktopSignature();

            var currentDomain = window.location.toString();
            currentDomain = currentDomain.substr(0, currentDomain.indexOf('/Default'));
            theURL = "cnsbarcode://scan?scanreturnerrors=yes&launchurl=" + currentDomain + "/Default.aspx%3FRETURN%3DCNS%26CNSID%3D::barcode::";

            onDocumentLoad('Document.ready() (Login.aspx)');
            $('#AfterImportTab').on('shown.bs.tab', function(e)
            {
                //e.target // newly activated tab
                //e.relatedTarget // previous active tab
                get_after_import_text('Document.ready() (Login.aspx)');
            });
            checkCacheVersion();
            checkCacheVersion();

        });

    </script>

    <style type="text/css">
        .changeStyles {
            display: inline;
            z-index: 10000;
        }

        .removeStyles {
            display:none !important;
            z-index: -100 !important;
        }
        /* Custom, iPhone Retina */
        @media only screen and (max-width : 320px) {
            .container-fluid {
                margin-left: -12px;
            }
        }

        /* Tab Navigation */
        .nav-tabs {
            margin: 0;
            padding: 0;
            border: 0;
        }
        .nav-tabs > li > a {
            background: #e6e6e6;
        }

        .nav-tabs > li.active > a,
        .nav-tabs > li.active > a:hover {
            background: #F5F5F5;
        }

        /* Tab Content */
       .tab-pane {
            border: 0.5px solid #e6e6e6;
            /*border-top: none !important;*/
            background: #F5F5F5;
            text-align: left;
            padding: 10px;
            width: 266px;
        }

        #LoginTable {
            z-index: 10;
        }

        .input-group[class*="col-"]  {
            padding-right: 15px;
        }

        #change_password_link, #change_password_link:hover, #change_password_link:visited {
            color: #337AB7;
            text-decoration: underline;
        }

    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <div id="interactive" class="viewport"></div>

    <div class="container-fluid">
        <div id="code" style="display: none;">
            <br />
            <input id="code_pass" style="width: 250px;" class="searchField" type="password" /><br />
            <input class="dayButton" onclick="Config();" type="button" value="submit" />
        </div>
        <!-- Nav tabs -->
        <ul id="Login_Type_Tabs" style="display: none;" class="nav nav-tabs" role="tablist">
            <li class="active">
                <a href="#foreman_login" role="tab" id="foreman_tab_label" data-toggle="tab"></a>
            </li>
            <li><a href="#emp_login" role="tab" id="employee_tab_label" data-toggle="tab"></a>
            </li>
        </ul>

        <!-- Tab panes -->
        <div style="margin-left: 25px;" id="offlineLogin">
            <div class="tab-content" id="LoginTable">
                <div class="tab-pane fade active in" id="foreman_login">
                    <div id="div_user" class="form-group">
                        <label class="control-label" for="UserName">User ID:</label>
                        <input type="text" name="UserName" class="form-control" id="UserName" placeholder="Enter User ID">
                        <span class="glyphicon glyphicon-remove form-control-feedback" id="UserNameRequired" title="User ID is Required" style="display:none"></span>
                        <span class="glyphicon glyphicon-ok form-control-feedback" id="UserNameGiven" title="Password is required." style="display:none"></span>
                    </div>

                    <div id="div_pass" class="form-group">
                        <label class="control-label" for="Password">Password:</label>
                        <input type="password" name="Password" class="form-control" id="Password" placeholder="Enter Password">
                        <span class="glyphicon glyphicon-remove form-control-feedback" id="PasswordRequired" title="Password is required." style="display:none"></span>


                        <span class="glyphicon glyphicon-ok form-control-feedback" id="PasswordGiven" title="Password is required." style="display:none"></span>
                    </div>

                    <span id="ErrorText" class="element-bold" style="display:none; color: #A94442;">Invalid Login</span>
                    <span id="OnlineLoginRequired" class="element-bold" style="display:none; color: #A94442;">Online Login Required</span>

                    <div class="checkbox">
                        <label>
                            <input id="RememberMe" type="checkbox"> Remember me next time
                        </label>
                    </div>

                    <button id="LoginButton" onclick="offLineAuth();" name="LoginButton" type="button" class="btn btn-default">Submit</button><br /><br />
                     <a id="change_password_link" onclick="forgotPasswordClicked();" href="#" data-toggle="modal" data-target="#change_password_Container">Forgot Your Password?</a>
                    <!--<a id="change_password_link" onclick="$('#change_password_Container').removeClass('removeStyles'); $('#change_password_Container').addClass('changeStyles');" href="#" data-toggle="modal" data-target="#change_password_Container">Forgot Your Password?</a>-->

                </div>

                <div class="tab-pane fade" id="emp_login">

                    <div class="form-group">
                        <label for="companySelector">Company:</label>
                        <select id="companySelector" class="form-control">

                        </select>
                    </div>

                    <div id="div_empNo" class="form-group">
                        <label for="Employee">Employee ID:</label>
                        <input type="text" class="form-control" id="Employee" placeholder="Enter Employee ID">

                        <span class="glyphicon glyphicon-remove form-control-feedback" id="EmployeeRequired" title="" style="display:none"></span>
                        <span class="glyphicon glyphicon-ok form-control-feedback" id="EmployeeGiven" title="" style="display:none"></span>
                    </div>

                    <div id="div_empPass" class="form-group">
                        <label for="pinNumber">PIN:</label>
                        <input type="password" class="form-control" id="pinNumber" placeholder="Enter PIN">

                        <span class="glyphicon glyphicon-remove form-control-feedback" id="EmpPasswordRequired" title="" style="display:none"></span>
                        <span class="glyphicon glyphicon-ok form-control-feedback" id="EmpPasswordGiven" title="" style="display:none"></span>
                    </div>

                    <span id="EmpErrorText" class="element-bold" style="display:none; color: #A94442;">Invalid Login</span>

                    <div class="checkbox">
                       <label>
                            <input id="EmpRememberMe" type="checkbox" /> Remember me next time
                        </label>
                    </div>
                    <button onclick="EmpAuth('Emp Submit.OnClick()(Login.aspx)');" type="button" class="btn btn-default">Submit</button>
                </div>
            </div>
        </div>

        <!-- Modals -->
        <!-- NOTE: Do NOT remove "display:none". EVER. It will break the modals completely
             It is being set to "display:inline" in the onclick method in the <a> tag above -->
        <div id="change_password_Container"  class="modal fade removeStyles" tabindex="-1" role="dialog" aria-labelledby="change_password_Container" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="change_password_modal_header">mJobTime Password Recovery</h4>
                    </div>
                    <div class="modal-body" id="change_password_modal_body">
                        <p>To change your password, enter your User ID in the field below and press the Send Code button. The code will be emailed to the email address provided in the mJobTime Employee Maintenance Screen. Submit this form with the code provided.</p>
                        <br />

                        <div id="SendCode_Panel" class="col-xs-24">
                            <p class="input-group">
                                <input type="text" id="UserID_Code" class="form-control" placeholder="Enter User ID">
                                <span class="input-group-btn">
                                    <button class="btn btn-primary" onclick="loading();send_Change_Password_Code_Server(); return false;" type="button">Send Code</button>
                                </span>
                            </p>
                            <br />
                            <p class="form-group">
                                <label for="Code">Enter Code</label>
                                <input type="text" id="Code" class="form-control">
                            </p>
                        </div>
                    </div>
                    <br /><br /><br /><br /><br /><br />
                    <div class="modal-footer">
                        <button type="button" onclick="window.location.href = 'Login.aspx'; return false;" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <a id="container_submit" type="button" onclick="submit_enter_code_form(); return false;" class="btn btn-primary">Submit</a>
                    </div>
                </div>
            </div>
        </div>

        <div id="changePassword_Panel" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">

                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="change_password_modal_header_">mJobTime Password Recovery</h4>
                    </div>
                    <div class="modal-body">
                        <p class="form-group">
                            <label id="currentUser">User ID: </label>
                            <%--<br/>
                            The password should contain alphabets, numbers or underscore. No special characters allowed.--%>
                        </p>

                        <p class="form-group">
                            <label for="password">New Password: </label>
                            <input type="password" id="password" class="form-control">
                        </p>

                        <p class="form-group">
                            <label for="confirmPassword">Confirm Password: </label>
                            <input type="password" id="confirmPassword" class="form-control">
                        </p>
                    </div>

                    <div class="modal-footer">
                        <button type="button" onclick="window.location.href = 'Login.aspx'; return false;" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <button type="button" onclick="submitNewPassword();return false;" class="btn btn-primary">Submit</button>
                    </div>

                </div>
            </div>
        </div>

    </div>

    <br /> <!-- Our Admin Functionality -->
    <div id="Config_Table" style="display: none; width: 100%; height: 450px;">


        <ul id="Admin_Tabs" class="nav nav-tabs" role="tablist">
            <li class="active">
                <a href="#SQL_Div" role="tab" data-toggle="tab">SQL</a>
            </li>
            <li><a href="#Config_Div" role="tab" data-toggle="tab">App Config</a>
            </li>
            <li><a href="#Grid_Config_Div" role="tab" data-toggle="tab">Grid Config</a>
            </li>
            <li><a href="#Web_Config_Div" role="tab" data-toggle="tab">Web Config</a>
            </li>
            <li><a href="#Manifest_Div" role="tab" data-toggle="tab">Manifest</a>
            </li>
            <li><a href="#Service_Worker_Div" role="tab" data-toggle="tab">Service Worker</a>
            </li>
            <li class="hidden"><a href="#ODBC_Div" role="tab" data-toggle="tab">ODBC</a>
            </li>
            <li><a href="#Logs_Div" role="tab" data-toggle="tab">Logs</a>
            </li>
            <li class="hidden"><a href="#GPS_Div" role="tab" data-toggle="tab">GPS</a>
            </li>
            <li><a href="#Sync_Div" role="tab" data-toggle="tab">Sync</a>
            </li>
            <li><a href="#Files_Div" role="tab" data-toggle="tab">Files</a>
            </li>
            <li><a id="AfterImportTab" href="#AfterImport_Div" role="tab" data-toggle="tab">AfterImport</a>
            </li>
        </ul>
        <div id="AdminContainer">
            <div class="tab-content" id="Admin_Tab_Content">
                <div class="tab-pane fade active in" style="width: 100% !important;" id="SQL_Div">
                    <br /><br />
                    <button type="button" onclick="$('#sql_tab_file_container').addClass('hidden');$('#sql_tab_query_container').removeClass('hidden');" class="btn btn-outline-primary">Query</button>
                    <button type="button" onclick="$('#sql_tab_file_container').removeClass('hidden');$('#sql_tab_query_container').addClass('hidden');" class="btn btn-outline-secondary">File</button>
                    <br /><br />
                    <div id="sql_tab_query_container">
                        <asp:HiddenField ID="PostbackCode" Value="0" runat="server" ClientIDMode="Static" />
                        <asp:TextBox runat="server" TextMode="MultiLine" ClientIDMode="Static" ID="sql_text"
                            Rows="5" Width="60%"></asp:TextBox>
                        <br />
                        <br />
                        <asp:Label ID="Label2" runat="server">Saved Queries: </asp:Label>
                        <asp:DropDownList runat="server" ClientIDMode="Static" ID="SavedQuery" onchange="saved_query_changed();">
                            <asp:ListItem Value="" Text=""></asp:ListItem>
                            <asp:ListItem Value="Backup" Text="Backup"></asp:ListItem>
                            <asp:ListItem Value="SELECT * FROM EMP_ONCLOCK WHERE ONCLOCK = 1" Text="On Clock Employees"></asp:ListItem>
                            <asp:ListItem Value="Timecards" Text="Timecards"></asp:ListItem>
                            <asp:ListItem Value="SELECT * FROM WEB_SETTINGS WHERE USERID = '' AND COMPANY = " Text="Web Settings"></asp:ListItem>
                            <asp:ListItem Value="SELECT * FROM ALERTS WHERE RELEASED = 0 AND ALERTTYPE  = 'WEB_SYNC'" Text="Unreleased Sync Alerts"></asp:ListItem>
                            <asp:ListItem Value="SELECT pda_id,COUNT(*) AS JobCount FROM JOBSYNC group by pda_id order by jobcount  desc" Text="Foreman Job Count"></asp:ListItem>
                            <asp:ListItem Value="SELECT pda_id,COUNT(*) AS CodeCount FROM CODESYNC group by pda_id order by CodeCount  desc" Text="Foreman CostCode Count"></asp:ListItem>
                            <asp:ListItem Value="RecentErrors" Text="Recent Errors"></asp:ListItem>
                            <asp:ListItem Value="select t.timecardid, t.udf3 as start_Address, t.udf4 as end_Address, g.start_loc, g.end_loc, g.REC_SAVED from timecard t inner join gps g on t.timecardid = g.timecardid where ((start_loc not in('','0') and udf3 = '') or (end_loc not in('','0') and udf4 = '')) and t.WORKDATE BETWEEN 20180101 AND today()" Text="GPS But No Address"></asp:ListItem>
                            <asp:ListItem Value="ConfigOut" Text="ConfigOut (With escaped FieldMap)"></asp:ListItem>
                            <asp:ListItem Value="[Initialize Employee Portal Reports]" Text="Initialize Employee Portal Reports"></asp:ListItem>

                            <asp:ListItem Value="" Text="----DATABASE STRUCTURE----" disabled></asp:ListItem>
                            <asp:ListItem Value="SELECT NAME FROM SYSOBJECTS WHERE TYPE = 'P' ORDER BY name" Text="Stored Procedures"></asp:ListItem>
                            <asp:ListItem Value="SP_Descript" Text="Stored Procedures Description"></asp:ListItem>
                            <asp:ListItem Value="SELECT NAME FROM SYSOBJECTS WHERE TYPE = 'U' ORDER BY name" Text="Tables"></asp:ListItem>
                            <asp:ListItem Value="Table_Descript" Text="Table Description"></asp:ListItem>
                            <asp:ListItem Value="SELECT NAME FROM SYSOBJECTS WHERE TYPE = 'TR' ORDER BY name" Text="Triggers"></asp:ListItem>
                            <asp:ListItem Value="Trigger_Descript" Text="Trigger Description"></asp:ListItem>
                            <asp:ListItem Value="ALTER TABLE [TABLE_NAME] DELETE PRIMARY KEY" Text="Remove Primary Key"></asp:ListItem>

                            <asp:ListItem Value="" Text="----DUPLICATES----" disabled></asp:ListItem>
                            <asp:ListItem Value="select costcode, costelement, jobno,company, inactive, count(*) from costcoderef  group by costcode, costelement, jobno, company, inactive having count(*) >1 order by jobno, costcode"
                                Text="Duplicate Cost Code Ref"></asp:ListItem>
                            <asp:ListItem Value="select costcode, count(*) from costcode where inactive = 0 group by costcode having count(*) > 1 order by costcode"
                                Text="Duplicate Cost Code"></asp:ListItem>
                            <asp:ListItem Value="select jobno, foreman, pda_id, company, inactive, count(*) from jobsync group by jobno, foreman, pda_id, company, inactive having count(*) >1  order by jobno, foreman, pda_id"
                                Text="Duplicate Job Sync"></asp:ListItem>
                            <asp:ListItem Value="select phaseno,jobno,company, inactive, count(*) from phaseref where inactive = 0  group by phaseno, jobno, company, inactive having count(*) >1 order by jobno, phaseno"
                                Text="Duplicate Phase Ref"></asp:ListItem>
                            <asp:ListItem Value="select costcode, phase, jobno, company, inactive, budget_type, count(*) from budget group by costcode, phase, jobno, company, inactive, budget_type having count(*) >1 order by jobno, costcode"
                                Text="Duplicate Budget"></asp:ListItem>
                            <asp:ListItem Value="select company, descript, eventtype, count(*) as count from dl_detail group by company, descript, eventtype having count > 1 order by company, eventtype, descript"
                                Text="Duplicate DL_Detail"></asp:ListItem>
                            <asp:ListItem Value="select company, eventtype, count(*) as count from dl_event group by company, eventtype having count > 1 order by company, eventtype"
                                Text="Duplicate DL_Event"></asp:ListItem>
                        </asp:DropDownList>
                     
                        <br /><br />
                    
                        <asp:Label ID="exportLabel" ClientIDMode="Static" runat="server">Export: </asp:Label>
                        <select id="ExportType">
                            <option value="CSV" selected="selected">CSV</option>
                        </select>
                        <input type="button" onclick="exportSqlQuery();" value="Go!" />

                        <span id="enteredBySpan" class="sql_timecard_fields" style="display: none;">&nbsp;Entered
                            By: </span>
                        <input onchange="saved_query_changed('enteredbyText.onchange (AdminScreen.aspx)');"
                            id="enteredbyText" class="sql_timecard_fields" style="display: none;" type="text" />
                        <span id="DateRangeSpan" class="sql_timecard_fields" style="display: none;">&nbsp;Date
                            Range: </span>
                        <input onchange="saved_query_changed('tc_startDate.onchange (AdminScreen.aspx)');"
                            type="date" id="tc_startDate" class="sql_timecard_fields" style="display: none;" />
                        <span class="sql_timecard_fields" style="display: none;">&nbsp;To&nbsp;</span>
                        <input onchange="saved_query_changed('tc_endDate.onchange (AdminScreen.aspx)');"
                            type="date" id="tc_endDate" class="sql_timecard_fields" style="display: none;" />
                        <br />
                        <br />
                        <asp:Button runat="server" ClientIDMode="Static" ID="runQueryButton" OnClientClick="if(getSessionStorage('config_auth') != 'true'){return false;}else{$('#ContentPlaceHolder1_settings_txt').val('');$('#ContentPlaceHolder1_config_txt').val('');}" OnClick="RunQuery"
                            Text="Run Query" />

                    </div>
                    <div id="sql_tab_file_container" class="hidden">
                        <input id="sql_file_input" type="file" class="file" />
                    </div>
                    
                        
                </div>
               <div class="tab-pane fade" style="width: 100% !important;" id="AfterImport_Div">
                   <input type="button"  id="AfterImportButton" value="Save"  onclick="if (getSessionStorage('config_auth') == 'true') { update_after_import(); } return false;" />
                    <textarea id="AfterImportTextBox" class="dropDown" style="width:80%;display: block; height: 500px;" cols="20" rows="2" ></textarea>
               </div>
                <div class="tab-pane fade" style="width: 100% !important;" id="Config_Div">
                    <div class="form-group">
                        <label for="companySelector">Application Settings:</label>
                        <select onchange="change_app_config_setting('Config_DDL.change()(Login.aspx)');" id="Config_DDL" class="form-control" style="width: 50% !important;">
                            <option value="all">All</option>
                        </select>
                        <input type="button"  id="updateJsonConfig_Button" onclick="update_json_config('updateJsonConfig_Button.click()(Login.aspx)');" value="Update" />
                        <br />
                       <textarea id="Config_Text_Area" class="dropDown" style="width:80%;display: block; height: 500px;" cols="20" rows="2" ></textarea>
                    </div>
                </div>

                <div class="tab-pane fade" style="width: 100% !important;" id="Grid_Config_Div">
                    <div class="form-group">
                        <label for="companySelector">Grid Settings:</label>
                        <select onchange="change_grid_config_setting('Config_DDL.change()(Login.aspx)');" id="Grid_Config_DDL" class="form-control" style="width: 50% !important;">
                            <option value="all">All</option>
                        </select>
                        <input type="button"  id="updateGridConfig_Button" onclick="update_grid_config('updateGridConfig_Button.click()(Login.aspx)');" value="Update" />
                        <br />
                       <textarea id="Grid_Text_Area" class="dropDown" style="width:80%;display: block; height: 500px;" cols="20" rows="2" ></textarea>
                    </div>
                </div>

                <div class="tab-pane fade" style="width: 100% !important;" id="Web_Config_Div">
                    <asp:TextBox Style="display: block;" ID="config_txt" runat="server" CssClass="dropDown" Width="80%" Height="800px" TextMode="MultiLine"></asp:TextBox>
                    <asp:Button runat="server" ID="config_txt_button" ClientIDMode="Static" Text="Save" OnClick="config_txt_button_Clicked" OnClientClick="if(getSessionStorage('config_auth') == 'true'){update_web_config();} return false;" />
                </div>

                <div class="tab-pane fade" style="width: 100% !important;" id="Manifest_Div">
                    <asp:TextBox Style="display: block;" ID="manifest_txt" runat="server" CssClass="dropDown" Width="80%" Height="800px" TextMode="MultiLine"></asp:TextBox>
                    <asp:Button runat="server" ID="manifest_button" ClientIDMode="Static" Text="Save" OnClientClick="update_manifest();return false;"  OnClick="manifest_button_Clicked" />
                </div>
                <div class="tab-pane fade" style="width: 100% !important;" id="Service_Worker_Div">
                    <asp:TextBox Style="display: block;" ID="serviceWorkerTextbox" runat="server" CssClass="dropDown" Width="80%" Height="800px" TextMode="MultiLine"></asp:TextBox>
                    <asp:Button runat="server" ID="service_worker_button" ClientIDMode="Static" Text="Save" OnClientClick="update_service_worker();return false;"  OnClick="manifest_button_Clicked" />
                </div>

                
                <div class="tab-pane fade" style="width: 100% !important;" id="ODBC_Div">ODBC_Div
                </div>

                <div class="tab-pane fade" style="width: 100% !important;" id="Logs_Div">
                    <h4>
                        Error Log:</h4>
                    <input type="text" id="log_append_text" />
                    <input type="button" value="Append Log" id="log_append_button" onclick="append_log_text($('#log_append_text').val());" />
                    <br />
                    <br />
                    <asp:Button ID="GoToErrorLog_Button" runat="server" Text="View Error Log" OnClientClick="if($('#errorArchive').val() == 'Archive'){window.open('log/mjt_log.txt');}else{window.open($('#errorArchive').val());} return false;" />
                    <asp:Button runat="server" OnClientClick=" $('#ContentPlaceHolder1_config_txt').val('');return true;" ClientIDMode="Static" ID="ArchiveErrorLog" Text="Archive Error Log"
                        OnClick="archiveErrorLog" />
                    <br />
                    <br />
                    <asp:DropDownList runat="server" ID="errorArchive" ClientIDMode="Static" OnSelectedIndexChanged="goToErrorArchive">
                        <asp:ListItem Text="Archive" Value="Archive" Selected="True"></asp:ListItem>
                    </asp:DropDownList>
                    <br />
                    <br />
                    <h4>
                        Sync Log:</h4>
                    <input type="text" id="synclog_append_text" />
                    <input type="button" value="Append Sync Log" id="synclog_append_button" onclick="append_synclog_text($('#synclog_append_text').val());" />
                    <br />
                    <br />
                    <asp:Button ID="GoToSyncLog_Button" runat="server" Text="View Sync Log" OnClientClick="if($('#syncArchive').val() == 'Archive'){window.open('log/mjt_sync_log.txt');}else{window.open($('#syncArchive').val());} return false;" />
                    <asp:Button runat="server" ClientIDMode="Static" ID="ArchiveSyncLog" Text="Archive Sync Log" OnClientClick=" $('#ContentPlaceHolder1_config_txt').val('');return true;" OnClick="archiveSyncLog" />
                    <br />
                    <br />
                    <asp:DropDownList runat="server" ID="syncArchive" ClientIDMode="Static" OnSelectedIndexChanged="goToSyncArchive">
                        <asp:ListItem Text="Archive" Value="Archive" Selected="True"></asp:ListItem>
                    </asp:DropDownList>
                    <br />
                    <br />
                    <h4>
                        Transaction Log:</h4>
                    <input type="text" id="translog_append_text" />
                    <input type="button" value="Append Transaction Log" id="Button1" onclick="append_translog_text($('#translog_append_text').val());" />
                    <br />
                    <br />
                    <asp:Button ID="GoToTransLog_Button" runat="server" Text="View Transaction Log" OnClientClick="if($('#TransArchive_DDL').val() == 'Archive'){window.open('log/mjt_trans_log.html');}else{window.open($('#TransArchive_DDL').val());} return false;" />
                    <asp:Button OnClientClick=" $('#ContentPlaceHolder1_config_txt').val('');return true;" runat="server" ClientIDMode="Static" ID="ArchiveTransLog" Text="Archive Transaction Log"
                        OnClick="archiveTransLog" />
                    <br />
                    <br />
                    <asp:DropDownList runat="server" ID="TransArchive_DDL" ClientIDMode="Static" OnSelectedIndexChanged="goToTransArchive">
                        <asp:ListItem Text="Archive" Value="Archive" Selected="True"></asp:ListItem>
                    </asp:DropDownList>
                    <br />
                    <br />
                   <h4> Desktop Log:</h4>
                    <asp:Button ID="Button2" runat="server" Text="View Transaction Log" OnClientClick="window.open('mJT15Error.log'); return false;" />
                </div>

                <div class="tab-pane fade" style="width: 100% !important;" id="Sync_Div">
                    <asp:TextBox Style="display: block;" ID="Sync_Text" runat="server" CssClass="dropDown" Width="80%" Height="200px" TextMode="MultiLine"></asp:TextBox>
                    <input type="button"  ID="Sync_Button" value="process sync object"  onclick="if(getSessionStorage('config_auth') == 'true'){Sync_String('Sync_Button.Clicked()(Login.aspx)');}" />
                    <br /><br />
                    <input type="button"  ID="CLEAR SYNC OBJECT" value="Clear Sync Object"  onclick="if (getSessionStorage('config_auth') == 'true') { clearSyncObject(); }" />

                    <br /><hr />

                    <input type="button"  id="skip_sync_object_button" value="Skip Sync Object"  onclick="skip_sync_object();" />
                    <input type="text" placeholder="NS**********" id="skip_sync_object_input" />
                </div>

                <div class="tab-pane fade" style="width: 100% !important;" id="GPS_Div">
                    <span>Configuration for this function is in config.json. Explinations for these settings can be found in the settings reference.</span>
                    <br />
                    <input id="Update_GPS_Button" onclick="updateMissingAddresses('', ''); return false;" value="Update Missing Addresses" type="button" />
                </div>

                <div class="tab-pane fade" style="width: 100% !important;" id="Files_Div">
                    <asp:Label runat="server" ID="PathLabel" ClientIDMode="Static" Text="Path"></asp:Label><asp:TextBox runat="server" ID="PathTextBox" ClientIDMode="Static"></asp:TextBox>
                    <asp:FileUpload runat="server" ID="FileUpload1" />
                    <asp:Button runat="server" Text="Upload" OnClientClick="$('#ContentPlaceHolder1_config_txt').val('');" OnClick="Upload_Clicked" ID="UPLOAD_BUTTON" />


                </div>

            </div>
        </div>
    </div>
    <script type="text/javascript">
        $("#sql_file_input").fileinput({
            show_X: false,
            overwriteInitial: true,
            browseIcon: '<i class="glyphicon glyphicon-picture"></i>',
            uploadExtraData: { 'Context': 'QUERY', 'Type': 'UPLOAD' },
            'showUpload': true
        });
    </script>
</asp:Content>
