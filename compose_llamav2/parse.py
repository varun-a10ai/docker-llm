import re
import yaml

def parse_file(filename):
    with open(filename, 'r') as file:
        content = file.read()
    
    # Define the pattern to extract rule components.
    pattern = re.compile(r'\d+\.\s\*\*(.*?)\*\* - (.*?)\n\s+"(.*?)" => "(.*?)"\n')
    
    # Extract all matches.
    matches = pattern.findall(content)

    rules = []
    for match in matches:
        rule_dict = {
            "Rule": {
                "Name": match[0],
                "Description": match[1],
                "Example": {
                    "Wrong": match[2],
                    "Right": match[3]
                }
            }
        }
        rules.append(rule_dict)

    # Convert the list of rule dictionaries to YAML.
    yaml_output = yaml.dump(rules, default_flow_style=False)
    return yaml_output

if __name__ == "__main__":
    filename = "rules.txt"  # Replace with your file path.
    yaml_result = parse_file(filename)
    print(yaml_result)
