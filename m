Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031BEC54E49
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 14:45:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E28C10E9DE;
	Wed, 28 Feb 2024 14:45:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m0nZF6q5";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC4D610E9DE
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 14:45:28 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-412b83cfb44so813725e9.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 06:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709131527; x=1709736327; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=86f9Rf7Ej3iE+dr1yfX4f35+KYVAPnY0+IDCGgKJGy0=;
 b=m0nZF6q5M8J8JactJBg8sbLnLJ016yNYOzXStmb64FcPY+qWAM4sitZ6NWStZuYWK4
 fQ8HpA89rCabao3KjpJ3scdYVh3mXp8mCseuiUzYeEh+2xQ8LZXKoSA5yVUwBQB+4lc2
 W7Kwq9ksNGvLMP5yWSXxYd1nAg7KvAc1QPhSCxXQqeyJ+IeRuGjTfKEXJkgI/m+1iXgA
 LmOl1VNM8dLKzb3f1pYQ0Ppkh/iqRiNt4CUvnYCAYc6Z9DpReG65nBLDXJ/o8LemRC/X
 BksFfTEYd3VxqLGbQqL02m0rqeJLhd9jUCrrf9BH+turx/sEEGYpK1AJone0X7y931yj
 jWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709131527; x=1709736327;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=86f9Rf7Ej3iE+dr1yfX4f35+KYVAPnY0+IDCGgKJGy0=;
 b=s4l4fClI+nyHZK/XjOKpshKqtTPDOaWmDlzhhEBflQrXg7xoVNVybW/fp809wFZJsO
 g/iPEHnTVLVKAt/qtHGecU9zBysIlwYbOTHGv6t12QiMfgE6yKktnrK1tgBOW47kAxST
 7h1XHRmzCCmoxyLLb88RnulN33QC/E6wsFUdVwJDwS/Zfn9+fzTjhsNIRYeeOdZK9zP0
 BfvmJ0ri4WW2UNppEtxx30fAFgmScUQGOdzB/sxS5GVdDRUcDBl+EGmbIMgXY9YoGO2Z
 tgZ0WM7OYXyl+UUhFbcuOjEEWdfiQVUGUtVVIyQC9crSFXgotbxCYHq6gOr6VDL+AjHL
 0k2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXrB+/J3g9yyjqkxUueJgb7aCIHcpXbS/4mHmhnAjvEGlGhRBQYeEazL9ZwR+RIFkXYvH+mnInjYp4uoZ3nIvgSmoedozj10ucmyVoag==
X-Gm-Message-State: AOJu0YyPLzn3uT8rBbFJgksdVghiV7d9ibkl31QSUVV0XfOnVn4m5rHW
 rdZGIdCTnJtjTgyzLMihlN4qNz92dWlE4SH9poVDRStBCZl/qRco
X-Google-Smtp-Source: AGHT+IG6BDO4uhplGB9wJgHzN0casuqzczcpwaaB+DxQFod6FGTyIFBedHQkrrLAK3pfAWXCTBnGEA==
X-Received: by 2002:a05:600c:4fcb:b0:412:85c2:db12 with SMTP id
 o11-20020a05600c4fcb00b0041285c2db12mr10756286wmq.2.1709131526560; 
 Wed, 28 Feb 2024 06:45:26 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 cg12-20020a5d5ccc000000b0033b1c321070sm14569930wrb.31.2024.02.28.06.45.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Feb 2024 06:45:26 -0800 (PST)
Message-ID: <d9a450ed-5632-42ce-b53c-e70b71762606@gmail.com>
Date: Wed, 28 Feb 2024 15:45:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Revert "drm/amd: Remove freesync video mode amdgpu
 parameter"
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240227184847.3078099-1-alexander.deucher@amd.com>
 <7e13e8d8-e486-4739-9844-f0b95861d34c@gmail.com>
 <CADnq5_OSLcbSX2H4b72YRVGz7GQqHg-8bcNWxdUdcoqAwP=dsg@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_OSLcbSX2H4b72YRVGz7GQqHg-8bcNWxdUdcoqAwP=dsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Am 28.02.24 um 15:23 schrieb Alex Deucher:
> On Wed, Feb 28, 2024 at 2:03 AM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> Am 27.02.24 um 19:48 schrieb Alex Deucher:
>>> This reverts commit e94e787e37b99645e7c02d20d0a1ba0f8a18a82a.
>>>
>>> This conflicts with how compositors want to handle VRR.  Now
>>> that compositors actually handle VRR, we probably don't need
>>> freesync video.
>>>
>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2985
>> Scratching my head what actually happens here? Doesn't the problem then
>> just depend on a module parameter?
> Yes.  The problem is that when freesync video is enabled, compositors
> don't know which modes are actual modes and which are a VRR video
> mode.  There are still customers that want the vrr video mode smooth
> video playback, but compositors don't want this by default.  I guess
> the alternative is to just drop this feature altogether now that
> compositors and media players are starting to support this properly.

That's what I would suggest as well.

As far as I can see adding those modes is actually buggy behavior and we 
need to avoid it.

Christian.

>
> Alex
>
>> Regards,
>> Christian.
>>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 27 +++++++++++++++++++++++++
>>>    2 files changed, 28 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index 0e365cadcc3fc..925026c183f41 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -194,6 +194,7 @@ extern int amdgpu_emu_mode;
>>>    extern uint amdgpu_smu_memory_pool_size;
>>>    extern int amdgpu_smu_pptable_id;
>>>    extern uint amdgpu_dc_feature_mask;
>>> +extern uint amdgpu_freesync_vid_mode;
>>>    extern uint amdgpu_dc_debug_mask;
>>>    extern uint amdgpu_dc_visual_confirm;
>>>    extern int amdgpu_dm_abm_level;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> index 15a8a64fc4e28..82b154b103f43 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> @@ -199,6 +199,7 @@ int amdgpu_mes_kiq;
>>>    int amdgpu_noretry = -1;
>>>    int amdgpu_force_asic_type = -1;
>>>    int amdgpu_tmz = -1; /* auto */
>>> +uint amdgpu_freesync_vid_mode;
>>>    int amdgpu_reset_method = -1; /* auto */
>>>    int amdgpu_num_kcq = -1;
>>>    int amdgpu_smartshift_bias;
>>> @@ -883,6 +884,32 @@ module_param_named(damageclips, amdgpu_damage_clips, int, 0444);
>>>    MODULE_PARM_DESC(tmz, "Enable TMZ feature (-1 = auto (default), 0 = off, 1 = on)");
>>>    module_param_named(tmz, amdgpu_tmz, int, 0444);
>>>
>>> +/**
>>> + * DOC: freesync_video (uint)
>>> + * Enable the optimization to adjust front porch timing to achieve seamless
>>> + * mode change experience when setting a freesync supported mode for which full
>>> + * modeset is not needed.
>>> + *
>>> + * The Display Core will add a set of modes derived from the base FreeSync
>>> + * video mode into the corresponding connector's mode list based on commonly
>>> + * used refresh rates and VRR range of the connected display, when users enable
>>> + * this feature. From the userspace perspective, they can see a seamless mode
>>> + * change experience when the change between different refresh rates under the
>>> + * same resolution. Additionally, userspace applications such as Video playback
>>> + * can read this modeset list and change the refresh rate based on the video
>>> + * frame rate. Finally, the userspace can also derive an appropriate mode for a
>>> + * particular refresh rate based on the FreeSync Mode and add it to the
>>> + * connector's mode list.
>>> + *
>>> + * Note: This is an experimental feature.
>>> + *
>>> + * The default value: 0 (off).
>>> + */
>>> +MODULE_PARM_DESC(
>>> +     freesync_video,
>>> +     "Enable freesync modesetting optimization feature (0 = off (default), 1 = on)");
>>> +module_param_named(freesync_video, amdgpu_freesync_vid_mode, uint, 0444);
>>> +
>>>    /**
>>>     * DOC: reset_method (int)
>>>     * GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco)

