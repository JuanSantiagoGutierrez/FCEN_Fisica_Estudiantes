#CÓDIGO PARA DISTRIBUCIÓN BINOMIAL
import numpy as np
import scipy.stats as stats
import matplotlib.pyplot as plt

# Datos de ejemplo
observed = np.array([25, 6])  # Frecuencias observadas para cada categoría, pueden agregar más categorías y hacen una dist. multinomial
n = 31  # Número total de ensayos
p = 0.193548387 # Probabilidad de éxito, calculada previamente

# Calcular las frecuencias esperadas
expected = np.array([n * (p**k) * ((1-p)**(n-k)) for k in range(len(observed))])
expected = expected / np.sum(expected) * np.sum(observed)  # Normalizar a la suma de observadas

# Realizar la prueba de chi-cuadrado
chi2_stat, p_value = stats.chisquare(f_obs=observed, f_exp=expected)

# Resultados
print("Frecuencias observadas:", observed)
print("Frecuencias esperadas:", expected)
print("Estadística chi-cuadrado:", chi2_stat)
print("Valor p:", p_value)

# Gráfico de barras
categories = ['Votos dip <= 0,5', 'Votos dip > 0,5']  # Nombres de las categorías, cambiénlos xd

x = np.arange(len(categories))  # Posiciones de las categorías

plt.bar(x - 0.2, observed, width=0.4, label='Observadas', color='blue', alpha=0.7)
plt.bar(x + 0.2, expected, width=0.4, label='Esperadas', color='orange', alpha=0.7)

plt.xlabel('Categorías')
plt.ylabel('Frecuencia')
plt.title('Frecuencias Observadas vs Esperadas')
plt.xticks(x, categories)
plt.legend()
plt.grid(axis='y')

# Mostrar gráfico
plt.tight_layout()
plt.show()

# Tomar decisión
alpha = 0.05
if p_value < alpha:
    print("Rechazamos la hipótesis nula.")
else:
    print("No rechazamos la hipótesis nula.")
