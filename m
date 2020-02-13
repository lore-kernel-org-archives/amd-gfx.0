Return-Path: <SRS0=YeOH=4B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B87C2BA83
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2020 10:30:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C75D020873
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2020 10:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n0emW4tk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C75D020873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BF3A6E1D8;
	Thu, 13 Feb 2020 10:30:47 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E07F56E1D8
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2020 10:30:46 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id y17so5985036wrh.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2020 02:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=Kl66Hm2vHbmvhLmEL/MRfrXGz1TCrdGbl5KWooJNxX0=;
 b=n0emW4tkOhfMZYalf437+RRlTc8EoJHdL+oeim74WCVe3JEWBk3cXzqUzipFnE30Y1
 nND/E2TZXq537JfcGFnZMZRV+oI7J4Dbsi+TsLutEdwLMVaHlht/j+zJ0mEOjf3V6Sf9
 c5J0L6YevYuY73dnOHkW7c0aCT0BcG72ub4wMX13J7bKkcXSORnytQIzTZwa479likml
 TqniIW2pct8bn5b7ooiC6cy0PXFuFn2zqKAJw58gEhcWdQARG7LKTteIp5jj/yw/fqkl
 rrRqKr8Pf+3Mumb7X+pJeRxT6Py1B8p+ARU4S5xLU6HFAze/Hf8Kpe9CC6XSzts6HMIz
 h1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Kl66Hm2vHbmvhLmEL/MRfrXGz1TCrdGbl5KWooJNxX0=;
 b=PwKfxmQPbzW+dVF7E1my/6GXXfrBNR3mfAsPO5awa51PyNXnx/0AYlY3kqS21qjSwu
 JcxOqKY0csbtwNQCnv1mUxdaLMJES/0KhrS9dIhfRRhB8JLWzHnu+jFx2ziv4Xf59jie
 6rLfu+At9cUdbaan1YG/UJOMThvy7Y8AMMHjT4hU7+nqbgmGX6iVxynp6ylsgsLzMKzu
 M4WN7GQ+yhFulg9yn8fhaPu1Oo2s5Ftl2SuRr2KEB9+0LlZDdau/RvmO/WPzNvb7KILr
 Y1s2FSrp4nC57tivakbH7D64NLYvTUyV5u0N58ZKG6TflcEQwBEu0YSceOmDDR7FZFvB
 RXdg==
X-Gm-Message-State: APjAAAVY2/dwfby3lYDArrf1/qrgXPnZi8X8LAwJyr1bJKr/KxH8Q0xP
 EIMxQ9e8KK0NcSY40w54AzUY7C/V
X-Google-Smtp-Source: APXvYqxoJlrReM7Lwe+W4fV9s33+iqhzI5jjxkpRQlsfVqiS31zyp1CtOEw8H3m/iaT+MusMj9BlUQ==
X-Received: by 2002:a5d:5452:: with SMTP id w18mr19969117wrv.333.1581589845258; 
 Thu, 13 Feb 2020 02:30:45 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id i16sm2566135wmb.36.2020.02.13.02.30.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Feb 2020 02:30:44 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: Move to a per-IB secure flag (TMZ)
To: Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200213005455.521401-1-luben.tuikov@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <e1b57c7e-138c-435a-8450-e1bf44e4e10d@gmail.com>
Date: Thu, 13 Feb 2020 11:30:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200213005455.521401-1-luben.tuikov@amd.com>
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

Am 13.02.20 um 01:54 schrieb Luben Tuikov:
> Move from a per-CS secure flag (TMZ) to a per-IB
> secure flag.

Well that seems to make a lot of sense to me, but need to bit of time to 
read into the PM4 handling of TMZ.

Especially what is the "start" parameter good for?

Regards,
Christian.

>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  2 --
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   | 23 ++++++++++++++++++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h  |  3 ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  9 ++++-----
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 23 +++++++----------------
>   drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c    |  3 +--
>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c    |  3 +--
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    |  3 +--
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 20 ++++++--------------
>   include/uapi/drm/amdgpu_drm.h            |  7 ++++---
>   10 files changed, 44 insertions(+), 52 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 80ba6dfc54e2..f9fa6e104fef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -231,8 +231,6 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
>   	if (ret)
>   		goto free_all_kdata;
>   
> -	p->job->secure = cs->in.flags & AMDGPU_CS_FLAGS_SECURE;
> -
>   	if (p->ctx->vram_lost_counter != p->job->vram_lost_counter) {
>   		ret = -ECANCELED;
>   		goto free_all_kdata;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 6e0f97afb030..cae81914c821 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -132,6 +132,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>   	uint64_t fence_ctx;
>   	uint32_t status = 0, alloc_size;
>   	unsigned fence_flags = 0;
> +	bool secure;
>   
>   	unsigned i;
>   	int r = 0;
> @@ -213,9 +214,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>   	if (job && ring->funcs->emit_cntxcntl) {
>   		status |= job->preamble_status;
>   		status |= job->preemption_status;
> -		amdgpu_ring_emit_cntxcntl(ring, status, job->secure);
> +		amdgpu_ring_emit_cntxcntl(ring, status);
>   	}
>   
> +	secure = false;
>   	for (i = 0; i < num_ibs; ++i) {
>   		ib = &ibs[i];
>   
> @@ -227,12 +229,27 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>   		    !amdgpu_sriov_vf(adev)) /* for SRIOV preemption, Preamble CE ib must be inserted anyway */
>   			continue;
>   
> +		/* If this IB is TMZ, add frame TMZ start packet,
> +		 * else, turn off TMZ.
> +		 */
> +		if (ib->flags & AMDGPU_IB_FLAGS_SECURE && ring->funcs->emit_tmz) {
> +			if (!secure) {
> +				secure = true;
> +				amdgpu_ring_emit_tmz(ring, true);
> +			}
> +		} else if (secure) {
> +			secure = false;
> +			amdgpu_ring_emit_tmz(ring, false);
> +		}
> +
>   		amdgpu_ring_emit_ib(ring, job, ib, status);
>   		status &= ~AMDGPU_HAVE_CTX_SWITCH;
>   	}
>   
> -	if (ring->funcs->emit_tmz)
> -		amdgpu_ring_emit_tmz(ring, false, job ? job->secure : false);
> +	if (secure) {
> +		secure = false;
> +		amdgpu_ring_emit_tmz(ring, false);
> +	}
>   
>   #ifdef CONFIG_X86_64
>   	if (!(adev->flags & AMD_IS_APU))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index 31c4444b0203..2e2110dddb76 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -61,9 +61,6 @@ struct amdgpu_job {
>   	/* user fence handling */
>   	uint64_t		uf_addr;
>   	uint64_t		uf_sequence;
> -
> -	/* the job is due to a secure command submission */
> -	bool			secure;
>   };
>   
>   int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned num_ibs,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 5134d0dd6dc2..930316e60155 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -158,8 +158,7 @@ struct amdgpu_ring_funcs {
>   	void (*begin_use)(struct amdgpu_ring *ring);
>   	void (*end_use)(struct amdgpu_ring *ring);
>   	void (*emit_switch_buffer) (struct amdgpu_ring *ring);
> -	void (*emit_cntxcntl) (struct amdgpu_ring *ring, uint32_t flags,
> -			       bool trusted);
> +	void (*emit_cntxcntl) (struct amdgpu_ring *ring, uint32_t flags);
>   	void (*emit_rreg)(struct amdgpu_ring *ring, uint32_t reg);
>   	void (*emit_wreg)(struct amdgpu_ring *ring, uint32_t reg, uint32_t val);
>   	void (*emit_reg_wait)(struct amdgpu_ring *ring, uint32_t reg,
> @@ -167,7 +166,7 @@ struct amdgpu_ring_funcs {
>   	void (*emit_reg_write_reg_wait)(struct amdgpu_ring *ring,
>   					uint32_t reg0, uint32_t reg1,
>   					uint32_t ref, uint32_t mask);
> -	void (*emit_tmz)(struct amdgpu_ring *ring, bool start, bool trusted);
> +	void (*emit_tmz)(struct amdgpu_ring *ring, bool start);
>   	/* priority functions */
>   	void (*set_priority) (struct amdgpu_ring *ring,
>   			      enum drm_sched_priority priority);
> @@ -243,12 +242,12 @@ struct amdgpu_ring {
>   #define amdgpu_ring_emit_gds_switch(r, v, db, ds, wb, ws, ab, as) (r)->funcs->emit_gds_switch((r), (v), (db), (ds), (wb), (ws), (ab), (as))
>   #define amdgpu_ring_emit_hdp_flush(r) (r)->funcs->emit_hdp_flush((r))
>   #define amdgpu_ring_emit_switch_buffer(r) (r)->funcs->emit_switch_buffer((r))
> -#define amdgpu_ring_emit_cntxcntl(r, d, s) (r)->funcs->emit_cntxcntl((r), (d), (s))
> +#define amdgpu_ring_emit_cntxcntl(r, d) (r)->funcs->emit_cntxcntl((r), (d))
>   #define amdgpu_ring_emit_rreg(r, d) (r)->funcs->emit_rreg((r), (d))
>   #define amdgpu_ring_emit_wreg(r, d, v) (r)->funcs->emit_wreg((r), (d), (v))
>   #define amdgpu_ring_emit_reg_wait(r, d, v, m) (r)->funcs->emit_reg_wait((r), (d), (v), (m))
>   #define amdgpu_ring_emit_reg_write_reg_wait(r, d0, d1, v, m) (r)->funcs->emit_reg_write_reg_wait((r), (d0), (d1), (v), (m))
> -#define amdgpu_ring_emit_tmz(r, b, s) (r)->funcs->emit_tmz((r), (b), (s))
> +#define amdgpu_ring_emit_tmz(r, b) (r)->funcs->emit_tmz((r), (b))
>   #define amdgpu_ring_pad_ib(r, ib) ((r)->funcs->pad_ib((r), (ib)))
>   #define amdgpu_ring_init_cond_exec(r) (r)->funcs->init_cond_exec((r))
>   #define amdgpu_ring_patch_cond_exec(r,o) (r)->funcs->patch_cond_exec((r),(o))
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 4e25b39ac14f..1a9787a0177e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -256,8 +256,7 @@ static int gfx_v10_0_rlc_backdoor_autoload_enable(struct amdgpu_device *adev);
>   static int gfx_v10_0_wait_for_rlc_autoload_complete(struct amdgpu_device *adev);
>   static void gfx_v10_0_ring_emit_ce_meta(struct amdgpu_ring *ring, bool resume);
>   static void gfx_v10_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume);
> -static void gfx_v10_0_ring_emit_tmz(struct amdgpu_ring *ring, bool start,
> -				    bool trusted);
> +static void gfx_v10_0_ring_emit_tmz(struct amdgpu_ring *ring, bool start);
>   
>   static void gfx10_kiq_set_resources(struct amdgpu_ring *kiq_ring, uint64_t queue_mask)
>   {
> @@ -4564,8 +4563,7 @@ static void gfx_v10_0_ring_emit_sb(struct amdgpu_ring *ring)
>   }
>   
>   static void gfx_v10_0_ring_emit_cntxcntl(struct amdgpu_ring *ring,
> -					 uint32_t flags,
> -					 bool trusted)
> +					 uint32_t flags)
>   {
>   	uint32_t dw2 = 0;
>   
> @@ -4573,8 +4571,6 @@ static void gfx_v10_0_ring_emit_cntxcntl(struct amdgpu_ring *ring,
>   		gfx_v10_0_ring_emit_ce_meta(ring,
>   				    flags & AMDGPU_IB_PREEMPTED ? true : false);
>   
> -	gfx_v10_0_ring_emit_tmz(ring, true, trusted);
> -
>   	dw2 |= 0x80000000; /* set load_enable otherwise this package is just NOPs */
>   	if (flags & AMDGPU_HAVE_CTX_SWITCH) {
>   		/* set load_global_config & load_global_uconfig */
> @@ -4731,17 +4727,12 @@ static void gfx_v10_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume)
>   					   sizeof(de_payload) >> 2);
>   }
>   
> -static void gfx_v10_0_ring_emit_tmz(struct amdgpu_ring *ring, bool start,
> -				    bool trusted)
> +static void gfx_v10_0_ring_emit_tmz(struct amdgpu_ring *ring, bool start)
>   {
> -	amdgpu_ring_write(ring, PACKET3(PACKET3_FRAME_CONTROL, 0));
> -	/*
> -	 * cmd = 0: frame begin
> -	 * cmd = 1: frame end
> -	 */
> -	amdgpu_ring_write(ring,
> -			  ((amdgpu_is_tmz(ring->adev) && trusted) ? FRAME_TMZ : 0)
> -			  | FRAME_CMD(start ? 0 : 1));
> +	if (amdgpu_is_tmz(ring->adev)) {
> +		amdgpu_ring_write(ring, PACKET3(PACKET3_FRAME_CONTROL, 0));
> +		amdgpu_ring_write(ring, FRAME_TMZ | FRAME_CMD(start ? 0 : 1));
> +	}
>   }
>   
>   static void gfx_v10_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> index 95bb2422b27c..31f44d05e606 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> @@ -2973,8 +2973,7 @@ static uint64_t gfx_v6_0_get_gpu_clock_counter(struct amdgpu_device *adev)
>   	return clock;
>   }
>   
> -static void gfx_v6_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32_t flags,
> -				      bool trusted)
> +static void gfx_v6_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32_t flags)
>   {
>   	if (flags & AMDGPU_HAVE_CTX_SWITCH)
>   		gfx_v6_0_ring_emit_vgt_flush(ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index 648d767d14e7..8f20a5dd44fe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -2320,8 +2320,7 @@ static void gfx_v7_0_ring_emit_ib_compute(struct amdgpu_ring *ring,
>   	amdgpu_ring_write(ring, control);
>   }
>   
> -static void gfx_v7_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32_t flags,
> -				      bool trusted)
> +static void gfx_v7_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32_t flags)
>   {
>   	uint32_t dw2 = 0;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index a46ec1c9846e..fa245973de12 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -6386,8 +6386,7 @@ static void gfx_v8_ring_emit_sb(struct amdgpu_ring *ring)
>   	amdgpu_ring_write(ring, 0);
>   }
>   
> -static void gfx_v8_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32_t flags,
> -				      bool trusted)
> +static void gfx_v8_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32_t flags)
>   {
>   	uint32_t dw2 = 0;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index e5753746cbf9..9d3805488832 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -5212,29 +5212,21 @@ static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring)
>   	amdgpu_ring_write_multiple(ring, (void *)&de_payload, sizeof(de_payload) >> 2);
>   }
>   
> -static void gfx_v9_0_ring_emit_tmz(struct amdgpu_ring *ring, bool start,
> -				   bool trusted)
> +static void gfx_v9_0_ring_emit_tmz(struct amdgpu_ring *ring, bool start)
>   {
> -	amdgpu_ring_write(ring, PACKET3(PACKET3_FRAME_CONTROL, 0));
> -	/*
> -	 * cmd = 0: frame begin
> -	 * cmd = 1: frame end
> -	 */
> -	amdgpu_ring_write(ring,
> -			  ((amdgpu_is_tmz(ring->adev) && trusted) ? FRAME_TMZ : 0)
> -			  | FRAME_CMD(start ? 0 : 1));
> +	if (amdgpu_is_tmz(ring->adev)) {
> +		amdgpu_ring_write(ring, PACKET3(PACKET3_FRAME_CONTROL, 0));
> +		amdgpu_ring_write(ring, FRAME_TMZ | FRAME_CMD(start ? 0 : 1));
> +	}
>   }
>   
> -static void gfx_v9_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32_t flags,
> -				      bool trusted)
> +static void gfx_v9_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32_t flags)
>   {
>   	uint32_t dw2 = 0;
>   
>   	if (amdgpu_sriov_vf(ring->adev))
>   		gfx_v9_0_ring_emit_ce_meta(ring);
>   
> -	gfx_v9_0_ring_emit_tmz(ring, true, trusted);
> -
>   	dw2 |= 0x80000000; /* set load_enable otherwise this package is just NOPs */
>   	if (flags & AMDGPU_HAVE_CTX_SWITCH) {
>   		/* set load_global_config & load_global_uconfig */
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 918ac3548cd3..eaf94a421901 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -556,9 +556,6 @@ struct drm_amdgpu_cs_chunk {
>   	__u64		chunk_data;
>   };
>   
> -/* Flag the command submission as secure */
> -#define AMDGPU_CS_FLAGS_SECURE          (1 << 0)
> -
>   struct drm_amdgpu_cs_in {
>   	/** Rendering context id */
>   	__u32		ctx_id;
> @@ -599,6 +596,10 @@ union drm_amdgpu_cs {
>    */
>   #define AMDGPU_IB_FLAG_RESET_GDS_MAX_WAVE_ID (1 << 4)
>   
> +/* Flag the IB as secure (TMZ)
> + */
> +#define AMDGPU_IB_FLAGS_SECURE  (1 << 5)
> +
>   struct drm_amdgpu_cs_chunk_ib {
>   	__u32 _pad;
>   	/** AMDGPU_IB_FLAG_* */

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
