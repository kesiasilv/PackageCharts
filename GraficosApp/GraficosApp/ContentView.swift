//
//  ContentView.swift
//  GraficosApp
//
//  Created by Késia Silva Viana on 16/10/25.
//

import SwiftUI
import Charts //importando a framework responsavel por criar a vizualizacao de graficos

struct ContentView: View {
    var body: some View {
        VStack (alignment: .leading, spacing: 4){
            
            //criando uma descricao do grafico:
            Text("Gastos Mensais")
            Text("Ano atual: 2025")
                .fontWeight(.semibold)
                .font(.footnote)
                .foregroundColor(.secondary)
                .padding(.bottom, 12)
            
            
            Chart{ //criado o grafico a partir dos dados da matriz que criamos
                ForEach(viewDados) { viewDado in
                    //criadno uma vizualizacao de grafico do tipo de barras
                    BarMark(
                        x: .value("Ano", viewDado.date, unit: .month),
                        y: .value("Dados", viewDado.viewCount)
                        )
                    //criando uma personalizacao básica:
                    .foregroundStyle(Color.pink.gradient)
                }//tudo isso atua como uma ZStack ou seja posso estabelecer as regras atras das barras do meu grafico
            }
            
            
            .frame(height: 180)  //definindo um tamanho para o gráfico
            
            .chartXAxis{ //personaliza o eixo X
                AxisMarks(values: viewDados.map { $0.date }) { date in
                    AxisGridLine() //adiciona linhas como uma grade
                    AxisValueLabel(format: .dateTime.month(.narrow), centered: true)
                }
            }
           
            .chartYAxis{//personaliza o eixo Y
                AxisMarks{ mark in
                    AxisValueLabel()
                    AxisGridLine()
                }
                
            }
 
            //adicionando tipo uma anotacao
            .padding(.bottom) //deixa mais separado a descrição
            HStack{
                Image(systemName: "line.diagonal") //simbolo
                    .rotationEffect(Angle(degrees: 45)) //virando o simbolo
                    .foregroundColor(.mint)
                
                Text("Montantes Totais") //exemplo de descricao
                    .foregroundColor(.secondary)
            }
            .font(.caption2)
            .padding(.leading, 4)
        }
        .padding()
    }
}

struct ViewDado: Identifiable {
    let id = UUID() //digamos que o ID recebe UU e depois ele vai receber os 
    let date: Date //eixo X das datas das noticias
    let viewCount: Int //eixo Y de dados aleatorios
}

//aqui criamos a vizualizacao dos daods oque sera exibido nesse caso um array de numeros por anos
let viewDados: [ViewDado] = [
    .init(date: Date.from(year: 2025, month: 01, day: 01), viewCount: 1340),
    .init(date: Date.from(year: 2025, month: 02, day: 01), viewCount: 3245),
    .init(date: Date.from(year: 2025, month: 03, day: 01), viewCount: 6785),
    .init(date: Date.from(year: 2025, month: 04, day: 01), viewCount: 2889),
    .init(date: Date.from(year: 2025, month: 05, day: 01), viewCount: 3472),
    .init(date: Date.from(year: 2025, month: 06, day: 01), viewCount: 7773),
    .init(date: Date.from(year: 2025, month: 07, day: 01), viewCount: 2203),
    .init(date: Date.from(year: 2025, month: 08, day: 01), viewCount: 6646),
    .init(date: Date.from(year: 2025, month: 09, day: 01), viewCount: 1030),
    .init(date: Date.from(year: 2025, month: 10, day: 01), viewCount: 3256),
    .init(date: Date.from(year: 2025, month: 11, day: 01), viewCount: 3321),
    .init(date: Date.from(year: 2025, month: 12, day: 01), viewCount: 3321)
]

extension Date { //extensao para exibir a data com base naquele ano, mes, dia que eu passo.
    static func from(year: Int, month: Int, day: Int) -> Date {
        var components = DateComponents() //depois crio um objeto com base naqueles dados que passei
        components.year = year
        components.month = month
        components.day = day
        return Calendar.current.date(from: components)!
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
