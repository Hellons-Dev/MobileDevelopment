import SwiftUI

struct EventView: View {
    var activity : Schedule
    
       
    var body: some View {
        
        if activity.fields.activity.lowercased().contains(/^(breakfast|lunch|welcome breakfast)$/)
        {
            
            Image("breakfast")
        }
        else if activity.fields.activity.lowercased().contains("breakout")
        {
           Image("breakout")
        }
        else
        {
           Image("work")
        }
        VStack{
            Text(activity.fields.activity)
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding(.bottom,10)
           
            
            // Image("eventImage")
             //   .resizable()
               // .aspectRatio(contentMode: .fill)
                //.frame(width: 150,height: 150)
                //.clipped()
                //.cornerRadius(150)
                //.padding(.bottom,75)
            
            Text("Start: \(activity.fields.start)")
                .padding(.bottom,10)
            Text("End: \(activity.fields.end)")
                .padding(.bottom,10)
            //if areThereSpeakers(speakers: activity.fields.speakerS){
            //    VStack{
            //        Text("Speakers :")
            //            .font(.title)
            //            .fontWeight(.semibold)
            //            .padding(.bottom,10)
            //            .padding(.top,10)
                
            //        ForEach(activity.fields.speakerS!, id:\.self){ speaker in
            //            Text(speaker)
            //
            //        }
            //    }
            //}
                
            Text("Room :")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.bottom,10)
                .padding(.top,10)
            Text(activity.fields.location)
                .padding(.bottom,10)
            
                
            Text("note: \(activity.fields.notes ?? "no notes")")
                .padding(.bottom,10)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .multilineTextAlignment(.center)
                .foregroundColor(.red)
            
            Spacer()
        }
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView(activity : Schedule(id :"99", fields: Fields(end: "12 p.m", activity: "Maths", type: "Course", speakerS: ["Moise, Adams"], start: "monday 9 a.m", location: "Efrei", notes: "something")))
    }
}

func areThereSpeakers(speakers: [String]?) -> Bool {
    if speakers?.isEmpty != nil{
        return true
    }
    return false
}
