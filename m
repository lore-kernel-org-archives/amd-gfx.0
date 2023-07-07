Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68323EB64D9
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 08:31:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C95AD10E52B;
	Fri,  7 Jul 2023 08:31:48 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E94B810E52B
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 08:31:45 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-51a52a7d859so5198570a12.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Jul 2023 01:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688718701; x=1691310701;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gSxGB1xwhieH69dfkdTXofhic8vZzjKpfkiY072fPQQ=;
 b=ie3wjZKaQUHhESkYax+FiIECGQEY01/64Wxbl3ldXIuhgL9nPYg4qjz91dVGlxjzaY
 r1LqPrL+OkbMwRfkzcPSSIncmKU1iihqfGCcmsgXQtm2xyCCBoa0xRiqbW38CzTUheQM
 r+lb4Il0EZKuf05qiZzLZqbru5zfY0AGqdIAvBwgIt/oxWD3CEKgn6rRmGFaumVp/dCz
 YiiNxCSExZm+XYfX2bfU+qrjt6JkQmcTFA7m/7HFvrJ0wTx4hf6bwwRBnPOuuifDKZCq
 /Z+mBPgs3Yajs2KaeXV/J+Do9FTS4DbG2PTCBh49CFVS+D+mXCWZ7qbk+xeVARsluH5d
 02XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688718701; x=1691310701;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gSxGB1xwhieH69dfkdTXofhic8vZzjKpfkiY072fPQQ=;
 b=HlUwpBZLT++oEnwtp2CjygOcbfkyE+EVTJioFZ/jZp2JHBu0L0hht/sblRjZhZYFHW
 zYEmBpiMN2/OhsLk70aijH4cEjl1z6nd9O3C/q7lFiEGLUgaC6WrErb1Xe8FOmM/E4sE
 faRlMfa/xRgQZHvHyM0TWTk2GJ5VnbvetKhZnElXop+7gsw9rZ4g41lQ5iD2ZYfLZRjk
 DXRbU8BiPteQ2Rkgywbs9dCamhcRjMm/FS2GwMLLM0UOozCmKj3negp1XVSAgIcm/5/6
 1F0MKyqRlfOGH7wgJy8RKNP4VlzcxWPcCHOIL9TmhoMBOINY/YYE452g2Lb4zMpNJujX
 OOmw==
X-Gm-Message-State: ABy/qLbx1zLusmuOK75oPE2KnT6jmfrRWlkH03w+S2uXavVUZKguARDQ
 KR9f6sn86RSdVUT6K0QqHgI=
X-Google-Smtp-Source: APBJJlH0kEg9PHLKdKt8h0AYtspJOdNU0lAZ+6SBtcdVypvoWJ2hvOCMZXiC/8/ROPfR0hhNr1NiuQ==
X-Received: by 2002:a17:907:6d1f:b0:993:22a2:9234 with SMTP id
 sa31-20020a1709076d1f00b0099322a29234mr7906917ejc.31.1688718701384; 
 Fri, 07 Jul 2023 01:31:41 -0700 (PDT)
Received: from ?IPV6:2a00:e180:151d:fd00:ccd:1e13:686f:fcec?
 ([2a00:e180:151d:fd00:ccd:1e13:686f:fcec])
 by smtp.gmail.com with ESMTPSA id
 t23-20020a170906949700b009890e402a6bsm1870289ejx.221.2023.07.07.01.31.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 01:31:40 -0700 (PDT)
Message-ID: <eb89abfe-86b7-fb13-2189-c3e22a67502f@gmail.com>
Date: Fri, 7 Jul 2023 10:31:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] drm/amdgpu/gfx9: move update_spm_vmid() out of
 rlc_init()
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230706185501.7471-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230706185501.7471-1-alexander.deucher@amd.com>
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

Am 06.07.23 um 20:55 schrieb Alex Deucher:
> rlc_init() is part of sw_init() so it should not touch hardware.
> Additionally, calling the rlc update_spm_vmid() callback
> directly invokes a gfx on/off cycle which could result in
> powergating being enabled before hw init is complete.  Split
> update_spm_vmid() into an internal implementation for local
> use without gfxoff interaction and then the rlc callback
> which includes gfxoff handling.  lbpw_init also touches
> hardware so mvoe that to rlc_resume as well.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Christian König <christian.koenig@amd.com> for the series.

> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 34 ++++++++++++---------------
>   1 file changed, 15 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index d654bdd2037c9..7d992e4730db1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -762,6 +762,8 @@ static void gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
>   static int gfx_v9_0_ras_error_inject(struct amdgpu_device *adev,
>   				     void *inject_if, uint32_t instance_mask);
>   static void gfx_v9_0_reset_ras_error_count(struct amdgpu_device *adev);
> +static void gfx_v9_0_update_spm_vmid_internal(struct amdgpu_device *adev,
> +					      unsigned vmid);
>   
>   static void gfx_v9_0_kiq_set_resources(struct amdgpu_ring *kiq_ring,
>   				uint64_t queue_mask)
> @@ -1669,22 +1671,6 @@ static int gfx_v9_0_rlc_init(struct amdgpu_device *adev)
>   			return r;
>   	}
>   
> -	switch (adev->ip_versions[GC_HWIP][0]) {
> -	case IP_VERSION(9, 2, 2):
> -	case IP_VERSION(9, 1, 0):
> -		gfx_v9_0_init_lbpw(adev);
> -		break;
> -	case IP_VERSION(9, 4, 0):
> -		gfx_v9_4_init_lbpw(adev);
> -		break;
> -	default:
> -		break;
> -	}
> -
> -	/* init spm vmid with 0xf */
> -	if (adev->gfx.rlc.funcs->update_spm_vmid)
> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0xf);
> -
>   	return 0;
>   }
>   
> @@ -2944,12 +2930,14 @@ static int gfx_v9_0_rlc_resume(struct amdgpu_device *adev)
>   	switch (adev->ip_versions[GC_HWIP][0]) {
>   	case IP_VERSION(9, 2, 2):
>   	case IP_VERSION(9, 1, 0):
> +		gfx_v9_0_init_lbpw(adev);
>   		if (amdgpu_lbpw == 0)
>   			gfx_v9_0_enable_lbpw(adev, false);
>   		else
>   			gfx_v9_0_enable_lbpw(adev, true);
>   		break;
>   	case IP_VERSION(9, 4, 0):
> +		gfx_v9_4_init_lbpw(adev);
>   		if (amdgpu_lbpw > 0)
>   			gfx_v9_0_enable_lbpw(adev, true);
>   		else
> @@ -2959,6 +2947,8 @@ static int gfx_v9_0_rlc_resume(struct amdgpu_device *adev)
>   		break;
>   	}
>   
> +	gfx_v9_0_update_spm_vmid_internal(adev, 0xf);
> +
>   	adev->gfx.rlc.funcs->start(adev);
>   
>   	return 0;
> @@ -4883,12 +4873,11 @@ static int gfx_v9_0_update_gfx_clock_gating(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> -static void gfx_v9_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
> +static void gfx_v9_0_update_spm_vmid_internal(struct amdgpu_device *adev,
> +					      unsigned vmid)
>   {
>   	u32 reg, data;
>   
> -	amdgpu_gfx_off_ctrl(adev, false);
> -
>   	reg = SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_MC_CNTL);
>   	if (amdgpu_sriov_is_pp_one_vf(adev))
>   		data = RREG32_NO_KIQ(reg);
> @@ -4902,6 +4891,13 @@ static void gfx_v9_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
>   		WREG32_SOC15_NO_KIQ(GC, 0, mmRLC_SPM_MC_CNTL, data);
>   	else
>   		WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, data);
> +}
> +
> +static void gfx_v9_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
> +{
> +	amdgpu_gfx_off_ctrl(adev, false);
> +
> +	gfx_v9_0_update_spm_vmid_internal(adev, vmid);
>   
>   	amdgpu_gfx_off_ctrl(adev, true);
>   }

