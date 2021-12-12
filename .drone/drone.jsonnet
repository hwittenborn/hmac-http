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
    trigger: {repo: ["hwittenborn/hmac-http"]},
    depends_on: ["run-tests"],
    steps: [{
        name: "publish-package",
        image: "python:3",
        environment: {proget_api_key: {from_secret: "proget_api_key"}},
        commands: [
            "pip install build twine",
            "python3 -m build",
            "twine upload --repository-url \"https://$${proget_server}/pypi/python/legacy\" dist/*"
        ]
    }]
};

[
    runTests(),
    publishPackage()
]
# vim: set syntax=javascript
