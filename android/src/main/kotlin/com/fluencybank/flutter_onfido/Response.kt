package com.fluencybank.flutter_onfido

class Response(frontId: String?, backId: String?, faceId: String?, faceVariant: String?) {

    open inner class Identifiable(id: String?) {
        var id: String = "default"

        init {
            if (id != null) {
                this.id = id
            }
        }
    }

    inner class Document {
        var front: Identifiable? = null
        var back: Identifiable? = null
    }

    inner class Face(id: String?, variant: String?) : Identifiable(id) {
        var variant: String? = null

        init {
            if (variant != null) {
                this.variant = variant
            }
        }
    }

    var document: Document? = null
    var face: Face? = null

    init {
        initDocument(frontId, backId)
        initFace(faceId, faceVariant)
    }

    private fun initDocument(frontId: String?, backId: String?) {
        if (frontId != null || backId != null) {
            document = Document()
            if (frontId != null) {
                document!!.front = Identifiable(frontId)
            }
            if (backId != null) {
                document!!.back = Identifiable(backId)
            }
        }
    }

    private fun initFace(faceId: String?, faceVariant: String?) {
        if (faceId != null || faceVariant != null) {
            face = Face(faceId, faceVariant)
        }
    }

    fun toMap(): HashMap<String, Any> {
        val map: HashMap<String, Any> = HashMap()
        if (document != null) {
            map.put("document", HashMap<String, Any>())
            if (document!!.front != null) {
                (map["document"] as HashMap<String, Any>)["front"] = hashMapOf("id" to document!!.front?.id)
            }
            if (document!!.back != null) {
                (map["document"] as HashMap<String, Any>)["back"] = hashMapOf("id" to document!!.back?.id)
            }
        }
        if (face != null) {
            map.put("face", hashMapOf("variant" to face!!.variant, "id" to face!!.id))
        }
        return map
    }
}