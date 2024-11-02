import SuperTokens from "supertokens-web-js";
import Session from "supertokens-web-js/recipe/session";

export function initSuperTokensUI() {
    (window as any).supertokensUIInit("supertokensui", {
        appInfo: {
            websiteDomain: "$$WEBSITE_DOMAIN$$",
            apiDomain: "$$API_DOMAIN$$",
            appName: "$$APP_NAME$$",
        },
        recipeList: [
            (window as any).supertokensUIPasswordless.init({
                contactMethod: "EMAIL",
            }),
            (window as any).supertokensUISession.init(),
        ],
    });
}

export function initSuperTokensWebJS() {
    SuperTokens.init({
        appInfo: {
            appName: "$$APP_NAME$$",
            apiDomain: "$$API_DOMAIN$$",
        },
        recipeList: [Session.init()],
    });
}
