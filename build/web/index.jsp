<%-- 
    Document   : index
    Created on : 24 de mai. de 2021, 19:35:09
    Author     : wagner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList" %>
<%@page import="web.DbListener" %>
<%@page import="db.TaskConnector" %>
<!DOCTYPE html>

<%
    Exception reqException = null;
    ArrayList<String> taskList = new ArrayList<>();
    try {
        if (request.getParameter("add") != null) {
            String taskName = request.getParameter("taskName");
            TaskConnector.addTasks(taskName);
            response.sendRedirect(request.getRequestURI());
        }
        if (request.getParameter("remove") != null) {
            String taskName = request.getParameter("taskName");
            TaskConnector.removeTasks(taskName);
            response.sendRedirect(request.getRequestURI());
        }
        taskList = TaskConnector.getTasks();
    } catch (Exception e) {
        reqException = e;
    }
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tarefas - JDBC</title>
        <link rel="stylesheet" href="WEB-INF/css/style.css"/>
    </head>
    <body>
        <header>
            <h2>Wagner de Almeida</h2>
            <h2>RA: 1290481813036</h2>
            <hr/>
            <h2>JDBC</h2>
            <h3>Tarefas</h3>
            <%if (DbListener.exception != null) {%>
            <div style="color: red">
                Erro na criação da base: <%= DbListener.exception.getMessage()%>
            </div>
            <%}%>
            <%if (reqException != null) {%>
            <div style="color: red">
                Erro na processamento da página: <%= reqException.getMessage()%>
            </div>
            <%}%>
        </header>
        <main>
            <form>
                <input type="text" name="taskName"/>
                <input type="submit" name="add" value="Adicionar tarefa"/>
            </form>
            <hr/>
            <table border="1">
                <thead>
                    <tr>
                        <th>Nome da tarefa</th>
                        <th>Exclusão</th>
                    </tr>
                </thead>
                <tbody>
                    <%for (String taskName : taskList) {%>
                    <tr>
                        <td><%=taskName%></td>
                        <td>
                            <form>
                                <input type="hidden" name="taskName" value="<%=taskName%>"/>
                                <input type="submit" name="remove" value="Remover"/>
                            </form>
                        </td>
                    </tr>
                    <%}%>
                <td></td>
                <td></td>
                </tr>
                </tbody>
            </table>
        </main>
    </body>
</html>
