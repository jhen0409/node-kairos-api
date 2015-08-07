require! {
  \node-fetch : fetch
  jsonschema: { Validator }
  \./schemas
}
v = new Validator!

class Karios
  # constructor
  (app_id, app_key) -> @auth = { app_id, app_key }

  # private funcs
  post = (url, headers, params) ->
    fetch do
      url
      {
        method: \POST
        headers: {
          'Content-Type': \application/json
          ...headers
        }
        ...do ->
          if params then body: JSON.stringify params else {}
      }
    .then (res) ->
      if res.status is 403
        return status: res.status, body: null
      res.json!.then (result) ->
        status: res.status, body: result

  # public funcs
  enroll: (params) ->
    (resolve, reject) <~ new Promise _
    # validate params
    valid = v.validate params, schemas.ENROLL
    return reject valid.errors if valid.errors.length
    # post
    url = \https://api.kairos.com/enroll
    resolve post url, @auth, params

  recognize: (params) ->
    (resolve, reject) <~ new Promise _
    # validate params
    valid = v.validate params, schemas.RECOGNIZE
    return reject valid.errors if valid.errors.length
    # post
    url = \https://api.kairos.com/recognize
    resolve post url, @auth, params

  detect: (params) ->
    (resolve, reject) <~ new Promise _
    # validate params
    valid = v.validate params, schemas.DETECT
    return reject valid.errors if valid.errors.length
    # post
    url = \https://api.kairos.com/detect
    resolve post url, @auth, params

  galleryListAll: ->
    (resolve, reject) <~ new Promise _
    # post
    url = \https://api.kairos.com/gallery/list_all
    resolve post url, @auth

  galleryView: (params) ->
    (resolve, reject) <~ new Promise _
    # validate params
    valid = v.validate params, schemas.GALLERY_VIEW
    return reject valid.errors if valid.errors.length
    # post
    url = \https://api.kairos.com/gallery/view
    resolve post url, @auth, params

  galleryRemove: (params) ->
    (resolve, reject) <~ new Promise _
    # validate params
    valid = v.validate params, schemas.GALLERY_REMOVE
    return reject valid.errors if valid.errors.length
    # post
    url = \https://api.kairos.com/gallery/remove
    resolve post url, @auth, params

  galleryRemoveSubject: (params) ->
    (resolve, reject) <~ new Promise _
    # validate params
    valid = v.validate params, schemas.GALLERY_REMOVE_SUBJECT
    return reject valid.errors if valid.errors.length
    # post
    url = \https://api.kairos.com/gallery/remove_subject
    resolve post url, @auth, params

module.exports = Karios