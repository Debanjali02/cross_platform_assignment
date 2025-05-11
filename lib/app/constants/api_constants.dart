class ApiConstants {
  // Base URL for the Parse Server
  static const parseUrl = "https://parseapi.back4app.com/classes/";

  // Your Parse App ID and API Key
  static const parseAppID = "vaQVDI4NC94mwogu6ERDoxEJoRJKQFKTd3MWh06p";  // Replace with your Back4App App ID
  static const parseApiKey = "vEk3wDOOkbFthoFvwGfObJmMtHaPO2DM7IYXCX9s";  // Replace with your Back4App REST API Key

  // The class names that represent your data models in Back4App
  static const task = "Task"; // The class name for tasks
  static const tasks = "Tasks"; // If you are using multiple tasks, this is the collection name
  
  // API Endpoints for tasks
  static const taskEndpoint = "${parseUrl}Task"; // Endpoint to fetch tasks (replace "Task" with your class name)
}
