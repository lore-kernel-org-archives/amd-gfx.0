Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96390C3DA5D
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jul 2024 13:49:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 201C010E514;
	Mon, 22 Jul 2024 13:49:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PpZ530k0";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50A4810E514
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 13:49:14 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-42660b8dd27so30410585e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 06:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721656153; x=1722260953; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YuZaZxN8SxE3LQxjHYwuMTCAwhSvkabnxWypPbDS+9Q=;
 b=PpZ530k0PaWt9XrzG50jtHvd0DysqQ49UClyiwRVqMsvGvtRp1+TSPg4lDZumlMyIk
 IN8Osu0JlIysxHmv0sF4ylgQWCIqFR5zX65fLNV5NQaWWmrSfZL0NdUROQEwSA+R1xIP
 W8OKrt7WlmhQ8IoYvxjKpQxIfLx0uSAG/OH9LU0yILSB2xSxf2T9P+O4ruy6Qh6XjNCB
 rocjEh0RbIr9IuTkUd/Qww9PjROu43Pb75E/GUWGkGSdiyletx4r21fBmzw1rgfj+e6M
 Kk+5qWx8Sxw2sj0ZjdQKJ6ECdf/3RK4bQoqCZYGrUFLasibmT/cKTq/NigmOcDw50TER
 UUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721656153; x=1722260953;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YuZaZxN8SxE3LQxjHYwuMTCAwhSvkabnxWypPbDS+9Q=;
 b=UY48A+kOvKHsKaK1b5cRuR/03woQDKsZ8l8BjnTShfudS9nhduIjxZkRVeJxsPiVpZ
 IST3LjoYPYsd9GhqHf6nquY5W1o6l3XSvCILS7B5jdrAx5W4hi6dOHtXOGTO2EPDp0lU
 kmtkiRdEkUztHECXmZ+zM6a8v2AjF5OtfkZijhNhSKOCDr31thZZpA/J1ATRP5gF7CKv
 onPBW2a9gBYnSwvyqYthbiLXEXGtf8IFGoKH5V5T/8Nhs26DldPRy9xPoBlvJGxOE2s1
 53JlQ3TZONa3dra/n1hGUz/7NGGlW4oMyDD8cT/TII3sqS4QLXaJM0mXiGnEw3Zd88zu
 VekQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTFsDOVg82zaLbUJAmr6r7+K5CERdYZGHZIQkJhtqFfXErCR7W4pe29Hd4YKIcDuqu+4vIrEsWAIocEKfuTjTI6GjGwDLSzhU1pI+HiA==
X-Gm-Message-State: AOJu0YwsPuXDat8cjD7etWh+WDwmttAedgmU+bI00MJwljL4p9mS+lAd
 3AnTxg0hrGp4ec4JvUcW4ShZPUWkNerIfASDXY0TAYH0Emu8Zxdl
X-Google-Smtp-Source: AGHT+IGTdzOhupo+IXCTZd0Jnb7ufoSaLtqz8MjwMakSIlHtrpy1vgtqpliRjdKY9XrLIy3TfH6WvQ==
X-Received: by 2002:a05:600c:3ba3:b0:426:5de3:2ae5 with SMTP id
 5b1f17b1804b1-427dc520291mr53495385e9.10.1721656152200; 
 Mon, 22 Jul 2024 06:49:12 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d68fa171sm130498285e9.1.2024.07.22.06.49.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 06:49:11 -0700 (PDT)
Message-ID: <e3c11386-ddf6-47ab-8416-39694936db3f@gmail.com>
Date: Mon, 22 Jul 2024 15:49:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] drm/amdgpu/gfx11: Enable bad opcode interrupt
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Jesse Zhang <jesse.zhang@amd.com>, Prike Liang <Prike.Liang@amd.com>
References: <20240717204011.15342-1-alexander.deucher@amd.com>
 <20240717204011.15342-2-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240717204011.15342-2-alexander.deucher@amd.com>
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

Am 17.07.24 um 22:40 schrieb Alex Deucher:
> From: Jesse Zhang <jesse.zhang@amd.com>
>
> For the bad opcode case, it will cause CP/ME hang.
> The firmware will prevent the ME side from hanging by raising a bad opcode interrupt.
> And the driver needs to perform a vmid reset when receiving the interrupt.
>
> v2: update irq naming (drop priv) (Alex)
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> Reviewed-by: Prike Liang <Prike.Liang@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 73 ++++++++++++++++++++++++++
>   1 file changed, 73 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 02efa475eb7e..ce5cb60b8628 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1569,6 +1569,13 @@ static int gfx_v11_0_sw_init(void *handle)
>   	if (r)
>   		return r;
>   
> +	/* Bad opcode Event */
> +	r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_GRBM_CP,
> +			      GFX_11_0_0__SRCID__CP_BAD_OPCODE_ERROR,
> +			      &adev->gfx.bad_op_irq);
> +	if (r)
> +		return r;
> +
>   	/* Privileged reg */
>   	r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_GRBM_CP,
>   			      GFX_11_0_0__SRCID__CP_PRIV_REG_FAULT,
> @@ -4646,6 +4653,7 @@ static int gfx_v11_0_hw_fini(void *handle)
>   
>   	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
>   	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
> +	amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
>   
>   	if (!adev->no_hw_access) {
>   		if (amdgpu_async_gfx_ring) {
> @@ -5002,6 +5010,9 @@ static int gfx_v11_0_late_init(void *handle)
>   	if (r)
>   		return r;
>   
> +	r = amdgpu_irq_get(adev, &adev->gfx.bad_op_irq, 0);
> +	if (r)
> +		return r;
>   	return 0;
>   }
>   
> @@ -6293,6 +6304,51 @@ static int gfx_v11_0_set_priv_reg_fault_state(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> +static int gfx_v11_0_set_bad_op_fault_state(struct amdgpu_device *adev,
> +					    struct amdgpu_irq_src *source,
> +					    unsigned type,
> +					    enum amdgpu_interrupt_state state)
> +{
> +	u32 cp_int_cntl_reg, cp_int_cntl;
> +	int i , j;
> +
> +	switch (state) {
> +	case AMDGPU_IRQ_STATE_DISABLE:
> +	case AMDGPU_IRQ_STATE_ENABLE:

That switch is pretty pointless since state can only be disabled or enabled.

Most likely just c&p from an older version of the code and at some point 
lost it's relevance.

Apart from that the series looks good to me.

Regards,
Christian.

> +		for (i = 0; i < adev->gfx.me.num_me; i++) {
> +			for (j = 0; j < adev->gfx.me.num_pipe_per_me; j++) {
> +				cp_int_cntl_reg = gfx_v11_0_get_cpg_int_cntl(adev, i, j);
> +
> +				if (cp_int_cntl_reg) {
> +					cp_int_cntl = RREG32_SOC15_IP(GC, cp_int_cntl_reg);
> +					cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,
> +								    OPCODE_ERROR_INT_ENABLE,
> +								    state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
> +					WREG32_SOC15_IP(GC, cp_int_cntl_reg, cp_int_cntl);
> +				}
> +			}
> +		}
> +		for (i = 0; i < adev->gfx.mec.num_mec; i++) {
> +			for (j = 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
> +				/* MECs start at 1 */
> +				cp_int_cntl_reg = gfx_v11_0_get_cpc_int_cntl(adev, i + 1, j);
> +
> +				if (cp_int_cntl_reg) {
> +					cp_int_cntl = RREG32_SOC15_IP(GC, cp_int_cntl_reg);
> +					cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CP_ME1_PIPE0_INT_CNTL,
> +								    OPCODE_ERROR_INT_ENABLE,
> +								    state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
> +					WREG32_SOC15_IP(GC, cp_int_cntl_reg, cp_int_cntl);
> +				}
> +			}
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +	return 0;
> +}
> +
>   static int gfx_v11_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
>   					       struct amdgpu_irq_src *source,
>   					       unsigned int type,
> @@ -6369,6 +6425,15 @@ static int gfx_v11_0_priv_reg_irq(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> +static int gfx_v11_0_bad_op_irq(struct amdgpu_device *adev,
> +				struct amdgpu_irq_src *source,
> +				struct amdgpu_iv_entry *entry)
> +{
> +	DRM_ERROR("Illegal opcode in command stream \n");
> +	gfx_v11_0_handle_priv_fault(adev, entry);
> +	return 0;
> +}
> +
>   static int gfx_v11_0_priv_inst_irq(struct amdgpu_device *adev,
>   				   struct amdgpu_irq_src *source,
>   				   struct amdgpu_iv_entry *entry)
> @@ -6747,6 +6812,11 @@ static const struct amdgpu_irq_src_funcs gfx_v11_0_priv_reg_irq_funcs = {
>   	.process = gfx_v11_0_priv_reg_irq,
>   };
>   
> +static const struct amdgpu_irq_src_funcs gfx_v11_0_bad_op_irq_funcs = {
> +	.set = gfx_v11_0_set_bad_op_fault_state,
> +	.process = gfx_v11_0_bad_op_irq,
> +};
> +
>   static const struct amdgpu_irq_src_funcs gfx_v11_0_priv_inst_irq_funcs = {
>   	.set = gfx_v11_0_set_priv_inst_fault_state,
>   	.process = gfx_v11_0_priv_inst_irq,
> @@ -6764,6 +6834,9 @@ static void gfx_v11_0_set_irq_funcs(struct amdgpu_device *adev)
>   	adev->gfx.priv_reg_irq.num_types = 1;
>   	adev->gfx.priv_reg_irq.funcs = &gfx_v11_0_priv_reg_irq_funcs;
>   
> +	adev->gfx.bad_op_irq.num_types = 1;
> +	adev->gfx.bad_op_irq.funcs = &gfx_v11_0_bad_op_irq_funcs;
> +
>   	adev->gfx.priv_inst_irq.num_types = 1;
>   	adev->gfx.priv_inst_irq.funcs = &gfx_v11_0_priv_inst_irq_funcs;
>   

