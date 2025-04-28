import { z } from "genkit";

const inputSchema = z.object({
  location: z.string().describe("Input location"),
});

const outputSchema = z.object({
  location: z.string().describe('Name of Location'),
  latitude: z.number().describe('Latitude'),
  longitude: z.number().describe('Longitude'),
  description: z.string().describe('Description'),
  intresting_facts: z.array(z.string()).describe('List of Intresting facts'),
});

