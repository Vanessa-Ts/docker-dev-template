from fastapi import FastAPI, Request
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates

from app.core.config import settings

app = FastAPI(title=settings.app_name, version=settings.version)

app.mount("/static", StaticFiles(directory="src/app/ui"), name="static")
templates = Jinja2Templates(directory="src/app/ui")

@app.get("/")
async def index(request: Request):
    return templates.TemplateResponse("index.html", {
        "request": request,
        "app_name": settings.app_name,
        "version": settings.version,
        "environment": settings.environment,
    })


if __name__ == "__main__":
    import uvicorn
    uvicorn.run("app.main:app", host="0.0.0.0", port=8000, reload=True)  # noqa: S104
