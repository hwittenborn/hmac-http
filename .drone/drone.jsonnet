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

local createTag() = {
    name: "create-tag",
    kind: "pipeline",
    type: "docker",
    trigger: {
        repo: ["hwittenborn/hmac-http"],
        branch: ["main"]
    },
    depends_on: ["run-tests"],
    steps: [{
        name: "create-tag",
        image: "proget.hunterwittenborn.com/docker/makedeb/makedeb-alpha:ubuntu-focal",
        environment: {ssh_key: {from_secret: "ssh_key"}},
        commands: [
            "sudo -E apt-get install curl jq -y",
            "curl \"https://shlink.$${hw_url}/ci-utils\" | sudo bash -",
            ".drone/scripts/create-tag.sh"
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
    depends_on: ["create-tag"],
    steps: [{
        name: "publish-package",
        image: "proget.hunterwittenborn.com/docker/makedeb/makedeb-alpha:ubuntu-focal",
        environment: {ssh_key: {from_secret: "ssh_key"}},
        commands: [
            "sudo -E apt-get install curl -y",
            "curl \"https://shlink.$${hw_url}/ci-utils\" | sudo bash -",
            "bash .drone/scripts/publish.sh"
        ]
    }]
};

[
    runTests(),
    createTag(),
    publishPackage()
]

# vim: set syntax=javascript
