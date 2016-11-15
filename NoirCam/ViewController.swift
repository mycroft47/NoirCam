// http://www.xcode-training-and-tips.com/tag/imageview/

//  ViewController.swift
//  NoirCam
//
//  Created by David McMahon on 6/28/15.
//  Copyright (c) 2015 Bluewater Publishing. All rights reserved.
//  modified sy 2016-05-22
//  test for github 2016-11-14

import UIKit
import CoreImage

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var items: [String] = ["Original", "Tonality", "Ansel Adams", "Dark", "Noir", "Dots"]
    
    var filterNames: [String] = ["Original", "CIPhotoEffectTonal", "CIMaximumComponent", "CIMinimumComponent", "CIPhotoEffectNoir", "CIDotScreen"]
  
  var originalImage : UIImage = UIImage(named:"girl.jpg")!
//   var originalImage : UIImage  = UIImage(named:"pigtails 2.png")!
//var originalImage : UIImage  = UIImage(named:"Strong Man.jpg")!

  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView!, cellForRowAtIndexPath
        indexPath: IndexPath!) -> UITableViewCell! {
            let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle,
                reuseIdentifier: "MyTestCell")
            cell.textLabel!.text = items[indexPath.row]
            return cell
    }
    
   
    
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
 
      let CIfilterName = filterNames[indexPath.row]
      print(CIfilterName)
      
      if CIfilterName == "Original" {
        imageView.image = originalImage
        
      } else if CIfilterName == "CIPhotoEffectTonal" { // force crash
        assert(1 == 2, "Failure!")
        
      } else {
      
        let ciContext = CIContext(options: nil)
        let startImage = CIImage(image: originalImage)

        let filter = CIFilter(name: CIfilterName)
        filter!.setDefaults()

        filter!.setValue(startImage, forKey: kCIInputImageKey)
        let filteredImageData = filter!.value(forKey: kCIOutputImageKey) as! CIImage
        let filteredImageRef = ciContext.createCGImage(filteredImageData, from: filteredImageData.extent)
        imageView.image = UIImage(cgImage: filteredImageRef!)
        
      } // end if
    }  // end func
} // end class



/*
 Swift : Create black and white Photo App with CoreImage

In this tutorial we’ll create a simple photo app that lets the user apply different black and white effects to an image. The app will include three principle elements:

A UIImageView
UITableView
The Core Image framework

Get started by creating a single View application, choosing Swift as your programming language. Once your project is created, open the storyboard and set up your app like this. At the top we’ll put an imageView, and we’ll put a tableView below it. Drag an image into your app and then set the image property of the imageView object on your view to that image.

Screen Shot 2015-06-28 at 10.05.05 AM



Next, lets create outlets for the imageView and tableView. Click the show Assistant editor to open the code window. Select the tableView and control + drag to your class to create an outlet.

Screen Shot 2015-06-28 at 10.06.18 AM

Next name your outlet:

SetOutlet

Repeat the process for the imageView. Next we need to make sure the tableView datasource and delegate have been set. Select the tableView, then click on show Connections Inspector. Click on datasource and control+drag to the View Controller. Repeat the process for delegate.
  
TableViewDelegate

Now let’s make sure we have Core Image in our project so that we can apply filters to the image. We need to do 2 steps to accomplish this. First, click on your project in the left pane and select Build Phases. Click Link Binary with Libraries and click the + button. Then enter Core Image.

AddFramework

Select Coreimage.framework and click Add. Now add an import statement to your viewController.swift file, which all together should look something like this:

//
// ViewController.swift
// NoirCam
//
// Created by David McMahon on 6/28/15.
// Copyright (c) 2015 Bluewater Publishing. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  @IBOutlet weak var imageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

Now we need an array to hold the names of the filters that we are going to display in the tableView. We’re going to have 5 black and white filters. I just made up names for the filters, the names you use aren’t all that important. Put your array declaration right below the imageView Outlet line:

var items: [String] = [“Tonality”, “Noir”, “Ansel Adams”,“Dark”,“Dots”]

Next, add a function to set the number of rows in the table, to the number of array elements in items:

func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  return self.items.count;
}

Next we need to tell the system what to display in the tableView. This is done by setting the text property of cell.textLabel:

func tableView(tableView: UITableView!, cellForRowAtIndexPath
  indexPath: NSIndexPath!) -> UITableViewCell! {
  
  let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle,
                                              reuseIdentifier: “MyTestCell”)
  
  cell.textLabel!.text = items[indexPath.row]
  
  return cell
}

The next step is to implement didSelectRowAtIndexPath so that we can apply the correct filter when the user makes a selection. For now we’ll just put the function and add the code in a minute.

func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
  
}

Let’s build and run to make sure that everything is working OK so far.

iOS Simulator Screen Shot Jun 28, 2015, 10.38.23 AM

Now that we have the basic structure of the app set up, we can add the image filter code. The first step is to create an array of filter names recognized by Core Image.

var filterNames: [String] = [“CIPhotoEffectTonal”,“CIPhotoEffectNoir”,“CIMaximumComponent”,“CIMinimumComponent”,“CIDotScreen”]

The next step is to determine which row the user selected in the table, and then pick the correct filter name based on that selection. You can do it like this:

func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
  
  var CIfilterName = filterNames[indexPath.row]
  println(CIfilterName)
  
}

We’ve added a print statement so we can check it. Run your app and make sure that works. Now we need to keep a copy of the original image – so that the user can try out each filter on the original copy. Add this line to your class, using the name of the image you imported to the project.

var originalImage : UIImage = UIImage(named:“girl.jpg”)!

Next lets apply the selected filter. The following code goes into the didSelectRowAtIndexPath function. First, you need a CIContext when working with Core Image. Then we will set the input or starting image. Core Image works with its own image type CIImage so we will pass our original image that we are storing in the background.

let ciContext = CIContext(options: nil)
let startImage = CIImage(image: originalImage)

Now we’ll tell it which filter the user selected:

let filter = CIFilter(name: CIfilterName)
filter.setDefaults()

Now we’ll let Core Image do the dirty work of applying the filter:

filter.setValue(startImage, forKey: kCIInputImageKey)
let filteredImageData = filter.valueForKey(kCIOutputImageKey) as! CIImage
let filteredImageRef = ciContext.createCGImage(filteredImageData, fromRect: filteredImageData.extent())

Finally, set the image displayed in the imageView to the filtered image:

imageView.image = UIImage(CGImage: filteredImageRef);

Your didSelectRowAtIndexPath function should look like this:

func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
  
  var CIfilterName = filterNames[indexPath.row]
  println(CIfilterName)
  
  let ciContext = CIContext(options: nil)
  let startImage = CIImage(image: originalImage)
  
  let filter = CIFilter(name: CIfilterName)
  filter.setDefaults()
  
  filter.setValue(startImage, forKey: kCIInputImageKey)
  let filteredImageData = filter.valueForKey(kCIOutputImageKey) as! CIImage
  let filteredImageRef = ciContext.createCGImage(filteredImageData, fromRect: filteredImageData.extent())
  
  imageView.image = UIImage(CGImage: filteredImageRef);
  
}

Build and run, and test one of the filters:
 
 */
