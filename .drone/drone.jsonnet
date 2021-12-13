local runTests() = {
    name: "run-tests",
    kind: "pipeline",
    type: "docker",
    steps: [{
        name: "run-tests",
        image: "python:3",
        commands: [
            "pip install black flake8",
            "black --check ./",
            "flake8 ./"
        ]
    }]
};

local publishPackage() = {
    name: "publish-package",
    kind: "pipeline",
    type: "docker",
    trigger: {
        repo: ["hwittenborn/hmac-http"],
        branch: ["main"]
    },
    depends_on: ["run-tests"],
    steps: [{
        name: "publish-package",
        image: "python:3",
        environment: {pypi_api_key: {from_secret: "pypi_api_key"}},
        commands: [
            "pip install build twine",
            "python3 -m build",
            "twine upload -u '__token__' -p \"$${pypi_api_key}\" dist/*"
        ]
    }]
};

[
    runTests(),
    publishPackage()
]

# vim: set syntax=javascript
