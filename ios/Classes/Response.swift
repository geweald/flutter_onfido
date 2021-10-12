import Foundation
import Onfido

func createResponse(_ results: [OnfidoResult], faceVariant: String?) -> [String: [String: Any]] {
  var jsonResponse = [String: [String: Any]]()

  let document: [OnfidoResult]? = results.filter({ result in
    if case OnfidoResult.document = result { return true }
    return false;
  });

  let onfidoResult: OnfidoResult? = document?.first

  let face: OnfidoResult? = results.filter({ result in
    if case OnfidoResult.face = result { return true }
    return false
  }).first

  if let documentUnwrapped = onfidoResult, case OnfidoResult.document(let documentResponse) = documentUnwrapped {
      jsonResponse["document"] = ["front": ["id": documentResponse.front.id]]

      if let back = documentResponse.back {
          jsonResponse["document"]?["back"] = ["id": back.id]
      }
  }

  if let faceUnwrapped = face, case OnfidoResult.face(let faceResponse) = faceUnwrapped {
    jsonResponse["face"] = ["id": faceResponse.id, "variant": faceVariant!]
  }

  return jsonResponse
}
