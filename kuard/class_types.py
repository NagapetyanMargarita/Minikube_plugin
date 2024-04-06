from typing import TypedDict


class Metrics(TypedDict):
    files_count: int
    CPU: float
    memory: str


class Container(TypedDict):
    id: str
    name: str
    inspect: dict | None
    metrics: Metrics | None


class Pod(TypedDict):
    name: str
    uid: int
    containers: list[Container]
