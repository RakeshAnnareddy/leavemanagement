from flask import Flask, request,jsonify
from flask_restful import Api, Resource
from pymongo import MongoClient
from flask_bcrypt import Bcrypt

app = Flask(__name__)
api = Api(app)
bcrypt = Bcrypt(app)

# Replace the following values with your MongoDB connection details
mongo_url = "mongodb+srv://dbUser:root@planmyleave.rvztvkr.mongodb.net/?retryWrites=true&w=majority"
client = MongoClient(mongo_url)
database = client["PlanMyLeaves"]  # Replace with your actual database name
collection = database["leave_applications"]

class RegisterResource(Resource):
    def post(self):
        try:
            data = request.get_json()

            # Validate incoming data
            if 'username' not in data or 'password' not in data:
                return {'message': 'Incomplete data'}, 400

            # Hash the password
            hashed_password = bcrypt.generate_password_hash(data['password']).decode('utf-8')

            # Check if the username already exists
            if collection.find_one({'username': data['username']}):
                return {'message': 'Username already exists'}, 400

            # Insert the user into MongoDB
            collection.insert_one({
                'username': data['username'],
                'password': hashed_password
            })

            return {'message': 'User registered successfully'}, 201

        except Exception as e:
            print(f"Error: {e}")
            return {'message': 'Failed to register user'}, 500

class LoginResource(Resource):
    def post(self):
        try:
            data = request.get_json()

            # Validate incoming data
            if 'username' not in data or 'password' not in data:
                return {'message': 'Incomplete data'}, 400

            # Check if the user exists
            user = collection.find_one({'username': data['username']})

            if user and bcrypt.check_password_hash(user['password'], data['password']):
                return {'message': 'Login successful'}, 200
            else:
                return {'message': 'Invalid username or password'}, 401

        except Exception as e:
            print(f"Error: {e}")
            return {'message': 'Failed to log in'}, 500

class ApplyLeaveResource(Resource):
    def post(self):
        try:
            data = request.get_json()

            # Validate the incoming data
            if 'leaveType' not in data or 'leaveSubject' not in data or 'startDate' not in data or 'endDate' not in data or 'description' not in data:
                return {'message': 'Incomplete data'}, 400

            # Process the leave application
            leave_type = data['leaveType']
            leave_subject = data['leaveSubject']
            start_date = data['startDate']
            end_date = data['endDate']
            description = data['description']
            status='pending'

            # Save the leave application data to MongoDB
            result = collection.insert_one({
                'leaveType': leave_type,
                'leaveSubject': leave_subject,
                'startDate': start_date,
                'endDate': end_date,
                'description': description,
                'status':status
            })

            return {'message': 'Leave application submitted successfully', 'inserted_id': str(result.inserted_id)}, 200

        except Exception as e:
            print(f"Error: {e}")
            return {'message': 'Failed to submit leave application'}, 500
        
        
class GetApplicationDetails(Resource):
    def get(self):
        data= collection.find()
        data= list(data)
        return jsonify({'leave_applications':data})
        

api.add_resource(RegisterResource, '/api/register')
api.add_resource(LoginResource, '/api/login')
api.add_resource(ApplyLeaveResource, '/api/apply-leave')
api.add_resource(GetApplicationDetails,'/api/get-details')

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port='8000')
    
    
    
    
    
