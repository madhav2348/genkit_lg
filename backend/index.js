import { startFlowServer } from "@genkit-ai/express";

startFlowServer({ port: 2222, cors: { origin: "*" }, flows: [] });
