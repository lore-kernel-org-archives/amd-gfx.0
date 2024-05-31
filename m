Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BAA9C27C54
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 12:53:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E1C710E38D;
	Mon,  3 Jun 2024 12:53:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="PTfNWfYy";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7006A10E16D
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 17:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zTh2KnqZhSXOKeLYDBSjxyZ41LpariZ0KtPLE6alTPg=; b=PTfNWfYynMnZUYohfhJowfW352
 Av0nqYOEj2zW3h2SyI7KvNr14IzpG6NI6vYFmdDndEbLMnEFISymU16yZYxjPFnS32EATVKr6suGJ
 2ogCz5p36dbdCjy/rhVct5pbzTvqHjcGmM25zm3GGo4MFWytf2voV2fEkbI8zPC9Af6MCGtFqz3LY
 FPOO1aHWaFYXNIjlivIyDDoUvsTzK8cLT3gP7xLZwA1eMHlM11aL3WYaHCQz+fiDhcZESeKqhik6F
 Tflq9SYnv+N0GdEB8fVSWAQ0pE+x4Esdijsu2+hhwJzVtK9bMwGSuzX3kHQN99Bx5oGrYWh4QHFiZ
 jJzEmXkw==;
Received: from [84.69.19.168] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1sD5mM-00F2bz-60; Fri, 31 May 2024 19:10:58 +0200
Message-ID: <b43bd153-890c-4575-874e-c183287ff446@igalia.com>
Date: Fri, 31 May 2024 18:10:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Convert some legacy DRM debug macros
 into appropriate categories
Content-Language: en-GB
To: Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com
References: <20240528125711.86488-1-tursulin@igalia.com>
 <05859b28-e4ef-43f9-a540-7635dcd329f0@amd.com>
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <05859b28-e4ef-43f9-a540-7635dcd329f0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 03 Jun 2024 12:52:59 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 30/05/2024 20:57, Hamza Mahfooz wrote:
> On 5/28/24 08:57, Tvrtko Ursulin wrote:
>> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>
>> Currently when one enables driver debugging dmesg gets spammed, at I
>> suspect vblank rate, with messages like:
>>
>>   [drm:amdgpu_dm_atomic_check [amdgpu]] MPO enablement requested on 
>> crtc:[00000000f073c3bb]
>>
>> Fix if by converting some logging from deprecated and incorrect
>> DRM_DEBUG_DRIVER to drm_dbg_atomic. Plus some localized drive-by changes
>> to drm_dbg_kms.
>>
>> By no means an exhaustive conversion but at least it allows turning on
>> driver debug selectively.
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> 
> Applied, thanks!

Oh so fast for this one, thank you!

Regards,

Tvrtko

> 
>> ---
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 73 ++++++++++---------
>>   1 file changed, 39 insertions(+), 34 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c 
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 975feb1c69b8..bf9db488eee6 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -2363,13 +2363,13 @@ static int 
>> detect_mst_link_for_all_connectors(struct drm_device *dev)
>>           aconnector = to_amdgpu_dm_connector(connector);
>>           if (aconnector->dc_link->type == dc_connection_mst_branch &&
>>               aconnector->mst_mgr.aux) {
>> -            DRM_DEBUG_DRIVER("DM_MST: starting TM on aconnector: %p 
>> [id: %d]\n",
>> +            drm_dbg_kms(dev, "DM_MST: starting TM on aconnector: %p 
>> [id: %d]\n",
>>                        aconnector,
>>                        aconnector->base.base.id);
>>               ret = 
>> drm_dp_mst_topology_mgr_set_mst(&aconnector->mst_mgr, true);
>>               if (ret < 0) {
>> -                DRM_ERROR("DM_MST: Failed to start MST\n");
>> +                drm_err(dev, "DM_MST: Failed to start MST\n");
>>                   aconnector->dc_link->type =
>>                       dc_connection_single;
>>                   ret = 
>> dm_helpers_dp_mst_stop_top_mgr(aconnector->dc_link->ctx,
>> @@ -3298,15 +3298,15 @@ void amdgpu_dm_update_connector_after_detect(
>>            * We got a DP short pulse (Link Loss, DP CTS, etc...).
>>            * Do nothing!!
>>            */
>> -        DRM_DEBUG_DRIVER("DCHPD: connector_id=%d: dc_sink didn't 
>> change.\n",
>> -                aconnector->connector_id);
>> +        drm_dbg_kms(dev, "DCHPD: connector_id=%d: dc_sink didn't 
>> change.\n",
>> +                 aconnector->connector_id);
>>           if (sink)
>>               dc_sink_release(sink);
>>           return;
>>       }
>> -    DRM_DEBUG_DRIVER("DCHPD: connector_id=%d: Old sink=%p New 
>> sink=%p\n",
>> -        aconnector->connector_id, aconnector->dc_sink, sink);
>> +    drm_dbg_kms(dev, "DCHPD: connector_id=%d: Old sink=%p New 
>> sink=%p\n",
>> +            aconnector->connector_id, aconnector->dc_sink, sink);
>>       mutex_lock(&dev->mode_config.mutex);
>> @@ -9191,7 +9191,9 @@ static void amdgpu_dm_commit_streams(struct 
>> drm_atomic_state *state,
>>           if (amdgpu_dm_crtc_modeset_required(new_crtc_state, 
>> dm_new_crtc_state->stream, dm_old_crtc_state->stream)) {
>> -            DRM_DEBUG_ATOMIC("Atomic commit: SET crtc id %d: [%p]\n", 
>> acrtc->crtc_id, acrtc);
>> +            drm_dbg_atomic(dev,
>> +                       "Atomic commit: SET crtc id %d: [%p]\n",
>> +                       acrtc->crtc_id, acrtc);
>>               if (!dm_new_crtc_state->stream) {
>>                   /*
>> @@ -9209,8 +9211,9 @@ static void amdgpu_dm_commit_streams(struct 
>> drm_atomic_state *state,
>>                    * have a sink to keep the pipe running so that
>>                    * hw state is consistent with the sw state
>>                    */
>> -                DRM_DEBUG_DRIVER("%s: Failed to create new stream for 
>> crtc %d\n",
>> -                        __func__, acrtc->base.base.id);
>> +                drm_dbg_atomic(dev,
>> +                           "Failed to create new stream for crtc %d\n",
>> +                        acrtc->base.base.id);
>>                   continue;
>>               }
>> @@ -9224,7 +9227,9 @@ static void amdgpu_dm_commit_streams(struct 
>> drm_atomic_state *state,
>>               crtc->hwmode = new_crtc_state->mode;
>>               mode_set_reset_required = true;
>>           } else if (modereset_required(new_crtc_state)) {
>> -            DRM_DEBUG_ATOMIC("Atomic commit: RESET. crtc id 
>> %d:[%p]\n", acrtc->crtc_id, acrtc);
>> +            drm_dbg_atomic(dev,
>> +                       "Atomic commit: RESET. crtc id %d:[%p]\n",
>> +                       acrtc->crtc_id, acrtc);
>>               /* i.e. reset mode */
>>               if (dm_old_crtc_state->stream)
>>                   remove_stream(adev, acrtc, dm_old_crtc_state->stream);
>> @@ -9679,7 +9684,7 @@ static void amdgpu_dm_atomic_commit_tail(struct 
>> drm_atomic_state *state)
>>   #endif
>>                   if (amdgpu_dm_crtc_configure_crc_source(
>>                       crtc, dm_new_crtc_state, cur_crc_src))
>> -                    DRM_DEBUG_DRIVER("Failed to configure crc source");
>> +                    drm_dbg_atomic(dev, "Failed to configure crc 
>> source");
>>               }
>>           }
>>   #endif
>> @@ -10851,7 +10856,7 @@ static int amdgpu_dm_atomic_check(struct 
>> drm_device *dev,
>>       ret = drm_atomic_helper_check_modeset(dev, state);
>>       if (ret) {
>> -        DRM_DEBUG_DRIVER("drm_atomic_helper_check_modeset() failed\n");
>> +        drm_dbg_atomic(dev, "drm_atomic_helper_check_modeset() 
>> failed\n");
>>           goto fail;
>>       }
>> @@ -10866,7 +10871,7 @@ static int amdgpu_dm_atomic_check(struct 
>> drm_device *dev,
>>           new_crtc_state = drm_atomic_get_crtc_state(state, 
>> new_con_state->crtc);
>>           if (IS_ERR(new_crtc_state)) {
>> -            DRM_DEBUG_DRIVER("drm_atomic_get_crtc_state() failed\n");
>> +            drm_dbg_atomic(dev, "drm_atomic_get_crtc_state() failed\n");
>>               ret = PTR_ERR(new_crtc_state);
>>               goto fail;
>>           }
>> @@ -10881,7 +10886,7 @@ static int amdgpu_dm_atomic_check(struct 
>> drm_device *dev,
>>               if (drm_atomic_crtc_needs_modeset(new_crtc_state)) {
>>                   ret = add_affected_mst_dsc_crtcs(state, crtc);
>>                   if (ret) {
>> -                    DRM_DEBUG_DRIVER("add_affected_mst_dsc_crtcs() 
>> failed\n");
>> +                    drm_dbg_atomic(dev, "add_affected_mst_dsc_crtcs() 
>> failed\n");
>>                       goto fail;
>>                   }
>>               }
>> @@ -10898,7 +10903,7 @@ static int amdgpu_dm_atomic_check(struct 
>> drm_device *dev,
>>           ret = amdgpu_dm_verify_lut_sizes(new_crtc_state);
>>           if (ret) {
>> -            DRM_DEBUG_DRIVER("amdgpu_dm_verify_lut_sizes() failed\n");
>> +            drm_dbg_atomic(dev, "amdgpu_dm_verify_lut_sizes() 
>> failed\n");
>>               goto fail;
>>           }
>> @@ -10907,13 +10912,13 @@ static int amdgpu_dm_atomic_check(struct 
>> drm_device *dev,
>>           ret = drm_atomic_add_affected_connectors(state, crtc);
>>           if (ret) {
>> -            DRM_DEBUG_DRIVER("drm_atomic_add_affected_connectors() 
>> failed\n");
>> +            drm_dbg_atomic(dev, "drm_atomic_add_affected_connectors() 
>> failed\n");
>>               goto fail;
>>           }
>>           ret = drm_atomic_add_affected_planes(state, crtc);
>>           if (ret) {
>> -            DRM_DEBUG_DRIVER("drm_atomic_add_affected_planes() 
>> failed\n");
>> +            drm_dbg_atomic(dev, "drm_atomic_add_affected_planes() 
>> failed\n");
>>               goto fail;
>>           }
>> @@ -10952,7 +10957,7 @@ static int amdgpu_dm_atomic_check(struct 
>> drm_device *dev,
>>               if (IS_ERR(new_plane_state)) {
>>                   ret = PTR_ERR(new_plane_state);
>> -                DRM_DEBUG_DRIVER("new_plane_state is BAD\n");
>> +                drm_dbg_atomic(dev, "new_plane_state is BAD\n");
>>                   goto fail;
>>               }
>>           }
>> @@ -10984,7 +10989,7 @@ static int amdgpu_dm_atomic_check(struct 
>> drm_device *dev,
>>                           &lock_and_validation_needed,
>>                           &is_top_most_overlay);
>>           if (ret) {
>> -            DRM_DEBUG_DRIVER("dm_update_plane_state() failed\n");
>> +            drm_dbg_atomic(dev, "dm_update_plane_state() failed\n");
>>               goto fail;
>>           }
>>       }
>> @@ -10997,7 +11002,7 @@ static int amdgpu_dm_atomic_check(struct 
>> drm_device *dev,
>>                          false,
>>                          &lock_and_validation_needed);
>>           if (ret) {
>> -            DRM_DEBUG_DRIVER("DISABLE: dm_update_crtc_state() 
>> failed\n");
>> +            drm_dbg_atomic(dev, "DISABLE: dm_update_crtc_state() 
>> failed\n");
>>               goto fail;
>>           }
>>       }
>> @@ -11010,7 +11015,7 @@ static int amdgpu_dm_atomic_check(struct 
>> drm_device *dev,
>>                          true,
>>                          &lock_and_validation_needed);
>>           if (ret) {
>> -            DRM_DEBUG_DRIVER("ENABLE: dm_update_crtc_state() failed\n");
>> +            drm_dbg_atomic(dev, "ENABLE: dm_update_crtc_state() 
>> failed\n");
>>               goto fail;
>>           }
>>       }
>> @@ -11024,7 +11029,7 @@ static int amdgpu_dm_atomic_check(struct 
>> drm_device *dev,
>>                           &lock_and_validation_needed,
>>                           &is_top_most_overlay);
>>           if (ret) {
>> -            DRM_DEBUG_DRIVER("dm_update_plane_state() failed\n");
>> +            drm_dbg_atomic(dev, "dm_update_plane_state() failed\n");
>>               goto fail;
>>           }
>>       }
>> @@ -11040,21 +11045,21 @@ static int amdgpu_dm_atomic_check(struct 
>> drm_device *dev,
>>       /* Run this here since we want to validate the streams we 
>> created */
>>       ret = drm_atomic_helper_check_planes(dev, state);
>>       if (ret) {
>> -        DRM_DEBUG_DRIVER("drm_atomic_helper_check_planes() failed\n");
>> +        drm_dbg_atomic(dev, "drm_atomic_helper_check_planes() 
>> failed\n");
>>           goto fail;
>>       }
>>       for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
>>           dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
>>           if (dm_new_crtc_state->mpo_requested)
>> -            DRM_DEBUG_DRIVER("MPO enablement requested on 
>> crtc:[%p]\n", crtc);
>> +            drm_dbg_atomic(dev, "MPO enablement requested on 
>> crtc:[%p]\n", crtc);
>>       }
>>       /* Check cursor planes scaling */
>>       for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
>>           ret = dm_check_crtc_cursor(state, crtc, new_crtc_state);
>>           if (ret) {
>> -            DRM_DEBUG_DRIVER("dm_check_crtc_cursor() failed\n");
>> +            drm_dbg_atomic(dev, "dm_check_crtc_cursor() failed\n");
>>               goto fail;
>>           }
>>       }
>> @@ -11137,13 +11142,13 @@ static int amdgpu_dm_atomic_check(struct 
>> drm_device *dev,
>>       if (lock_and_validation_needed) {
>>           ret = dm_atomic_get_state(state, &dm_state);
>>           if (ret) {
>> -            DRM_DEBUG_DRIVER("dm_atomic_get_state() failed\n");
>> +            drm_dbg_atomic(dev, "dm_atomic_get_state() failed\n");
>>               goto fail;
>>           }
>>           ret = do_aquire_global_lock(dev, state);
>>           if (ret) {
>> -            DRM_DEBUG_DRIVER("do_aquire_global_lock() failed\n");
>> +            drm_dbg_atomic(dev, "do_aquire_global_lock() failed\n");
>>               goto fail;
>>           }
>> @@ -11151,7 +11156,7 @@ static int amdgpu_dm_atomic_check(struct 
>> drm_device *dev,
>>           if (dc_resource_is_dsc_encoding_supported(dc)) {
>>               ret = compute_mst_dsc_configs_for_state(state, 
>> dm_state->context, vars);
>>               if (ret) {
>> -                DRM_DEBUG_DRIVER("compute_mst_dsc_configs_for_state() 
>> failed\n");
>> +                drm_dbg_atomic(dev, 
>> "compute_mst_dsc_configs_for_state() failed\n");
>>                   ret = -EINVAL;
>>                   goto fail;
>>               }
>> @@ -11160,7 +11165,7 @@ static int amdgpu_dm_atomic_check(struct 
>> drm_device *dev,
>>           ret = dm_update_mst_vcpi_slots_for_dsc(state, 
>> dm_state->context, vars);
>>           if (ret) {
>> -            DRM_DEBUG_DRIVER("dm_update_mst_vcpi_slots_for_dsc() 
>> failed\n");
>> +            drm_dbg_atomic(dev, "dm_update_mst_vcpi_slots_for_dsc() 
>> failed\n");
>>               goto fail;
>>           }
>> @@ -11172,12 +11177,12 @@ static int amdgpu_dm_atomic_check(struct 
>> drm_device *dev,
>>            */
>>           ret = drm_dp_mst_atomic_check(state);
>>           if (ret) {
>> -            DRM_DEBUG_DRIVER("drm_dp_mst_atomic_check() failed\n");
>> +            drm_dbg_atomic(dev, "drm_dp_mst_atomic_check() failed\n");
>>               goto fail;
>>           }
>>           status = dc_validate_global_state(dc, dm_state->context, true);
>>           if (status != DC_OK) {
>> -            DRM_DEBUG_DRIVER("DC global validation failure: %s (%d)",
>> +            drm_dbg_atomic(dev, "DC global validation failure: %s (%d)",
>>                          dc_status_to_str(status), status);
>>               ret = -EINVAL;
>>               goto fail;
>> @@ -11255,11 +11260,11 @@ static int amdgpu_dm_atomic_check(struct 
>> drm_device *dev,
>>   fail:
>>       if (ret == -EDEADLK)
>> -        DRM_DEBUG_DRIVER("Atomic check stopped to avoid deadlock.\n");
>> +        drm_dbg_atomic(dev, "Atomic check stopped to avoid 
>> deadlock.\n");
>>       else if (ret == -EINTR || ret == -EAGAIN || ret == -ERESTARTSYS)
>> -        DRM_DEBUG_DRIVER("Atomic check stopped due to signal.\n");
>> +        drm_dbg_atomic(dev, "Atomic check stopped due to signal.\n");
>>       else
>> -        DRM_DEBUG_DRIVER("Atomic check failed with err: %d\n", ret);
>> +        drm_dbg_atomic(dev, "Atomic check failed with err: %d\n", ret);
>>       trace_amdgpu_dm_atomic_check_finish(state, ret);
