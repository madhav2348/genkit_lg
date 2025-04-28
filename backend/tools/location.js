import { z } from "genkit";
import { ai } from "../ai";

async function GetLatitudeLongitude() {

  try {
    const data = await response.json();

    if (data.length >= 1) {
      // data successfully came back.
      const locationObject = data[0];
      return { lat: locationObject.lat, long: locationObject.lon };
    }

    throw new Error("Unable to get latitude and longitude.");
  } catch (error) {
    throw new Error("Error fetching latitude and longitude:", error);
  }
};

const getLocation = ai.defineTool({
  name: "getLocation",
  description: "A tool to get Location , Latitude , Longitude ",
  inputSchema: z.object({
    location: z.string().describe("The name of the location"),
  }),
  outputSchema: {
    schema: z.object({
      latitude: z.number().describe("Latitude"),
      longitude: z.number().describe("Longitude"),
    }),
  },
  async(input) {},
});
