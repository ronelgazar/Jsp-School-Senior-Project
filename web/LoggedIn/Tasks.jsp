<%@ page import="java.util.ArrayList" %>
<%@include file="Header.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Open Tasks</title>
    <!-- Include Bootstrap 5 CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/custom-logged.css">
    <!-- Add any other stylesheets you need -->
    <style>
        /* Custom styles */
        body {
            background-color: #f8f9fa;
        }

        .container {
            padding: 2rem;
        }

        .task-list {
            list-style: none;
            padding: 0;
        }

        .task-item {
            background-color: #fff;
            border: 1px solid #e1e5eb;
            border-radius: 8px;
            margin-bottom: 1rem;
            padding: 1rem;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .task-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            cursor: pointer;
        }

        .task-title {
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .task-desc {
            color: #6c757d;
        }

        .task-priority {
            font-size: 0.875rem;
            font-weight: 600;
            padding: 0.25rem 0.5rem;
            border-radius: 0.25rem;
            margin-right: 0.5rem;
        }

        .taskp-high {
            background-color: #dc3545;
            color: #fff;
        }

        .taskp-medium {
            background-color: #ffc107;
            color: #000;
        }

        .taskp-low {
            background-color: #0d6efd;
            color: #fff;
        }

        .task-actions {
            display: flex;
            gap: 1rem;
        }

        .task-action {
            font-size: 0.875rem;
            text-decoration: underline;
            cursor: pointer;
            text-color: #0d6efd;
        }

        .task-action:hover {
            color: #0d6efd;
        }
    </style>
</head>
<body>
    <div class="container">
        <%int JobID = Integer.parseInt(session.getAttribute("LoggedJobID").toString()); %>
        <h1 class="text-3xl font-semibold mb-4">Open Tasks</h1>
        <div class="flex mb-4">
            <span class="ml-auto self-center mr-2">Priority Color Coding:</span>
            <span class="badge badge-pill taskp-high mr-2">High</span>
            <span class="badge badge-pill taskp-medium mr-2">Medium</span>
            <span class="badge badge-pill taskp-low mr-2">Low</span>
        </div>
        <ul class="nav nav-tabs nav-justified">
            <li class="nav-item"><a href="#toyou" data-bs-toggle="tab" class="nav-link tab-header active">Tasks Assigned To You</a></li>
            <li class="nav-item"><a href="#byyou" data-bs-toggle="tab" class="nav-link tab-header">Tasks Assigned By You</a></li>
        </ul>
        <div class="tab-content mt-4">
            <div class="tab-pane fade show active" id="toyou">
                <ul class="task-list">
                    <%
                        datalayer.DALTasks objDAL = new datalayer.DALTasks(session.getServletContext());
                        ArrayList<beans.Tasks> TasksAL = objDAL.getTasksOpenForYou(Integer.parseInt(session.getAttribute("LoggedEmpId").toString()));
                        for(beans.Tasks x : TasksAL){
                            if(x.getStatus()!='O' && x.getStatus()!='W') continue;
                            String status="";
                            String priority="";
                            switch(x.getTaskPriority()){
                                case 'L': priority="taskp-low"; break;
                                case 'M': priority="taskp-medium"; break;
                                case 'H': priority="taskp-high"; break;
                            }
                            switch(x.getStatus()){
                                case 'O': status="Open"; break;
                                case 'W': status="Work In Progress"; break;
                                case 'C': status="Closed"; break;
                            }
                            if(status=="Closed") continue;
                    %>
                    <li class="task-item <%=priority%>" id="<%=x.getTaskID()%>Task">
                        <div class="task-header">
                            <div>
                                <span class="task-title"><%=x.getTaskName()%></span>
                                <span class="task-priority <%=priority%>"><%=status%></span>
                            </div>
                            <div class="task-actions">
                                <a href="Reassign.jsp?reassign=<%=x.getTaskID()%>" class="badge badge-pill badge-bar-left task-action">Reassign</a>
                                <a id="<%=x.getTaskID()%>" onclick="changeStatus(<%=x.getTaskID()%>)" class=" badge badge-pill badge-bar-left task-action">Change Status</a>
                            </div>
                        </div>
                        <p class="task-desc"><%=x.getTaskDescription()%></p>
                        <div class="task-details">
                            <span class="date-given">Task Assigned on: <%=x.getDate()%></span>
                            <span class="last-date">Task Completion by: <%=x.getLastDate()%></span>
                        </div>
                    </li>
                    <% } %>
                </ul>
            </div>
            <div class="tab-pane fade" id="byyou">
                <ul class="task-list">
                    <%
                        TasksAL = objDAL.getTasksAssignedByYou(Integer.parseInt(session.getAttribute("LoggedEmpId").toString()));
                        for(beans.Tasks x : TasksAL){
                            if(x.getStatus()!='O' && x.getStatus()!='W') continue;
                            String status="";
                            String priority="";
                            switch(x.getTaskPriority()){
                                case 'L': priority="taskp-low"; break;
                                case 'M': priority="taskp-medium"; break;
                                case 'H': priority="taskp-high"; break;
                            }
                            switch(x.getStatus()){
                                case 'O': status="Open"; break;
                                case 'W': status="Work In Progress"; break;
                                case 'C': status="Closed"; break;
                            }
                            if(status=="Closed") continue;
                            beans.Employees e = x.EmployeeList.get(0);
                            datalayer.DALJobs objDALJ = new datalayer.DALJobs(session.getServletContext());
                            e.setJobName(objDALJ.getJobByJobID(e.getJobID()));
                    %>
                    <li class="task-item <%=priority%>" id="<%=x.getTaskID()%>Task">
                        <div class="task-header">
                            <div>
                                <span class="task-title"><%=x.getTaskName()%></span>
                                <span class="task-priority <%=priority%>"><%=status%></span>
                            </div>
                            <div class="task-actions">
                                <span class="emp-deet"><%=e.getEmpName()%> (<%=e.getJobName()%>)</span>
                                <a id="<%=x.getTaskID()%>" onclick="changeStatus(<%=x.getTaskID()%>)" class=" badge badge-pill badge-bar-left task-action">Change Status</a>
                            </div>
                        </div>
                        <p class="task-desc"><%=x.getTaskDescription()%></p>
                        <div class="task-details">
                            <span class="date-given">Task Assigned on: <%=x.getDate()%></span>
                            <span class="last-date">Task Completion by: <%=x.getLastDate()%></span>
                        </div>
                    </li>
                    <% } %>
                </ul>
            </div>
        </div>
    </div>
    <!-- Include Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        var xhttp;
        function changeStatus(id) {
            var task = document.getElementById((id + "Task"));
            xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function() {
                if (this.readyState == 4 && this.status == 200) {
                    document.getElementById(id).innerHTML = xhttp.responseText;
                    var s = xhttp.responseText;
                    s = s.substr(0, s.length - 2);
                    if (s == "Closed") {
                        document.getElementById((id + 'Task')).style.display = 'none';
                    }
                }
            };
            xhttp.open("post", ("../EmpServlet?taskid=" + id), true);
            xhttp.send();
        }
    </script>
</body>
</html>
