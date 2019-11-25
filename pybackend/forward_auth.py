import os
from typing import Dict, List
from fastapi import FastAPI, Depends, HTTPException
from pydantic import BaseModel
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from starlette.requests import Request
from starlette.status import HTTP_401_UNAUTHORIZED

app = FastAPI(title="Forward Auth API", docs_url=None, redoc_url=None)

## authentication
class JWTBearer(HTTPBearer):
    def __init__(self, auto_error: bool = True):
        super().__init__(scheme_name="Novice JWT Bearer", auto_error=auto_error)

    async def __call__(self, request: Request) -> None:
        credentials: HTTPAuthorizationCredentials = await super().__call__(request)

        if credentials.credentials != "foobar":
            raise HTTPException(HTTP_401_UNAUTHORIZED, detail="Invalid Token")


## response models
class StatusResp(BaseModel):
    status: str


## service methods
@app.get("/auth", response_model=StatusResp, dependencies=[Depends(JWTBearer())])
async def forward_auth():
    return {"status": "ok"}
