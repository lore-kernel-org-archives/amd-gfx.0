Return-Path: <SRS0=V/Q8=BI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAD8C433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 08:44:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B08852076E
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 08:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhahDjPE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B08852076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D4A96E48B;
	Wed, 29 Jul 2020 08:44:20 +0000 (UTC)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com
 [IPv6:2a00:1450:4864:20::643])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B51B6E48B
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 08:44:19 +0000 (UTC)
Received: by mail-ej1-x643.google.com with SMTP id qc22so8682835ejb.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 01:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=cZGQoUUnZ8dTemrWaJeaXKPU/Y5J+l4SVUtK64Qg0CU=;
 b=dhahDjPECYSFPRO5lg/iGvmZhFzeCqgQ5SNsSBDls/eTa4i/8KNINDPc+5DK+RUCXw
 leq4cf20xInPW0d6bHwhYX2IFRxNeE4P4CbQKWmv3EwJaZXxH49t+wqXsJsi2bqBbYy7
 XgiZ3/25gegJwtVFfXivUNAdgOFh/1vX07IAeSOHHvQ6F7XI0Ud3fk4wRTl4EDlcv297
 Eoj8E0wDdgoosnRzdjokFmkm4midY0/QlxxmedPiuFzfQevFmoezDE+HBgQeDz+W4cuM
 AXOSI3czSFP5pu3RezirE5Tz3PkwhzED5mU2tWyDS94t1+tfY6KnzV4oX+IPa6pw8CSo
 FBsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=cZGQoUUnZ8dTemrWaJeaXKPU/Y5J+l4SVUtK64Qg0CU=;
 b=R4llbqEp6YlYAkdzPqKky14Zrc/VwYmFky2qeVwTyBbUvwxTt0L/UZeJ9atOlIW60g
 6+ngTA8pR8mnHgd3sHjrIkYg4UlZpby7uTXuzXQn/+kCs5Sh3OLtpza+QaOPqABpEYAU
 jjmo3KfBDOTZ2qXZVL7cLH3nsLrSn5qa9oLzNbJPsnFylfU/HKG/oBTSI0ZW8orJzyQP
 j78LSnHj2p79Yve1z3RlaZp5zXf/RS3aYkv7mwYwYaZJH20xSzKL5bPWsLX15lVmpZpX
 JgMggcT/q7bv+gMLMbYOaAIeqVSiEsK1aqE2NQrmST9db/U4ftqDAypidyjb8Bu6coQM
 5XAA==
X-Gm-Message-State: AOAM530w3s6uDC2oAtISaSAD6ry1BlE3s2/pEet0ji7YexFXxiWN9dYn
 R2JV6+LtsfVv2gK7ytV0GQo=
X-Google-Smtp-Source: ABdhPJwk2iox1S7IVy7lkQFmHd5iS+vA6lx++6BpRyrxCDGNtQYtQ5nGZGKpoqALxBFosX1yOfINig==
X-Received: by 2002:a17:906:17cc:: with SMTP id
 u12mr28605439eje.344.1596012257977; 
 Wed, 29 Jul 2020 01:44:17 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id p16sm1042876ejd.27.2020.07.29.01.44.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2020 01:44:17 -0700 (PDT)
Subject: Re: [PATCH 04/14] drm/amdgpu: move stolen vga bo from amdgpu to
 amdgpu.gmc
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200728224605.3919-1-alexander.deucher@amd.com>
 <20200728224605.3919-5-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <021773e5-7d01-7296-2595-6ae9e11e61f8@gmail.com>
Date: Wed, 29 Jul 2020 10:44:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728224605.3919-5-alexander.deucher@amd.com>
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
Reply-To: christian.koenig@amd.com
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 29.07.20 um 00:45 schrieb Alex Deucher:
> Since that is where we store the other data related to
> the stolen vga memory.

Mhm, how about putting everything into struct amdgpu_mman instead?

This stuff is not at all GMC related as far as I can see.

We just put it into the GMC code because we have all the other memory 
sizes there as well.

Christian.

>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 3 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 6 +++---
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c   | 2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c   | 2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   | 2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 4 ++--
>   8 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 2a7fbe21619d..899664357015 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -767,7 +767,6 @@ struct amdgpu_device {
>   	bool				is_atom_fw;
>   	uint8_t				*bios;
>   	uint32_t			bios_size;
> -	struct amdgpu_bo		*stolen_vga_memory;
>   	uint32_t			bios_scratch_reg_offset;
>   	uint32_t			bios_scratch[AMDGPU_BIOS_NUM_SCRATCH];
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index 9d58c56f6cfc..ddb64be670c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -213,7 +213,8 @@ struct amdgpu_gmc {
>   	uint8_t			vram_vendor;
>   	uint32_t                srbm_soft_reset;
>   	bool			prt_warning;
> -	uint64_t		stolen_size;
> +	uint64_t		stolen_vga_size;
> +	struct amdgpu_bo	*stolen_vga_memory;
>   	uint32_t		sdpif_register;
>   	/* apertures */
>   	u64			shared_aperture_start;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index a188216bccc2..39781127d059 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1979,9 +1979,9 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>   	 * This is used for VGA emulation and pre-OS scanout buffers to
>   	 * avoid display artifacts while transitioning between pre-OS
>   	 * and driver.  */
> -	r = amdgpu_bo_create_kernel_at(adev, 0, adev->gmc.stolen_size,
> +	r = amdgpu_bo_create_kernel_at(adev, 0, adev->gmc.stolen_vga_size,
>   				       AMDGPU_GEM_DOMAIN_VRAM,
> -				       &adev->stolen_vga_memory,
> +				       &adev->gmc.stolen_vga_memory,
>   				       &stolen_vga_buf);
>   	if (r)
>   		return r;
> @@ -2043,7 +2043,7 @@ void amdgpu_ttm_late_init(struct amdgpu_device *adev)
>   {
>   	void *stolen_vga_buf;
>   	/* return the VGA stolen memory (if any) back to VRAM */
> -	amdgpu_bo_free_kernel(&adev->stolen_vga_memory, NULL, &stolen_vga_buf);
> +	amdgpu_bo_free_kernel(&adev->gmc.stolen_vga_memory, NULL, &stolen_vga_buf);
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 040220e97cf3..337d70503970 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -812,7 +812,7 @@ static int gmc_v10_0_sw_init(void *handle)
>   	if (r)
>   		return r;
>   
> -	adev->gmc.stolen_size = gmc_v10_0_get_vbios_fb_size(adev);
> +	adev->gmc.stolen_vga_size = gmc_v10_0_get_vbios_fb_size(adev);
>   
>   	/* Memory manager */
>   	r = amdgpu_bo_init(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> index 4de996868d32..28ddb41a78c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -862,7 +862,7 @@ static int gmc_v6_0_sw_init(void *handle)
>   	if (r)
>   		return r;
>   
> -	adev->gmc.stolen_size = gmc_v6_0_get_vbios_fb_size(adev);
> +	adev->gmc.stolen_vga_size = gmc_v6_0_get_vbios_fb_size(adev);
>   
>   	r = amdgpu_bo_init(adev);
>   	if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> index 4113f2d33b75..8b8ecbb99d84 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -1035,7 +1035,7 @@ static int gmc_v7_0_sw_init(void *handle)
>   	if (r)
>   		return r;
>   
> -	adev->gmc.stolen_size = gmc_v7_0_get_vbios_fb_size(adev);
> +	adev->gmc.stolen_vga_size = gmc_v7_0_get_vbios_fb_size(adev);
>   
>   	/* Memory manager */
>   	r = amdgpu_bo_init(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index f29ff9afcc10..8e3763ec268f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -1160,7 +1160,7 @@ static int gmc_v8_0_sw_init(void *handle)
>   	if (r)
>   		return r;
>   
> -	adev->gmc.stolen_size = gmc_v8_0_get_vbios_fb_size(adev);
> +	adev->gmc.stolen_vga_size = gmc_v8_0_get_vbios_fb_size(adev);
>   
>   	/* Memory manager */
>   	r = amdgpu_bo_init(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index ac15d7678d24..b66c60680dba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1243,7 +1243,7 @@ static int gmc_v9_0_sw_init(void *handle)
>   	if (r)
>   		return r;
>   
> -	adev->gmc.stolen_size = gmc_v9_0_get_vbios_fb_size(adev);
> +	adev->gmc.stolen_vga_size = gmc_v9_0_get_vbios_fb_size(adev);
>   
>   	/* Memory manager */
>   	r = amdgpu_bo_init(adev);
> @@ -1282,7 +1282,7 @@ static int gmc_v9_0_sw_fini(void *handle)
>   	amdgpu_vm_manager_fini(adev);
>   
>   	if (gmc_v9_0_keep_stolen_memory(adev))
> -		amdgpu_bo_free_kernel(&adev->stolen_vga_memory, NULL, &stolen_vga_buf);
> +		amdgpu_bo_free_kernel(&adev->gmc.stolen_vga_memory, NULL, &stolen_vga_buf);
>   
>   	amdgpu_gart_table_vram_free(adev);
>   	amdgpu_bo_fini(adev);

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
