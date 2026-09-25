Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0EA3C9830D
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2026 10:34:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7248710E268;
	Fri, 25 Sep 2026 10:34:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="EOGGNJ2c";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C99910E268
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2026 10:34:20 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49cd4ba9f68so8207155e9.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2026 03:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1790332458; x=1790937258; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WFS9Gu2RNFmQNsftz4YJtV2uU7Vc2WE+Ixja4ba6Zps=;
 b=EOGGNJ2cWfWYdqcWmQQzdPHUI9pk/80UJwBZ/RZQSpeVYAHV+Geb5EF3YG6212n6FU
 OdPghAXfi1HZqmcXKUel6XdWhV92ZMFUo1JS6Lo2nGAKTS1M1KvLM03w/O0CPQaamxUJ
 Jo3bKxrmLjBPtG10qqUmjkbB3z59jP/Q1PHLgUXfbF2qHExR196r/7tZSqwddNQNInLA
 uCBqaJS2MBz75PP643yJTmbXXeqAn3xFLugPd4sOXyXTfKzvi2k2cPh4IXCHWb4J63Jj
 +Bbj/oNiHWnbpEH+CHnJ2Tk5cEw2hLvSxhp8huAhPUqTja7viNDMeoPJ2UuVy8U5dHIL
 slyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790332458; x=1790937258;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WFS9Gu2RNFmQNsftz4YJtV2uU7Vc2WE+Ixja4ba6Zps=;
 b=gcM2PKchZpCn8wGfnbjd1XNmNDepDsWzaTJTqsLqc0rv9mjn6TaCAGN0SYtCgzHLWp
 5axbxysDMqTADZj3qL5oSrEFMfcN1S7vDCLtzfaV8mNleUcVjQLpeTp2CfUHEMZsyBCD
 a5KqFJZbDc6P8a2Zmv5yPz78IYmFUEWeRVoPNr9ckNWwnQagK13sEipPWhZDIpzY40fV
 ISSdF/UoaHMftCOm/icO4jOMLMH8nBgCr18cspzdiCD84ruk7WrJJwvLPuVNUPHTju6N
 4S3DybiPPtLldJ0lxmNhZ9q67mkCTOsIusL3eP4rcg2+FTH4pmkofTU8l1lz6fJpFA9u
 0XBA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy5H2G9deBr7V0atH6XZc6coHIR3TgJG3W3dnYhF7e8TEblLd658lPxLNNMaOSXh5tjdWNnStor@lists.freedesktop.org
X-Gm-Message-State: AFuF++k36qshMN5kZimupxlCinmXhKyxS9vmuMMlMNQairwlJu5lcmbF
 85LA0tzTZ9qWdTBOdpHj3hmVLAZwVQnWryYoQ0YNz3Fb/AbUyMLi3ooCY12naQq08uQ=
X-Gm-Gg: AYBFou3UvRezMZzFNaMnn8yAHt2OgIc78YWqkxS7jQYOx8BHE125pg6ClcjgRuwfQo6
 JmvfNYGS5wci6dwViXA0l8jc5M7fQYJtItDM6fdpZVmrmArlSaoXBgg+aP2uhBuk93D7Q0iPCqP
 7IKB364UMogCP9eN8Td1Ut1RpyRDGHiWXkFFvKEIs2M29VbtJ/KhQhZltn7ksoyKgtuSLMmrkqa
 syzFMYo/Dw1XeOHzcLRHykrmbV6zFN+H15a53ju5sShcr1u3hALXiv8vfaoCuQFsSJ8dwpvncJ8
 YboHla0Fv/hqtgQxzjzyrD0x1cOh24cOPs3J0AOlAzxbZyb6Q0gB7U/eLejz6Lp6tS9lJ7Pw11g
 jKFkZoxydxDL3vUfHCCObyUHhmJcgs8nEU9+fSD2RwK6kH0ItF8q1D/osyqHyrdDf/Ar0qrIUZ2
 E1ZoKI8e7NxECMBNoEiDCNQueZCg3hGplQ/FYUHDeXlbW/F0kWTBmsuWZ7gCTHxqVoZhkokEux6
 5+gfklg0m8tz5M=
X-Received: by 2002:a05:600c:8484:b0:49c:fe46:7219 with SMTP id
 5b1f17b1804b1-49fe66d8135mr89257005e9.20.1790332458125; 
 Fri, 25 Sep 2026 03:34:18 -0700 (PDT)
Received: from [192.168.0.116] ([81.79.79.1]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a74538asm6113570f8f.34.2026.09.25.03.34.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2026 03:34:16 -0700 (PDT)
Message-ID: <5fdab172-c7b8-472e-8c6c-c6d5fd7afc70@ursulin.net>
Date: Fri, 25 Sep 2026 11:34:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Derive RLC SPM xcc from GFXHUB
To: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com, James.Zhu@amd.com, Bing.Ma@amd.com
References: <20260925093718.2737342-1-lijo.lazar@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260925093718.2737342-1-lijo.lazar@amd.com>
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


On 25/09/2026 10:37, Lijo Lazar wrote:
> RLC SPM is updated for GFX subsystem related performance counters. Only
> jobs on rings that use GFX subsystem need to be updated. Some rings like
> SDMA could be inside/outside of GFX subsytem based on SOC. Identify the
> rings using GFXHUB assignment and use hub id assigned to find the right
> GC rather than relying on xcc id. xcc id may not be necessarily assigned
> properly for all rings.

I don't know the hardware well enough to review or be certain of what I 
will ask, but if you remember the "kitten dies" meme it often comes to 
my mind that "every time amdgpu repeatedly walks a list of everything to 
find something at runtime a kitten dies". :)

On a serious note, question I have following the statement from the 
commit message that xcc id is not always correct for all rings is, would 
it be feasible to make it correct? At ring init time I mean. And so 
avoid having to repeatedly look for it.

Regards,

Tvrtko

> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c | 31 +++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h |  2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  |  2 +-
>   4 files changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 0f8b097001e3..6ea73ef6e672 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -212,7 +212,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   		amdgpu_ring_emit_pipeline_sync(ring);
>   
>   	if (emit_spm_needed)
> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, ring, job->vmid);
> +		amdgpu_gfx_rlc_update_spm(adev, ring, job->vmid);
>   
>   	if (emit_gds_needed)
>   		amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
> index 002fae3c380e..f791e1bcbf17 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
> @@ -27,6 +27,37 @@
>   #include "amdgpu_gfx.h"
>   #include "amdgpu_rlc.h"
>   
> +/**
> + * amdgpu_gfx_rlc_update_spm - update RLC SPM VMID
> + *
> + * @adev: amdgpu_device pointer
> + * @ring: ring the VMID got assigned to
> + * @vmid: VMID to program
> + *
> + * RLC SPM counters are used only for GFX and GFX Cache subsystem. Only jobs submitted to
> + * rings in GFX subsystem need to update RLC SPM counters. Derive xcc_id from ring->vm_hub.
> + */
> +void amdgpu_gfx_rlc_update_spm(struct amdgpu_device *adev,
> +			       struct amdgpu_ring *ring, unsigned int vmid)
> +{
> +	int xcc_id, num_xcc;
> +
> +	if (!adev->gfx.rlc.funcs->update_spm_vmid || !ring)
> +		return;
> +
> +	if (!AMDGPU_IS_GFXHUB(ring->vm_hub))
> +		return;
> +
> +	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
> +	for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
> +		if (AMDGPU_GFXHUB(xcc_id) == ring->vm_hub) {
> +			adev->gfx.rlc.funcs->update_spm_vmid(adev, xcc_id, ring,
> +							     vmid);
> +			return;
> +		}
> +	}
> +}
> +
>   /**
>    * amdgpu_gfx_rlc_enter_safe_mode - Set RLC into safe mode
>    *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> index 959d60c90dcd..1410954da5a6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> @@ -370,6 +370,8 @@ struct amdgpu_rlc {
>   	struct amdgpu_rlcg_reg_access_ctrl reg_access_ctrl[AMDGPU_MAX_RLC_INSTANCES];
>   };
>   
> +void amdgpu_gfx_rlc_update_spm(struct amdgpu_device *adev,
> +			       struct amdgpu_ring *ring, unsigned int vmid);
>   void amdgpu_gfx_rlc_enter_safe_mode(struct amdgpu_device *adev, int xcc_id);
>   void amdgpu_gfx_rlc_exit_safe_mode(struct amdgpu_device *adev, int xcc_id);
>   int amdgpu_gfx_rlc_init_sr(struct amdgpu_device *adev, u32 dws);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 29a66e39f3d6..dc8f85176b8b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -865,7 +865,7 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   		amdgpu_gmc_emit_pasid_mapping(ring, job->vmid, job->pasid);
>   
>   	if (spm_update_needed)
> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, ring, job->vmid);
> +		amdgpu_gfx_rlc_update_spm(adev, ring, job->vmid);
>   
>   	if (gds_switch_needed)
>   		amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,

