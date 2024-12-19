import { ApolloClient, InMemoryCache, HttpLink } from '@apollo/client';

// Apollo Client används som GraphQL-klient för att hantera nätverksanrop
const client = new ApolloClient({
  // Klienten är konfigurerad med en HttpLink för att kommunicera med GitHubs GraphQL-API.
  link: new HttpLink({
    uri: 'https://api.github.com/graphql',
    headers: {
      Authorization: ` `, // Token - Bort tagen för att kunna pusha via github desktop
    },
  }),
  cache: new InMemoryCache(),
});

export default client;



