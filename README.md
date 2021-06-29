### LEIA-ME
Esse é um modelo de floresta randômica (random forest) bastante simples que pode ser utilizado para classificar imagens de satélite.

Funciona assim: digamos que você tem 4 classes que quer identificar na imagem. Então você deve criar um shapefile para cada classe e delinear, com base na imagem de satélite, regiões de interesse (podem ser, por exemplo, tipos de florestas).
Depois, você deve extrair (de forma automática ou manual) pontos amostrais que sejam representativos dessas classes. A sugestão aqui é utilizar algum algoritmo de "pontos aleatórios dentro de polígonos", mas fica a seu critério.

Certifique-se que o raster utilizado e os shapefiles estão em WGS-84, caso contrário, o R tem dificuldades em trabalhar com os arquivos. Com tudo nos conformes, basta especificar os diretórios, ver quantos pontos amostrais você quer no total, e como você quer dividir esses pontos entre treino e teste.
Por fim, é só rodar o script.


Esse algoritmo foi desenvolvido com muita ajuda de Enzo Crisigiovanni, Doutor em Ciências Agrárias.