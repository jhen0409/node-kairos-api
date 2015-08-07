select_enum = <[ FACE EYES FULL SETPOSE ]>

module.exports =

  ENROLL:
    id: \/enroll
    type: \object
    properties:
      image:            type: \string
      subject_id:       type: \string
      gallery_name:     type: \string
      minHeadScale:     type: \number, minimum: 0.015, maximum: 0.5
      selector:         enum: select_enum
      multiple_faces:   type: \boolean
    required: <[ image subject_id gallery_name ]>

  RECOGNIZE:
    id: \/recognize
    type: \object
    properties:
      image:            type: \string
      gallery_name:     type: \string
      minHeadScale:     type: \number, minimum: 0.015, maximum: 0.5
      selector:         enum: select_enum
      threshold:        type: \number, minimum: 0.0, maximum: 1.0
      max_num_results:  type: \number
    required: <[ image gallery_name ]>

  DETECT:
    id: \/detect
    type: \object
    properties:
      image:            type: \string
      selector:         enum: select_enum
      minHeadScale:     type: \number, minimum: 0.015, maximum: 0.5
    required: <[ image ]>

  # GALLERY_LIST_ALL no params

  GALLERY_VIEW:
    id: \/galleryView
    type: \object
    properties:
      gallery_name:     type: \string
    required: <[ gallery_name ]>

  GALLERY_REMOVE:
    id: \/galleryRemove
    type: \object
    properties:
      gallery_name:     type: \string
    required: <[ gallery_name ]>

  GALLERY_REMOVE_SUBJECT:
    id: \/galleryRemoveSubject
    type: \object
    properties:
      subject_id:       type: \string
      gallery_name:     type: \string
    required: <[ subject_id gallery_name ]>