import express from 'express';
import SuperTokens from 'supertokens-node';
import Dashboard from 'supertokens-node/recipe/dashboard';
import Passwordless from 'supertokens-node/recipe/passwordless';
import Session from "supertokens-node/recipe/session";
import { SMTPService } from "supertokens-node/recipe/passwordless/emaildelivery";
import { middleware } from 'supertokens-node/framework/express';

const app = express();

SuperTokens.init({
  appInfo: {
    apiDomain: process.env.API_DOMAIN,
    appName: process.env.APP_NAME,
    websiteDomain: process.env.WEBSITE_DOMAIN,
  },
  supertokens: {
    connectionURI: process.env.SUPERTOKENS_CONNECTION_URI,
    apiKey: process.env.SUPERTOKENS_API_KEY
  },
  recipeList: [
    Dashboard.init(),
    Passwordless.init({
      contactMethod: 'EMAIL',
      flowType: 'MAGIC_LINK',
      emailDelivery: {
        service: new SMTPService({
          smtpSettings: {
            host: process.env.SMTP_HOST,
            port: process.env.SMTP_PORT,
            from: {
                name: process.env.SMTP_FROM_NAME,
                email: process.env.SMTP_FROM_EMAIL,
            },
            secure: true,
          },
        })
      }
    }),
    Session.init(),
  ],
});

app.use(middleware());

app.get('/health', (_, res) => {
  res.send('ok');
});

app.listen(3001, () => {
  console.log('Server running on http://localhost:3001');
  console.log('Dashboard available at http://localhost:3001/auth/dashboard');
});
