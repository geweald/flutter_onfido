package com.fluencybank.flutter_onfido

public class Response(frontId: String, backId: String, faceId: String, faceVariant: String) {

    open inner class Identifiable(id: String) {
        var id = "default"

        init {
            this.id = id
        }
    }

    inner class Document {
        lateinit var front: Identifiable
        lateinit var back: Identifiable
    }

    inner class Face(id: String, variant: String) : Identifiable(id) {
        var variant: String

        init {
            this.variant = variant
        }
    }

    lateinit var document: Document
    lateinit var face: Face

    init {
        initDocument(frontId, backId)
        initFace(faceId, faceVariant)
    }

    private fun initDocument(frontId: String, backId: String) {
        if (frontId != null || backId != null) {
            document = Document()
            if (frontId != null) {
                document.front = Identifiable(frontId)
            }
            if (backId != null) {
                document.back = Identifiable(backId)
            }
        }
    }

    private fun initFace(faceId: String, faceVariant: String) {
        if (faceId != null || faceVariant != null) {
            face = Face(faceId, faceVariant)
        }
    }
}