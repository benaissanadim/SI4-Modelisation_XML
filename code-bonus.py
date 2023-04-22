import os
import xml.etree.ElementTree as ET

current_path = os.path.abspath(__file__)

dir_name = os.path.dirname(current_path)

xml_path = os.path.join(dir_name, 'organisme.xml')

# Parse the XML file
tree = ET.parse(xml_path)
root = tree.getroot()

for agence in root.findall("./AGENCES/AGENCE"):
    total_ca_agence = 0
    print("Agence: ", agence.find("./NOM").text)
    for sejour in agence.findall("./SEJOURS/SEJOUR"):
        tarif = int(sejour.find("./TARIF").text.replace('$',''))
        total_ca_sejour = 0
        for session in sejour.findall("./SESSIONS/SESSION"):
            nb_clients = len(session.findall("./PARTICIPANTS/CLIENTS/CLIENT_REF"))
            ca = nb_clients * tarif
            total_ca_sejour += ca
        print(" - Séjour: ", sejour.find("./NOM").text, " | Chiffre d'affaires: ", total_ca_sejour, "$")
        total_ca_agence += total_ca_sejour
    print("Chiffre d'affaires total de l'agence: ", total_ca_agence, "$\n")
