<%@include file="Header.jsp"%>
<div class="min-h-screen bg-gray-100">
    <div class="container mx-auto p-8">
        <h1 class="text-3xl font-semibold mb-4">Closed Tasks</h1>
        <div class="mb-4 flex justify-end space-x-4">
            <span class="badge badge-pill taskp-high mr-2">High</span>
            <span class="badge badge-pill taskp-medium mr-2">Medium</span>
            <span class="badge badge-pill taskp-low mr-2">Low</span>
            <span class="text-gray-600">Priority Color Coding</span>
        </div>
        <ul class="nav nav-tabs nav-justified">
            <li class="nav-item">
                <a href="#toyou" data-toggle="tab" class="nav-link">Tasks Assigned To You</a>
            </li>
            <li class="nav-item">
                <a href="#byyou" data-toggle="tab" class="nav-link">Tasks Assigned By You</a>
            </li>
        </ul>
        <div class="tab-content">
            <div class="tab-pane active" id="toyou">
                <div class="mt-4">
                    <%
                        datalayer.DALTasks objDAL = new datalayer.DALTasks(session.getServletContext());
                        ArrayList<beans.Tasks> TasksAL = objDAL.getTasksOpenForYou(Integer.parseInt(session.getAttribute("LoggedEmpId").toString()));
                        for(beans.Tasks x : TasksAL){
                            if(x.getStatus()!='C')
                                continue;
                            String priority = "";
                            switch(x.getTaskPriority()){
                                case 'L':
                                    priority="bg-green-500";
                                    break;
                                case 'M':
                                    priority="bg-yellow-500";
                                    break;
                                case 'H':
                                    priority="bg-red-500";
                                    break;				
                            }
                    %>
                    <div class="bg-white p-4 mb-4 rounded-lg shadow">
                        <span class="<%=priority%> text-white px-2 py-1 rounded"><a id="<%=x.getTaskID()%>">Closed</a></span>
                        <h3 class="text-lg mt-2 cursor-pointer task-header"><span class="caret"></span> <%=x.getTaskName()%></h3>
                        <p class="task-desc"><span class=" glyphicon glyphicon-triangle-right"></span> <%=x.getTaskDescription()%></p>
                        <div class="flex justify-between mt-2">
                            <span class="text-gray-600">Task Assigned on: <%=x.getDate()%></span>
                            <span class="text-gray-600">Task Completion by: <%=x.getLastDate()%></span>
                        </div>
                    </div>
                    <%}%>
                </div>
            </div>
            <div class="tab-pane" id="byyou">
                <div class="mt-4">
                    <%
                        objDAL = new datalayer.DALTasks(session.getServletContext());
                        TasksAL = objDAL.getTasksAssignedByYou(Integer.parseInt(session.getAttribute("LoggedEmpId").toString()));
                        for(beans.Tasks x : TasksAL){
                            if(x.getStatus()!='C')
                                continue;
                            String priority = "";
                            switch(x.getTaskPriority()){
                                case 'L':
                                    priority="bg-green-500";
                                    break;
                                case 'M':
                                    priority="bg-yellow-500";
                                    break;
                                case 'H':
                                    priority="bg-red-500";
                                    break;				
                            }
                            beans.Employees e   = x.EmployeeList.get(0);
                            datalayer.DALJobs objDALJ = new datalayer.DALJobs(session.getServletContext());
                            e.setJobName(objDALJ.getJobByJobID(e.getJobID()));
                    %>
                    <div class="bg-white p-4 mb-4 rounded-lg shadow">
                        <span class="<%=priority%> text-white px-2 py-1 rounded"><a id="<%=x.getTaskID()%>">Closed</a></span>
                        <p class="emp-deet"><%=e.getEmpName()%> (<%=e.getJobName()%>)</p>
                        <h3 class="text-lg cursor-pointer task-header"><span class="caret"></span> <%=x.getTaskName()%></h3>
                        <p class="task-desc"><span class=" glyphicon glyphicon-triangle-right"></span> <%=x.getTaskDescription()%></p>
                        <div class="flex justify-between mt-2">
                            <span class="text-gray-600">Task Assigned on: <%=x.getDate()%></span>
                            <span class="text-gray-600">Task Completion by: <%=x.getLastDate()%></span>
                        </div>
                    </div>
                    <%}%>
                </div>
            </div> 
        </div>
    </div>
</div>
<script src="../LatestJQuery.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
        $(".task-header").click(function(){
            $(this).next().slideToggle();
        });
    });
</script>
<%@include file="Footer.html"%>
