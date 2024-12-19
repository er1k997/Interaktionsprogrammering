import React, { useState } from 'react';
import { View, Text, FlatList, StyleSheet, TouchableOpacity, ActivityIndicator, TextInput, ScrollView } from 'react-native';
import { useQuery, gql } from '@apollo/client';
import DropdownComponent from './dropDown';
import { useNavigation } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
import { StackNavigationProp } from '@react-navigation/stack';
import Icon from 'react-native-vector-icons/FontAwesome';

 
// En GraphQL-query (GET_TRENDING_REPOS) är definierad för att hämta repositories från GitHub.
const GET_TRENDING_REPOS = gql`
query GetTrendingRepos($selectedLanguage: String!) {
  search(query: $selectedLanguage, type: REPOSITORY, first: 10) {
    edges {
      node {
        ... on Repository {
          name
          owner {
            login
          }
          stargazerCount
          createdAt
          forks {
            totalCount
          }
          primaryLanguage {
            name
          }
          licenseInfo {
            name
          }
          watchers {
            totalCount
        }
        }
      }
    }
  }
}
`;

const TrendingRepos = () => {
    type RootStackParamList = {
        TrendingRepos: undefined;
        RepoDetails: { repo: any };
    };

    const Stack = createStackNavigator<RootStackParamList>();

    type TrendingReposScreenProp = StackNavigationProp<RootStackParamList, 'TrendingRepos'>;
    const navigation = useNavigation<TrendingReposScreenProp>();

    const [selectedLanguage, setSelectedLanguage] = useState<string>('language:C++ sort:stars');
    const [selectedYear, setSelectedYear] = useState<string>('2024');

    const handleYearChange = (year: string) => {
        setSelectedYear(year);
    };

    const handleLanguageChange = (language: string) => {
        setSelectedLanguage(language);
    };

    const { loading, error, data } = useQuery(GET_TRENDING_REPOS, {
        variables: {
            selectedLanguage: `${selectedLanguage} created:<${selectedYear}`,
        },
        fetchPolicy: 'network-only',
    });

    const formatDate = (isoString: string) => {
        const date = new Date(isoString);
        return date.toLocaleDateString('en-US', {
            year: 'numeric',
            month: 'long',
            day: 'numeric',
            hour: '2-digit',
            minute: '2-digit',
        });
    };

    if (loading) return <ActivityIndicator size="large" color="white" />;
    if (error) return <Text style={{ color: 'white' }}>Error: {error.message}</Text>;

    return (
        <ScrollView style={styles.container}>
            <View style={styles.filterRow}>
                {/* Dropdown for Year */}
                <DropdownComponent onValueChange={handleYearChange} datasetChoice={1} />
                {/* Dropdown for Language */}
                <DropdownComponent onValueChange={handleLanguageChange} datasetChoice={2} />
            </View>

            <FlatList   // FlatList används för att dynamiskt rendera en lista av repositories, och varje kort innehåller: Repository-namn, Stjärnor (med en stjärnikon), Antalet forks och Språk.

                data={data?.search?.edges || []}
                keyExtractor={(item) => item.node.name}
                renderItem={({ item }) => (
                    <View style={styles.card}>
                        <View style={styles.cardContent}>
                            <Text style={styles.title}> {item.node.name}</Text>
                            <View style={styles.infoRow}>
                                <Icon name="thumbs-up" size={20} color="#FFD700" />
                                <Text style={styles.text}>{item.node.stargazerCount}</Text>
                            </View>

                            <View style={styles.infoRow}>
                                <Icon name="code" size={20} color="black" />
                                <Text style={styles.text}>{item.node.forks.totalCount}</Text>
                            </View>
                            <Text style={styles.text}>
                                <Text style={styles.textBold}>Primary Language:</Text> {item.node.primaryLanguage?.name || "N/A"}
                            </Text>
                            <TouchableOpacity
                                style={styles.readMore}
                                onPress={() =>
                                    navigation.navigate('RepoDetails', {
                                        repo: item.node,
                                    })
                                }
                            >
                                <Text style={styles.readMoreText}>Read more</Text>
                            </TouchableOpacity>
                        </View>
                    </View>
                )}
                contentContainerStyle={{ paddingBottom: 300 }}
            />
        </ScrollView>
    );
};


const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: 'darkolivegreen', 
        padding: 16,
    },
    picker: {
        height: 50,
        width: '100%',
        borderColor: 'gray',
        borderWidth: 1,
        marginBottom: 10,
        
    },
    card: {
        width: 370,
        height: 190,
        backgroundColor: 'gray',
        borderRadius: 10,
        padding: 5,
        margin: 10,
        marginLeft: 60,
        shadowColor: '#000',
        shadowOffset: { width: 0, height: 2 },
        shadowOpacity: 0.25,
        shadowRadius: 3.5,
        
    },
    infoRow: {
        flexDirection: 'row',
        alignItems: 'center',
        marginBottom: 10,
    },
    cardContent: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'flex-start',
        margin: 10,
    },
    text: {
        color: 'white', 
        fontSize: 15,
        fontFamily: 'sans-serif',
        margin: 5,
    },
    textBold: {
        color: 'white', 
        fontSize: 15,
        fontFamily: 'sans-serif',
        margin: 5,
        fontWeight: 'bold',
    },
    readMore: {
        width: '30%',
        height: '23%',
        backgroundColor: 'black',
        borderRadius: 10,
        position: 'absolute',
        bottom: 0,
        right: 0,
        justifyContent: 'center',
        alignItems: 'center',
    },
    readMoreText: {
        color: 'white', 
        fontSize: 15,
        fontFamily: 'sans-serif',
    },
    title: {
        color: 'white', 
        fontSize: 20,
        fontFamily: 'sans-serif',
        marginBottom: 5,
        fontWeight: 'bold',
    },
    filterRow: {
        flexDirection: 'column', 
        alignItems: 'flex-start', 
        justifyContent: 'flex-start', 
        marginBottom: 20,
        marginLeft: 60,
        paddingHorizontal: 5, 
    },
});

export default TrendingRepos;
