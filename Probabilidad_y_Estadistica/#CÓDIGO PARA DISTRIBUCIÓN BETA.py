#CÓDIGO PARA DISTRIBUCIÓN BETA
import numpy as np
import matplotlib.pyplot as plt
import scipy.stats as stats
#En vez de hacer la lista como hicimos nosotros, copien lo que pasé al whatsapp, para poder exportar los datos desde su excel
# Supongamos que tus datos son una lista o un array de numpy
# Aquí debes reemplazarlo con tus propios datos
data = np.array([0.437218041939563,
0.298325753787454,
0.462951356887568,
0.50608257347883,
0.327245945387495,
0.320712157925978,
0.536948581712888,
0.200083671666369,
0.499652191335684,
0.672160071077248,
0.405128435413191,
0.389571377695014,
0.225936121330163,
0.316717372988115,
0.325953347632158,
0.260701933117694,
0.573585154053968,
1,00,
0.580520532971486,
0.496325184535232,
])  # Inserta aquí tus datos

# Parámetros de la distribución beta
a = 6  # Parámetro alpha-cantidad de "éxitos"
b = 14 # Parámetro beta-cantidad de "fracasos"

# Generar valores teóricos de la distribución beta
quantiles = np.linspace(0, 1, len(data))
theoretical_quantiles = stats.beta.ppf(quantiles, a, b)

# Crear el Q-Q plot
plt.figure(figsize=(8, 8))
plt.scatter(theoretical_quantiles, np.sort(data), label='Datos', color='blue')
plt.plot([min(theoretical_quantiles), max(theoretical_quantiles)],
         [min(theoretical_quantiles), max(theoretical_quantiles)],
         color='red', linestyle='--', label='Línea de referencia')
plt.title('Q-Q Plot')
plt.xlabel('Cuantiles teóricos')
plt.ylabel('Cuantiles de los datos')
plt.legend()
plt.grid()
plt.show()