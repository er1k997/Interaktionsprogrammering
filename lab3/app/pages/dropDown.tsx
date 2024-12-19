import React, { useState } from 'react';
import { StyleSheet, Text, View, TouchableOpacity } from 'react-native';
 
const dataYear = [
    { label: "2014", value: "2014" },
    { label: "2015", value: "2015" },
    { label: "2016", value: "2016" },
    { label: "2017", value: "2017" },
    { label: "2018", value: "2018" },
    { label: "2019", value: "2019" },
    { label: "2020", value: "2020" },
];

const dataLang = [
    { label: "C++", value: "language:C++ sort:stars" },
    { label: "JavaScript", value: "language:JavaScript sort:stars" },
    { label: "Python", value: "language:Python sort:stars" },
    { label: "Java", value: "language:Java sort:stars" },
    { label: "Go", value: "language:Go sort:stars" },
    { label: "Ruby", value: "language:Ruby sort:stars" },
    { label: "TypeScript", value: "language:TypeScript sort:stars" },
    { label: "C#", value: "language:C# sort:stars" },
    { label: "PHP", value: "language:PHP sort:stars" },
    { label: "Swift", value: "language:Swift sort:stars" },
    { label: "Kotlin", value: "language:Kotlin sort:stars" },
    { label: "Rust", value: "language:Rust sort:stars" },
    { label: "Dart", value: "language:Dart sort:stars" },
    { label: "Shell", value: "language:Shell sort:stars" },
    { label: "Objective-C", value: "language:Objective-C sort:stars" },
    { label: "Vue", value: "language:Vue sort:stars" },
];

interface DropdownComponentYearProps {
    onValueChange: (value: string) => void;
    datasetChoice: 1 | 2;
}

const DropdownComponentYear: React.FC<DropdownComponentYearProps> = ({ onValueChange, datasetChoice }) => {
    const [value, setValue] = useState<string>(''); // React Hooks (useState) gör att gränssnittet återrenderas varje gång en användare gör ett val, och en ny query skickas.
    const [isFocus, setIsFocus] = useState(false);  // For managing focus and dropdown visibility

    const data = datasetChoice === 1 ? dataYear : dataLang;

    const handleValueChange = (item: { label: string; value: string }) => {
        setValue(item.value);
        onValueChange(item.value);
        setIsFocus(false); // Close dropdown after selecting an item
    };

    return (
        <View style={styles.container}>
            <TouchableOpacity
                style={styles.dropdownButton}
                onPress={() => setIsFocus(!isFocus)}  // Toggle the visibility of the options
            >
                <Text style={styles.buttonText}>
                    {datasetChoice === 1 ? 'Select Year' : 'Select Language'}
                </Text>
            </TouchableOpacity>

            {isFocus && (
                <View style={styles.optionsRow}>
                    {data.map((item) => (
                        <TouchableOpacity
                            key={item.value}
                            style={styles.optionButton}
                            onPress={() => handleValueChange(item)}
                        >
                            <Text style={styles.optionText}>{item.label}</Text>
                        </TouchableOpacity>
                    ))}
                </View>
            )}
        </View>
    );
};

export default DropdownComponentYear;

const styles = StyleSheet.create({
    container: {
        padding: 10,
    },
    dropdownButton: {
        height: 40,
        width: 165,
        borderColor: 'black',
        backgroundColor: 'white',
        borderWidth: 0.5,
        borderRadius: 8,
        paddingHorizontal: 8,
        justifyContent: 'center',
        alignItems: 'center',
        marginBottom: 10,
    },
    buttonText: {
        fontSize: 16,
    },
    optionsRow: {
        flexDirection: 'row',
        flexWrap: 'wrap',
        marginTop: 10,
    },
    optionButton: {
        marginRight: 10,
        marginBottom: 10,
        paddingVertical: 8,
        paddingHorizontal: 15,
        backgroundColor: 'white',
        borderRadius: 5,
    },
    optionText: {
        fontSize: 14,
    },
});
