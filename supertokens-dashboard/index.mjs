import express from 'express';
import SuperTokens from 'supertokens-node';
import Dashboard from 'supertokens-node/recipe/dashboard';
import { middleware } from 'supertokens-node/framework/express';

const app = express();

SuperTokens.init({
  appInfo: {
    apiDomain: "https://supertokens-63e-3567.prg1.zerops.app",
    appName: "MyApp",
    websiteDomain: "https://supertokens-63e-3567.prg1.zerops.app",
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
