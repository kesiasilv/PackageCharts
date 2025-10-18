//
//  ContentView.swift
//  GraficosApp
//
//  Created by Késia Silva Viana on 16/10/25.
//

import SwiftUI
import Charts //importando a framework responsavel por criar a vizualizacao de graficos

struct ContentView: View {
    var mockData = ViewDado.mockData
    
    @State private var rawSelectionDate: Date?//propriedade criada para usar nas interacoes
    
    var selectedViewMonth: ViewDado? {
        guard let rawSelectionDate else { return nil }
        return mockData.first{
            Calendar.current.isDate(rawSelectionDate, equalTo: $0.date, toGranularity: .month)
        }
    }
    
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
                
                //criando um if para a UI das barras de quando selecionamos cada uma:
                if let selectedViewMonth {
                    RuleMark(x: .value("Selected Month", selectedViewMonth.date, unit: .month)) //aqui criei uma linha vertical que adiciona no eixo X se eu quisesse uma horizontal no eixo Y criava como tal.
                        .foregroundStyle(.secondary.opacity(0.3))//personalizando a linha
                    //criando a UI que ficara por cima da linha
                        .annotation(position: .top, overflowResolution: .init(x: .fit(to: .chart), y: .disabled)) {
                            VStack{
                                Text(selectedViewMonth.date, format: .dateTime.month(.wide))
                                    .bold()
                                
                                Text("\(selectedViewMonth.viewCount)")
                                .font(.title3.bold())
                            }
                            //personalizando o tamanho do quadro que exibirá quando segurar na barra
                            .foregroundStyle(.white)
                            .padding(12)
                            .frame(width: 120)
                            .background(RoundedRectangle(cornerRadius: 10).fill(.pink.gradient))
                        }
                }
                ForEach(mockData) { viewDado in
                    //criadno uma vizualizacao de grafico do tipo de barras
                    BarMark(
                        x: .value("Ano", viewDado.date, unit: .month),
                        y: .value("Dados", viewDado.viewCount)
                        )
                    //criando uma personalizacao básica:
                    .foregroundStyle(Color.pink.gradient)
                    //adicionando a opacidade quando clica na barra:
                    .opacity(rawSelectionDate == nil || viewDado.date == selectedViewMonth? .date ? 1 : 0.5)
                    
                    
                }//tudo isso atua como uma ZStack ou seja posso estabelecer as regras atras das barras do meu grafico
            }
            
            
            .frame(height: 180)  //definindo um tamanho para o gráfico
            
            //criando o drang in drop que passa por cima de cada barra do grafico:
            .chartXSelection(value: $rawSelectionDate.animation(.easeInOut)) //a animacao é bem minima para mudar a interface quando passa pelas barras mas sem a condicao de cima essa animação n funciona
//            //para fins de testes e ver se ta funcionando o drang in drop
//            .onChange(of: selectedViewMonth?.viewCount, { oldValue, newValue in
//                print(newValue)
//            })
            
            .chartXAxis{ //personaliza o eixo X
                AxisMarks(values: mockData.map { $0.date }) { date in
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

//struct ViewDado: Identifiable {
//    let id = UUID() //digamos que o ID recebe UU e depois ele vai receber os 
//    let date: Date //eixo X das datas das noticias
//    let viewCount: Int //eixo Y de dados aleatorios
//}
//
////aqui criamos a vizualizacao dos daods oque sera exibido nesse caso um array de numeros por anos
//let mockData: [ViewDado] = [
//    .init(date: Date.from(year: 2025, month: 01, day: 01), viewCount: 1340),
//    .init(date: Date.from(year: 2025, month: 02, day: 01), viewCount: 3245),
//    .init(date: Date.from(year: 2025, month: 03, day: 01), viewCount: 6785),
//    .init(date: Date.from(year: 2025, month: 04, day: 01), viewCount: 2889),
//    .init(date: Date.from(year: 2025, month: 05, day: 01), viewCount: 3472),
//    .init(date: Date.from(year: 2025, month: 06, day: 01), viewCount: 7773),
//    .init(date: Date.from(year: 2025, month: 07, day: 01), viewCount: 2203),
//    .init(date: Date.from(year: 2025, month: 08, day: 01), viewCount: 6646),
//    .init(date: Date.from(year: 2025, month: 09, day: 01), viewCount: 1030),
//    .init(date: Date.from(year: 2025, month: 10, day: 01), viewCount: 3256),
//    .init(date: Date.from(year: 2025, month: 11, day: 01), viewCount: 3321),
//    .init(date: Date.from(year: 2025, month: 12, day: 01), viewCount: 3321)
//]
//
//extension Date { //extensao para exibir a data com base naquele ano, mes, dia que eu passo.
//    static func from(year: Int, month: Int, day: Int) -> Date {
//        var components = DateComponents() //depois crio um objeto com base naqueles dados que passei
//        components.year = year
//        components.month = month
//        components.day = day
//        return Calendar.current.date(from: components)!
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
