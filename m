Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2439AC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 11:04:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7357D1122E6;
	Tue, 11 Jan 2022 11:04:49 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7C2D10F4C9
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 11:04:47 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 q9-20020a7bce89000000b00349e697f2fbso574625wmj.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 03:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=aanpBfHBAUjfC3pclVLQ2CxQXaho+PFqjiZxy7LZZh0=;
 b=lgH53HNDX79hOGhrL7FT2qjzzlYFvKTIoe7YovC6ukRDX9alogRidLVwAtbMnVvSn6
 bIeJY/6WX/Gs1AY0SXt9QtWzbWhsB4d9ulC2YCGPwYYN5S223hNLqibKTbxGYGSoVpLO
 bjII6treou2HMzpJc5uHiI8VYPn2HCpE8W402RUnuo2m+kRYG6ZfF6O9/lFKSfFrD/wl
 6uBcXOcHRNTz5CNzjlriab3fShdCkFnznPPlaf9E/DI6/28Ct1+t/Ai9dBKhhQNYMOUW
 HeeFROfjGwbnYmehKodhC1o3RGNSsZeNO7HHaPGx4UGQMQzCtOMArH8Crl1GQtkMKu2j
 +ZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=aanpBfHBAUjfC3pclVLQ2CxQXaho+PFqjiZxy7LZZh0=;
 b=E+LbhJj9mP3GvWwuQGbZm1lraVXZckl+r26+fnkQbtuuM8Ovh26hdLuqQbw9McqrsI
 2781r+w1KnsWgMbF/j4rV1s7v1WwBZo+38BAAriZS49bP5JRNlb7uQEOTe5hEO99u6Df
 mUodNa/byQKrrH1nGU58pIYLyPAd7jSP16ilkYC8gCorRE7E7mP90UCHy6fyH+yzLc/V
 auY4TIMfXDq/ZTPfroGVoRW/nE5fLJ9PwqQ66v2NuCwqzGgq9gi66t/h6B0p+rR0f7B4
 9YKNyFpYqjNDM/lAUKoxz/P0DE9oYKagbJZ34Q7OOz5szJz+TyrhKa/STSa0V2EXxnKe
 Tx/A==
X-Gm-Message-State: AOAM533bke/wM5J1ZTXfeYWdfdXHGjKWMcYoevPg1KAHxEQdq7AVcAeF
 v9rsR3o0wQ/2FsjkbDUHSjw=
X-Google-Smtp-Source: ABdhPJy8DV7yclhXaytBBFOwhQXgxHtubRst79Lz53KgYMEpZzagjUtMlLn/ygf3x8B2K7zlJileaA==
X-Received: by 2002:a1c:44d7:: with SMTP id r206mr1967585wma.79.1641899086207; 
 Tue, 11 Jan 2022 03:04:46 -0800 (PST)
Received: from [192.168.178.21] (p57b0bff8.dip0.t-ipconnect.de.
 [87.176.191.248])
 by smtp.gmail.com with ESMTPSA id u11sm1508139wmq.2.2022.01.11.03.04.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jan 2022 03:04:45 -0800 (PST)
Subject: Re: [PATCH 1/3] drm/amdgpu: add reset register dump function for
 gfx_v10_0
To: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220111071119.5464-1-Amaranath.Somalapuram@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <1b0dfcf1-f483-94a7-2061-1283ec36c07d@gmail.com>
Date: Tue, 11 Jan 2022 12:04:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220111071119.5464-1-Amaranath.Somalapuram@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 11.01.22 um 08:11 schrieb Somalapuram Amaranath:
> Implementation of register dump function when the AMD GPU resets
>
> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 55 +++++++++++++++++++++++-
>   drivers/gpu/drm/amd/include/amd_shared.h |  2 +
>   2 files changed, 56 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index dbe7442fb25c..dbd74204f06d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -7466,7 +7466,6 @@ static int gfx_v10_0_hw_init(void *handle)
>   {
>   	int r;
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -
>   	if (!amdgpu_emu_mode)
>   		gfx_v10_0_init_golden_registers(adev);
>   
> @@ -7580,6 +7579,59 @@ static int gfx_v10_0_hw_fini(void *handle)
>   	return 0;
>   }
>   
> +static int gfx_v10_0_reset_reg_dumps(void *handle,
> +		uint32_t (**dump)[2], uint32_t *n_regs, char ***r_names)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	uint32_t i = 0;
> +
> +#define N_REGS (17)
> +#define DUMP_REG(addr) do {				\
> +		(*dump)[i][0] = (addr);			\
> +		(*dump)[i++][1] = RREG32(addr);		\
> +	} while (0)

Please no unprefixed local defines like this.

> +
> +	char *reg_names[N_REGS] = {
> +		"mmGRBM_STATUS2", "mmGRBM_STATUS_SE0", "mmGRBM_STATUS_SE1",
> +		"mmGRBM_STATUS_SE2", "mmGRBM_STATUS_SE3", "mmSDMA0_STATUS_REG",
> +		"mmSDMA1_STATUS_REG", "mmCP_STAT", "mmCP_STALLED_STAT1",
> +		"mmCP_STALLED_STAT1", "mmCP_STALLED_STAT3", "mmCP_CPC_STATUS",
> +		"mmCP_CPC_BUSY_STAT", "mmCP_CPC_STALLED_STAT1", "mmCP_CPF_STATUS",
> +		"mmCP_CPF_BUSY_STAT", "mmCP_CPF_STALLED_STAT1"
> +	};

IIRC you can avoid that by stringifying the names in the macro, but in 
general I think the kernel should not have those names.

Only userspace needs to be able to match the register number to the name.

Regards,
Christian.

> +
> +	*dump = kmalloc(N_REGS*2*sizeof(uint32_t), GFP_KERNEL);
> +	if (*dump == NULL)
> +		return -ENOMEM;
> +	DUMP_REG(mmGRBM_STATUS2);
> +	DUMP_REG(mmGRBM_STATUS_SE0);
> +	DUMP_REG(mmGRBM_STATUS_SE1);
> +	DUMP_REG(mmGRBM_STATUS_SE2);
> +	DUMP_REG(mmGRBM_STATUS_SE3);
> +	DUMP_REG(mmSDMA0_STATUS_REG);
> +	DUMP_REG(mmSDMA1_STATUS_REG);
> +	DUMP_REG(mmCP_STAT);
> +	DUMP_REG(mmCP_STALLED_STAT1);
> +	DUMP_REG(mmCP_STALLED_STAT1);
> +	DUMP_REG(mmCP_STALLED_STAT3);
> +	DUMP_REG(mmCP_CPC_STATUS);
> +	DUMP_REG(mmCP_CPC_BUSY_STAT);
> +	DUMP_REG(mmCP_CPC_STALLED_STAT1);
> +	DUMP_REG(mmCP_CPF_STATUS);
> +	DUMP_REG(mmCP_CPF_BUSY_STAT);
> +	DUMP_REG(mmCP_CPF_STALLED_STAT1);

> +
> +	*n_regs = i;
> +
> +	(*r_names) = kcalloc(N_REGS, sizeof(char *), GFP_KERNEL);
> +	for (i = 0; i < N_REGS; i++) {
> +		(*r_names)[i] = kcalloc(30, sizeof(char), GFP_KERNEL);
> +		strcpy((*r_names)[i], reg_names[i]);
> +	}
> +
> +	return 0;
> +}
> +
>   static int gfx_v10_0_suspend(void *handle)
>   {
>   	return gfx_v10_0_hw_fini(handle);
> @@ -9359,6 +9411,7 @@ static const struct amd_ip_funcs gfx_v10_0_ip_funcs = {
>   	.set_clockgating_state = gfx_v10_0_set_clockgating_state,
>   	.set_powergating_state = gfx_v10_0_set_powergating_state,
>   	.get_clockgating_state = gfx_v10_0_get_clockgating_state,
> +	.reset_reg_dumps = gfx_v10_0_reset_reg_dumps,
>   };
>   
>   static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index 4b9e68a79f06..98291a8f57dd 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -298,6 +298,8 @@ struct amd_ip_funcs {
>   				     enum amd_powergating_state state);
>   	void (*get_clockgating_state)(void *handle, u32 *flags);
>   	int (*enable_umd_pstate)(void *handle, enum amd_dpm_forced_level *level);
> +	int (*reset_reg_dumps)(void *handle,
> +			uint32_t (**dump)[2], uint32_t *n_regs, char ***r_names);
>   };
>   
>   

