//
//  CardView.swift
//  bonsai
//
//  Created by justyn on 2022-05-18.
//
import SwiftUI


private enum likeState
{
    case hot
    case not
    case empty
}

struct CardView: View {
    var day: String = "Day"
    var cardAlpha: Double = 1.0
    
    @ObservedObject var productViewModel:ProductViewModel

    @State private var translation: CGSize = .zero
    @State private var isDragging = false
    @State private var motionOffset: Double = 0.0
    @State private var motionScale: Double = 0.0
    @State private var swipeStatus: likeState = .empty
    
    
    
    private var product: Product
    private var onRemove: (_ product: Product) -> Void
    
    
    init(product: Product,viewModel:ProductViewModel, onRemove: @escaping (_ product: Product) -> Void){
        self.product = product
        self.onRemove = onRemove
        self.productViewModel = viewModel
    }
    private func getIconName(state: likeState) -> String
        {
            switch state
            {
                case .hot:     return "hot"
                case .not:     return "not"
                default:       return "Empty"
            }
        }
    
    
    private func setCardState(offset: CGFloat) -> likeState
        {
            if offset <= CardViewConsts.hotThreshold   { return .hot }
            if offset >= CardViewConsts.notThreshold   { return .not }
            return .empty
        }
    
    
    private func getSwipePercentage(_ geometry: GeometryProxy, from gesture: DragGesture.Value) -> CGFloat {
            gesture.translation.width / geometry.size.width
        }

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                CarouselView(numberOfImages: self.product.product_images.count){
                    ForEach (self.product.product_images, id:\.image_id){ img in
                        AsyncImage(url:URL(string: img.img_url),content:{ image in
                            image.resizable()                        },
                                   placeholder: {
                            ProgressView()
                        })
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: geometry.size.height * 0.75)
                            .clipped()
                }
                }
                
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(product.title+","+product.lineage)
                            .font(.title)
                            .bold()
                        Text(product.vendor)
                            .font(.subheadline)
                            .bold()
                        Text(product.product_type)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    // Add a spacer to push our HStack to the left and the spacer fill the empty space
                    Spacer()
                    
                    Image(systemName: "info.circle")
                        .foregroundColor(self.isDragging ? .red : .gray)
                }.padding(.horizontal)
                BottomBarView(viewModel:productViewModel,product: self.product)
            }
            // Add padding, corner radius and shadow with blur radius
            .padding(.bottom)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            .animation(.interactiveSpring())
            .offset(x:translation.width,y:translation.height)
            //calculate R-angle Based on the lentgh of the swipegesture and limit rotation to 15 degrees
            //must put rotation after ofset but before gesture else card becomse stuck
            .rotationEffect(
                .degrees(CardViewConsts.cardRotLimit * -Double(self.translation.width / geometry.size.width) ), anchor: .center)
            .gesture(DragGesture()
                        .onChanged{gesture in
                        print("swipe started")
                        self.translation = gesture.translation
                        self.swipeStatus = setCardState(offset: gesture.translation.width)
                    }
                    .onEnded{gesture in
                        print("swipe ended")
                if(abs(self.translation.width / geometry.size.width)>CardViewConsts.swipeThreshold){
                    self.onRemove(self.product)
                }else{
                    self.translation = .zero
                }
                       
                        
                    })
            .onTapGesture(count: 2) {
                print("double tap")
            }
            
            
        }
          }
}

private struct CardViewConsts
{
    static let cardRotLimit: CGFloat = 15.0
    static let swipeThreshold:CGFloat = 0.50
    static let hotThreshold:CGFloat = -0.1
    static let notThreshold:CGFloat = 0.1
    
    static let cardRatio: CGFloat = 1.333
    static let cardCornerRadius: CGFloat = 24.0
    static let cardShadowOffset: CGFloat = 16.0
    static let cardShadowBlur: CGFloat = 16.0
    
    static let labelTextSize: CGFloat = 24.0
    static let labelTextKerning: CGFloat = 6.0
    
    static let motionRemapFromMin: Double = 0.0
    static let motionRemapFromMax: Double = 0.25
    static let motionRemapToMin: Double = 0.0
    static let motionRemapToMax: Double = 1.0
    
    static let springResponse: Double = 0.5
    static let springBlendDur: Double = 0.3
    
    static let iconSize: CGSize = CGSize(width: 96.0, height: 96.0)
}



