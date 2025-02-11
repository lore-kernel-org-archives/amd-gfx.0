Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABE4C0219E
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2025 07:50:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F1E810E422;
	Tue, 11 Feb 2025 07:50:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D10EAo89";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82F2E10E3A9
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2025 07:50:27 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-38dd14c9a66so1273762f8f.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 23:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739260226; x=1739865026; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LyGCiQCKgEJPXQcBpPORkG6W7TfByA+7+D3bjpj2Upc=;
 b=D10EAo89RxGc22xOOhFEb+JoAVhM81TWAlu+BgTU5fXUWyyKLNtx+iqznz1x6k15J5
 QvS8C1dPMUrkjGoevY8S14cTJG+9W5m/AgD08ZUdfYZEBHtrnffJ/aGto9hU5+N96vrw
 FzryjlrvP6U6E9CvMe97PVDQE2bjaFppERfQkAjZQfRMmzygxLglSqGzo2lw8ANcGsCw
 6RZdOa3ToQBWia0dZN2NtSlMp2P/AXNXseQ7z88iG9pHmdd4U22hMPIFBYqHsx+0enTA
 HMMctHQixnAfM3dpo5fAuftR6qY7KER6WIOjwYO+OXq0MoSuH2G+nldNBTukepfFx/SN
 gIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739260226; x=1739865026;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LyGCiQCKgEJPXQcBpPORkG6W7TfByA+7+D3bjpj2Upc=;
 b=oSQyVg7TiJ/YOIC3IHZocmhL3XNJjhEDANsDbrvlLpSjdM9b4OthjyR7OLXK0tPQCD
 ECZyQ/t5V4mZiDFj6wHhemrFZt0g4HgskgMwHcOyGa0A7hKvwnew2b52NmQ+NcyspIbE
 H3tkuqB1QOVVnUhQJs5/HX9irJUFTGbXGLhrfS0F4Kfl7y/HinQjUNv/+cFAkN0ZF+7x
 lIlod3Ac6ypHEyXmIdWZO4CjDlpOH9N730GjE44U0iUz7sQsNXkCS+5DMynjGAAEbU8/
 +QfVgZm62O2+JQ4s86zqSQWstUJsT+ujmYG9U4pXHoDXAqUgJRRJLEf8004YUOeWQgdW
 7YDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3g0Uw4e0C9sUuVobSTj2PnVOy6GDMukfn5KIiMi2a7bydrrCRs+gcbZXPJUNgmFTCmqjl41JP@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzKYMgh2rVB4wKGaPUPJb0yorhnECPw9cHB9F3cM+vsgRLJB2xx
 X0441CuF1ZxJjAq0lM9eH5PQ935zyN7P+wEaZLby+IMcHEZ1Kuta
X-Gm-Gg: ASbGncsGevYM1sPcdTlmN8OHiLHxu2iKfJAd3GsAMCuBOoNB5weHlJJw0bnniK2nNNP
 as6cT9+X6KWdmm/cE65mP0+HkbXIlgz1Sxaoc+ab067v9/A5eDxZ1JnBhZ5tzhRQ9nNr2+3PFRj
 +ldNpCCg2lorW1gcBwIxlIhYncFdP9a70zO6+65vmGyo6Br9oAuS88A5AQ0NusQSm69VCxMxeCE
 gwav/xDxlWNR2D3JQYwKelOL3UurjRytStzoFeKPgIeoZ8aGvArhC5Tgh69IwCgK3el82cdKNgl
 pXDFE1uAc7N9/1DolMckz+sXNXZmlJwtSRD7+KhPIf/y
X-Google-Smtp-Source: AGHT+IHE5C3DSM3SMgKMSkCqwSzJrRlwuQZEOrcOlHXN+whZxFgKW4UVimj66WH7yT4YIalinta5tA==
X-Received: by 2002:a5d:64c2:0:b0:38d:df2d:7ac8 with SMTP id
 ffacd0b85a97d-38ddf2d7d5dmr6441392f8f.25.1739260225629; 
 Mon, 10 Feb 2025 23:50:25 -0800 (PST)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393b66f3e3sm80649275e9.19.2025.02.10.23.50.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 23:50:24 -0800 (PST)
Message-ID: <3b0f5a69-5819-4c24-9e0f-e3373cbcd6f4@gmail.com>
Date: Tue, 11 Feb 2025 08:50:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Set snoop bit for SDMA for MI series
To: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20250206210721.200197-1-Harish.Kasiviswanathan@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20250206210721.200197-1-Harish.Kasiviswanathan@amd.com>
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

Am 06.02.25 um 22:07 schrieb Harish Kasiviswanathan:
> SDMA writes has to probe invalidate RW lines. Set snoop bit in mmhub for
> this to happen.
>
> v2: Missed a few mmhub_v9_4. Added now.
> v3: Calculate hub offset once since it doesn't change inside the loop
>      Modified function names based on review comments.
>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c       | 25 ++++++++++
>   drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c       | 27 +++++++++++
>   drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c       | 31 ++++++++++++
>   .../asic_reg/mmhub/mmhub_9_4_1_offset.h       | 32 +++++++++++++
>   .../asic_reg/mmhub/mmhub_9_4_1_sh_mask.h      | 48 +++++++++++++++++++
>   5 files changed, 163 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
> index 9689e2b5d4e5..1383acb5aece 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
> @@ -172,6 +172,30 @@ static void mmhub_v1_7_init_tlb_regs(struct amdgpu_device *adev)
>   	WREG32_SOC15(MMHUB, 0, regMC_VM_MX_L1_TLB_CNTL, tmp);
>   }
>   
> +/* Set snoop bit for SDMA so that SDMA writes probe-invalidates RW lines */
> +static void mmhub_v1_7_init_snoop_override_regs(struct amdgpu_device *adev)
> +{
> +	uint32_t tmp;
> +	int j;
> +	uint32_t distance = regDAGB1_WRCLI_GPU_SNOOP_OVERRIDE -
> +			    regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE;

Please keep short declarations last. Apart from that looks good to me.

Regards,
Christian.

> +
> +	for (j = 0; j < 5; j++) { /* DAGB instances */
> +		tmp = RREG32_SOC15_OFFSET(MMHUB, 0,
> +			regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE, j * distance);
> +		tmp |= (1 << 15); /* SDMA client is BIT15 */
> +		WREG32_SOC15_OFFSET(MMHUB, 0,
> +			regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE, j * distance, tmp);
> +
> +		tmp = RREG32_SOC15_OFFSET(MMHUB, 0,
> +			regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE, j * distance);
> +		tmp |= (1 << 15);
> +		WREG32_SOC15_OFFSET(MMHUB, 0,
> +			regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE, j * distance, tmp);
> +	}
> +
> +}
> +
>   static void mmhub_v1_7_init_cache_regs(struct amdgpu_device *adev)
>   {
>   	uint32_t tmp;
> @@ -337,6 +361,7 @@ static int mmhub_v1_7_gart_enable(struct amdgpu_device *adev)
>   	mmhub_v1_7_init_system_aperture_regs(adev);
>   	mmhub_v1_7_init_tlb_regs(adev);
>   	mmhub_v1_7_init_cache_regs(adev);
> +	mmhub_v1_7_init_snoop_override_regs(adev);
>   
>   	mmhub_v1_7_enable_system_domain(adev);
>   	mmhub_v1_7_disable_identity_aperture(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> index e646e5cef0a2..ce013a715b86 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> @@ -213,6 +213,32 @@ static void mmhub_v1_8_init_tlb_regs(struct amdgpu_device *adev)
>   	}
>   }
>   
> +/* Set snoop bit for SDMA so that SDMA writes probe-invalidates RW lines */
> +static void mmhub_v1_8_init_snoop_override_regs(struct amdgpu_device *adev)
> +{
> +	uint32_t tmp, inst_mask;
> +	int i, j;
> +	uint32_t distance = regDAGB1_WRCLI_GPU_SNOOP_OVERRIDE -
> +			    regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE;
> +
> +	inst_mask = adev->aid_mask;
> +	for_each_inst(i, inst_mask) {
> +		for (j = 0; j < 5; j++) { /* DAGB instances */
> +			tmp = RREG32_SOC15_OFFSET(MMHUB, i,
> +				regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE, j * distance);
> +			tmp |= (1 << 15); /* SDMA client is BIT15 */
> +			WREG32_SOC15_OFFSET(MMHUB, i,
> +				regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE, j * distance, tmp);
> +
> +			tmp = RREG32_SOC15_OFFSET(MMHUB, i,
> +				regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE, j * distance);
> +			tmp |= (1 << 15);
> +			WREG32_SOC15_OFFSET(MMHUB, i,
> +				regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE, j * distance, tmp);
> +		}
> +	}
> +}
> +
>   static void mmhub_v1_8_init_cache_regs(struct amdgpu_device *adev)
>   {
>   	uint32_t tmp, inst_mask;
> @@ -418,6 +444,7 @@ static int mmhub_v1_8_gart_enable(struct amdgpu_device *adev)
>   	mmhub_v1_8_init_system_aperture_regs(adev);
>   	mmhub_v1_8_init_tlb_regs(adev);
>   	mmhub_v1_8_init_cache_regs(adev);
> +	mmhub_v1_8_init_snoop_override_regs(adev);
>   
>   	mmhub_v1_8_enable_system_domain(adev);
>   	mmhub_v1_8_disable_identity_aperture(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> index ff1b58e44689..fe0710b55c3a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> @@ -198,6 +198,36 @@ static void mmhub_v9_4_init_tlb_regs(struct amdgpu_device *adev, int hubid)
>   			    hubid * MMHUB_INSTANCE_REGISTER_OFFSET, tmp);
>   }
>   
> +/* Set snoop bit for SDMA so that SDMA writes probe-invalidates RW lines */
> +static void mmhub_v9_4_init_snoop_override_regs(struct amdgpu_device *adev, int hubid)
> +{
> +	uint32_t tmp;
> +	int i;
> +	uint32_t distance = mmDAGB1_WRCLI_GPU_SNOOP_OVERRIDE -
> +			    mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE;
> +	uint32_t huboffset = hubid * MMHUB_INSTANCE_REGISTER_OFFSET;
> +
> +	for (i = 0; i < 5 - (2 * hubid); i++) {
> +		/* DAGB instances 0 to 4 are in hub0 and 5 to 7 are in hub1 */
> +		tmp = RREG32_SOC15_OFFSET(MMHUB, 0,
> +			mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE,
> +			huboffset + i * distance);
> +		tmp |= (1 << 15); /* SDMA client is BIT15 */
> +		WREG32_SOC15_OFFSET(MMHUB, 0,
> +			mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE,
> +			huboffset + i * distance, tmp);
> +
> +		tmp = RREG32_SOC15_OFFSET(MMHUB, 0,
> +			mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE,
> +			huboffset + i * distance);
> +		tmp |= (1 << 15);
> +		WREG32_SOC15_OFFSET(MMHUB, 0,
> +			mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE,
> +			huboffset + i * distance, tmp);
> +	}
> +
> +}
> +
>   static void mmhub_v9_4_init_cache_regs(struct amdgpu_device *adev, int hubid)
>   {
>   	uint32_t tmp;
> @@ -392,6 +422,7 @@ static int mmhub_v9_4_gart_enable(struct amdgpu_device *adev)
>   		if (!amdgpu_sriov_vf(adev))
>   			mmhub_v9_4_init_cache_regs(adev, i);
>   
> +		mmhub_v9_4_init_snoop_override_regs(adev, i);
>   		mmhub_v9_4_enable_system_domain(adev, i);
>   		if (!amdgpu_sriov_vf(adev))
>   			mmhub_v9_4_disable_identity_aperture(adev, i);
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_offset.h b/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_offset.h
> index c488d4a50cf4..b2252deabc17 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_offset.h
> @@ -203,6 +203,10 @@
>   #define mmDAGB0_WR_DATA_CREDIT_BASE_IDX                                                                1
>   #define mmDAGB0_WR_MISC_CREDIT                                                                         0x0058
>   #define mmDAGB0_WR_MISC_CREDIT_BASE_IDX                                                                1
> +#define mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE                                                               0x005b
> +#define mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_BASE_IDX                                                      1
> +#define mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE                                                         0x005c
> +#define mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE_BASE_IDX                                                1
>   #define mmDAGB0_WRCLI_ASK_PENDING                                                                      0x005d
>   #define mmDAGB0_WRCLI_ASK_PENDING_BASE_IDX                                                             1
>   #define mmDAGB0_WRCLI_GO_PENDING                                                                       0x005e
> @@ -455,6 +459,10 @@
>   #define mmDAGB1_WR_DATA_CREDIT_BASE_IDX                                                                1
>   #define mmDAGB1_WR_MISC_CREDIT                                                                         0x00d8
>   #define mmDAGB1_WR_MISC_CREDIT_BASE_IDX                                                                1
> +#define mmDAGB1_WRCLI_GPU_SNOOP_OVERRIDE                                                               0x00db
> +#define mmDAGB1_WRCLI_GPU_SNOOP_OVERRIDE_BASE_IDX                                                      1
> +#define mmDAGB1_WRCLI_GPU_SNOOP_OVERRIDE_VALUE                                                         0x00dc
> +#define mmDAGB1_WRCLI_GPU_SNOOP_OVERRIDE_VALUE_BASE_IDX                                                1
>   #define mmDAGB1_WRCLI_ASK_PENDING                                                                      0x00dd
>   #define mmDAGB1_WRCLI_ASK_PENDING_BASE_IDX                                                             1
>   #define mmDAGB1_WRCLI_GO_PENDING                                                                       0x00de
> @@ -707,6 +715,10 @@
>   #define mmDAGB2_WR_DATA_CREDIT_BASE_IDX                                                                1
>   #define mmDAGB2_WR_MISC_CREDIT                                                                         0x0158
>   #define mmDAGB2_WR_MISC_CREDIT_BASE_IDX                                                                1
> +#define mmDAGB2_WRCLI_GPU_SNOOP_OVERRIDE                                                               0x015b
> +#define mmDAGB2_WRCLI_GPU_SNOOP_OVERRIDE_BASE_IDX                                                      1
> +#define mmDAGB2_WRCLI_GPU_SNOOP_OVERRIDE_VALUE                                                         0x015c
> +#define mmDAGB2_WRCLI_GPU_SNOOP_OVERRIDE_VALUE_BASE_IDX                                                1
>   #define mmDAGB2_WRCLI_ASK_PENDING                                                                      0x015d
>   #define mmDAGB2_WRCLI_ASK_PENDING_BASE_IDX                                                             1
>   #define mmDAGB2_WRCLI_GO_PENDING                                                                       0x015e
> @@ -959,6 +971,10 @@
>   #define mmDAGB3_WR_DATA_CREDIT_BASE_IDX                                                                1
>   #define mmDAGB3_WR_MISC_CREDIT                                                                         0x01d8
>   #define mmDAGB3_WR_MISC_CREDIT_BASE_IDX                                                                1
> +#define mmDAGB3_WRCLI_GPU_SNOOP_OVERRIDE                                                               0x01db
> +#define mmDAGB3_WRCLI_GPU_SNOOP_OVERRIDE_BASE_IDX                                                      1
> +#define mmDAGB3_WRCLI_GPU_SNOOP_OVERRIDE_VALUE                                                         0x01dc
> +#define mmDAGB3_WRCLI_GPU_SNOOP_OVERRIDE_VALUE_BASE_IDX                                                1
>   #define mmDAGB3_WRCLI_ASK_PENDING                                                                      0x01dd
>   #define mmDAGB3_WRCLI_ASK_PENDING_BASE_IDX                                                             1
>   #define mmDAGB3_WRCLI_GO_PENDING                                                                       0x01de
> @@ -1211,6 +1227,10 @@
>   #define mmDAGB4_WR_DATA_CREDIT_BASE_IDX                                                                1
>   #define mmDAGB4_WR_MISC_CREDIT                                                                         0x0258
>   #define mmDAGB4_WR_MISC_CREDIT_BASE_IDX                                                                1
> +#define mmDAGB4_WRCLI_GPU_SNOOP_OVERRIDE                                                               0x025b
> +#define mmDAGB4_WRCLI_GPU_SNOOP_OVERRIDE_BASE_IDX                                                      1
> +#define mmDAGB4_WRCLI_GPU_SNOOP_OVERRIDE_VALUE                                                         0x025c
> +#define mmDAGB4_WRCLI_GPU_SNOOP_OVERRIDE_VALUE_BASE_IDX                                                1
>   #define mmDAGB4_WRCLI_ASK_PENDING                                                                      0x025d
>   #define mmDAGB4_WRCLI_ASK_PENDING_BASE_IDX                                                             1
>   #define mmDAGB4_WRCLI_GO_PENDING                                                                       0x025e
> @@ -4793,6 +4813,10 @@
>   #define mmDAGB5_WR_DATA_CREDIT_BASE_IDX                                                                1
>   #define mmDAGB5_WR_MISC_CREDIT                                                                         0x3058
>   #define mmDAGB5_WR_MISC_CREDIT_BASE_IDX                                                                1
> +#define mmDAGB5_WRCLI_GPU_SNOOP_OVERRIDE                                                               0x305b
> +#define mmDAGB5_WRCLI_GPU_SNOOP_OVERRIDE_BASE_IDX                                                      1
> +#define mmDAGB5_WRCLI_GPU_SNOOP_OVERRIDE_VALUE                                                         0x305c
> +#define mmDAGB5_WRCLI_GPU_SNOOP_OVERRIDE_VALUE_BASE_IDX                                                1
>   #define mmDAGB5_WRCLI_ASK_PENDING                                                                      0x305d
>   #define mmDAGB5_WRCLI_ASK_PENDING_BASE_IDX                                                             1
>   #define mmDAGB5_WRCLI_GO_PENDING                                                                       0x305e
> @@ -5045,6 +5069,10 @@
>   #define mmDAGB6_WR_DATA_CREDIT_BASE_IDX                                                                1
>   #define mmDAGB6_WR_MISC_CREDIT                                                                         0x30d8
>   #define mmDAGB6_WR_MISC_CREDIT_BASE_IDX                                                                1
> +#define mmDAGB6_WRCLI_GPU_SNOOP_OVERRIDE                                                               0x30db
> +#define mmDAGB6_WRCLI_GPU_SNOOP_OVERRIDE_BASE_IDX                                                      1
> +#define mmDAGB6_WRCLI_GPU_SNOOP_OVERRIDE_VALUE                                                         0x30dc
> +#define mmDAGB6_WRCLI_GPU_SNOOP_OVERRIDE_VALUE_BASE_IDX                                                1
>   #define mmDAGB6_WRCLI_ASK_PENDING                                                                      0x30dd
>   #define mmDAGB6_WRCLI_ASK_PENDING_BASE_IDX                                                             1
>   #define mmDAGB6_WRCLI_GO_PENDING                                                                       0x30de
> @@ -5297,6 +5325,10 @@
>   #define mmDAGB7_WR_DATA_CREDIT_BASE_IDX                                                                1
>   #define mmDAGB7_WR_MISC_CREDIT                                                                         0x3158
>   #define mmDAGB7_WR_MISC_CREDIT_BASE_IDX                                                                1
> +#define mmDAGB7_WRCLI_GPU_SNOOP_OVERRIDE                                                               0x315b
> +#define mmDAGB7_WRCLI_GPU_SNOOP_OVERRIDE_BASE_IDX                                                      1
> +#define mmDAGB7_WRCLI_GPU_SNOOP_OVERRIDE_VALUE                                                         0x315c
> +#define mmDAGB7_WRCLI_GPU_SNOOP_OVERRIDE_VALUE_BASE_IDX                                                1
>   #define mmDAGB7_WRCLI_ASK_PENDING                                                                      0x315d
>   #define mmDAGB7_WRCLI_ASK_PENDING_BASE_IDX                                                             1
>   #define mmDAGB7_WRCLI_GO_PENDING                                                                       0x315e
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_sh_mask.h
> index 2969fbf282b7..5069d2fd467f 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_sh_mask.h
> @@ -1532,6 +1532,12 @@
>   //DAGB0_WRCLI_DBUS_GO_PENDING
>   #define DAGB0_WRCLI_DBUS_GO_PENDING__BUSY__SHIFT                                                              0x0
>   #define DAGB0_WRCLI_DBUS_GO_PENDING__BUSY_MASK                                                                0xFFFFFFFFL
> +//DAGB0_WRCLI_GPU_SNOOP_OVERRIDE
> +#define DAGB0_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE__SHIFT                                                         0x0
> +#define DAGB0_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE_MASK                                                           0xFFFFFFFFL
> +//DAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE
> +#define DAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE__SHIFT                                                   0x0
> +#define DAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE_MASK                                                     0xFFFFFFFFL
>   //DAGB0_DAGB_DLY
>   #define DAGB0_DAGB_DLY__DLY__SHIFT                                                                            0x0
>   #define DAGB0_DAGB_DLY__CLI__SHIFT                                                                            0x8
> @@ -3207,6 +3213,12 @@
>   //DAGB1_WRCLI_DBUS_GO_PENDING
>   #define DAGB1_WRCLI_DBUS_GO_PENDING__BUSY__SHIFT                                                              0x0
>   #define DAGB1_WRCLI_DBUS_GO_PENDING__BUSY_MASK                                                                0xFFFFFFFFL
> +//DAGB1_WRCLI_GPU_SNOOP_OVERRIDE
> +#define DAGB1_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE__SHIFT                                                         0x0
> +#define DAGB1_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE_MASK                                                           0xFFFFFFFFL
> +//DAGB1_WRCLI_GPU_SNOOP_OVERRIDE_VALUE
> +#define DAGB1_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE__SHIFT                                                   0x0
> +#define DAGB1_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE_MASK                                                     0xFFFFFFFFL
>   //DAGB1_DAGB_DLY
>   #define DAGB1_DAGB_DLY__DLY__SHIFT                                                                            0x0
>   #define DAGB1_DAGB_DLY__CLI__SHIFT                                                                            0x8
> @@ -4882,6 +4894,12 @@
>   //DAGB2_WRCLI_DBUS_GO_PENDING
>   #define DAGB2_WRCLI_DBUS_GO_PENDING__BUSY__SHIFT                                                              0x0
>   #define DAGB2_WRCLI_DBUS_GO_PENDING__BUSY_MASK                                                                0xFFFFFFFFL
> +//DAGB2_WRCLI_GPU_SNOOP_OVERRIDE
> +#define DAGB2_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE__SHIFT                                                         0x0
> +#define DAGB2_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE_MASK                                                           0xFFFFFFFFL
> +//DAGB2_WRCLI_GPU_SNOOP_OVERRIDE_VALUE
> +#define DAGB2_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE__SHIFT                                                   0x0
> +#define DAGB2_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE_MASK                                                     0xFFFFFFFFL
>   //DAGB2_DAGB_DLY
>   #define DAGB2_DAGB_DLY__DLY__SHIFT                                                                            0x0
>   #define DAGB2_DAGB_DLY__CLI__SHIFT                                                                            0x8
> @@ -6557,6 +6575,12 @@
>   //DAGB3_WRCLI_DBUS_GO_PENDING
>   #define DAGB3_WRCLI_DBUS_GO_PENDING__BUSY__SHIFT                                                              0x0
>   #define DAGB3_WRCLI_DBUS_GO_PENDING__BUSY_MASK                                                                0xFFFFFFFFL
> +//DAGB3_WRCLI_GPU_SNOOP_OVERRIDE
> +#define DAGB3_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE__SHIFT                                                         0x0
> +#define DAGB3_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE_MASK                                                           0xFFFFFFFFL
> +//DAGB3_WRCLI_GPU_SNOOP_OVERRIDE_VALUE
> +#define DAGB3_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE__SHIFT                                                   0x0
> +#define DAGB3_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE_MASK                                                     0xFFFFFFFFL
>   //DAGB3_DAGB_DLY
>   #define DAGB3_DAGB_DLY__DLY__SHIFT                                                                            0x0
>   #define DAGB3_DAGB_DLY__CLI__SHIFT                                                                            0x8
> @@ -8232,6 +8256,12 @@
>   //DAGB4_WRCLI_DBUS_GO_PENDING
>   #define DAGB4_WRCLI_DBUS_GO_PENDING__BUSY__SHIFT                                                              0x0
>   #define DAGB4_WRCLI_DBUS_GO_PENDING__BUSY_MASK                                                                0xFFFFFFFFL
> +//DAGB4_WRCLI_GPU_SNOOP_OVERRIDE
> +#define DAGB4_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE__SHIFT                                                         0x0
> +#define DAGB4_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE_MASK                                                           0xFFFFFFFFL
> +//DAGB4_WRCLI_GPU_SNOOP_OVERRIDE_VALUE
> +#define DAGB4_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE__SHIFT                                                   0x0
> +#define DAGB4_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE_MASK                                                     0xFFFFFFFFL
>   //DAGB4_DAGB_DLY
>   #define DAGB4_DAGB_DLY__DLY__SHIFT                                                                            0x0
>   #define DAGB4_DAGB_DLY__CLI__SHIFT                                                                            0x8
> @@ -28737,6 +28767,12 @@
>   //DAGB5_WRCLI_DBUS_GO_PENDING
>   #define DAGB5_WRCLI_DBUS_GO_PENDING__BUSY__SHIFT                                                              0x0
>   #define DAGB5_WRCLI_DBUS_GO_PENDING__BUSY_MASK                                                                0xFFFFFFFFL
> +//DAGB5_WRCLI_GPU_SNOOP_OVERRIDE
> +#define DAGB5_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE__SHIFT                                                         0x0
> +#define DAGB5_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE_MASK                                                           0xFFFFFFFFL
> +//DAGB5_WRCLI_GPU_SNOOP_OVERRIDE_VALUE
> +#define DAGB5_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE__SHIFT                                                   0x0
> +#define DAGB5_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE_MASK                                                     0xFFFFFFFFL
>   //DAGB5_DAGB_DLY
>   #define DAGB5_DAGB_DLY__DLY__SHIFT                                                                            0x0
>   #define DAGB5_DAGB_DLY__CLI__SHIFT                                                                            0x8
> @@ -30412,6 +30448,12 @@
>   //DAGB6_WRCLI_DBUS_GO_PENDING
>   #define DAGB6_WRCLI_DBUS_GO_PENDING__BUSY__SHIFT                                                              0x0
>   #define DAGB6_WRCLI_DBUS_GO_PENDING__BUSY_MASK                                                                0xFFFFFFFFL
> +//DAGB6_WRCLI_GPU_SNOOP_OVERRIDE
> +#define DAGB6_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE__SHIFT                                                         0x0
> +#define DAGB6_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE_MASK                                                           0xFFFFFFFFL
> +//DAGB6_WRCLI_GPU_SNOOP_OVERRIDE_VALUE
> +#define DAGB6_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE__SHIFT                                                   0x0
> +#define DAGB6_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE_MASK                                                     0xFFFFFFFFL
>   //DAGB6_DAGB_DLY
>   #define DAGB6_DAGB_DLY__DLY__SHIFT                                                                            0x0
>   #define DAGB6_DAGB_DLY__CLI__SHIFT                                                                            0x8
> @@ -32087,6 +32129,12 @@
>   //DAGB7_WRCLI_DBUS_GO_PENDING
>   #define DAGB7_WRCLI_DBUS_GO_PENDING__BUSY__SHIFT                                                              0x0
>   #define DAGB7_WRCLI_DBUS_GO_PENDING__BUSY_MASK                                                                0xFFFFFFFFL
> +//DAGB7_WRCLI_GPU_SNOOP_OVERRIDE
> +#define DAGB7_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE__SHIFT                                                         0x0
> +#define DAGB7_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE_MASK                                                           0xFFFFFFFFL
> +//DAGB7_WRCLI_GPU_SNOOP_OVERRIDE_VALUE
> +#define DAGB7_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE__SHIFT                                                   0x0
> +#define DAGB7_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE_MASK                                                     0xFFFFFFFFL
>   //DAGB7_DAGB_DLY
>   #define DAGB7_DAGB_DLY__DLY__SHIFT                                                                            0x0
>   #define DAGB7_DAGB_DLY__CLI__SHIFT                                                                            0x8

