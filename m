Return-Path: <SRS0=wRAp=4H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D49C34047
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 11:02:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9787C206DB
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 11:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mvu+OlIk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9787C206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4715B6EB7E;
	Wed, 19 Feb 2020 11:02:51 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EF9D6EB72
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 11:02:50 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id t23so135800wmi.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 03:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=ePXbpz6gyrkHCCbrDARvfkAQfpjVkF+pwZKLZS769bw=;
 b=Mvu+OlIkJvl3tCZ8hMJw68XvMV0l0vQHwPvtbXNaIRpUjwoaRN06sUqWnEFAA9F8ta
 Cmr2cXdM6SHhOzQESQxCobVeYb0kcKEvjEEpLOD88JRD+tkQ6xcXPMQLIF7EVkZQzvWJ
 2ZYFWMCs61s6R3W8Xasr73cobMiBrUrj6B9yt4/T03cT/B1M4Z7Ui+2EpgPa7o2DLkZf
 0O3rZA/VyvhHRJR6YRjx8+mS7qGVH+aggepcKhPQhagzhPtSRUfne1byAK/vwm+x1Ukc
 Z4KqVxOf93RY37mWqa3RT03gK2rXaW8j6pMmM9ro2P01kHUdzeCWlfBt5g6Z+Pc7HC5i
 Nw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=ePXbpz6gyrkHCCbrDARvfkAQfpjVkF+pwZKLZS769bw=;
 b=B5a+Lfz6RyYzJxmPRgfD2909669vZNKJimjDcZKHhCWTXJYRY9ZDhyQyTojL2rzHKq
 tMq3M3JOUpn337Mbir1DlfX+q9f+uEOySrZSugupijgDGo3uOiowX/bya74hNQXBLKb1
 RgwxvTODoXcpmQfqImZw8uUX4yT5ZHHt7tL0CE3T5Dv0/iz7DxZaci0h1VX2jrufkRO5
 3UUB95qXDUlSeKrnESt+umYl8YkGOqvDmqud46H2kXbngoC0UYg4CtvnGeEChkhxYfLi
 25i30SzJBIY0NIA0EqUbupirnaDz7tf96LRJvIZnnElx+WcuTD2OuZFOMPg0h5dgveKk
 hNQA==
X-Gm-Message-State: APjAAAW5YCH9R2bKw2t8TeZLuUjwXaNnAowdp5Gb5j1eOx6C8HLW2zpH
 FFe3XMyMsqxbbiZsjKHuZ8Qn9rUn
X-Google-Smtp-Source: APXvYqxuJz78PoDpEuNcy0qIPmHpxI3rHA8uVE+d5wQdsUOced6AjuFoLXV/XaFhfQSnqnnBZg8mSg==
X-Received: by 2002:a1c:1b93:: with SMTP id b141mr9770776wmb.114.1582110168391; 
 Wed, 19 Feb 2020 03:02:48 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id d13sm2503011wrc.64.2020.02.19.03.02.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 19 Feb 2020 03:02:47 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: Add a chunk ID for spm trace
To: Jacob He <jacob.he@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200219101506.16779-1-jacob.he@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <e2fea4f5-0eea-75b5-9cd7-68b603629d8d@gmail.com>
Date: Wed, 19 Feb 2020 12:02:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200219101506.16779-1-jacob.he@amd.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 19.02.20 um 11:15 schrieb Jacob He:
> [WHY]
> When SPM trace enabled, SPM_VMID should be updated with the current
> vmid.
>
> [HOW]
> Add a chunk id, AMDGPU_CHUNK_ID_SPM_TRACE, so that UMD can tell us
> which job should update SPM_VMID.
> Right before a job is submitted to GPU, set the SPM_VMID accordingly.
>
> [Limitation]
> Running more than one SPM trace enabled processes simultaneously is
> not supported.

Well there are multiple problems with that patch.

First of all you need to better describe what SPM tracing is in the 
commit message.

Then the updating of mmRLC_SPM_MC_CNTL must be executed asynchronously 
on the ring. Otherwise we might corrupt an already executing SPM trace.

And you also need to make sure to disable the tracing again or otherwise 
we run into a bunch of trouble when the VMID is reused.

You also need to make sure that IBs using the SPM trace are serialized 
with each other, e.g. hack into amdgpu_ids.c file and make sure that 
only one VMID at a time can have that attribute.

Regards,
Christian.

>
> Change-Id: Ic932ef6ac9dbf244f03aaee90550e8ff3a675666
> Signed-off-by: Jacob He <jacob.he@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  |  7 +++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  | 10 +++++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h |  1 +
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 15 ++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 15 ++++++++++++++-
>   8 files changed, 48 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index f9fa6e104fef..3f32c4db5232 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -113,6 +113,7 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
>   	uint32_t uf_offset = 0;
>   	int i;
>   	int ret;
> +	bool update_spm_vmid = false;
>   
>   	if (cs->in.num_chunks == 0)
>   		return 0;
> @@ -221,6 +222,10 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
>   		case AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL:
>   			break;
>   
> +		case AMDGPU_CHUNK_ID_SPM_TRACE:
> +			update_spm_vmid = true;
> +			break;
> +
>   		default:
>   			ret = -EINVAL;
>   			goto free_partial_kdata;
> @@ -231,6 +236,8 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
>   	if (ret)
>   		goto free_all_kdata;
>   
> +	p->job->need_update_spm_vmid = update_spm_vmid;
> +
>   	if (p->ctx->vram_lost_counter != p->job->vram_lost_counter) {
>   		ret = -ECANCELED;
>   		goto free_all_kdata;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index cae81914c821..36faab12b585 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -156,9 +156,13 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>   		return -EINVAL;
>   	}
>   
> -	if (vm && !job->vmid) {
> -		dev_err(adev->dev, "VM IB without ID\n");
> -		return -EINVAL;
> +	if (vm) {
> +		if (!job->vmid) {
> +			dev_err(adev->dev, "VM IB without ID\n");
> +			return -EINVAL;
> +		} else if (adev->gfx.rlc.funcs->update_spm_vmid && job->need_update_spm_vmid) {
> +			adev->gfx.rlc.funcs->update_spm_vmid(adev, job->vmid);
> +		}
>   	}
>   
>   	alloc_size = ring->funcs->emit_frame_size + num_ibs *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index 2e2110dddb76..4582536961c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -52,6 +52,7 @@ struct amdgpu_job {
>   	bool                    vm_needs_flush;
>   	uint64_t		vm_pd_addr;
>   	unsigned		vmid;
> +	bool			need_update_spm_vmid;
>   	unsigned		pasid;
>   	uint32_t		gds_base, gds_size;
>   	uint32_t		gws_base, gws_size;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> index d3d4707f2168..52509c254cbd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> @@ -126,6 +126,7 @@ struct amdgpu_rlc_funcs {
>   	void (*stop)(struct amdgpu_device *adev);
>   	void (*reset)(struct amdgpu_device *adev);
>   	void (*start)(struct amdgpu_device *adev);
> +	void (*update_spm_vmid)(struct amdgpu_device *adev, unsigned vmid);
>   };
>   
>   struct amdgpu_rlc {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 5e9fb0976c6c..91eb788d6229 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4214,6 +4214,18 @@ static int gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> +static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
> +{
> +	u32 data;
> +
> +	data = RREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL);
> +
> +	data &= ~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK;
> +	data |= (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
> +
> +	WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, data);
> +}
> +
>   static const struct amdgpu_rlc_funcs gfx_v10_0_rlc_funcs = {
>   	.is_rlc_enabled = gfx_v10_0_is_rlc_enabled,
>   	.set_safe_mode = gfx_v10_0_set_safe_mode,
> @@ -4224,7 +4236,8 @@ static const struct amdgpu_rlc_funcs gfx_v10_0_rlc_funcs = {
>   	.resume = gfx_v10_0_rlc_resume,
>   	.stop = gfx_v10_0_rlc_stop,
>   	.reset = gfx_v10_0_rlc_reset,
> -	.start = gfx_v10_0_rlc_start
> +	.start = gfx_v10_0_rlc_start,
> +	.update_spm_vmid = gfx_v10_0_update_spm_vmid
>   };
>   
>   static int gfx_v10_0_set_powergating_state(void *handle,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index 8f20a5dd44fe..b24fc55cf13a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -4221,7 +4221,8 @@ static const struct amdgpu_rlc_funcs gfx_v7_0_rlc_funcs = {
>   	.resume = gfx_v7_0_rlc_resume,
>   	.stop = gfx_v7_0_rlc_stop,
>   	.reset = gfx_v7_0_rlc_reset,
> -	.start = gfx_v7_0_rlc_start
> +	.start = gfx_v7_0_rlc_start,
> +	.update_spm_vmid = NULL
>   };
>   
>   static int gfx_v7_0_early_init(void *handle)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index fa245973de12..66640d2b6b37 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -5600,7 +5600,8 @@ static const struct amdgpu_rlc_funcs iceland_rlc_funcs = {
>   	.resume = gfx_v8_0_rlc_resume,
>   	.stop = gfx_v8_0_rlc_stop,
>   	.reset = gfx_v8_0_rlc_reset,
> -	.start = gfx_v8_0_rlc_start
> +	.start = gfx_v8_0_rlc_start,
> +	.update_spm_vmid = NULL
>   };
>   
>   static void gfx_v8_0_update_medium_grain_clock_gating(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 9b7ff783e9a5..df872f949f68 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -4704,6 +4704,18 @@ static int gfx_v9_0_update_gfx_clock_gating(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> +static void gfx_v9_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
> +{
> +	u32 data;
> +
> +	data = RREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL);
> +
> +	data &= ~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK;
> +	data |= (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
> +
> +	WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, data);
> +}
> +
>   static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_funcs = {
>   	.is_rlc_enabled = gfx_v9_0_is_rlc_enabled,
>   	.set_safe_mode = gfx_v9_0_set_safe_mode,
> @@ -4715,7 +4727,8 @@ static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_funcs = {
>   	.resume = gfx_v9_0_rlc_resume,
>   	.stop = gfx_v9_0_rlc_stop,
>   	.reset = gfx_v9_0_rlc_reset,
> -	.start = gfx_v9_0_rlc_start
> +	.start = gfx_v9_0_rlc_start,
> +	.update_spm_vmid = gfx_v9_0_update_spm_vmid
>   };
>   
>   static int gfx_v9_0_set_powergating_state(void *handle,

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
