Return-Path: <SRS0=eROb=P3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B967C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 11:23:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 561F861288
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 11:23:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 561F861288
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D835E6F4EC;
	Mon,  8 Nov 2021 11:23:40 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C0906F4EC
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Nov 2021 11:23:39 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id c4so26244793wrd.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Nov 2021 03:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=hqlLhJ8/61IuvlzN6Sw6PZrGBEG6mpAv6nLHh3zPDJo=;
 b=cU9Ih89E6uGAMObaMUMCoYxmZkLwtpTalKQAMf5UlbF6CDG+hSAszZ0qv1MC5BBG94
 vxUqwOhSV+u1VfQQLeJBbqp2H/Kf0htjrdO5domo4zGPuIZ+ietJlcoY8B+4noazODA4
 p1YQyhYoHUADyRXVwbO6o1JNpUWh4Sx7tJuLtfOBvJgDEAcaC11u4ewJxJIU7qIMjadC
 DNEKYIOVSBFo6xfuMF87i6YW5C7X7nGUPPiQB9xkB8Jp5W5yRX/lS3NoHZl8pLT4n29I
 h4djWGI/PzYu1Yc74pkTJc7gDJc32quLLMbdejDPG/aIzZiSDMRuzoK+SwIuFOlcL7hU
 VBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=hqlLhJ8/61IuvlzN6Sw6PZrGBEG6mpAv6nLHh3zPDJo=;
 b=w9akN4hFGURsAT37giQfe0CP6jCWt3O8ZZo6ul5PPCvU+THYlvUh1qm0EmepeU1NJn
 YWCfnxdlMSFf9y0Sr2PvfwqkR/ChN/jOquUR2678MUrBJBdthp3la7P+pVFyKNC5j6mR
 Xnogm1dAxTXSdVz93YIX7goGpEZe0/cCPAVzwCMAX9pIzrK6cHPCOAxgFPn7dxaNwbbO
 P2U4QU5OEn+5fQr00X+SpbwEQePd1UIDnRaDFND3aLwlapDtTrrFJwM+VQ2mbeDIAL5u
 eK8QLAdTZJ1YBAJXTXkzyxIYgdhvaesc7VwxI7qGndRjiF+UNTeTwXiYcw3B2kUV4Znt
 uUOw==
X-Gm-Message-State: AOAM532yl/yjeIzOOFPwMrFDEvwaMIPSG1e+C5WpEGEHwhl2Oy+RXGbU
 pdoZMrqS8RiEA5cmsHUSypdTci4zceA=
X-Google-Smtp-Source: ABdhPJy5+rmMj49ALUmGrxnFcQxp9zNuC/bn47ZNKZep7Gl/HXFttjdiXV+4cuPR/XmV08h8CqQefw==
X-Received: by 2002:adf:ca05:: with SMTP id o5mr99068776wrh.7.1636370617971;
 Mon, 08 Nov 2021 03:23:37 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:308a:d18e:268b:408f?
 ([2a02:908:1252:fb60:308a:d18e:268b:408f])
 by smtp.gmail.com with ESMTPSA id t127sm20112733wma.9.2021.11.08.03.23.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Nov 2021 03:23:37 -0800 (PST)
Subject: Re: [PATCH] drm/amd/display: log amdgpu_dm_atomic_check() failure
 cause
To: "S, Shirish" <sshankar@amd.com>, Paul Menzel <pmenzel@molgen.mpg.de>,
 Shirish S <shirish.s@amd.com>
References: <20211108084054.11162-1-shirish.s@amd.com>
 <d85871bd-72af-d02d-5c23-f3c13ccbfd52@molgen.mpg.de>
 <af95f11c-c70c-352b-da5a-3a185426d696@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <d4d96a2d-11c5-ab58-efb0-262ef75d515d@gmail.com>
Date: Mon, 8 Nov 2021 12:23:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <af95f11c-c70c-352b-da5a-3a185426d696@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 08.11.21 um 12:13 schrieb S, Shirish:
> Hi Paul,
>
> On 11/8/2021 2:27 PM, Paul Menzel wrote:
>> Dear Shrish,
>>
>>
>> Am 08.11.21 um 09:40 schrieb Shirish S:
>>> update user with next level of info about which condition led to
>>> atomic check failure.
>>>
>>> Signed-off-by: Shirish S <shirish.s@amd.com>
>>> ---
>>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 70 
>>> ++++++++++++++-----
>>>   1 file changed, 52 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c 
>>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> index 1e26d9be8993..37ea8a76fa09 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> @@ -10746,8 +10746,10 @@ static int amdgpu_dm_atomic_check(struct 
>>> drm_device *dev,
>>>       trace_amdgpu_dm_atomic_check_begin(state);
>>>         ret = drm_atomic_helper_check_modeset(dev, state);
>>> -    if (ret)
>>> +    if (ret) {
>>> +        DRM_DEV_ERROR(adev->dev, "drm_atomic_helper_check_modeset() 
>>> failed\n");
>>
>> Does the Linux kernel provide means (for example ftrace) to trace 
>> such things, so the (generic) debug lines don’t have to be added? Or 
>> is it to better debug user bug reports?
>>
> ftrace requires additional tooling, am trying to avoid it and make the 
> error reporting more trivial to the developers, in case there is a 
> failure in atomic_check.

Yeah, but Paul is right that here looks like totally overkill to me as well.

And especially calls to functions like drm_atomic_helper_check_modeset() 
sound like parameter validation to me which the kernel should absolute 
NOT report about on default severity level.

Otherwise you allow userspace to flood the logs with trivial error messages.

Regards,
Christian.

>
> Regards,
>
> Shirish S
>
>>
>> Kind regards,
>>
>> Paul
>>
>>
>>>           goto fail;
>>> +    }
>>>         /* Check connector changes */
>>>       for_each_oldnew_connector_in_state(state, connector, 
>>> old_con_state, new_con_state, i) {
>>> @@ -10763,6 +10765,7 @@ static int amdgpu_dm_atomic_check(struct 
>>> drm_device *dev,
>>>             new_crtc_state = drm_atomic_get_crtc_state(state, 
>>> new_con_state->crtc);
>>>           if (IS_ERR(new_crtc_state)) {
>>> +            DRM_DEV_ERROR(adev->dev, "drm_atomic_get_crtc_state() 
>>> failed\n");
>>>               ret = PTR_ERR(new_crtc_state);
>>>               goto fail;
>>>           }
>>> @@ -10777,8 +10780,10 @@ static int amdgpu_dm_atomic_check(struct 
>>> drm_device *dev,
>>>           for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, 
>>> new_crtc_state, i) {
>>>               if (drm_atomic_crtc_needs_modeset(new_crtc_state)) {
>>>                   ret = add_affected_mst_dsc_crtcs(state, crtc);
>>> -                if (ret)
>>> +                if (ret) {
>>> +                    DRM_DEV_ERROR(adev->dev, 
>>> "add_affected_mst_dsc_crtcs() failed\n");
>>>                       goto fail;
>>> +                }
>>>               }
>>>           }
>>>       }
>>> @@ -10793,19 +10798,25 @@ static int amdgpu_dm_atomic_check(struct 
>>> drm_device *dev,
>>>               continue;
>>>             ret = amdgpu_dm_verify_lut_sizes(new_crtc_state);
>>> -        if (ret)
>>> +        if (ret) {
>>> +            DRM_DEV_ERROR(adev->dev, "amdgpu_dm_verify_lut_sizes() 
>>> failed\n");
>>>               goto fail;
>>> +        }
>>>             if (!new_crtc_state->enable)
>>>               continue;
>>>             ret = drm_atomic_add_affected_connectors(state, crtc);
>>> -        if (ret)
>>> -            return ret;
>>> +        if (ret) {
>>> +            DRM_DEV_ERROR(adev->dev, 
>>> "drm_atomic_add_affected_connectors() failed\n");
>>> +            goto fail;
>>> +        }
>>>             ret = drm_atomic_add_affected_planes(state, crtc);
>>> -        if (ret)
>>> +        if (ret) {
>>> +            DRM_DEV_ERROR(adev->dev, 
>>> "drm_atomic_add_affected_planes() failed\n");
>>>               goto fail;
>>> +        }
>>>             if (dm_old_crtc_state->dsc_force_changed)
>>>               new_crtc_state->mode_changed = true;
>>> @@ -10842,6 +10853,7 @@ static int amdgpu_dm_atomic_check(struct 
>>> drm_device *dev,
>>>                 if (IS_ERR(new_plane_state)) {
>>>                   ret = PTR_ERR(new_plane_state);
>>> +                DRM_DEV_ERROR(adev->dev, "new_plane_state is BAD\n");
>>>                   goto fail;
>>>               }
>>>           }
>>> @@ -10854,8 +10866,10 @@ static int amdgpu_dm_atomic_check(struct 
>>> drm_device *dev,
>>>                           new_plane_state,
>>>                           false,
>>>                           &lock_and_validation_needed);
>>> -        if (ret)
>>> +        if (ret) {
>>> +            DRM_DEV_ERROR(adev->dev, "dm_update_plane_state() 
>>> failed\n");
>>>               goto fail;
>>> +        }
>>>       }
>>>         /* Disable all crtcs which require disable */
>>> @@ -10865,8 +10879,10 @@ static int amdgpu_dm_atomic_check(struct 
>>> drm_device *dev,
>>>                          new_crtc_state,
>>>                          false,
>>>                          &lock_and_validation_needed);
>>> -        if (ret)
>>> +        if (ret) {
>>> +            DRM_DEV_ERROR(adev->dev, "DISABLE: 
>>> dm_update_crtc_state() failed\n");
>>>               goto fail;
>>> +        }
>>>       }
>>>         /* Enable all crtcs which require enable */
>>> @@ -10876,8 +10892,10 @@ static int amdgpu_dm_atomic_check(struct 
>>> drm_device *dev,
>>>                          new_crtc_state,
>>>                          true,
>>>                          &lock_and_validation_needed);
>>> -        if (ret)
>>> +        if (ret) {
>>> +            DRM_DEV_ERROR(adev->dev, "ENABLE: 
>>> dm_update_crtc_state() failed\n");
>>>               goto fail;
>>> +        }
>>>       }
>>>         /* Add new/modified planes */
>>> @@ -10887,20 +10905,26 @@ static int amdgpu_dm_atomic_check(struct 
>>> drm_device *dev,
>>>                           new_plane_state,
>>>                           true,
>>>                           &lock_and_validation_needed);
>>> -        if (ret)
>>> +        if (ret) {
>>> +            DRM_DEV_ERROR(adev->dev, "dm_update_plane_state() 
>>> failed\n");
>>>               goto fail;
>>> +        }
>>>       }
>>>         /* Run this here since we want to validate the streams we 
>>> created */
>>>       ret = drm_atomic_helper_check_planes(dev, state);
>>> -    if (ret)
>>> +    if (ret) {
>>> +        DRM_DEV_ERROR(adev->dev, "drm_atomic_helper_check_planes() 
>>> failed\n");
>>>           goto fail;
>>> +    }
>>>         /* Check cursor planes scaling */
>>>       for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
>>>           ret = dm_check_crtc_cursor(state, crtc, new_crtc_state);
>>> -        if (ret)
>>> +        if (ret) {
>>> +            DRM_DEV_ERROR(adev->dev, "dm_check_crtc_cursor() 
>>> failed\n");
>>>               goto fail;
>>> +        }
>>>       }
>>>         if (state->legacy_cursor_update) {
>>> @@ -10987,20 +11011,28 @@ static int amdgpu_dm_atomic_check(struct 
>>> drm_device *dev,
>>>        */
>>>       if (lock_and_validation_needed) {
>>>           ret = dm_atomic_get_state(state, &dm_state);
>>> -        if (ret)
>>> +        if (ret) {
>>> +            DRM_DEV_ERROR(adev->dev, "dm_atomic_get_state() 
>>> failed\n");
>>>               goto fail;
>>> +        }
>>>             ret = do_aquire_global_lock(dev, state);
>>> -        if (ret)
>>> +        if (ret) {
>>> +            DRM_DEV_ERROR(adev->dev, "do_aquire_global_lock() 
>>> failed\n");
>>>               goto fail;
>>> +        }
>>>     #if defined(CONFIG_DRM_AMD_DC_DCN)
>>> -        if (!compute_mst_dsc_configs_for_state(state, 
>>> dm_state->context, vars))
>>> +        if (!compute_mst_dsc_configs_for_state(state, 
>>> dm_state->context, vars)) {
>>> +            DRM_DEV_ERROR(adev->dev, 
>>> "compute_mst_dsc_configs_for_state() failed\n");
>>>               goto fail;
>>> +        }
>>>             ret = dm_update_mst_vcpi_slots_for_dsc(state, 
>>> dm_state->context, vars);
>>> -        if (ret)
>>> +        if (ret) {
>>> +            DRM_DEV_ERROR(adev->dev, 
>>> "dm_update_mst_vcpi_slots_for_dsc() failed\n");
>>>               goto fail;
>>> +        }
>>>   #endif
>>>             /*
>>> @@ -11010,11 +11042,13 @@ static int amdgpu_dm_atomic_check(struct 
>>> drm_device *dev,
>>>            * to get stuck in an infinite loop and hang eventually.
>>>            */
>>>           ret = drm_dp_mst_atomic_check(state);
>>> -        if (ret)
>>> +        if (ret) {
>>> +            DRM_DEV_ERROR(adev->dev, "drm_dp_mst_atomic_check() 
>>> failed\n");
>>>               goto fail;
>>> +        }
>>>           status = dc_validate_global_state(dc, dm_state->context, 
>>> false);
>>>           if (status != DC_OK) {
>>> -            drm_dbg_atomic(dev,
>>> +            DRM_DEV_ERROR(adev->dev,
>>>                          "DC global validation failure: %s (%d)",
>>>                          dc_status_to_str(status), status);
>>>               ret = -EINVAL;
>>>

