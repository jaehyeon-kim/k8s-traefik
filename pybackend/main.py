import os
import httpx
from fastapi import FastAPI
from pydantic import BaseModel, Schema
from typing import Optional

APP_PREFIX = os.environ["APP_PREFIX"]

app = FastAPI(title="{0} API".format(APP_PREFIX), docs_url=None, redoc_url=None)

## response models
class NameResp(BaseModel):
    title: str


class PathResp(BaseModel):
    title: str
    path: str


class AdmissionReq(BaseModel):
    gre: int = Schema(None, ge=0, le=800)
    gpa: float = Schema(None, ge=0.0, le=4.0)
    rank: str = Schema(None, ge="1", le="4")


class AdmissionResp(BaseModel):
    result: bool


## service methods
@app.get("/", response_model=NameResp)
async def whoami():
    return {"title": app.title}


@app.post("/admission")
async def admission(*, req: Optional[AdmissionReq]):
    host = os.getenv("RSERVE_HOST", "localhost")
    port = os.getenv("RSERVE_PORT", "8000")
    async with httpx.AsyncClient() as client:
        dat = req.json() if req else None
        r = await client.post("http://{0}:{1}/{2}".format(host, port, "admission"), data=dat)
        return r.json()


@app.get("/{p}", response_model=PathResp)
async def whichpath(p: str):
    print(p)
    return {"title": app.title, "path": p}
