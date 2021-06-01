const { PrismaClient } = require("@prisma/client")
const { GraphQLServer } = require("graphql-yoga")
const  { GraphQLDateTime } = require("graphql-iso-date")

const typeDefs = `
  scalar DateTime
  
  type User {
    id:        String     
    email:     String
    password:  String
    active:    Boolean
    createdAt: DateTime!   
    updatedAt: DateTime!  
    role:      Role
    profile:   Profile
    itsystems: [Itsystem]
  }

  type Profile {
    id:        String 
    firstName: String
    lastName:  String
    phone:     String
    room:      Int
    bio:       String
    userId:    String
    user:      User!   
  }

  type Itsystem {
    id:            String   
    itSystemUsers: [User]
    sysInfo:       SysInfo
    permission :   String
  }

  type SysInfo {
    id :          String   
    name:         String
    active:       Boolean
    description:  String
    bisnessOwner: String
    adminstrator: String
    createdAt:    DateTime 
    updatedAt:    DateTime 
    itsystem:     Itsystem 
    itSystemId:   String   
    }

    enum Role {
     ADMIN
     ORDINARY
    }

    type Query {
        users:[User!]
        user(id: String!):User
    }

  `
const resolvers = {
    DateTime: GraphQLDateTime,

        Query:{
            users: async (parent, args, context, info)=>{
                return context.prisma.user.findMany({
                    include:{
                        itsystems: true,
                        profile: true
                    }
                })
            },
            user: async (parent, args, context, info)=>{
                const { id } = args
                return context.prisma.user.findUnique({
                    where: {
                        id: id
                    }
                })
            }
        }

}



const prisma = new PrismaClient()

const server = new GraphQLServer({
  typeDefs,
  resolvers,
  context(request) {
    //console.log(request.request.headers)
    return {
      prisma,
      request
    }
  }
})

const options = {
    port: 8000,
    
    playground: "/playground",
}

server.start(options, ({port}) => 
console.log(
    `Server started, listening on port ${port} for incoming requests.`
)
)


