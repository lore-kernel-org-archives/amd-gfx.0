Return-Path: <SRS0=/upn=OT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AFBC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 09:16:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1905760F58
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 09:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1905760F58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E87F6EA10;
	Wed, 29 Sep 2021 09:16:15 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 964DB6EA10
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 09:16:13 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 t16-20020a1c7710000000b003049690d882so4607712wmi.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 02:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=xp/ptP6GHYoR4dprEkGuqIx7nfia7pARblXeNADRoPc=;
 b=HYSC1xYZdWnzwBZMmxcfLlHqfvrlMYBE2Dhg37HQsRhmL3FAtOf826JmgJs28qNOxt
 tORW0trBvDWtuMaSHrOlyU9DbqF85NQcu73Y86CEg5IiffO118H3KBVJVdROM+YmCWju
 sZM1+M+oFu7OySujBHQtGSQsDrbMQb+cNz5Heb3atSG67Xh0d5pFo/xB+nKAdcBlS5JV
 AIwssGtc2OIJMVcFiMxIKwSP7sJVMoAtOECZMKMAa7ZsVYNjn4zbQ8zxkQgm3x+AHChz
 3o3sr+yIiY6iVtewfkSWBePGVLvrus4ufaVLtuGqhZqtOtThGa4RvlUqz+uVSv3RYjS+
 /Grg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=xp/ptP6GHYoR4dprEkGuqIx7nfia7pARblXeNADRoPc=;
 b=cC9+Jq9hGq6XkGnZMiM1aFMmOPK3GE0+tUTpnMrkJDAxHQKNgAudXPY8dDGeE9+ErY
 jqiBI4p2YvbXjmjB5VeBHWjS7RxR1Yf4GtHNytjkkpXG0VRDiUFITwh1RirkrDmvLXq7
 f9Kq+zgAQdHsEEZFdB5+9XyHmVPfGTwSHhL8iTEu6fvJFTXDxtnn2cSicsfJRnbiCEgY
 ulci7AjGYAeDhay7RQZomMSHVMQLVygMwBdr2IPPmAdc6NaCAXus1nDTBMb3Lu0md33u
 zd9MSShFu35MiOWmEDBT+3YKl0eKmVKWJXUFZzQMKABcoyj/G1j/Pbad5YoHc26iKopT
 R/Dw==
X-Gm-Message-State: AOAM530sHGPB8J5iBt4pFj7PBHyhbRkJqVEeEP/uvi8Egcb9b081pbBW
 oepbQrriUPgAj4TdgCWbqyjAGuzIP2Y=
X-Google-Smtp-Source: ABdhPJx3c/K/20VXsPlO7lHpv1hb2uYpJfg0w5vLysVbdTR5TivEt+ZJyIDpPmbVQxJRcwDH0YLtug==
X-Received: by 2002:a1c:ac86:: with SMTP id v128mr9233153wme.3.1632906972096; 
 Wed, 29 Sep 2021 02:16:12 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:4405:6e4f:ef81:78d1?
 ([2a02:908:1252:fb60:4405:6e4f:ef81:78d1])
 by smtp.gmail.com with ESMTPSA id n11sm1065337wmq.19.2021.09.29.02.16.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Sep 2021 02:16:11 -0700 (PDT)
Subject: Re: [PATCH 27/64] drm/amdgpu/nv: convert to IP version checking
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210928164237.833132-1-alexander.deucher@amd.com>
 <20210928164237.833132-28-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <a290f1ee-8526-b971-0b77-6c3864515097@gmail.com>
Date: Wed, 29 Sep 2021 11:16:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210928164237.833132-28-alexander.deucher@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 28.09.21 um 18:42 schrieb Alex Deucher:
> Use IP versions rather than asic_type to differentiate
> IP version specific features.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/nv.c | 75 +++++++++++++++++----------------
>   1 file changed, 38 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 0dc390a7509f..57be517d70bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -180,8 +180,8 @@ static const struct amdgpu_video_codecs yc_video_codecs_decode = {
>   static int nv_query_video_codecs(struct amdgpu_device *adev, bool encode,
>   				 const struct amdgpu_video_codecs **codecs)
>   {
> -	switch (adev->asic_type) {
> -	case CHIP_SIENNA_CICHLID:
> +	switch (adev->ip_versions[UVD_HWIP]) {
> +	case IP_VERSION(3, 0, 0):
>   		if (amdgpu_sriov_vf(adev)) {
>   			if (encode)
>   				*codecs = &sriov_sc_video_codecs_encode;
> @@ -194,29 +194,27 @@ static int nv_query_video_codecs(struct amdgpu_device *adev, bool encode,
>   				*codecs = &sc_video_codecs_decode;
>   		}
>   		return 0;
> -	case CHIP_NAVY_FLOUNDER:
> -	case CHIP_DIMGREY_CAVEFISH:
> -	case CHIP_VANGOGH:
> +	case IP_VERSION(3, 0, 16):
> +	case IP_VERSION(3, 0, 2):
>   		if (encode)
>   			*codecs = &nv_video_codecs_encode;
>   		else
>   			*codecs = &sc_video_codecs_decode;
>   		return 0;
> -	case CHIP_YELLOW_CARP:
> +	case IP_VERSION(3, 1, 1):
>   		if (encode)
>   			*codecs = &nv_video_codecs_encode;
>   		else
>   			*codecs = &yc_video_codecs_decode;
>   		return 0;
> -	case CHIP_BEIGE_GOBY:
> +	case IP_VERSION(3, 0, 33):
>   		if (encode)
>   			*codecs = &bg_video_codecs_encode;
>   		else
>   			*codecs = &bg_video_codecs_decode;
>   		return 0;
> -	case CHIP_NAVI10:
> -	case CHIP_NAVI14:
> -	case CHIP_NAVI12:
> +	case IP_VERSION(2, 0, 0):
> +	case IP_VERSION(2, 0, 2):
>   		if (encode)
>   			*codecs = &nv_video_codecs_encode;
>   		else
> @@ -511,14 +509,15 @@ nv_asic_reset_method(struct amdgpu_device *adev)
>   		dev_warn(adev->dev, "Specified reset method:%d isn't supported, using AUTO instead.\n",
>   				  amdgpu_reset_method);
>   
> -	switch (adev->asic_type) {
> -	case CHIP_VANGOGH:
> -	case CHIP_YELLOW_CARP:
> +	switch (adev->ip_versions[MP1_HWIP]) {
> +	case IP_VERSION(11, 5, 0):
> +	case IP_VERSION(13, 0, 1):
> +	case IP_VERSION(13, 0, 3):
>   		return AMD_RESET_METHOD_MODE2;
> -	case CHIP_SIENNA_CICHLID:
> -	case CHIP_NAVY_FLOUNDER:
> -	case CHIP_DIMGREY_CAVEFISH:
> -	case CHIP_BEIGE_GOBY:
> +	case IP_VERSION(11, 0, 7):
> +	case IP_VERSION(11, 0, 11):
> +	case IP_VERSION(11, 0, 12):
> +	case IP_VERSION(11, 0, 13):
>   		return AMD_RESET_METHOD_MODE1;
>   	default:
>   		if (amdgpu_dpm_is_baco_supported(adev))
> @@ -1042,8 +1041,11 @@ static int nv_common_early_init(void *handle)
>   
>   	adev->rev_id = nv_get_rev_id(adev);
>   	adev->external_rev_id = 0xff;
> -	switch (adev->asic_type) {
> -	case CHIP_NAVI10:
> +	/* TODO: split the GC and PG flags based on the relevant IP version for which
> +	 * they are relevant.
> +	 */
> +	switch (adev->ip_versions[GC_HWIP]) {
> +	case IP_VERSION(10, 1, 10):
>   		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
>   			AMD_CG_SUPPORT_GFX_CGCG |
>   			AMD_CG_SUPPORT_IH_CG |
> @@ -1065,7 +1067,7 @@ static int nv_common_early_init(void *handle)
>   			AMD_PG_SUPPORT_ATHUB;
>   		adev->external_rev_id = adev->rev_id + 0x1;
>   		break;
> -	case CHIP_NAVI14:
> +	case IP_VERSION(10, 1, 1):
>   		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
>   			AMD_CG_SUPPORT_GFX_CGCG |
>   			AMD_CG_SUPPORT_IH_CG |
> @@ -1086,7 +1088,7 @@ static int nv_common_early_init(void *handle)
>   			AMD_PG_SUPPORT_VCN_DPG;
>   		adev->external_rev_id = adev->rev_id + 20;
>   		break;
> -	case CHIP_NAVI12:
> +	case IP_VERSION(10, 1, 2):
>   		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
>   			AMD_CG_SUPPORT_GFX_MGLS |
>   			AMD_CG_SUPPORT_GFX_CGCG |
> @@ -1115,7 +1117,7 @@ static int nv_common_early_init(void *handle)
>   			adev->rev_id = 0;
>   		adev->external_rev_id = adev->rev_id + 0xa;
>   		break;
> -	case CHIP_SIENNA_CICHLID:
> +	case IP_VERSION(10, 3, 0):
>   		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
>   			AMD_CG_SUPPORT_GFX_CGCG |
>   			AMD_CG_SUPPORT_GFX_CGLS |
> @@ -1139,7 +1141,7 @@ static int nv_common_early_init(void *handle)
>   		}
>   		adev->external_rev_id = adev->rev_id + 0x28;
>   		break;
> -	case CHIP_NAVY_FLOUNDER:
> +	case IP_VERSION(10, 3, 2):
>   		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
>   			AMD_CG_SUPPORT_GFX_CGCG |
>   			AMD_CG_SUPPORT_GFX_CGLS |
> @@ -1158,8 +1160,7 @@ static int nv_common_early_init(void *handle)
>   			AMD_PG_SUPPORT_MMHUB;
>   		adev->external_rev_id = adev->rev_id + 0x32;
>   		break;
> -
> -	case CHIP_VANGOGH:
> +	case IP_VERSION(10, 3, 1):
>   		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
>   			AMD_CG_SUPPORT_GFX_MGLS |
>   			AMD_CG_SUPPORT_GFX_CP_LS |
> @@ -1182,7 +1183,7 @@ static int nv_common_early_init(void *handle)
>   		if (adev->apu_flags & AMD_APU_IS_VANGOGH)
>   			adev->external_rev_id = adev->rev_id + 0x01;
>   		break;
> -	case CHIP_DIMGREY_CAVEFISH:
> +	case IP_VERSION(10, 3, 4):
>   		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
>   			AMD_CG_SUPPORT_GFX_CGCG |
>   			AMD_CG_SUPPORT_GFX_CGLS |
> @@ -1201,7 +1202,7 @@ static int nv_common_early_init(void *handle)
>   			AMD_PG_SUPPORT_MMHUB;
>   		adev->external_rev_id = adev->rev_id + 0x3c;
>   		break;
> -	case CHIP_BEIGE_GOBY:
> +	case IP_VERSION(10, 3, 5):
>   		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
>   			AMD_CG_SUPPORT_GFX_CGCG |
>   			AMD_CG_SUPPORT_GFX_CGLS |
> @@ -1218,7 +1219,7 @@ static int nv_common_early_init(void *handle)
>   			AMD_PG_SUPPORT_MMHUB;
>   		adev->external_rev_id = adev->rev_id + 0x46;
>   		break;
> -	case CHIP_YELLOW_CARP:
> +	case IP_VERSION(10, 3, 3):
>   		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
>   			AMD_CG_SUPPORT_GFX_MGLS |
>   			AMD_CG_SUPPORT_GFX_CGCG |
> @@ -1247,7 +1248,7 @@ static int nv_common_early_init(void *handle)
>   		else
>   			adev->external_rev_id = adev->rev_id + 0x01;
>   		break;
> -	case CHIP_CYAN_SKILLFISH:
> +	case IP_VERSION(10, 1, 3):
>   		adev->cg_flags = 0;
>   		adev->pg_flags = 0;
>   		adev->external_rev_id = adev->rev_id + 0x82;
> @@ -1374,14 +1375,14 @@ static int nv_common_set_clockgating_state(void *handle,
>   	if (amdgpu_sriov_vf(adev))
>   		return 0;
>   
> -	switch (adev->asic_type) {
> -	case CHIP_NAVI10:
> -	case CHIP_NAVI14:
> -	case CHIP_NAVI12:
> -	case CHIP_SIENNA_CICHLID:
> -	case CHIP_NAVY_FLOUNDER:
> -	case CHIP_DIMGREY_CAVEFISH:
> -	case CHIP_BEIGE_GOBY:
> +	switch (adev->ip_versions[NBIO_HWIP]) {
> +	case IP_VERSION(2, 3, 0):
> +	case IP_VERSION(2, 3, 1):
> +	case IP_VERSION(2, 3, 2):
> +	case IP_VERSION(3, 3, 0):
> +	case IP_VERSION(3, 3, 1):
> +	case IP_VERSION(3, 3, 2):
> +	case IP_VERSION(3, 3, 3):
>   		adev->nbio.funcs->update_medium_grain_clock_gating(adev,
>   				state == AMD_CG_STATE_GATE);
>   		adev->nbio.funcs->update_medium_grain_light_sleep(adev,

