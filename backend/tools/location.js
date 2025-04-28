import { z } from "genkit";
import { ai } from "../ai.js";
import { extractJsonFromCodeBlock } from "./convert.js";

async function GetLatitudeLongitude(location) {
  try {
    const { response } = await ai.generate(
      `Give me a json object of PLACE ${location} Latitude, longitude, description and intresting_facts`
    );
    const data = extractJsonFromCodeBlock(response);

    if (data.length >= 1) {
      return {
        lat: data.latitude,
        long: data.longitude,
        desc: data.description,
        facts: data.intresting_facts,
      };
    }

    throw new Error("Unable to get latitude and longitude.");
  } catch (error) {
    throw new Error("Error fetching latitude and longitude:", error);
  }
}

const getLocation = ai.defineTool(
  {
    name: "getLocation",
    description: "A tool to get Location , Latitude , Longitude ",
    inputSchema: z.object({
      location: z.string().describe("The name of the location"),
    }),
    outputSchema: {
      schema: z.object({
        latitude: z.number().describe("Latitude"),
        longitude: z.number().describe("Longitude"),
        description: z.string().describe("Description"),
        intresting_facts: z
          .array(z.string())
          .describe("List of Intresting facts"),
      }),
    },
  },
  async (input) => await GetLatitudeLongitude(input.location)
);

export { getLocation };
