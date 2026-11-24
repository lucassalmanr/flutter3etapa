# Laudo técnico — Operação Resgate

## Resumo da validação

- `flutter analyze`: executado após as correções.
- `flutter test`: 2 testes automatizados aprovados para o mapeamento de autor e status.
- O fluxo real com Google e Firestore exige o projeto Firebase da escola, que não acompanha o ZIP. Os roteiros manuais abaixo devem ser repetidos após executar `flutterfire configure`.

## Bug 01

**Arquivo:** `lib/models/ocorrencia.dart`  
**Sintoma:** o usuário que criou a ocorrência não era reconhecido como dono.  
**Causa:** `autorId` era lido do campo `autorNome`.  
**Correção:** o modelo passou a ler `autorId` do campo homônimo.  
**Teste:** o teste `preserva o uid e o status armazenados` confirma que `uid-123` permanece em `autorId` e não é substituído pelo nome.

## Bug 02

**Arquivo:** `lib/models/ocorrencia.dart`  
**Sintoma:** ocorrências abertas apareciam como resolvidas e vice-versa.  
**Causa:** o valor salvo em `resolvido` era negado durante a leitura.  
**Correção:** o modelo agora preserva o booleano armazenado e usa `false` quando o campo não existe.  
**Teste:** os dois testes de `Ocorrencia.fromMap` verificam os estados `true` e o padrão `false`.

## Bug 03

**Arquivo:** `lib/services/central_service.dart`  
**Sintoma:** os registros mais antigos eram exibidos antes dos mais recentes.  
**Causa:** a consulta usava `descending: false`.  
**Correção:** a consulta passou a ordenar `criadoEm` de forma decrescente.  
**Teste:** roteiro manual: criar duas ocorrências em sequência e confirmar que a segunda aparece no topo; a consulta também foi validada pelo analisador.

## Bug 04

**Arquivo:** `lib/services/central_service.dart`  
**Sintoma:** a autorização do dono falhava, principalmente entre contas diferentes.  
**Causa:** o cadastro gravava o e-mail em `autorId`, enquanto a autorização comparava esse campo com `User.uid`.  
**Correção:** o cadastro agora grava `u.uid`; o nome/e-mail de exibição continua separado em `autorNome`.  
**Teste:** roteiro manual com duas contas: a conta autora visualiza o botão de status e a outra conta não; a consistência do UID também é coberta pelo teste do modelo.

## Bug 05

**Arquivo:** `lib/services/central_service.dart`  
**Sintoma:** clicar em “Marcar como resolvido” não alterava o estado.  
**Causa:** a atualização escrevia novamente `item.resolvido`.  
**Correção:** a atualização passou a persistir `!item.resolvido`.  
**Teste:** roteiro manual: alternar aberto → resolvido → aberto e conferir a mudança na lista em tempo real.

## Bug 06

**Arquivo:** `lib/services/central_service.dart`  
**Sintoma:** pistas eram perdidas ou não apareciam na ocorrência correta.  
**Causa:** toda pista era gravada em `ocorrencias/pistas/pistas`, ignorando o ID recebido.  
**Correção:** a escrita agora usa `ocorrencias/{ocorrenciaId}/pistas`, o mesmo caminho observado pela tela.  
**Teste:** roteiro manual: a conta B envia uma pista no caso da conta A; ambos os navegadores devem recebê-la apenas nesse caso.

## Bug 07

**Arquivo:** `lib/pages/central_page.dart`  
**Sintoma:** era possível cadastrar uma ocorrência sem título ou sem local.  
**Causa:** a validação só rejeitava quando os dois campos estavam vazios (`&&`).  
**Correção:** a condição passou a rejeitar quando qualquer campo obrigatório estiver vazio (`||`).  
**Teste:** roteiro manual: tentar registrar só com título, só com local e com espaços; os três casos permanecem no formulário e exibem a mensagem de validação.

## Bug 08

**Arquivo:** `lib/pages/central_page.dart`  
**Sintoma:** o interruptor “Somente não resolvidos” não assumia o valor escolhido.  
**Causa:** o callback armazenava `!value`.  
**Correção:** o estado agora recebe diretamente `value`.  
**Teste:** roteiro manual: ativar e desativar o interruptor e conferir que a posição visual acompanha o toque.

## Bug 09

**Arquivo:** `lib/pages/central_page.dart`  
**Sintoma:** o filtro de não resolvidos mostrava justamente os itens resolvidos.  
**Causa:** o predicado selecionava `o.resolvido`.  
**Correção:** o filtro passou a selecionar `!o.resolvido`.  
**Teste:** roteiro manual: manter um caso aberto e outro resolvido, ativar o filtro e confirmar que apenas o aberto permanece.

## Bug 10

**Arquivo:** `lib/pages/central_page.dart`  
**Sintoma:** o projeto não compilava ao montar o subtítulo da ocorrência.  
**Causa:** uma string delimitada por aspas simples continha uma quebra de linha literal.  
**Correção:** o subtítulo passou a usar `\n` e concatenação válida de strings.  
**Teste:** `flutter analyze` processa a tela sem erro de sintaxe.

## Bug 11

**Arquivo:** `lib/pages/central_page.dart`  
**Sintoma:** a tela de detalhes não abria e o código não compilava.  
**Causa:** `DetalhePage` exige uma `Ocorrencia`, mas a navegação chamava o construtor sem o argumento.  
**Correção:** a ocorrência selecionada agora é enviada com `DetalhePage(ocorrencia: o)`.  
**Teste:** `flutter analyze` valida o construtor; roteiro manual: tocar no segundo item e confirmar que título, local e responsável pertencem ao item selecionado.

## Bug 12

**Arquivo:** `lib/pages/detalhe_page.dart`  
**Sintoma:** pistas preenchidas não eram enviadas e uma tentativa vazia podia criar documento vazio.  
**Causa:** a condição retornava quando havia texto e, no caminho restante, o serviço recebia sempre `''`.  
**Correção:** o texto é normalizado uma vez, entradas vazias são ignoradas e a mensagem real é enviada ao serviço.  
**Teste:** roteiro manual: o botão sem texto não cria pista; uma mensagem com espaços nas bordas aparece normalizada e em tempo real nas duas contas.

## Verificação multiusuário final

1. Configurar o Firebase conforme o `README.md`, mantendo Google Authentication e as regras do Firestore habilitados.
2. Abrir dois perfis/janelas com contas Google diferentes.
3. Na conta A, cadastrar uma ocorrência e confirmar que ela aparece automaticamente na conta B.
4. Na conta B, abrir a ocorrência e enviar uma pista; confirmar a atualização nas duas contas.
5. Confirmar que somente a conta A vê e consegue usar o controle de status.
6. Salvar a captura como `evidencias/duas-contas-mesma-ocorrencia.png` antes da entrega.
