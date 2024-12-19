import { ApolloClient, InMemoryCache, HttpLink } from '@apollo/client';

// Apollo Client används som GraphQL-klient för att hantera nätverksanrop
const client = new ApolloClient({
  // Klienten är konfigurerad med en HttpLink för att kommunicera med GitHubs GraphQL-API.
  link: new HttpLink({
    uri: '',
    headers: {
      Authorization: ` `,
    },
  }),
  cache: new InMemoryCache(),
});

export default client;



