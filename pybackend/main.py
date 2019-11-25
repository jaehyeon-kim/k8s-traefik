import os
from fastapi import FastAPI
from pydantic import BaseModel

APP_PREFIX = os.environ["APP_PREFIX"]

app = FastAPI(title="{0} API".format(APP_PREFIX), docs_url=None, redoc_url=None)

## response models
class NameResp(BaseModel):
    title: str


class PathResp(NameResp):
    title: str
    path: str


## service methods
@app.get("/", response_model=NameResp)
async def whoami():
    return {"title": app.title}


@app.get("/{p}", response_model=PathResp)
async def whichpath(p: str):
    print(p)
    return {"title": app.title, "path": p}
