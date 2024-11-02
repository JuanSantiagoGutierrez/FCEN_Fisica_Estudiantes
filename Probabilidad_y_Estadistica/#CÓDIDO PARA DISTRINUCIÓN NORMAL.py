#CÓDIDO PARA DISTRIBUCIÓN NORMAL
import numpy as np
import matplotlib.pyplot as plt
import scipy.stats as stats
#agreguen el excel
# Suponiendo que tienes tus datos en una lista
datos = [0.5810582011,
0.4710006225,
0.405,
0.5688405797,
0.5071428571,
0.6666666667,
0.5666666667,
0.328125,
0.6041666667,
0.3881578947,
0.3947368421,
0.3245614035,
0.5,
0.3157894737,
0.3793859649,
0.4921052632,
0.5105263158,
0.6052631579,
0.4978070175,
0.3872807018,
0.3921052632,
0.4561403509,
0.3789473684,
0.6649122807,
0.6052631579,
0.5350877193,
0.4333333333,
0.4122807018,
0.3157894737,
0.199122807,
0.2973684211,
0.6105263158,
0.4105263158,
0.5710526316,
0.3703703704,
0.4571150097,
0.4868421053,
0.4490740741,
0.5,
0.3055555556,
0.4444444444,
0.58125,
0.5610859729,
0.421957672,
0.5875,
0.6700534759,
0.3803030303,
0.3818181818,
0.5049342105,
0.7794117647,
0.5666666667,
0.6057692308,
0.6428571429,
0.4666666667,
0.4333333333,
0.4,
0.3404761905,
0.4333333333,
0.5333333333,
0.4666666667,
0.7,
0.3666666667,
0.3666666667,
0.34375,
0.4411764706,
0.2941176471,
0.3333333333,
0.5666666667,
0.8777777778]  # Cambia esto por tus datos

# Convertir a un array de numpy
datos = np.array(datos)

# Calcular los parámetros de la distribución normal (media y desviación estándar)
media = np.mean(datos)
desviacion_estandar = np.std(datos)

# Generar los cuantiles de la distribución normal
quantiles_normal = stats.norm.ppf(np.linspace(0.01, 0.99, len(datos)), loc=media, scale=desviacion_estandar)

# Generar los cuantiles de los datos reales
quantiles_datos = np.percentile(datos, np.linspace(1, 99, len(datos)))

# Crear el Q-Q plot
plt.figure(figsize=(8, 8))
plt.scatter(quantiles_normal, quantiles_datos, color='blue', label='Datos reales vs Normal')
plt.plot([quantiles_normal.min(), quantiles_normal.max()], [quantiles_normal.min(), quantiles_normal.max()], color='red', linestyle='--', label='y=x')
plt.xlabel('Cuantiles de la distribución normal')
plt.ylabel('Cuantiles de los datos reales')
plt.title('Q-Q Plot')
plt.legend()
plt.grid()
plt.show()