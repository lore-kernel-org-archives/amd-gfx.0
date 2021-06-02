Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2A2C4708F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 07:00:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87B2961242
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 07:00:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B2961242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2986C6EB6A;
	Wed,  2 Jun 2021 07:00:43 +0000 (UTC)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49B8E6EB6A
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 07:00:42 +0000 (UTC)
Received: by mail-lj1-x236.google.com with SMTP id m3so1214231lji.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Jun 2021 00:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=lRVrbSOGcBsGZx2lDqmwZvfOPTUNDsAwJLEDD27NGjY=;
 b=sIVZDgPsNv39UtqPhRil6EykA0b5gI99jtWSFO5ZknTermAbiS6n/7ixsNOV9HrDWY
 tVFxd7qRs/8kuOp6m9cilnENsNwht/a6gyfaKUY/ruaIPX2wnM7/v/A5fFFmJjmZBKA5
 Uw/cF0x6kqaoXQkCI1L+3lJ2BpvENZSZuoc6wv9UFu65Ebr/iVRZZqzixtbAfawzsTFo
 e4PPNe2WuIXymwvQT8JyXzhB1yM5E6pk6TusDxfxi1S/fUxIEVrh4Iq5s2XNsxyp09Kg
 QsbtAJzz1Yk9Yd3i5K4skZOSc8Hlt6jYW8K/W+GxPyAebjmW/Cj9POl+Uas053bgWDlj
 c/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=lRVrbSOGcBsGZx2lDqmwZvfOPTUNDsAwJLEDD27NGjY=;
 b=izSgvPMICRz5EZAdFKWfr/ouekim66j7UGrZa7fL/ZeYuheoyjpz/NcvZIxYz491H1
 ERQbYl+pBLOPUjRdUhg3TcjBrjv/0XKU/zJjSWjw81q8ZuxjOIQpqseTunyWoaL/l/UQ
 EglsGhvfALpfMxcxMPGvCZVLT/QLCQ/PtCZ2E4+4Fv+cz/cV7ulU8bM4Hq3tM6CNb+/D
 ikByFT8PivtLB7YH/xbAsNDJvJubQPzQgFPp/71/BQsIAiHPhHf/THPliWKtwWANl4tW
 V4iTmnUhR+l+kEqteChnBMsj0SFI3WrP7D2+9vdB8WJzAYa3WDYWOHLIpWK4PsBwTYiI
 V5Zg==
X-Gm-Message-State: AOAM533yawjQ0SGYoMYtobNEd1m6nv1g+XZTM4zaDwcFP7JQS4hYwBdb
 Y4n/rlBSvYRdZKrrBjyLv6eNzpEAeGk=
X-Google-Smtp-Source: ABdhPJzQ4wFBui/xuahJMia6bR73HWjZqdpmFCIPpHDoXwh5fWTOg+wWtPyAk72QwGrOxxLUPsVG9Q==
X-Received: by 2002:a05:651c:311:: with SMTP id
 a17mr3681358ljp.90.1622617240745; 
 Wed, 02 Jun 2021 00:00:40 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:cd07:2759:3eec:1d00?
 ([2a02:908:1252:fb60:cd07:2759:3eec:1d00])
 by smtp.gmail.com with ESMTPSA id c9sm1901310lfb.207.2021.06.02.00.00.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jun 2021 00:00:39 -0700 (PDT)
Subject: Re: [PATCH v3] drm/amdgpu: Don't flush/invalidate HDP for APUs and A+A
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210602020458.781206-1-jinhuieric.huang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <61d996d7-1001-3717-ab96-b09ffbfdf282@gmail.com>
Date: Wed, 2 Jun 2021 09:00:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210602020458.781206-1-jinhuieric.huang@amd.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 02.06.21 um 04:04 schrieb Eric Huang:
> Integrate two macros into two generic functions and add
> no_flush flag to determine if HDP flush is needed for
> all Asics.

Yes that starts looks like it should work, just a few comments below.

>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  9 ++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 29 ++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h    |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c     | 15 ++---------
>   4 files changed, 37 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 1e3cd4ce9e91..224552d38240 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1297,10 +1297,6 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
>   #define amdgpu_asic_read_bios_from_rom(adev, b, l) (adev)->asic_funcs->read_bios_from_rom((adev), (b), (l))
>   #define amdgpu_asic_read_register(adev, se, sh, offset, v)((adev)->asic_funcs->read_register((adev), (se), (sh), (offset), (v)))
>   #define amdgpu_asic_get_config_memsize(adev) (adev)->asic_funcs->get_config_memsize((adev))
> -#define amdgpu_asic_flush_hdp(adev, r) \
> -	((adev)->asic_funcs->flush_hdp ? (adev)->asic_funcs->flush_hdp((adev), (r)) : (adev)->hdp.funcs->flush_hdp((adev), (r)))
> -#define amdgpu_asic_invalidate_hdp(adev, r) \
> -	((adev)->asic_funcs->invalidate_hdp ? (adev)->asic_funcs->invalidate_hdp((adev), (r)) : (adev)->hdp.funcs->invalidate_hdp((adev), (r)))
>   #define amdgpu_asic_need_full_reset(adev) (adev)->asic_funcs->need_full_reset((adev))
>   #define amdgpu_asic_init_doorbell_index(adev) (adev)->asic_funcs->init_doorbell_index((adev))
>   #define amdgpu_asic_get_pcie_usage(adev, cnt0, cnt1) ((adev)->asic_funcs->get_pcie_usage((adev), (cnt0), (cnt1)))
> @@ -1314,6 +1310,11 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
>   
>   #define amdgpu_inc_vram_lost(adev) atomic_inc(&((adev)->vram_lost_counter));
>   
> +void amdgpu_asic_flush_hdp(struct amdgpu_device *adev,
> +		struct amdgpu_ring *ring);
> +void amdgpu_asic_invalidate_hdp(struct amdgpu_device *adev,
> +		struct amdgpu_ring *ring);
> +
>   /* Common functions */
>   bool amdgpu_device_has_job_running(struct amdgpu_device *adev);
>   bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 9c4d33f649f7..951feefb5e76 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3505,6 +3505,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	if (r)
>   		goto failed_unmap;
>   
> +	if ((adev->flags & AMD_IS_APU) || adev->gmc.xgmi.connected_to_cpu)
> +		adev->hdp.no_flush = true;
> +

This is not correct. We can only skip HDP flush on X86_64, but not on 
32bit builds.

Additional to that we might want this somewhere in the GMC code and not 
here.

>   	/* doorbell bar mapping and doorbell index init*/
>   	amdgpu_device_doorbell_init(adev);
>   
> @@ -5548,3 +5551,29 @@ bool amdgpu_device_is_headless(struct amdgpu_device *adev)
>       /* Check if it is NV's VGA class while VCN is harvest, it is headless*/
>       return nv_is_headless_sku(adev->pdev);
>   }
> +
> +void amdgpu_asic_flush_hdp(struct amdgpu_device *adev,
> +		struct amdgpu_ring *ring)

Please name the functions amdgpu_device_, the amdgpu_asic_ names are for 
callbacks only.

> +{
> +	if (adev->hdp.no_flush)
> +		return;

Since we now have a function to check the different conditions I think 
we might want to check for X86_64 & APU and XGMI connection separately here.

But that is not a hard requirement, using the no_flush variable is fine 
with me if you think that this is better.

> +
> +	if (ring->funcs->emit_hdp_flush)
> +		amdgpu_ring_emit_hdp_flush(ring);
> +	else if (adev->asic_funcs->flush_hdp)
> +		adev->asic_funcs->flush_hdp(adev, ring);
> +	else
> +		adev->hdp.funcs->flush_hdp(adev, ring);
> +}
> +
> +void amdgpu_asic_invalidate_hdp(struct amdgpu_device *adev,
> +		struct amdgpu_ring *ring)
> +{
> +	if (adev->hdp.no_flush)
> +		return;
> +
> +	if (adev->asic_funcs->invalidate_hdp)
> +		adev->asic_funcs->invalidate_hdp(adev, ring);
> +	else
> +		adev->hdp.funcs->invalidate_hdp(adev, ring);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
> index 7ec99d591584..1ca23f2f51d2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
> @@ -44,6 +44,7 @@ struct amdgpu_hdp {
>   	struct ras_common_if			*ras_if;
>   	const struct amdgpu_hdp_funcs		*funcs;
>   	const struct amdgpu_hdp_ras_funcs	*ras_funcs;
> +	bool	no_flush;
>   };
>   
>   int amdgpu_hdp_ras_late_init(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index aaa2574ce9bc..6db676c4c7e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -222,15 +222,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>   	if (job && ring->funcs->init_cond_exec)
>   		patch_offset = amdgpu_ring_init_cond_exec(ring);
>   
> -#ifdef CONFIG_X86_64
> -	if (!(adev->flags & AMD_IS_APU))
> -#endif
> -	{
> -		if (ring->funcs->emit_hdp_flush)
> -			amdgpu_ring_emit_hdp_flush(ring);
> -		else
> -			amdgpu_asic_flush_hdp(adev, ring);
> -	}
> +	amdgpu_asic_flush_hdp(adev, ring);

We also have two more HDP flush cases in the GART code and the CPU based 
VM code IIRC.

Thanks,
Christian.

>   
>   	if (need_ctx_switch)
>   		status |= AMDGPU_HAVE_CTX_SWITCH;
> @@ -267,10 +259,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>   	if (job && ring->funcs->emit_frame_cntl)
>   		amdgpu_ring_emit_frame_cntl(ring, false, secure);
>   
> -#ifdef CONFIG_X86_64
> -	if (!(adev->flags & AMD_IS_APU))
> -#endif
> -		amdgpu_asic_invalidate_hdp(adev, ring);
> +	amdgpu_asic_invalidate_hdp(adev, ring);
>   
>   	if (ib->flags & AMDGPU_IB_FLAG_TC_WB_NOT_INVALIDATE)
>   		fence_flags |= AMDGPU_FENCE_FLAG_TC_WB_ONLY;

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
