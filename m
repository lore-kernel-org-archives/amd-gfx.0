Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 333CFC74A5B
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 06:16:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CC4D10E1B4;
	Thu, 30 Mar 2023 06:16:09 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C361510E1B4
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 06:16:07 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id cn12so72278009edb.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 23:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680156966;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9XvCvteZjYBR8H8BFGIIVoPM8gD5ooYM4zfNV6A/oDg=;
 b=OFU6exh1B3sq5PNdtYmT5yILsrG4k07RVHFqNuBapMjxdBUtJMAo2xgRjYXVP+8laI
 vOrY1fZtSmThJkENZDoq2AR9Zt5501ChkKZR0uaryQZ4HugqMjXQe8a3TE8dvIsiVQv6
 Hxl+3tzlMDvsLvOjLY6+KPYYUhArhTQInGp+djGJgYvxMdmzbO8+0YK7fUZQVvJYXRiU
 At/J9NgBXQNaKALF3Xb6820O7yXhxVR+eEQzulCJRgA4NtcQLD6c6RoNAWSMXBMo3wh/
 FSFFN9QWabCFWej0khsmXkwjoe7JwUcFhq0JQYJbGho3AKAV0zb+aVlcHoDcE3T85c2p
 V5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680156966;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9XvCvteZjYBR8H8BFGIIVoPM8gD5ooYM4zfNV6A/oDg=;
 b=KIporfVgHPfBFw+LWKuQva7N2AaXGGc1vXNVjKZ8db1zefCYhPMlrq9SCuBxyzOEKw
 GIodLkbhZd6CthtLP/AwdujHgzM6Hk2ztlMJuCERofppFdTt/CW1mD76dvlz6ujVIKzs
 GbccwXvM3vKzG3RV85tjOUq8damTeFFfuvGV9oLV1GMTR2+kHrXBYuUz+X4fZiUv9q5Z
 Phiu2lK981tjFXBeTx+z4FzH455Oh3230t/p1pqNhpcqyCNhVMCMb4Vu0BhCmMjCRc3b
 fbZ8WrN1BJc9SiE1q70LW3qDm9V3+qZeHb8k0z7un2lCBeeTY8secHYAvu1td1rd9l30
 lt1Q==
X-Gm-Message-State: AAQBX9eg8OroMve71HT4jr7biRsqTQn88MpR39QAOIRTeigoqqn1myno
 X/KrDWzBFdkinl71NO6WUho=
X-Google-Smtp-Source: AKy350aUC+cOu3iV4awGeIa69A1Bt4YDj3KEBvf2KsDqAmvt5IO3NsTzTJHidZJ5wai0rLhayn5GIg==
X-Received: by 2002:a17:906:74f:b0:933:3b2e:6016 with SMTP id
 z15-20020a170906074f00b009333b2e6016mr21858539ejb.7.1680156966034; 
 Wed, 29 Mar 2023 23:16:06 -0700 (PDT)
Received: from [192.168.178.21] (p4fc2092b.dip0.t-ipconnect.de. [79.194.9.43])
 by smtp.gmail.com with ESMTPSA id
 bb11-20020a1709070a0b00b0093dce4e6257sm8280713ejc.201.2023.03.29.23.16.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Mar 2023 23:16:05 -0700 (PDT)
Message-ID: <e0800275-c356-bbad-ac5a-c92cf0d14c35@gmail.com>
Date: Thu, 30 Mar 2023 08:16:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 09/13] drm/amdgpu: add get_gfx_shadow_info callback for
 gfx11
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329152521.1980681-1-alexander.deucher@amd.com>
 <20230329152521.1980681-10-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230329152521.1980681-10-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Am 29.03.23 um 17:25 schrieb Alex Deucher:
> Used to get the size and alignment requirements for
> the gfx shadow buffer for preemption.
>
> v2: use FW version check to determine whether to
>      return a valid size here
>      return an error if not supported (Alex)
> v3: drop GDS (Alex)
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 1fc1e941f7df..df2eabf50e6e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -822,6 +822,30 @@ static void gfx_v11_0_select_me_pipe_q(struct amdgpu_device *adev,
>   	soc21_grbm_select(adev, me, pipe, q, vm);
>   }
>   
> +/* all sizes are in bytes */
> +#define MQD_SHADOW_BASE_SIZE      73728
> +#define MQD_SHADOW_BASE_ALIGNMENT 256
> +#define MQD_FWWORKAREA_SIZE       484
> +#define MQD_FWWORKAREA_ALIGNMENT  256
> +
> +static int gfx_v11_0_get_gfx_shadow_info(struct amdgpu_device *adev,
> +					 struct amdgpu_gfx_shadow_info *shadow_info)
> +{
> +	if (shadow_info) {

Why would anybody call this without parameter?

Christian.

> +		if (adev->gfx.cp_gfx_shadow) {
> +			shadow_info->shadow_size = MQD_SHADOW_BASE_SIZE;
> +			shadow_info->shadow_alignment = MQD_SHADOW_BASE_ALIGNMENT;
> +			shadow_info->csa_size = MQD_FWWORKAREA_SIZE;
> +			shadow_info->csa_alignment = MQD_FWWORKAREA_ALIGNMENT;
> +			return 0;
> +		} else {
> +			memset(shadow_info, 0, sizeof(struct amdgpu_gfx_shadow_info));
> +			return -ENOTSUPP;
> +		}
> +	}
> +	return -EINVAL;
> +}
> +
>   static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_funcs = {
>   	.get_gpu_clock_counter = &gfx_v11_0_get_gpu_clock_counter,
>   	.select_se_sh = &gfx_v11_0_select_se_sh,
> @@ -830,6 +854,7 @@ static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_funcs = {
>   	.read_wave_vgprs = &gfx_v11_0_read_wave_vgprs,
>   	.select_me_pipe_q = &gfx_v11_0_select_me_pipe_q,
>   	.update_perfmon_mgcg = &gfx_v11_0_update_perf_clk,
> +	.get_gfx_shadow_info = &gfx_v11_0_get_gfx_shadow_info,
>   };
>   
>   static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)

