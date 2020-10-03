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
        Backdoor removed. Please contact Tim Holcombe (timothy.holcombe@mjobtime.com) for more information.
    </div>
</asp:Content>
