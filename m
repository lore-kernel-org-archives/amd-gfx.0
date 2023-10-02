Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F595E784AF
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Oct 2023 10:30:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6139A10E27A;
	Mon,  2 Oct 2023 10:30:45 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 960AE10E27A
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Oct 2023 10:30:23 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-406619b53caso24108375e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Oct 2023 03:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696242622; x=1696847422; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CDOjH25eQbTqly8iVeFqUYGsGoEv6ZjIqYuzVbRfXrE=;
 b=Go28Aj+815VRMjXBroj3/51Gee5phavC7fIutvRvmBf/Obcg4x+Y1liAh9I8vsREQS
 bq6kr1sJjix+4XCIPA603qIfMM/q6T94P6yDQ2SiHVr0mxJAwQYr6mBusdZLsjPgzlx+
 HhEfISChklIcjfQmRjgXxjXfSZ04576mZt/lDNHBEuDyJzxAyX/vFwniRxoeTzpz0gSk
 WGOGXfY7ECHDvbJTHO7nRYpyKLwzBbiY13a5iWqiXR+ct0Trtqdfi1yqgWa8wpjwGQnN
 oWd2cg42DtUZlJ3JL0v8eVRRDqlFNZopGqhmhcX3N5WaSWu4lS4KR4lU5/JBQ1FfVjIA
 AliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696242622; x=1696847422;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CDOjH25eQbTqly8iVeFqUYGsGoEv6ZjIqYuzVbRfXrE=;
 b=ac8y09my1DJaqPslyk7dOHneRTFkN7Z78CEITAzttSZ5jFhfjnDJbEqPMx7qCJW5uF
 6fROYFrez8KaBOWGhrcji/pednNZbgPMIiKX0SpKLFzEzs3wn8gDstiHNj5dzhVU9KTz
 /LjZc3fKmLHDKykp1Ce33URYQ2eTLT1wAjOmS48ZvsHy/C/jlMcmZ6aZCajUvLiRg43x
 GJ2B5oKXaMbL1eU6AVqHT49nKnFhVDGnfW4MFPGA2EkGELP8n1Zo/xEP4lB5P7xHBKJv
 8Ej7b7RDMIovgXQi5xWXUThdljanjHA3HeGvVlhIpUlKoSZ99uZ4f6FdS6ZZhtdBqMlh
 ahvQ==
X-Gm-Message-State: AOJu0Yyo1cIb9YMp1AI3eMT+RUOdfmDfM6pvmMJdVmJrUANLa0xNB299
 ZwTZZl3Z0tCfrwmCDXhA7sc=
X-Google-Smtp-Source: AGHT+IGkyA7fU5hQhT+pLiV8+OVJ9ipTmIjnqVWp4sYTEEBhMuocR7vRDh1nAZrfkcbyyEzJtb2w1g==
X-Received: by 2002:a05:600c:21d1:b0:405:3ae6:2413 with SMTP id
 x17-20020a05600c21d100b004053ae62413mr9459976wmj.25.1696242621559; 
 Mon, 02 Oct 2023 03:30:21 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 x13-20020a1c7c0d000000b0040472ad9a3dsm6893891wmc.14.2023.10.02.03.30.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 03:30:20 -0700 (PDT)
Message-ID: <4412e272-1617-8e0e-583c-92881a00cd7d@gmail.com>
Date: Mon, 2 Oct 2023 12:30:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] drm/amdgpu: Drop unnecessary return statements
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20230930040736.1153256-1-srinivasan.shanmugam@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230930040736.1153256-1-srinivasan.shanmugam@amd.com>
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 30.09.23 um 06:07 schrieb Srinivasan Shanmugam:
> There is no reason to call return at the end of function that
> returns void.
>
> Fixes the below:
>
> WARNING: void function return statements are not generally useful
>
> Thus remove such a statement in the affected functions.
>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h | 1 -
>   drivers/gpu/drm/amd/amdgpu/atombios_encoders.c | 1 -
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c        | 2 --
>   drivers/gpu/drm/amd/amdgpu/ih_v6_0.c           | 4 ----
>   drivers/gpu/drm/amd/amdgpu/navi10_ih.c         | 4 ----
>   drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c         | 3 ---
>   drivers/gpu/drm/amd/amdgpu/nv.c                | 2 --
>   drivers/gpu/drm/amd/amdgpu/soc21.c             | 2 --
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c          | 2 --
>   9 files changed, 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
> index 3c988cc406e4..381101d2bf05 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
> @@ -112,7 +112,6 @@ static inline void amdgpu_res_first(struct ttm_resource *res,
>   	cur->remaining = size;
>   	cur->node = NULL;
>   	WARN_ON(res && start + size > res->size);
> -	return;
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> index d95b2dc78063..3ee219aa2891 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> @@ -228,7 +228,6 @@ void amdgpu_atombios_encoder_init_backlight(struct amdgpu_encoder *amdgpu_encode
>   register_acpi_backlight:
>   	/* Try registering an ACPI video backlight device instead. */
>   	acpi_video_register_backlight();
> -	return;
>   }
>   
>   void
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> index e7ae37233234..065b2bd5f5a6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> @@ -746,8 +746,6 @@ void gfx_v9_4_2_init_golden_registers(struct amdgpu_device *adev,
>   			 die_id);
>   		break;
>   	}
> -
> -	return;
>   }
>   
>   void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> index ec0c8f8b465a..d9ed7332d805 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> @@ -641,8 +641,6 @@ static void ih_v6_0_update_clockgating_state(struct amdgpu_device *adev,
>   		if (def != data)
>   			WREG32_SOC15(OSSSYS, 0, regIH_CLK_CTRL, data);
>   	}
> -
> -	return;
>   }
>   
>   static int ih_v6_0_set_clockgating_state(void *handle,
> @@ -726,8 +724,6 @@ static void ih_v6_0_get_clockgating_state(void *handle, u64 *flags)
>   
>   	if (!RREG32_SOC15(OSSSYS, 0, regIH_CLK_CTRL))
>   		*flags |= AMD_CG_SUPPORT_IH_CG;
> -
> -	return;
>   }
>   
>   static const struct amd_ip_funcs ih_v6_0_ip_funcs = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> index bb1873363d75..e64b33115848 100644
> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> @@ -665,8 +665,6 @@ static void navi10_ih_update_clockgating_state(struct amdgpu_device *adev,
>   		if (def != data)
>   			WREG32_SOC15(OSSSYS, 0, mmIH_CLK_CTRL, data);
>   	}
> -
> -	return;
>   }
>   
>   static int navi10_ih_set_clockgating_state(void *handle,
> @@ -691,8 +689,6 @@ static void navi10_ih_get_clockgating_state(void *handle, u64 *flags)
>   
>   	if (!RREG32_SOC15(OSSSYS, 0, mmIH_CLK_CTRL))
>   		*flags |= AMD_CG_SUPPORT_IH_CG;
> -
> -	return;
>   }
>   
>   static const struct amd_ip_funcs navi10_ih_ip_funcs = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
> index f85eec05d218..cc034a740605 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
> @@ -173,8 +173,6 @@ static void nbio_v7_9_sdma_doorbell_range(struct amdgpu_device *adev, int instan
>   	default:
>   		break;
>   	}
> -
> -	return;
>   }
>   
>   static void nbio_v7_9_vcn_doorbell_range(struct amdgpu_device *adev, bool use_doorbell,
> @@ -556,7 +554,6 @@ const struct amdgpu_nbio_funcs nbio_v7_9_funcs = {
>   static void nbio_v7_9_query_ras_error_count(struct amdgpu_device *adev,
>   					void *ras_error_status)
>   {
> -	return;
>   }
>   
>   static void nbio_v7_9_handle_ras_controller_intr_no_bifring(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 0535cabe3b16..1995c7459f20 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -1115,8 +1115,6 @@ static void nv_common_get_clockgating_state(void *handle, u64 *flags)
>   	adev->hdp.funcs->get_clock_gating_state(adev, flags);
>   
>   	adev->smuio.funcs->get_clock_gating_state(adev, flags);
> -
> -	return;
>   }
>   
>   static const struct amd_ip_funcs nv_common_ip_funcs = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index 92a80780ab72..6fcc4f7be117 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -885,8 +885,6 @@ static void soc21_common_get_clockgating_state(void *handle, u64 *flags)
>   	adev->nbio.funcs->get_clockgating_state(adev, flags);
>   
>   	adev->hdp.funcs->get_clock_gating_state(adev, flags);
> -
> -	return;
>   }
>   
>   static const struct amd_ip_funcs soc21_common_ip_funcs = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index 96831f931423..88e17f5e20b2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -877,8 +877,6 @@ static void vcn_v4_0_enable_clock_gating(struct amdgpu_device *adev, int inst)
>   		| UVD_SUVD_CGC_CTRL__IME_MODE_MASK
>   		| UVD_SUVD_CGC_CTRL__SITE_MODE_MASK);
>   	WREG32_SOC15(VCN, inst, regUVD_SUVD_CGC_CTRL, data);
> -
> -	return;
>   }
>   
>   static void vcn_v4_0_enable_ras(struct amdgpu_device *adev, int inst_idx,

