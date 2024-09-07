
import SwiftUI

struct TodoItem: Identifiable {
    let id = UUID()
    var title: String
    var isCompleted: Bool = false
}

struct ContentView: View {
    @State private var newTodoItem = ""
    @State private var todoItems = [TodoItem]()

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(todoItems) { item in
                        HStack {
                            Text(item.title)
                            Spacer()
                            Button(action: {
                                toggleTodoItemCompletion(item: item)
                            }) {
                                Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                            }
                        }
                    }
                    .onDelete(perform: deleteTodoItems)
                }
                .listStyle(PlainListStyle())

                HStack {
                    TextField("Add a new task", text: $newTodoItem)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        addTodoItem()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.blue)
                            .font(.system(size: 25))
                    }
                }
                .padding()
            }
            .navigationBarTitle("To-Do List")
        }
    }

    func addTodoItem() {
        guard !newTodoItem.isEmpty else { return }
        let todoItem = TodoItem(title: newTodoItem)
        todoItems.append(todoItem)
        newTodoItem = ""
    }

    func deleteTodoItems(at offsets: IndexSet) {
        todoItems.remove(atOffsets: offsets)
    }

    func toggleTodoItemCompletion(item: TodoItem) {
        if let index = todoItems.firstIndex(where: { $0.id == item.id }) {
            todoItems[index].isCompleted.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
