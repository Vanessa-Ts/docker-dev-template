from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    model_config = SettingsConfigDict(
        env_file=".env",
        env_file_encoding="utf-8",
        case_sensitive=False,
    )

    app_name: str = "docker-dev-template"
    version: str = "0.1.0"
    environment: str = "development"

    @property
    def log_level(self) -> str:
        return "DEBUG" if self.environment == "development" else "INFO"


settings = Settings()
