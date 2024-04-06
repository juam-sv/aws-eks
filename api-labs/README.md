# Flask REST API Lab

[![Lint Pipeline](https://github.com/juam-sv/chatgpt-labs/actions/workflows/python-lint-test.yml/badge.svg)](https://github.com/juam-sv/chatgpt-labs/actions/workflows/python-lint-test.yml)

This is an example application showcasing a Flask REST API with authentication using JSON web tokens (JWT). The application provides several endpoints for user management, dashboard access, login, logoff, generating reports, and retrieving the current time.

## Endpoints

### User Endpoint

- **Endpoint**: `/user`
- **Method**: GET
- **Authentication**: Token-based authentication is required.
- **Description**: Retrieves user information.

### Dashboard Endpoint

- **Endpoint**: `/dashboard`
- **Method**: GET
- **Authentication**: Token-based authentication is required.
- **Description**: Retrieves dashboard data.

### Login Endpoint

- **Endpoint**: `/login`
- **Method**: POST
- **Authentication**: No authentication required.
- **Description**: Allows users to log in by providing their credentials (username and password). Upon successful authentication, a token is generated and returned.

### Logoff Endpoint

- **Endpoint**: `/logoff`
- **Method**: POST
- **Authentication**: Token-based authentication is required.
- **Description**: Logs out the user by invalidating the provided authentication token.

### Report Endpoint

- **Endpoint**: `/report`
- **Method**: GET
- **Authentication**: Token-based authentication is required.
- **Description**: Retrieves a report.

### Time Endpoint

- **Endpoint**: `/time`
- **Method**: GET
- **Authentication**: No authentication required.
- **Description**: Retrieves the current time.

## Running the Application

To run the Flask application, follow these steps:

1. Make sure you have Docker installed on your machine.

2. Build the Docker image by running the following command in the project directory:

   ```shell
   docker build -t flask-api-example:v1.0 .
   ```

3. Start a Docker container from the built image:

   ```shell
   docker run -p 5000:5000 -e SECRET_KEY=<your-secret-key> flask-api-example:v1.0
   ```

   Replace `<your-secret-key>` with your preferred secret key for JWT authentication.

4. The Flask application will be accessible at `http://localhost:5000`.

## Testing the Endpoints

You can use the following `curl` commands to test the endpoints:

1. Authenticate and store the token in an environment variable:

   ```shell
   export TOKEN=$(curl -X POST -H "Content-Type: application/json" -d '{"username":"john", "password":"password1"}' http://localhost:5000/login | jq -r '.token')
   ```

2. Make a request to the time endpoint using the stored token:

   ```shell
   curl -X GET -H "Authorization: Bearer $TOKEN" http://localhost:5000/time
   ```

Feel free to modify the request parameters and payload according to your needs.

Please ensure that you have the required dependencies installed, as mentioned in the `requirements.txt` file.

---

Thank you for checking out this Flask REST API example. If you have any questions or need further assistance, please let me know.