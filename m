Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59AE5C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Nov 2022 16:51:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75DB910E77E;
	Fri, 18 Nov 2022 16:51:03 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 207CD10E77F
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 16:50:59 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id gv23so14472574ejb.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 08:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UEHGjpROLunVEX0g3gtfUD9NB1JX48WxJIXR6gCmaaw=;
 b=RLWsNJbHZuq/ydGILx3J/ZXBrHGh3AcbfFrLYXsuay+rDzzzBOQ+51MhpC7l0c8Nmz
 hUZ7wehxWvYIvDNn1a2gWWSTkf5WcODUPKFm55Fc8JJs29A2yltdMSuml+kUPMfCmntB
 kkQoe6ZcBcHf+4HO0lIhDWQ9S95hdSOmc9ZjEje/R1aRfUIUe+epMIjy0vp9Np9Rugjo
 pY4BLdAWZR7XDlDY8cKpplYfZuHQSkqam0ydqupKGt43+8xqYc4ZsoGHrdzvyLN+XGGc
 wLHUJFV5yZ+j6rhAwoRsTrPLR6YH+BMes7cwx24GxR8acFSzH+lJjUije1bHT/vNXeSq
 8j/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UEHGjpROLunVEX0g3gtfUD9NB1JX48WxJIXR6gCmaaw=;
 b=si6gYOkzNXNQMLbFh/02lE4S4vvi754CSx2dF2cyluL01AXebzdvQopkR9EBeqcJRU
 2kbCsG0/F6PwtImdG9kwbD3gDcysPuMff+gsIBHDpFGcM7U/pQeyn6+ARvAH5QM3Je4P
 kEZ2zJo+7nfZCxzXqm/MYZrgZ8jXa/coA60VFxnFuwX05xvVB2bAxoyi2cR7vsHVWhql
 94OYtP0QPdv8WiLkh7+eUkawG6FxdMtG1p05lBbaP94g81UZh+0MBrOKaE0Pwcz54JGC
 9/UEYkD12N1FlJ5mTfLLh3UW885uLXOLMJbs/hGzR4AiuMvFFqKAB3DjNFXtLwuz/cpR
 dVqw==
X-Gm-Message-State: ANoB5pnAnrHCSODgz/CN7rgbPpZjqqjF+uCKWBWPGaGrMHtM73xKdcXK
 0Iv/GeF+x0771prsKZscOXE=
X-Google-Smtp-Source: AA0mqf7VHaeqy3OVadZEMfGlQpKBrxTUlKnWifRHhqtS2RCHhPFSooaI0Pl990Z0fUmn7BLRz4koZQ==
X-Received: by 2002:a17:906:706:b0:7ac:2e16:eb05 with SMTP id
 y6-20020a170906070600b007ac2e16eb05mr7028523ejb.26.1668790257556; 
 Fri, 18 Nov 2022 08:50:57 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:6df3:758:835a:3ec8?
 ([2a02:908:1256:79a0:6df3:758:835a:3ec8])
 by smtp.gmail.com with ESMTPSA id
 10-20020a170906308a00b00782fbb7f5f7sm1879911ejv.113.2022.11.18.08.50.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Nov 2022 08:50:56 -0800 (PST)
Message-ID: <0de80953-e83b-553d-1de5-3a22149c90c7@gmail.com>
Date: Fri, 18 Nov 2022 17:50:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu/psp: don't free PSP buffers on suspend
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221116164006.2830029-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20221116164006.2830029-1-alexander.deucher@amd.com>
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

Am 16.11.22 um 17:40 schrieb Alex Deucher:
> We can reuse the same buffers on resume.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

But I would like to ad the WARN_ON() to not free anything during suspend 
on newer kernels as well.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 56 +++++++++++++------------
>   1 file changed, 29 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 0a8c30475dda..d9cb4c4b8289 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -172,6 +172,7 @@ void psp_ta_free_shared_buf(struct ta_mem_context *mem_ctx)
>   {
>   	amdgpu_bo_free_kernel(&mem_ctx->shared_bo, &mem_ctx->shared_mc_addr,
>   			      &mem_ctx->shared_buf);
> +	mem_ctx->shared_bo = NULL;
>   }
>   
>   static void psp_free_shared_bufs(struct psp_context *psp)
> @@ -182,6 +183,7 @@ static void psp_free_shared_bufs(struct psp_context *psp)
>   	/* free TMR memory buffer */
>   	pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
>   	amdgpu_bo_free_kernel(&psp->tmr_bo, &psp->tmr_mc_addr, pptr);
> +	psp->tmr_bo = NULL;
>   
>   	/* free xgmi shared memory */
>   	psp_ta_free_shared_buf(&psp->xgmi_context.context.mem_context);
> @@ -743,37 +745,39 @@ static int psp_load_toc(struct psp_context *psp,
>   /* Set up Trusted Memory Region */
>   static int psp_tmr_init(struct psp_context *psp)
>   {
> -	int ret;
> +	int ret = 0;
>   	int tmr_size;
>   	void *tmr_buf;
>   	void **pptr;
>   
> -	/*
> -	 * According to HW engineer, they prefer the TMR address be "naturally
> -	 * aligned" , e.g. the start address be an integer divide of TMR size.
> -	 *
> -	 * Note: this memory need be reserved till the driver
> -	 * uninitializes.
> -	 */
> -	tmr_size = PSP_TMR_SIZE(psp->adev);
> -
> -	/* For ASICs support RLC autoload, psp will parse the toc
> -	 * and calculate the total size of TMR needed */
> -	if (!amdgpu_sriov_vf(psp->adev) &&
> -	    psp->toc.start_addr &&
> -	    psp->toc.size_bytes &&
> -	    psp->fw_pri_buf) {
> -		ret = psp_load_toc(psp, &tmr_size);
> -		if (ret) {
> -			DRM_ERROR("Failed to load toc\n");
> -			return ret;
> +	if (!psp->tmr_bo) {
> +		/*
> +		 * According to HW engineer, they prefer the TMR address be "naturally
> +		 * aligned" , e.g. the start address be an integer divide of TMR size.
> +		 *
> +		 * Note: this memory need be reserved till the driver
> +		 * uninitializes.
> +		 */
> +		tmr_size = PSP_TMR_SIZE(psp->adev);
> +
> +		/* For ASICs support RLC autoload, psp will parse the toc
> +		 * and calculate the total size of TMR needed */
> +		if (!amdgpu_sriov_vf(psp->adev) &&
> +		    psp->toc.start_addr &&
> +		    psp->toc.size_bytes &&
> +		    psp->fw_pri_buf) {
> +			ret = psp_load_toc(psp, &tmr_size);
> +			if (ret) {
> +				DRM_ERROR("Failed to load toc\n");
> +				return ret;
> +			}
>   		}
> -	}
>   
> -	pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
> -	ret = amdgpu_bo_create_kernel(psp->adev, tmr_size, PSP_TMR_ALIGNMENT,
> -				      AMDGPU_GEM_DOMAIN_VRAM,
> -				      &psp->tmr_bo, &psp->tmr_mc_addr, pptr);
> +		pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
> +		ret = amdgpu_bo_create_kernel(psp->adev, tmr_size, PSP_TMR_ALIGNMENT,
> +					      AMDGPU_GEM_DOMAIN_VRAM,
> +					      &psp->tmr_bo, &psp->tmr_mc_addr, pptr);
> +	}
>   
>   	return ret;
>   }
> @@ -2701,8 +2705,6 @@ static int psp_suspend(void *handle)
>   	}
>   
>   out:
> -	psp_free_shared_bufs(psp);
> -
>   	return ret;
>   }
>   

