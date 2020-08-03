Return-Path: <SRS0=0vKA=BN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7219FC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2020 16:30:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43F832075A
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2020 16:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="saVajQY6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43F832075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0A426E2B6;
	Mon,  3 Aug 2020 16:30:02 +0000 (UTC)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 360A06E2B6
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2020 16:30:02 +0000 (UTC)
Received: by mail-ot1-x341.google.com with SMTP id q9so12689503oth.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Aug 2020 09:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XRoNNxhuyYiDlwe8zH+MPm1Tx0OJZM+hf3uG7oBbQwE=;
 b=saVajQY6BG82JtnpqmvAh6NVqRlJ36fiV2nhLZ1GrTjFgrnAtKmHwVvToBKkrUbWP9
 k5eSJ4mTwRKdRUg4fImAFAZ114lRIf9fpbcnHQZ9sUn3j+AxNTz7F5ey8frhr1n09aWJ
 50tnxdpenhrmGqw2kIidAVSV560mCQJ2Ex+NlHz818q49mi8CVfW+ZgovrXtZbLsX5A0
 cJZazzUOKRTXnPul9M/MKxUzaiErfy4IToCLZrRowDzJQuLlM5QhpH4e8JcR2nr7ktgT
 O1uPzYooLdOmBC0u2iXz0MCuBZw895jbT4iHco0pY9WBBuDdyUVRw0RvQ2WvfdBYuZxW
 aEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=XRoNNxhuyYiDlwe8zH+MPm1Tx0OJZM+hf3uG7oBbQwE=;
 b=U6+9wk1TAdxnkGGrlCJWmobvbcw3f+LTwYSXYMpdOl5s//EyVKij5jT2KHtdLRFRYb
 TvusrJV5N8ZYo9DxP6thmKTsV9AkMJZG3z43nrrt7NABeKS92rP1ZRs7rRJg06TsZiGL
 iov0PxHNl19UbaRZVGrt2144wu1XJlnH2ClPM2KclZycV3zb1U+lDcAZy0x4xLvQl6I/
 rEAO3/frqXgPGDteSmNuWFvFH6fuWOV47TWMjCET0RdVA1qcXZB8D2aRUulE81856004
 XHsrux2W49G7fgUWmDfsrVvHwaRLzrRxFx3L3qCjdwAvuei6JWh5gmxDChqfcwibhCKl
 OoNw==
X-Gm-Message-State: AOAM5330TXX45aUFDowNMriXiZhqTh8eV0tPV8YOwD5z4OnRAjk/6vWS
 icTtNlmld//iHSeSooS5VvA=
X-Google-Smtp-Source: ABdhPJxgN5XEWgCpUqzbmwfWR7iuvbVXKWfT6LkLMXEiGmvAm0xfIpmTH69zO7vHkGaMQYnWTsRvQw==
X-Received: by 2002:a9d:6acc:: with SMTP id m12mr12477861otq.207.1596472201380; 
 Mon, 03 Aug 2020 09:30:01 -0700 (PDT)
Received: from ?IPv6:2602:4b:a6ae:c000:6d4:c4ff:fe4a:ea6b?
 ([2602:4b:a6ae:c000:6d4:c4ff:fe4a:ea6b])
 by smtp.gmail.com with ESMTPSA id u19sm3039578oic.10.2020.08.03.09.29.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2020 09:30:00 -0700 (PDT)
Subject: Re: [PATCH 2/2] drm/amd/powerplay: put VCN/JPEG into PG ungate state
 before dpm table setup
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200803044648.28805-1-evan.quan@amd.com>
 <20200803044648.28805-2-evan.quan@amd.com>
From: Matt Coffin <mcoffin13@gmail.com>
Autocrypt: addr=mcoffin13@gmail.com; keydata=
 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
 tuwClJVHcEqY1gkUE/HKR1MQFfXl979G/1Ql1g==
Message-ID: <9eacd2a5-12e7-0f2f-a078-ca7c99c1a390@gmail.com>
Date: Mon, 3 Aug 2020 10:29:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200803044648.28805-2-evan.quan@amd.com>
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
Cc: alexander.deucher@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thanks Evan! I can confirm that this resolved the following GitLab
issue. Thanks for CC'ing me!

https://gitlab.freedesktop.org/drm/amd/-/issues/1243

Series is Tested-by: Matt Coffin <mcoffin13@gmail.com>

On 8/2/20 10:46 PM, Evan Quan wrote:
> As VCN related dpm table setup needs VCN be in PG ungate state. Same logics
> applies to JPEG.
> 
> Change-Id: I94335efc4e0424cfe0991e984c938998fd8f1287
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 38 +++++++++++++++++-----
>  1 file changed, 30 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 85b04c48bd09..1349d05c5f3d 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -134,7 +134,8 @@ int smu_get_dpm_freq_range(struct smu_context *smu,
>  }
>  
>  static int smu_dpm_set_vcn_enable(struct smu_context *smu,
> -				  bool enable)
> +				  bool enable,
> +				  int *previous_pg_state)
>  {
>  	struct smu_power_context *smu_power = &smu->smu_power;
>  	struct smu_power_gate *power_gate = &smu_power->power_gate;
> @@ -148,6 +149,9 @@ static int smu_dpm_set_vcn_enable(struct smu_context *smu,
>  	if (atomic_read(&power_gate->vcn_gated) ^ enable)
>  		goto out;
>  
> +	if (previous_pg_state)
> +		*previous_pg_state = atomic_read(&power_gate->vcn_gated);
> +
>  	ret = smu->ppt_funcs->dpm_set_vcn_enable(smu, enable);
>  	if (!ret)
>  		atomic_set(&power_gate->vcn_gated, !enable);
> @@ -159,7 +163,8 @@ static int smu_dpm_set_vcn_enable(struct smu_context *smu,
>  }
>  
>  static int smu_dpm_set_jpeg_enable(struct smu_context *smu,
> -				   bool enable)
> +				   bool enable,
> +				   int *previous_pg_state)
>  {
>  	struct smu_power_context *smu_power = &smu->smu_power;
>  	struct smu_power_gate *power_gate = &smu_power->power_gate;
> @@ -173,6 +178,9 @@ static int smu_dpm_set_jpeg_enable(struct smu_context *smu,
>  	if (atomic_read(&power_gate->jpeg_gated) ^ enable)
>  		goto out;
>  
> +	if (previous_pg_state)
> +		*previous_pg_state = atomic_read(&power_gate->jpeg_gated);
> +
>  	ret = smu->ppt_funcs->dpm_set_jpeg_enable(smu, enable);
>  	if (!ret)
>  		atomic_set(&power_gate->jpeg_gated, !enable);
> @@ -212,7 +220,7 @@ int smu_dpm_set_power_gate(struct smu_context *smu, uint32_t block_type,
>  	 */
>  	case AMD_IP_BLOCK_TYPE_UVD:
>  	case AMD_IP_BLOCK_TYPE_VCN:
> -		ret = smu_dpm_set_vcn_enable(smu, !gate);
> +		ret = smu_dpm_set_vcn_enable(smu, !gate, NULL);
>  		if (ret)
>  			dev_err(smu->adev->dev, "Failed to power %s VCN!\n",
>  				gate ? "gate" : "ungate");
> @@ -230,7 +238,7 @@ int smu_dpm_set_power_gate(struct smu_context *smu, uint32_t block_type,
>  				gate ? "gate" : "ungate");
>  		break;
>  	case AMD_IP_BLOCK_TYPE_JPEG:
> -		ret = smu_dpm_set_jpeg_enable(smu, !gate);
> +		ret = smu_dpm_set_jpeg_enable(smu, !gate, NULL);
>  		if (ret)
>  			dev_err(smu->adev->dev, "Failed to power %s JPEG!\n",
>  				gate ? "gate" : "ungate");
> @@ -407,6 +415,7 @@ static int smu_late_init(void *handle)
>  {
>  	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>  	struct smu_context *smu = &adev->smu;
> +	int vcn_gate, jpeg_gate;
>  	int ret = 0;
>  
>  	if (!smu->pm_enabled)
> @@ -418,6 +427,14 @@ static int smu_late_init(void *handle)
>  		return ret;
>  	}
>  
> +	/*
> +	 * 1. Power up VCN/JPEG as the succeeding smu_set_default_dpm_table()
> +	 *    needs VCN/JPEG up.
> +	 * 2. Save original gate states and then we can restore back afterwards.
> +	 */
> +	smu_dpm_set_vcn_enable(smu, true, &vcn_gate);
> +	smu_dpm_set_jpeg_enable(smu, true, &jpeg_gate);
> +
>  	/*
>  	 * Set initialized values (get from vbios) to dpm tables context such as
>  	 * gfxclk, memclk, dcefclk, and etc. And enable the DPM feature for each
> @@ -429,6 +446,11 @@ static int smu_late_init(void *handle)
>  		return ret;
>  	}
>  
> +	/* Restore back to original VCN/JPEG power gate states */
> +	smu_dpm_set_vcn_enable(smu, !vcn_gate, NULL);
> +	smu_dpm_set_jpeg_enable(smu, !vcn_gate, NULL);
> +
> +
>  	ret = smu_populate_umd_state_clk(smu);
>  	if (ret) {
>  		dev_err(adev->dev, "Failed to populate UMD state clocks!\n");
> @@ -991,8 +1013,8 @@ static int smu_hw_init(void *handle)
>  
>  	if (smu->is_apu) {
>  		smu_powergate_sdma(&adev->smu, false);
> -		smu_dpm_set_vcn_enable(smu, true);
> -		smu_dpm_set_jpeg_enable(smu, true);
> +		smu_dpm_set_vcn_enable(smu, true, NULL);
> +		smu_dpm_set_jpeg_enable(smu, true, NULL);
>  		smu_set_gfx_cgpg(&adev->smu, true);
>  	}
>  
> @@ -1132,8 +1154,8 @@ static int smu_hw_fini(void *handle)
>  
>  	if (smu->is_apu) {
>  		smu_powergate_sdma(&adev->smu, true);
> -		smu_dpm_set_vcn_enable(smu, false);
> -		smu_dpm_set_jpeg_enable(smu, false);
> +		smu_dpm_set_vcn_enable(smu, false, NULL);
> +		smu_dpm_set_jpeg_enable(smu, false, NULL);
>  	}
>  
>  	if (!smu->pm_enabled)
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
