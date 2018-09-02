# SKScrollView
The custom scrollview to handle multiple views easy.

# Steps to Integrate:
  1. Download the project.
  2. Drag & Drop the file "SKScrollView.swift" into your own project.
  3. Create a UIScrollView in your Xib/Storyboard and change the class name as "SKScrollView".
  4. Done.
  
# Insert a View into SKScrollView:

  You can use below lines to insert new view into scrollview. This scrollview automatically adjusts the contentSize.

  ```
  let view = UIView(frame: CGRect(x: 0, y: 0, width: yourScrollView.frame.size.width, height: 200.0))
  view.backgroundColor = .orange
  
  yourScrollView.insertNewSubView(view, atIndex: index, scrollToView: true)
  ```
 
# Delete a View from SKScrollView:

  1. Deleting view by it's index.
  
  ```
  yourScrollView.deleteSubView(atIndex: index)
  ```
  
  2. Deleting view by it's own reference.
  
  ```
  yourScrollView.deleteSubView(view)
  ```
  
