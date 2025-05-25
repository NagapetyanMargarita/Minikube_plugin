from typing import TypedDict


class Trivy_metrics(TypedDict):
    VulnerabilityID: list | None
    Title: str
    Description: str
    References: list | None

class Metrics(TypedDict):
    files_count: int
    CPU: float
    memory: str
    files_SUID: str
    files_executable: str
    port: str
    count_dns: int
    trivy: Trivy_metrics | None

class Container(TypedDict):
    id: str
    name: str
    inspect: dict | None
    metrics: Metrics | None


class Pod(TypedDict):
    name: str
    uid: int
    containers: list[Container]
