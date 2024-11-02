import express from 'express';
import SuperTokens from 'supertokens-node';
import Dashboard from 'supertokens-node/recipe/dashboard';
import { middleware } from 'supertokens-node/framework/express';

const app = express();

SuperTokens.init({
  appInfo: {
    apiDomain: process.env.zeropsSubdomain || process.env.API_DOMAIN,
    appName: "MyApp",
    websiteDomain: process.env.zeropsSubdomain || process.env.WEBSITE_DOMAIN,
  },
  supertokens: {
    connectionURI: process.env.supertoken_zeropsSubdomain || process.env.SUPERTOKEN_INSTANCE,
  },
  recipeList: [
    Dashboard.init(),
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
