# Informações importantes

### Arquitetura

A arquitetura utilizada no projeto é baseada em [VIP/CleanSwift](https://clean-swift.com/), porém com algumas simplificações, uso de coordinator e factories.
As Camadas utilizadas na aquitetura são:
- Interactor
- Presenter
- ViewController
- Coordinator
- Service \(Ou Worker)

Apesar de não existir a necessidade de criar a camada de rede\(ApiClient), adicionei como exemplo e utilizei respostas mockadas para avançar o fluxo.

### Testes

Foram testadas as camadas Interactor, Presenter e Coordinator.

#### Observações extras

Devido a algumas questões técnicas mantive o foco na arquitetura, testes e organização do código, 
animações e interações mais complexas não foram implementadas, mas podemos rever essas questões mais a frente.

##### **Muito Obrigado, qualquer dúvida estou a disposição**