package com.fluencybank.flutter_onfido

import java.lang.reflect.Field

class Response(frontId: String?, backId: String?, faceId: String?, faceVariant: String?) {

    open inner class Identifiable(id: String?) {
        var id = "default"

        init {
            if (id != null) {
                this.id = id
            }
        }
    }

    inner class Document {
        lateinit var front: Identifiable
        lateinit var back: Identifiable
    }

    inner class Face(id: String?, variant: String?) : Identifiable(id) {
        lateinit var variant: String

        init {
            if (variant != null) {
                this.variant = variant
            }
        }
    }

    lateinit var document: Document
    lateinit var face: Face

    init {
        initDocument(frontId, backId)
        initFace(faceId, faceVariant)
    }

    private fun initDocument(frontId: String?, backId: String?) {
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

    private fun initFace(faceId: String?, faceVariant: String?) {
        if (faceId != null || faceVariant != null) {
            face = Face(faceId, faceVariant)
        }
    }

    companion object {
        @JvmStatic
        fun convertPublicFieldsToMap(o: Any): HashMap<String, Any> {
            val map: HashMap<String, Any> = HashMap();
            val declaredFields: Array<Field> = o.javaClass.fields;
            for (field in declaredFields) {
                val key: String = field.getName()
                val value: Any = field.get(o)
                if (value is Iterable<*>) {
                    // noop: This is currently not supported.
                } else if (value is Boolean) {
                    map.put(key, value)
                } else {
                    map.put(key, convertPublicFieldsToMap(value))
                }
            }
            return map
        }
    }
}