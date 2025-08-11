#lang racket/base

;; ----------------------------------------------------------------------
;; THIS FILE IS AUTO-GENERATED. DO NOT EDIT MANUALLY.
;; Any manual changes will be lost.
;; ----------------------------------------------------------------------

(require "reqs.rkt")

(provide (all-defined-out))

(define (obs-get-persistent-data realm slotName)
  (send-request! 6 `(("requestType" . "GetPersistentData")
                     ("requestData" . ,(hasheq 'realm realm 'slotName slotName)))))

(define (obs-set-persistent-data realm slotName slotValue)
  (send-request! 6 `(("requestType" . "SetPersistentData")
                     ("requestData" . ,(hasheq 'realm realm 'slotName slotName 'slotValue slotValue)))))

(define (obs-get-scene-collection-list)
  (send-request! 6 `(("requestType" . "GetSceneCollectionList")
                     ("requestData" . ,(hasheq)))))

(define (obs-set-current-scene-collection sceneCollectionName)
  (send-request! 6 `(("requestType" . "SetCurrentSceneCollection")
                     ("requestData" . ,(hasheq 'sceneCollectionName sceneCollectionName)))))

(define (obs-create-scene-collection sceneCollectionName)
  (send-request! 6 `(("requestType" . "CreateSceneCollection")
                     ("requestData" . ,(hasheq 'sceneCollectionName sceneCollectionName)))))

(define (obs-get-profile-list)
  (send-request! 6 `(("requestType" . "GetProfileList")
                     ("requestData" . ,(hasheq)))))

(define (obs-set-current-profile profileName)
  (send-request! 6 `(("requestType" . "SetCurrentProfile")
                     ("requestData" . ,(hasheq 'profileName profileName)))))

(define (obs-create-profile profileName)
  (send-request! 6 `(("requestType" . "CreateProfile")
                     ("requestData" . ,(hasheq 'profileName profileName)))))

(define (obs-remove-profile profileName)
  (send-request! 6 `(("requestType" . "RemoveProfile")
                     ("requestData" . ,(hasheq 'profileName profileName)))))

(define (obs-get-profile-parameter parameterCategory parameterName)
  (send-request! 6 `(("requestType" . "GetProfileParameter")
                     ("requestData" . ,(hasheq 'parameterCategory parameterCategory 'parameterName parameterName)))))

(define (obs-set-profile-parameter parameterCategory parameterName parameterValue)
  (send-request! 6 `(("requestType" . "SetProfileParameter")
                     ("requestData" . ,(hasheq 'parameterCategory parameterCategory 'parameterName parameterName 'parameterValue parameterValue)))))

(define (obs-get-video-settings)
  (send-request! 6 `(("requestType" . "GetVideoSettings")
                     ("requestData" . ,(hasheq)))))

(define (obs-set-video-settings fpsNumerator fpsDenominator baseWidth baseHeight outputWidth outputHeight)
  (send-request! 6 `(("requestType" . "SetVideoSettings")
                     ("requestData" . ,(hasheq 'fpsNumerator fpsNumerator 'fpsDenominator fpsDenominator 'baseWidth baseWidth 'baseHeight baseHeight 'outputWidth outputWidth 'outputHeight outputHeight)))))

(define (obs-get-stream-service-settings)
  (send-request! 6 `(("requestType" . "GetStreamServiceSettings")
                     ("requestData" . ,(hasheq)))))

(define (obs-set-stream-service-settings streamServiceType streamServiceSettings)
  (send-request! 6 `(("requestType" . "SetStreamServiceSettings")
                     ("requestData" . ,(hasheq 'streamServiceType streamServiceType 'streamServiceSettings streamServiceSettings)))))

(define (obs-get-record-directory)
  (send-request! 6 `(("requestType" . "GetRecordDirectory")
                     ("requestData" . ,(hasheq)))))

(define (obs-set-record-directory recordDirectory)
  (send-request! 6 `(("requestType" . "SetRecordDirectory")
                     ("requestData" . ,(hasheq 'recordDirectory recordDirectory)))))

(define (obs-get-source-filter-kind-list)
  (send-request! 6 `(("requestType" . "GetSourceFilterKindList")
                     ("requestData" . ,(hasheq)))))

(define (obs-get-source-filter-list sourceName sourceUuid)
  (send-request! 6 `(("requestType" . "GetSourceFilterList")
                     ("requestData" . ,(hasheq 'sourceName sourceName 'sourceUuid sourceUuid)))))

(define (obs-get-source-filter-default-settings filterKind)
  (send-request! 6 `(("requestType" . "GetSourceFilterDefaultSettings")
                     ("requestData" . ,(hasheq 'filterKind filterKind)))))

(define (obs-create-source-filter sourceName sourceUuid filterName filterKind filterSettings)
  (send-request! 6 `(("requestType" . "CreateSourceFilter")
                     ("requestData" . ,(hasheq 'sourceName sourceName 'sourceUuid sourceUuid 'filterName filterName 'filterKind filterKind 'filterSettings filterSettings)))))

(define (obs-remove-source-filter sourceName sourceUuid filterName)
  (send-request! 6 `(("requestType" . "RemoveSourceFilter")
                     ("requestData" . ,(hasheq 'sourceName sourceName 'sourceUuid sourceUuid 'filterName filterName)))))

(define (obs-set-source-filter-name sourceName sourceUuid filterName newFilterName)
  (send-request! 6 `(("requestType" . "SetSourceFilterName")
                     ("requestData" . ,(hasheq 'sourceName sourceName 'sourceUuid sourceUuid 'filterName filterName 'newFilterName newFilterName)))))

(define (obs-get-source-filter sourceName sourceUuid filterName)
  (send-request! 6 `(("requestType" . "GetSourceFilter")
                     ("requestData" . ,(hasheq 'sourceName sourceName 'sourceUuid sourceUuid 'filterName filterName)))))

(define (obs-set-source-filter-index sourceName sourceUuid filterName filterIndex)
  (send-request! 6 `(("requestType" . "SetSourceFilterIndex")
                     ("requestData" . ,(hasheq 'sourceName sourceName 'sourceUuid sourceUuid 'filterName filterName 'filterIndex filterIndex)))))

(define (obs-set-source-filter-settings sourceName sourceUuid filterName filterSettings overlay)
  (send-request! 6 `(("requestType" . "SetSourceFilterSettings")
                     ("requestData" . ,(hasheq 'sourceName sourceName 'sourceUuid sourceUuid 'filterName filterName 'filterSettings filterSettings 'overlay overlay)))))

(define (obs-set-source-filter-enabled sourceName sourceUuid filterName filterEnabled)
  (send-request! 6 `(("requestType" . "SetSourceFilterEnabled")
                     ("requestData" . ,(hasheq 'sourceName sourceName 'sourceUuid sourceUuid 'filterName filterName 'filterEnabled filterEnabled)))))

(define (obs-get-version)
  (send-request! 6 `(("requestType" . "GetVersion")
                     ("requestData" . ,(hasheq)))))

(define (obs-get-stats)
  (send-request! 6 `(("requestType" . "GetStats")
                     ("requestData" . ,(hasheq)))))

(define (obs-broadcast-custom-event eventData)
  (send-request! 6 `(("requestType" . "BroadcastCustomEvent")
                     ("requestData" . ,(hasheq 'eventData eventData)))))

(define (obs-call-vendor-request vendorName requestType requestData)
  (send-request! 6 `(("requestType" . "CallVendorRequest")
                     ("requestData" . ,(hasheq 'vendorName vendorName 'requestType requestType 'requestData requestData)))))

(define (obs-get-hotkey-list)
  (send-request! 6 `(("requestType" . "GetHotkeyList")
                     ("requestData" . ,(hasheq)))))

(define (obs-trigger-hotkey-by-name hotkeyName contextName)
  (send-request! 6 `(("requestType" . "TriggerHotkeyByName")
                     ("requestData" . ,(hasheq 'hotkeyName hotkeyName 'contextName contextName)))))

(define (obs-trigger-hotkey-by-key-sequence keyId keyModifiers keyModifiers.shift keyModifiers.control keyModifiers.alt keyModifiers.command)
  (send-request! 6 `(("requestType" . "TriggerHotkeyByKeySequence")
                     ("requestData" . ,(hasheq 'keyId keyId 'keyModifiers keyModifiers 'keyModifiers.shift keyModifiers.shift 'keyModifiers.control keyModifiers.control 'keyModifiers.alt keyModifiers.alt 'keyModifiers.command keyModifiers.command)))))

(define (obs-sleep sleepMillis sleepFrames)
  (send-request! 6 `(("requestType" . "Sleep")
                     ("requestData" . ,(hasheq 'sleepMillis sleepMillis 'sleepFrames sleepFrames)))))

(define (obs-get-input-list inputKind)
  (send-request! 6 `(("requestType" . "GetInputList")
                     ("requestData" . ,(hasheq 'inputKind inputKind)))))

(define (obs-get-input-kind-list unversioned)
  (send-request! 6 `(("requestType" . "GetInputKindList")
                     ("requestData" . ,(hasheq 'unversioned unversioned)))))

(define (obs-get-special-inputs)
  (send-request! 6 `(("requestType" . "GetSpecialInputs")
                     ("requestData" . ,(hasheq)))))

(define (obs-create-input sceneName sceneUuid inputName inputKind inputSettings sceneItemEnabled)
  (send-request! 6 `(("requestType" . "CreateInput")
                     ("requestData" . ,(hasheq 'sceneName sceneName 'sceneUuid sceneUuid 'inputName inputName 'inputKind inputKind 'inputSettings inputSettings 'sceneItemEnabled sceneItemEnabled)))))

(define (obs-remove-input inputName inputUuid)
  (send-request! 6 `(("requestType" . "RemoveInput")
                     ("requestData" . ,(hasheq 'inputName inputName 'inputUuid inputUuid)))))

(define (obs-set-input-name inputName inputUuid newInputName)
  (send-request! 6 `(("requestType" . "SetInputName")
                     ("requestData" . ,(hasheq 'inputName inputName 'inputUuid inputUuid 'newInputName newInputName)))))

(define (obs-get-input-default-settings inputKind)
  (send-request! 6 `(("requestType" . "GetInputDefaultSettings")
                     ("requestData" . ,(hasheq 'inputKind inputKind)))))

(define (obs-get-input-settings inputName inputUuid)
  (send-request! 6 `(("requestType" . "GetInputSettings")
                     ("requestData" . ,(hasheq 'inputName inputName 'inputUuid inputUuid)))))

(define (obs-set-input-settings inputName inputUuid inputSettings overlay)
  (send-request! 6 `(("requestType" . "SetInputSettings")
                     ("requestData" . ,(hasheq 'inputName inputName 'inputUuid inputUuid 'inputSettings inputSettings 'overlay overlay)))))

(define (obs-get-input-mute inputName inputUuid)
  (send-request! 6 `(("requestType" . "GetInputMute")
                     ("requestData" . ,(hasheq 'inputName inputName 'inputUuid inputUuid)))))

(define (obs-set-input-mute inputName inputUuid inputMuted)
  (send-request! 6 `(("requestType" . "SetInputMute")
                     ("requestData" . ,(hasheq 'inputName inputName 'inputUuid inputUuid 'inputMuted inputMuted)))))

(define (obs-toggle-input-mute inputName inputUuid)
  (send-request! 6 `(("requestType" . "ToggleInputMute")
                     ("requestData" . ,(hasheq 'inputName inputName 'inputUuid inputUuid)))))

(define (obs-get-input-volume inputName inputUuid)
  (send-request! 6 `(("requestType" . "GetInputVolume")
                     ("requestData" . ,(hasheq 'inputName inputName 'inputUuid inputUuid)))))

(define (obs-set-input-volume inputName inputUuid inputVolumeMul inputVolumeDb)
  (send-request! 6 `(("requestType" . "SetInputVolume")
                     ("requestData" . ,(hasheq 'inputName inputName 'inputUuid inputUuid 'inputVolumeMul inputVolumeMul 'inputVolumeDb inputVolumeDb)))))

(define (obs-get-input-audio-balance inputName inputUuid)
  (send-request! 6 `(("requestType" . "GetInputAudioBalance")
                     ("requestData" . ,(hasheq 'inputName inputName 'inputUuid inputUuid)))))

(define (obs-set-input-audio-balance inputName inputUuid inputAudioBalance)
  (send-request! 6 `(("requestType" . "SetInputAudioBalance")
                     ("requestData" . ,(hasheq 'inputName inputName 'inputUuid inputUuid 'inputAudioBalance inputAudioBalance)))))

(define (obs-get-input-audio-sync-offset inputName inputUuid)
  (send-request! 6 `(("requestType" . "GetInputAudioSyncOffset")
                     ("requestData" . ,(hasheq 'inputName inputName 'inputUuid inputUuid)))))

(define (obs-set-input-audio-sync-offset inputName inputUuid inputAudioSyncOffset)
  (send-request! 6 `(("requestType" . "SetInputAudioSyncOffset")
                     ("requestData" . ,(hasheq 'inputName inputName 'inputUuid inputUuid 'inputAudioSyncOffset inputAudioSyncOffset)))))

(define (obs-get-input-audio-monitor-type inputName inputUuid)
  (send-request! 6 `(("requestType" . "GetInputAudioMonitorType")
                     ("requestData" . ,(hasheq 'inputName inputName 'inputUuid inputUuid)))))

(define (obs-set-input-audio-monitor-type inputName inputUuid monitorType)
  (send-request! 6 `(("requestType" . "SetInputAudioMonitorType")
                     ("requestData" . ,(hasheq 'inputName inputName 'inputUuid inputUuid 'monitorType monitorType)))))

(define (obs-get-input-audio-tracks inputName inputUuid)
  (send-request! 6 `(("requestType" . "GetInputAudioTracks")
                     ("requestData" . ,(hasheq 'inputName inputName 'inputUuid inputUuid)))))

(define (obs-set-input-audio-tracks inputName inputUuid inputAudioTracks)
  (send-request! 6 `(("requestType" . "SetInputAudioTracks")
                     ("requestData" . ,(hasheq 'inputName inputName 'inputUuid inputUuid 'inputAudioTracks inputAudioTracks)))))

(define (obs-get-input-deinterlace-mode inputName inputUuid)
  (send-request! 6 `(("requestType" . "GetInputDeinterlaceMode")
                     ("requestData" . ,(hasheq 'inputName inputName 'inputUuid inputUuid)))))

(define (obs-set-input-deinterlace-mode inputName inputUuid inputDeinterlaceMode)
  (send-request! 6 `(("requestType" . "SetInputDeinterlaceMode")
                     ("requestData" . ,(hasheq 'inputName inputName 'inputUuid inputUuid 'inputDeinterlaceMode inputDeinterlaceMode)))))

(define (obs-get-input-deinterlace-field-order inputName inputUuid)
  (send-request! 6 `(("requestType" . "GetInputDeinterlaceFieldOrder")
                     ("requestData" . ,(hasheq 'inputName inputName 'inputUuid inputUuid)))))

(define (obs-set-input-deinterlace-field-order inputName inputUuid inputDeinterlaceFieldOrder)
  (send-request! 6 `(("requestType" . "SetInputDeinterlaceFieldOrder")
                     ("requestData" . ,(hasheq 'inputName inputName 'inputUuid inputUuid 'inputDeinterlaceFieldOrder inputDeinterlaceFieldOrder)))))

(define (obs-get-input-properties-list-property-items inputName inputUuid propertyName)
  (send-request! 6 `(("requestType" . "GetInputPropertiesListPropertyItems")
                     ("requestData" . ,(hasheq 'inputName inputName 'inputUuid inputUuid 'propertyName propertyName)))))

(define (obs-press-input-properties-button inputName inputUuid propertyName)
  (send-request! 6 `(("requestType" . "PressInputPropertiesButton")
                     ("requestData" . ,(hasheq 'inputName inputName 'inputUuid inputUuid 'propertyName propertyName)))))

(define (obs-get-media-input-status inputName inputUuid)
  (send-request! 6 `(("requestType" . "GetMediaInputStatus")
                     ("requestData" . ,(hasheq 'inputName inputName 'inputUuid inputUuid)))))

(define (obs-set-media-input-cursor inputName inputUuid mediaCursor)
  (send-request! 6 `(("requestType" . "SetMediaInputCursor")
                     ("requestData" . ,(hasheq 'inputName inputName 'inputUuid inputUuid 'mediaCursor mediaCursor)))))

(define (obs-offset-media-input-cursor inputName inputUuid mediaCursorOffset)
  (send-request! 6 `(("requestType" . "OffsetMediaInputCursor")
                     ("requestData" . ,(hasheq 'inputName inputName 'inputUuid inputUuid 'mediaCursorOffset mediaCursorOffset)))))

(define (obs-trigger-media-input-action inputName inputUuid mediaAction)
  (send-request! 6 `(("requestType" . "TriggerMediaInputAction")
                     ("requestData" . ,(hasheq 'inputName inputName 'inputUuid inputUuid 'mediaAction mediaAction)))))

(define (obs-get-virtual-cam-status)
  (send-request! 6 `(("requestType" . "GetVirtualCamStatus")
                     ("requestData" . ,(hasheq)))))

(define (obs-toggle-virtual-cam)
  (send-request! 6 `(("requestType" . "ToggleVirtualCam")
                     ("requestData" . ,(hasheq)))))

(define (obs-start-virtual-cam)
  (send-request! 6 `(("requestType" . "StartVirtualCam")
                     ("requestData" . ,(hasheq)))))

(define (obs-stop-virtual-cam)
  (send-request! 6 `(("requestType" . "StopVirtualCam")
                     ("requestData" . ,(hasheq)))))

(define (obs-get-replay-buffer-status)
  (send-request! 6 `(("requestType" . "GetReplayBufferStatus")
                     ("requestData" . ,(hasheq)))))

(define (obs-toggle-replay-buffer)
  (send-request! 6 `(("requestType" . "ToggleReplayBuffer")
                     ("requestData" . ,(hasheq)))))

(define (obs-start-replay-buffer)
  (send-request! 6 `(("requestType" . "StartReplayBuffer")
                     ("requestData" . ,(hasheq)))))

(define (obs-stop-replay-buffer)
  (send-request! 6 `(("requestType" . "StopReplayBuffer")
                     ("requestData" . ,(hasheq)))))

(define (obs-save-replay-buffer)
  (send-request! 6 `(("requestType" . "SaveReplayBuffer")
                     ("requestData" . ,(hasheq)))))

(define (obs-get-last-replay-buffer-replay)
  (send-request! 6 `(("requestType" . "GetLastReplayBufferReplay")
                     ("requestData" . ,(hasheq)))))

(define (obs-get-output-list)
  (send-request! 6 `(("requestType" . "GetOutputList")
                     ("requestData" . ,(hasheq)))))

(define (obs-get-output-status outputName)
  (send-request! 6 `(("requestType" . "GetOutputStatus")
                     ("requestData" . ,(hasheq 'outputName outputName)))))

(define (obs-toggle-output outputName)
  (send-request! 6 `(("requestType" . "ToggleOutput")
                     ("requestData" . ,(hasheq 'outputName outputName)))))

(define (obs-start-output outputName)
  (send-request! 6 `(("requestType" . "StartOutput")
                     ("requestData" . ,(hasheq 'outputName outputName)))))

(define (obs-stop-output outputName)
  (send-request! 6 `(("requestType" . "StopOutput")
                     ("requestData" . ,(hasheq 'outputName outputName)))))

(define (obs-get-output-settings outputName)
  (send-request! 6 `(("requestType" . "GetOutputSettings")
                     ("requestData" . ,(hasheq 'outputName outputName)))))

(define (obs-set-output-settings outputName outputSettings)
  (send-request! 6 `(("requestType" . "SetOutputSettings")
                     ("requestData" . ,(hasheq 'outputName outputName 'outputSettings outputSettings)))))

(define (obs-get-record-status)
  (send-request! 6 `(("requestType" . "GetRecordStatus")
                     ("requestData" . ,(hasheq)))))

(define (obs-toggle-record)
  (send-request! 6 `(("requestType" . "ToggleRecord")
                     ("requestData" . ,(hasheq)))))

(define (obs-start-record)
  (send-request! 6 `(("requestType" . "StartRecord")
                     ("requestData" . ,(hasheq)))))

(define (obs-stop-record)
  (send-request! 6 `(("requestType" . "StopRecord")
                     ("requestData" . ,(hasheq)))))

(define (obs-toggle-record-pause)
  (send-request! 6 `(("requestType" . "ToggleRecordPause")
                     ("requestData" . ,(hasheq)))))

(define (obs-pause-record)
  (send-request! 6 `(("requestType" . "PauseRecord")
                     ("requestData" . ,(hasheq)))))

(define (obs-resume-record)
  (send-request! 6 `(("requestType" . "ResumeRecord")
                     ("requestData" . ,(hasheq)))))

(define (obs-split-record-file)
  (send-request! 6 `(("requestType" . "SplitRecordFile")
                     ("requestData" . ,(hasheq)))))

(define (obs-create-record-chapter chapterName)
  (send-request! 6 `(("requestType" . "CreateRecordChapter")
                     ("requestData" . ,(hasheq 'chapterName chapterName)))))

(define (obs-get-scene-item-list sceneName sceneUuid)
  (send-request! 6 `(("requestType" . "GetSceneItemList")
                     ("requestData" . ,(hasheq 'sceneName sceneName 'sceneUuid sceneUuid)))))

(define (obs-get-group-scene-item-list sceneName sceneUuid)
  (send-request! 6 `(("requestType" . "GetGroupSceneItemList")
                     ("requestData" . ,(hasheq 'sceneName sceneName 'sceneUuid sceneUuid)))))

(define (obs-get-scene-item-id sceneName sceneUuid sourceName searchOffset)
  (send-request! 6 `(("requestType" . "GetSceneItemId")
                     ("requestData" . ,(hasheq 'sceneName sceneName 'sceneUuid sceneUuid 'sourceName sourceName 'searchOffset searchOffset)))))

(define (obs-get-scene-item-source sceneName sceneUuid sceneItemId)
  (send-request! 6 `(("requestType" . "GetSceneItemSource")
                     ("requestData" . ,(hasheq 'sceneName sceneName 'sceneUuid sceneUuid 'sceneItemId sceneItemId)))))

(define (obs-create-scene-item sceneName sceneUuid sourceName sourceUuid sceneItemEnabled)
  (send-request! 6 `(("requestType" . "CreateSceneItem")
                     ("requestData" . ,(hasheq 'sceneName sceneName 'sceneUuid sceneUuid 'sourceName sourceName 'sourceUuid sourceUuid 'sceneItemEnabled sceneItemEnabled)))))

(define (obs-remove-scene-item sceneName sceneUuid sceneItemId)
  (send-request! 6 `(("requestType" . "RemoveSceneItem")
                     ("requestData" . ,(hasheq 'sceneName sceneName 'sceneUuid sceneUuid 'sceneItemId sceneItemId)))))

(define (obs-duplicate-scene-item sceneName sceneUuid sceneItemId destinationSceneName destinationSceneUuid)
  (send-request! 6 `(("requestType" . "DuplicateSceneItem")
                     ("requestData" . ,(hasheq 'sceneName sceneName 'sceneUuid sceneUuid 'sceneItemId sceneItemId 'destinationSceneName destinationSceneName 'destinationSceneUuid destinationSceneUuid)))))

(define (obs-get-scene-item-transform sceneName sceneUuid sceneItemId)
  (send-request! 6 `(("requestType" . "GetSceneItemTransform")
                     ("requestData" . ,(hasheq 'sceneName sceneName 'sceneUuid sceneUuid 'sceneItemId sceneItemId)))))

(define (obs-set-scene-item-transform sceneName sceneUuid sceneItemId sceneItemTransform)
  (send-request! 6 `(("requestType" . "SetSceneItemTransform")
                     ("requestData" . ,(hasheq 'sceneName sceneName 'sceneUuid sceneUuid 'sceneItemId sceneItemId 'sceneItemTransform sceneItemTransform)))))

(define (obs-get-scene-item-enabled sceneName sceneUuid sceneItemId)
  (send-request! 6 `(("requestType" . "GetSceneItemEnabled")
                     ("requestData" . ,(hasheq 'sceneName sceneName 'sceneUuid sceneUuid 'sceneItemId sceneItemId)))))

(define (obs-set-scene-item-enabled sceneName sceneUuid sceneItemId sceneItemEnabled)
  (send-request! 6 `(("requestType" . "SetSceneItemEnabled")
                     ("requestData" . ,(hasheq 'sceneName sceneName 'sceneUuid sceneUuid 'sceneItemId sceneItemId 'sceneItemEnabled sceneItemEnabled)))))

(define (obs-get-scene-item-locked sceneName sceneUuid sceneItemId)
  (send-request! 6 `(("requestType" . "GetSceneItemLocked")
                     ("requestData" . ,(hasheq 'sceneName sceneName 'sceneUuid sceneUuid 'sceneItemId sceneItemId)))))

(define (obs-set-scene-item-locked sceneName sceneUuid sceneItemId sceneItemLocked)
  (send-request! 6 `(("requestType" . "SetSceneItemLocked")
                     ("requestData" . ,(hasheq 'sceneName sceneName 'sceneUuid sceneUuid 'sceneItemId sceneItemId 'sceneItemLocked sceneItemLocked)))))

(define (obs-get-scene-item-index sceneName sceneUuid sceneItemId)
  (send-request! 6 `(("requestType" . "GetSceneItemIndex")
                     ("requestData" . ,(hasheq 'sceneName sceneName 'sceneUuid sceneUuid 'sceneItemId sceneItemId)))))

(define (obs-set-scene-item-index sceneName sceneUuid sceneItemId sceneItemIndex)
  (send-request! 6 `(("requestType" . "SetSceneItemIndex")
                     ("requestData" . ,(hasheq 'sceneName sceneName 'sceneUuid sceneUuid 'sceneItemId sceneItemId 'sceneItemIndex sceneItemIndex)))))

(define (obs-get-scene-item-blend-mode sceneName sceneUuid sceneItemId)
  (send-request! 6 `(("requestType" . "GetSceneItemBlendMode")
                     ("requestData" . ,(hasheq 'sceneName sceneName 'sceneUuid sceneUuid 'sceneItemId sceneItemId)))))

(define (obs-set-scene-item-blend-mode sceneName sceneUuid sceneItemId sceneItemBlendMode)
  (send-request! 6 `(("requestType" . "SetSceneItemBlendMode")
                     ("requestData" . ,(hasheq 'sceneName sceneName 'sceneUuid sceneUuid 'sceneItemId sceneItemId 'sceneItemBlendMode sceneItemBlendMode)))))

(define (obs-get-scene-list)
  (send-request! 6 `(("requestType" . "GetSceneList")
                     ("requestData" . ,(hasheq)))))

(define (obs-get-group-list)
  (send-request! 6 `(("requestType" . "GetGroupList")
                     ("requestData" . ,(hasheq)))))

(define (obs-get-current-program-scene)
  (send-request! 6 `(("requestType" . "GetCurrentProgramScene")
                     ("requestData" . ,(hasheq)))))

(define (obs-set-current-program-scene sceneName sceneUuid)
  (send-request! 6 `(("requestType" . "SetCurrentProgramScene")
                     ("requestData" . ,(hasheq 'sceneName sceneName 'sceneUuid sceneUuid)))))

(define (obs-get-current-preview-scene)
  (send-request! 6 `(("requestType" . "GetCurrentPreviewScene")
                     ("requestData" . ,(hasheq)))))

(define (obs-set-current-preview-scene sceneName sceneUuid)
  (send-request! 6 `(("requestType" . "SetCurrentPreviewScene")
                     ("requestData" . ,(hasheq 'sceneName sceneName 'sceneUuid sceneUuid)))))

(define (obs-create-scene sceneName)
  (send-request! 6 `(("requestType" . "CreateScene")
                     ("requestData" . ,(hasheq 'sceneName sceneName)))))

(define (obs-remove-scene sceneName sceneUuid)
  (send-request! 6 `(("requestType" . "RemoveScene")
                     ("requestData" . ,(hasheq 'sceneName sceneName 'sceneUuid sceneUuid)))))

(define (obs-set-scene-name sceneName sceneUuid newSceneName)
  (send-request! 6 `(("requestType" . "SetSceneName")
                     ("requestData" . ,(hasheq 'sceneName sceneName 'sceneUuid sceneUuid 'newSceneName newSceneName)))))

(define (obs-get-scene-scene-transition-override sceneName sceneUuid)
  (send-request! 6 `(("requestType" . "GetSceneSceneTransitionOverride")
                     ("requestData" . ,(hasheq 'sceneName sceneName 'sceneUuid sceneUuid)))))

(define (obs-set-scene-scene-transition-override sceneName sceneUuid transitionName transitionDuration)
  (send-request! 6 `(("requestType" . "SetSceneSceneTransitionOverride")
                     ("requestData" . ,(hasheq 'sceneName sceneName 'sceneUuid sceneUuid 'transitionName transitionName 'transitionDuration transitionDuration)))))

(define (obs-get-source-active sourceName sourceUuid)
  (send-request! 6 `(("requestType" . "GetSourceActive")
                     ("requestData" . ,(hasheq 'sourceName sourceName 'sourceUuid sourceUuid)))))

(define (obs-get-source-screenshot sourceName sourceUuid imageFormat imageWidth imageHeight imageCompressionQuality)
  (send-request! 6 `(("requestType" . "GetSourceScreenshot")
                     ("requestData" . ,(hasheq 'sourceName sourceName 'sourceUuid sourceUuid 'imageFormat imageFormat 'imageWidth imageWidth 'imageHeight imageHeight 'imageCompressionQuality imageCompressionQuality)))))

(define (obs-save-source-screenshot sourceName sourceUuid imageFormat imageFilePath imageWidth imageHeight imageCompressionQuality)
  (send-request! 6 `(("requestType" . "SaveSourceScreenshot")
                     ("requestData" . ,(hasheq 'sourceName sourceName 'sourceUuid sourceUuid 'imageFormat imageFormat 'imageFilePath imageFilePath 'imageWidth imageWidth 'imageHeight imageHeight 'imageCompressionQuality imageCompressionQuality)))))

(define (obs-get-stream-status)
  (send-request! 6 `(("requestType" . "GetStreamStatus")
                     ("requestData" . ,(hasheq)))))

(define (obs-toggle-stream)
  (send-request! 6 `(("requestType" . "ToggleStream")
                     ("requestData" . ,(hasheq)))))

(define (obs-start-stream)
  (send-request! 6 `(("requestType" . "StartStream")
                     ("requestData" . ,(hasheq)))))

(define (obs-stop-stream)
  (send-request! 6 `(("requestType" . "StopStream")
                     ("requestData" . ,(hasheq)))))

(define (obs-send-stream-caption captionText)
  (send-request! 6 `(("requestType" . "SendStreamCaption")
                     ("requestData" . ,(hasheq 'captionText captionText)))))

(define (obs-get-transition-kind-list)
  (send-request! 6 `(("requestType" . "GetTransitionKindList")
                     ("requestData" . ,(hasheq)))))

(define (obs-get-scene-transition-list)
  (send-request! 6 `(("requestType" . "GetSceneTransitionList")
                     ("requestData" . ,(hasheq)))))

(define (obs-get-current-scene-transition)
  (send-request! 6 `(("requestType" . "GetCurrentSceneTransition")
                     ("requestData" . ,(hasheq)))))

(define (obs-set-current-scene-transition transitionName)
  (send-request! 6 `(("requestType" . "SetCurrentSceneTransition")
                     ("requestData" . ,(hasheq 'transitionName transitionName)))))

(define (obs-set-current-scene-transition-duration transitionDuration)
  (send-request! 6 `(("requestType" . "SetCurrentSceneTransitionDuration")
                     ("requestData" . ,(hasheq 'transitionDuration transitionDuration)))))

(define (obs-set-current-scene-transition-settings transitionSettings overlay)
  (send-request! 6 `(("requestType" . "SetCurrentSceneTransitionSettings")
                     ("requestData" . ,(hasheq 'transitionSettings transitionSettings 'overlay overlay)))))

(define (obs-get-current-scene-transition-cursor)
  (send-request! 6 `(("requestType" . "GetCurrentSceneTransitionCursor")
                     ("requestData" . ,(hasheq)))))

(define (obs-trigger-studio-mode-transition)
  (send-request! 6 `(("requestType" . "TriggerStudioModeTransition")
                     ("requestData" . ,(hasheq)))))

(define (obs-set-tbar-position position release)
  (send-request! 6 `(("requestType" . "SetTBarPosition")
                     ("requestData" . ,(hasheq 'position position 'release release)))))

(define (obs-get-studio-mode-enabled)
  (send-request! 6 `(("requestType" . "GetStudioModeEnabled")
                     ("requestData" . ,(hasheq)))))

(define (obs-set-studio-mode-enabled studioModeEnabled)
  (send-request! 6 `(("requestType" . "SetStudioModeEnabled")
                     ("requestData" . ,(hasheq 'studioModeEnabled studioModeEnabled)))))

(define (obs-open-input-properties-dialog inputName inputUuid)
  (send-request! 6 `(("requestType" . "OpenInputPropertiesDialog")
                     ("requestData" . ,(hasheq 'inputName inputName 'inputUuid inputUuid)))))

(define (obs-open-input-filters-dialog inputName inputUuid)
  (send-request! 6 `(("requestType" . "OpenInputFiltersDialog")
                     ("requestData" . ,(hasheq 'inputName inputName 'inputUuid inputUuid)))))

(define (obs-open-input-interact-dialog inputName inputUuid)
  (send-request! 6 `(("requestType" . "OpenInputInteractDialog")
                     ("requestData" . ,(hasheq 'inputName inputName 'inputUuid inputUuid)))))

(define (obs-get-monitor-list)
  (send-request! 6 `(("requestType" . "GetMonitorList")
                     ("requestData" . ,(hasheq)))))

(define (obs-open-video-mix-projector videoMixType monitorIndex projectorGeometry)
  (send-request! 6 `(("requestType" . "OpenVideoMixProjector")
                     ("requestData" . ,(hasheq 'videoMixType videoMixType 'monitorIndex monitorIndex 'projectorGeometry projectorGeometry)))))

(define (obs-open-source-projector sourceName sourceUuid monitorIndex projectorGeometry)
  (send-request! 6 `(("requestType" . "OpenSourceProjector")
                     ("requestData" . ,(hasheq 'sourceName sourceName 'sourceUuid sourceUuid 'monitorIndex monitorIndex 'projectorGeometry projectorGeometry)))))
