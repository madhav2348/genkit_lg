export function extractJsonFromCodeBlock(responseString) {
    const regex = /```json\s*([\s\S]*?)\s*```/;
    const match = responseString.match(regex);
    if (match && match[1]) {
      return JSON.parse(match[1].trim());
    }
    return null;
  }
  