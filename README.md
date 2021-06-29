### LEIA-ME
Esse é um modelo de floresta randômica (random forest) bastante simples que pode ser utilizado para classificar imagens de satélite.

Funciona assim: digamos que você tem 4 classes que quer identificar na imagem. Então você deve criar um shapefile para cada classe e delinear, com base na imagem de satélite, regiões de interesse (podem ser, por exemplo, tipos de florestas).
Depois, você deve extrair (de forma automática ou manual) pontos amostrais que sejam representativos dessas classes. A sugestão aqui é utilizar algum algoritmo de "pontos aleatórios dentro de polígonos", mas fica a seu critério.

Certifique-se que o raster utilizado e os shapefiles estão em WGS-84, caso contrário, o R tem dificuldades em trabalhar com os arquivos. Com tudo nos conformes, basta especificar os diretórios, ver quantos pontos amostrais você quer no total, e como você quer dividir esses pontos entre treino e teste.
Por fim, é só rodar o script.

O algoritmo vai importar os arquivos, fazer a extração de características, gerar o modelo RF, plotar a importância das bandas da sua imagem de satélite (dada pelo Índice de Gini), mostrar a matriz de confusão e calcular o índice Kappa. No final, vai aplicar o modelo no raster utilizado, e exportar um raster classificado.

O algoritmo-base foi desenvolvido por Enzo Crisigiovanni, Doutor em Ciências Agrárias que me auxiliou muito nas adaptações. Fica aqui meu agradecimento a ele.
