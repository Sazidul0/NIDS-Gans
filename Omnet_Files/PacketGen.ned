import inet.node.inet.StandardHost;
import inet.node.ethernet.EthernetSwitch;
import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;

network FiveNodeNetwork
{
    parameters:
        int numClients = default(3);

    submodules:
        configurator: Ipv4NetworkConfigurator {
            @display("p=100,200");
        }

        switch0: EthernetSwitch {
            @display("p=400,200");
            gates:
                ethg[32];
        }

        server: StandardHost {
            @display("p=150,100");
        }

        attacker: StandardHost {
            @display("p=150,350");
        }

        client[numClients]: StandardHost {
            @display("p=650,100;is=s");
        }

    connections allowunconnected:
        for i = 0 .. numClients-1 {
            client[i].ethg++ <--> { datarate = 100Mbps; } <--> switch0.ethg++;
        }

        server.ethg++   <--> { datarate = 100Mbps; } <--> switch0.ethg++;
        attacker.ethg++ <--> { datarate = 100Mbps; } <--> switch0.ethg++;
}