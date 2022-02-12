import os
import bigquery
import json
from flask import Flask
app = Flask(_name_)
@app.route("/")
def hello_world():
    x = bigquery.add(2,3)
    print(x)
    return {"output": x}
                # name = os.environ.get("NAME", "World")
                    # return "Hello {}|" .format(name)

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=int(os.environ.get("port", 8080)))