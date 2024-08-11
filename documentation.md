### Introduction
The purpose of this documentation is to provide comprehensive guidance on the configured CTFd platform, detailing its architecture, functionality, installation procedures, configuration options, and usage guidelines. Additionally, it provides developer guidelines and troubleshooting steps. It does not cover third-party integrations beyond the ones specified within the document.

### System Requirements
The project is operating system agnostic, relying on the Docker engine to meet compute, networking, and storage requirements. To streamline deployment and provide an effective user experience for participants, the project uses the cost-optimized E2 machine series, part of Google Cloud's general purpose machine family. It is recommended that the deployed instance meets the minimum hardware recommendations:
- 1 vCPU
- 2GB RAM
- 25GB Storage

### Installation
The installation process is largely automated, so that organizers may focus on challenge creation and user issues.

The following process assumes that the executing user has root or sudoer privileges:
1. git clone https://github.com/DeveshChande/ctf-framework.git
2. cd ctf-framework
3. sudo ./setup.sh

Setup the ctfd deployment following the on-screen instructions as per your requirements.

The following plugin settings are have been tested and are recommended for local deployments:
1. Containers:
    - Base URL: unix://var/run/docker.sock
    - Hostname for Docker Host: IP Address of the host machine that provides the docker environment
    - Container Expiration in Minutes: 30
    - Maximum per-container memory usage (in MB): 200
    - Maximum per-container CPUs: 1


