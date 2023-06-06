Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25CFC7EE24
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 16:19:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D21B10E23D;
	Tue,  6 Jun 2023 16:19:04 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86FE510E23C
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 16:19:02 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3f7378a75c0so24505835e9.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Jun 2023 09:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=froggi.es; s=google; t=1686068340; x=1688660340;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IkSNSReEmc4q/h1uq611jHp4rTVNREpV79bP22NkqVQ=;
 b=RHce7qgt0YWlrLaSYzWK1HIJO0baElK01A4+YwvDEpBWyUXlWrK+dmyOOyKnCPsxUN
 XajEhpQWdnbV/p1dq//e5yyfUYqY7fR+AEQ2AWL5MUVPgYgcicMbD06HZ2GV7DW2MiQS
 889yFfXYx3UrrJLLwaZtZzHTQGPt9SLtKeBqeCM6iW7mPU/LYJAowQrlcKjINqOj+D4z
 mdXEVuPY+OiARvTdb6gOLUBV8ZJkG+WI1OdlxpJ0kobfJbnZCae6RyZcfdXyhn1UiYiQ
 p96l1ynEgoI5j0PME2IUDNzI62QZftgV3KulhLjVKySBK2eTzoMBuNXuXa3qOdu7hVGl
 TjNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686068340; x=1688660340;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IkSNSReEmc4q/h1uq611jHp4rTVNREpV79bP22NkqVQ=;
 b=jzB2zwp8NHOKNvCMU7PZddWm5i2jzdGCTuARpHpGDSTtG7gNXuqe1CQ0CgRLeFhd/x
 dqK4h92NBUKn/OJ7F2h3a8D0riO5CbR9SxcESAprbT70CAcP8AhmgFkcj5HZTivMbWAV
 Xz+3zt9whixq/sztalqEhab7o44SwBPuME234oCZMEmP5TwkVGEcobCfsAI5QSKB4AFI
 hroe4XQtQjOHI4JcI3MuwryShF81jKwbM3GxYZP2dlIE6hXAE9yHy4yRfH0Cv/kmYvuu
 GX5U1JLZDPLI0MlfWSgpeXxkxARsQjWFyY1EIKWH2T9le1kAFbxlx+60I7O4Jn/lOw67
 ijPw==
X-Gm-Message-State: AC+VfDw+Ee7EmZA8RCZ093LHKgmYv6i9SVCW7D0qYmSIJpbhZZHn8sxo
 OyTCbh4WQpb5Yg1z451+WVPZhA==
X-Google-Smtp-Source: ACHHUZ4EzEUSEqPRGVHTBw4mvVuxYxDiCQQt4rvQEBrEV8tYIiZwkZYjoFo6xzLelrUsXxarsJcvsg==
X-Received: by 2002:a05:600c:21d7:b0:3f6:426:eae with SMTP id
 x23-20020a05600c21d700b003f604260eaemr2378118wmj.15.1686068340342; 
 Tue, 06 Jun 2023 09:19:00 -0700 (PDT)
Received: from [192.168.0.89]
 (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
 by smtp.gmail.com with ESMTPSA id
 8-20020a05600c230800b003f6cf9afc25sm18297060wmo.40.2023.06.06.09.18.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jun 2023 09:19:00 -0700 (PDT)
Message-ID: <47442442-794b-09da-4c70-1393344ce837@froggi.es>
Date: Tue, 6 Jun 2023 17:18:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 06/36] drm/amd/display: add CRTC driver-specific property
 for gamma TF
To: Harry Wentland <harry.wentland@amd.com>, Melissa Wen <mwen@igalia.com>,
 amd-gfx@lists.freedesktop.org, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 sunpeng.li@amd.com, Alex Deucher <alexander.deucher@amd.com>,
 dri-devel@lists.freedesktop.org, christian.koenig@amd.com,
 Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch
References: <20230523221520.3115570-1-mwen@igalia.com>
 <20230523221520.3115570-7-mwen@igalia.com>
 <5ea0146c-19a2-58d9-4cc9-29af6d433915@amd.com>
Content-Language: en-US
From: Joshua Ashton <joshua@froggi.es>
In-Reply-To: <5ea0146c-19a2-58d9-4cc9-29af6d433915@amd.com>
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
Cc: Sebastian Wick <sebastian.wick@redhat.com>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Shashank Sharma <Shashank.Sharma@amd.com>, Alex Hung <alex.hung@amd.com>,
 Simon Ser <contact@emersion.fr>, Xaver Hugl <xaver.hugl@gmail.com>,
 kernel-dev@igalia.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 sungjoon.kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 6/1/23 20:17, Harry Wentland wrote:
> 
> 
> On 5/23/23 18:14, Melissa Wen wrote:
>> Hook up driver-specific atomic operations for managing AMD color
>> properties and create AMD driver-specific color management properties
>> and attach them according to HW capabilities defined by `struct
>> dc_color_caps`. Add enumerated transfer function property to DRM CRTC
>> gamma to convert to wire encoding with or without a user gamma LUT.
>> Enumerated TFs are not supported yet by the DRM color pipeline,
>> therefore, create a DRM enum list with the predefined TFs supported by
>> the AMD display driver.
>>
>> Co-developed-by: Joshua Ashton <joshua@froggi.es>
>> Signed-off-by: Joshua Ashton <joshua@froggi.es>
>> Signed-off-by: Melissa Wen <mwen@igalia.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   | 36 ++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |  8 +++
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 22 ++++++
>>   .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 72 ++++++++++++++++++-
>>   4 files changed, 137 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>> index 389396eac222..88af075e6c18 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>> @@ -1247,6 +1247,38 @@ amdgpu_display_user_framebuffer_create(struct drm_device *dev,
>>   	return &amdgpu_fb->base;
>>   }
>>   
>> +static const struct drm_prop_enum_list drm_transfer_function_enum_list[] = {
>> +	{ DRM_TRANSFER_FUNCTION_DEFAULT, "Default" },
>> +	{ DRM_TRANSFER_FUNCTION_SRGB, "sRGB" },
>> +	{ DRM_TRANSFER_FUNCTION_BT709, "BT.709" },
>> +	{ DRM_TRANSFER_FUNCTION_PQ, "PQ (Perceptual Quantizer)" },
>> +	{ DRM_TRANSFER_FUNCTION_LINEAR, "Linear" },
>> +	{ DRM_TRANSFER_FUNCTION_UNITY, "Unity" },
>> +	{ DRM_TRANSFER_FUNCTION_HLG, "HLG (Hybrid Log Gamma)" },
>> +	{ DRM_TRANSFER_FUNCTION_GAMMA22, "Gamma 2.2" },
>> +	{ DRM_TRANSFER_FUNCTION_GAMMA24, "Gamma 2.4" },
>> +	{ DRM_TRANSFER_FUNCTION_GAMMA26, "Gamma 2.6" },
>> +};
> 
> Let's not use the DRM_/drm_ prefix here. It might clash later when
> we introduce DRM_ core interfaces for enumerated transfer functions.
> 
> We'll want to specify whether something is an EOTF or an inverse EOTF,
> or possibly an OETF. Of course that wouldn't apply to "Linear" or
> "Unity" (I'm assuming the two are the same?).
> 
> EOTF = electro-optical transfer function
> This is the transfer function to go from the encoded value to an
> optical (linear) value.
> 
> Inverse EOTF = simply the inverse of the EOTF
> This is usually intended to go from an optical/linear space (which
> might have been used for blending) back to the encoded values.
> 
> OETF = opto-electronic transfer function
> This is usually used for converting optical signals into encoded
> values. Usually that's done on the camera side but I think HLG might
> define the OETF instead of the EOTF. A bit fuzzy on that. If you're
> unclear about HLG I recommend we don't include it yet.
> 
> It would also be good to document a bit more what each of the TFs
> mean, but I'm fine if that comes later with a "driver-agnostic"
> API. The key thing to clarify is whether we have an EOTF or inv_EOTF,
> i.e. whether we use the TF to go from encoded to optical or vice
> versa.

Whether we use the inverse or not is just determined per-block though.

I think we should definitely document it per-block very explicitly 
(whether it is EOTF or inv EOTF) but I don't think we need to touch the 
enums here.

- Joshie 🐸✨

> 
> I know DC is sloppy and doesn't define those but it will still use
> them as either EOTF or inv_EOTF, based on which block they're being
> programmed, if I'm not mistaken.
> 
>> +
>> +#ifdef AMD_PRIVATE_COLOR
>> +static int
>> +amdgpu_display_create_color_properties(struct amdgpu_device *adev)
>> +{
>> +	struct drm_property *prop;
>> +
>> +	prop = drm_property_create_enum(adev_to_drm(adev),
>> +					DRM_MODE_PROP_ENUM,
>> +					"AMD_REGAMMA_TF",
>> +					drm_transfer_function_enum_list,
>> +					ARRAY_SIZE(drm_transfer_function_enum_list));
>> +	if (!prop)
>> +		return -ENOMEM;
>> +	adev->mode_info.regamma_tf_property = prop;
>> +
>> +	return 0;
>> +}
>> +#endif
>> +
> 
> It'd be nice if we have this function and the above enum_list
> in amdgpu_dm, possibly in amdgpu_dm_color.c. You could call it
> directly after the amdgpu_display_modeset_create_prop() call in
> amdgpu_dm_mode_config_init().
> 
>>   const struct drm_mode_config_funcs amdgpu_mode_funcs = {
>>   	.fb_create = amdgpu_display_user_framebuffer_create,
>>   };
>> @@ -1323,6 +1355,10 @@ int amdgpu_display_modeset_create_props(struct amdgpu_device *adev)
>>   			return -ENOMEM;
>>   	}
>>   
>> +#ifdef AMD_PRIVATE_COLOR
>> +	if (amdgpu_display_create_color_properties(adev))
>> +		return -ENOMEM;
>> +#endif
>>   	return 0;
>>   }
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
>> index b8633df418d4..881446c51b36 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
>> @@ -344,6 +344,14 @@ struct amdgpu_mode_info {
>>   	int			disp_priority;
>>   	const struct amdgpu_display_funcs *funcs;
>>   	const enum drm_plane_type *plane_type;
>> +
>> +	/* Driver-private color mgmt props */
>> +
>> +	/* @regamma_tf_property: Transfer function for CRTC regamma
>> +	 * (post-blending). Possible values are defined by `enum
>> +	 * drm_transfer_function`.
>> +	 */
>> +	struct drm_property *regamma_tf_property;
>>   };
>>   
>>   #define AMDGPU_MAX_BL_LEVEL 0xFF
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
>> index 2e2413fd73a4..ad5ee28b83dc 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
>> @@ -699,6 +699,20 @@ static inline void amdgpu_dm_set_mst_status(uint8_t *status,
>>   
>>   extern const struct amdgpu_ip_block_version dm_ip_block;
>>   
>> +enum drm_transfer_function {
>> +	DRM_TRANSFER_FUNCTION_DEFAULT,
>> +	DRM_TRANSFER_FUNCTION_SRGB,
>> +	DRM_TRANSFER_FUNCTION_BT709,
>> +	DRM_TRANSFER_FUNCTION_PQ,
>> +	DRM_TRANSFER_FUNCTION_LINEAR,
>> +	DRM_TRANSFER_FUNCTION_UNITY,
>> +	DRM_TRANSFER_FUNCTION_HLG,
>> +	DRM_TRANSFER_FUNCTION_GAMMA22,
>> +	DRM_TRANSFER_FUNCTION_GAMMA24,
>> +	DRM_TRANSFER_FUNCTION_GAMMA26,
>> +	DRM_TRANSFER_FUNCTION_MAX,
>> +};
>> +
>>   struct dm_plane_state {
>>   	struct drm_plane_state base;
>>   	struct dc_plane_state *dc_state;
>> @@ -726,6 +740,14 @@ struct dm_crtc_state {
>>   	struct dc_info_packet vrr_infopacket;
>>   
>>   	int abm_level;
>> +
>> +        /**
>> +	 * @regamma_tf:
>> +	 *
>> +	 * Pre-defined transfer function for converting internal FB -> wire
>> +	 * encoding.
>> +	 */
>> +	enum drm_transfer_function regamma_tf;
> 
> Again, let's avoid a drm_ prefix. Maybe name all this amdgpu_ instead.
> 
>>   };
>>   
>>   #define to_dm_crtc_state(x) container_of(x, struct dm_crtc_state, base)
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>> index e3762e806617..1eb279d341c5 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>> @@ -229,7 +229,6 @@ static void dm_crtc_destroy_state(struct drm_crtc *crtc,
>>   	if (cur->stream)
>>   		dc_stream_release(cur->stream);
>>   
>> -
> 
> nit: stray newline
> 
> Harry
> 
>>   	__drm_atomic_helper_crtc_destroy_state(state);
>>   
>>   
>> @@ -263,6 +262,7 @@ static struct drm_crtc_state *dm_crtc_duplicate_state(struct drm_crtc *crtc)
>>   	state->freesync_config = cur->freesync_config;
>>   	state->cm_has_degamma = cur->cm_has_degamma;
>>   	state->cm_is_degamma_srgb = cur->cm_is_degamma_srgb;
>> +	state->regamma_tf = cur->regamma_tf;
>>   	state->crc_skip_count = cur->crc_skip_count;
>>   	state->mpo_requested = cur->mpo_requested;
>>   	/* TODO Duplicate dc_stream after objects are stream object is flattened */
>> @@ -299,6 +299,69 @@ static int amdgpu_dm_crtc_late_register(struct drm_crtc *crtc)
>>   }
>>   #endif
>>   
>> +#ifdef AMD_PRIVATE_COLOR
>> +/**
>> + * drm_crtc_additional_color_mgmt - enable additional color properties
>> + * @crtc: DRM CRTC
>> + *
>> + * This function lets the driver enable the 3D LUT color correction property
>> + * on a CRTC. This includes shaper LUT, 3D LUT and regamma TF. The shaper
>> + * LUT and 3D LUT property is only attached if its size is not 0.
>> + */
>> +static void
>> +dm_crtc_additional_color_mgmt(struct drm_crtc *crtc)
>> +{
>> +	struct amdgpu_device *adev = drm_to_adev(crtc->dev);
>> +
>> +	if(adev->dm.dc->caps.color.mpc.ogam_ram)
>> +		drm_object_attach_property(&crtc->base,
>> +					   adev->mode_info.regamma_tf_property,
>> +					   DRM_TRANSFER_FUNCTION_DEFAULT);
>> +}
>> +
>> +static int
>> +amdgpu_dm_atomic_crtc_set_property(struct drm_crtc *crtc,
>> +				   struct drm_crtc_state *state,
>> +				   struct drm_property *property,
>> +				   uint64_t val)
>> +{
>> +	struct amdgpu_device *adev = drm_to_adev(crtc->dev);
>> +	struct dm_crtc_state *acrtc_state = to_dm_crtc_state(state);
>> +
>> +	if (property == adev->mode_info.regamma_tf_property) {
>> +		if (acrtc_state->regamma_tf != val) {
>> +			acrtc_state->regamma_tf = val;
>> +			acrtc_state->base.color_mgmt_changed |= 1;
>> +		}
>> +	} else {
>> +		drm_dbg_atomic(crtc->dev,
>> +			       "[CRTC:%d:%s] unknown property [PROP:%d:%s]]\n",
>> +			       crtc->base.id, crtc->name,
>> +			       property->base.id, property->name);
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int
>> +amdgpu_dm_atomic_crtc_get_property(struct drm_crtc *crtc,
>> +				   const struct drm_crtc_state *state,
>> +				   struct drm_property *property,
>> +				   uint64_t *val)
>> +{
>> +	struct amdgpu_device *adev = drm_to_adev(crtc->dev);
>> +	struct dm_crtc_state *acrtc_state = to_dm_crtc_state(state);
>> +
>> +	if (property == adev->mode_info.regamma_tf_property)
>> +		*val = acrtc_state->regamma_tf;
>> +	else
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
>> +#endif
>> +
>>   /* Implemented only the options currently available for the driver */
>>   static const struct drm_crtc_funcs amdgpu_dm_crtc_funcs = {
>>   	.reset = dm_crtc_reset_state,
>> @@ -317,6 +380,10 @@ static const struct drm_crtc_funcs amdgpu_dm_crtc_funcs = {
>>   #if defined(CONFIG_DEBUG_FS)
>>   	.late_register = amdgpu_dm_crtc_late_register,
>>   #endif
>> +#ifdef AMD_PRIVATE_COLOR
>> +	.atomic_set_property = amdgpu_dm_atomic_crtc_set_property,
>> +	.atomic_get_property = amdgpu_dm_atomic_crtc_get_property,
>> +#endif
>>   };
>>   
>>   static void dm_crtc_helper_disable(struct drm_crtc *crtc)
>> @@ -480,6 +547,9 @@ int amdgpu_dm_crtc_init(struct amdgpu_display_manager *dm,
>>   
>>   	drm_mode_crtc_set_gamma_size(&acrtc->base, MAX_COLOR_LEGACY_LUT_ENTRIES);
>>   
>> +#ifdef AMD_PRIVATE_COLOR
>> +	dm_crtc_additional_color_mgmt(&acrtc->base);
>> +#endif
>>   	return 0;
>>   
>>   fail:
> 

