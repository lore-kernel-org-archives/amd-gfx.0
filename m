Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC62C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 14:32:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1AE62053B
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 14:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="lNzJXJgV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1AE62053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AD076E09E;
	Mon,  8 Jun 2020 14:32:28 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D6456E840
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2020 14:32:27 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id l17so4363721wmj.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Jun 2020 07:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to;
 bh=GKWIm0azDCxLSg6UcyWc7rSovYmDP72I/JD5+Yb/qNE=;
 b=lNzJXJgV2fHm7TbizH361S90IASi17wyWUHqzcwW4u7tTxae6KXr+C0LjMAmLQqmKP
 0D9QnO8zqY1Ku4ticsen8nhFZvrqes1Rh+D6z8U36MCINpOa3IdoSISvvKhbwOYPoog7
 sEMZmDKY75gvwAZ5YCSvtqnBOKLBIgs9/jUtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=GKWIm0azDCxLSg6UcyWc7rSovYmDP72I/JD5+Yb/qNE=;
 b=ciee9a3+bdDPu7cKlR9LQxrtChjx+7sSfIGTUjbRS+DpC5R+7YJmMDoXnKhmEXHZzX
 TQBLIKcbNSr7KgmD/XVyhREv26yow0R2KMksW9oj9KFuDyqnyEE4ryOpgC3LYMF3pIix
 EM8V7gf7pGnKgTx8ucPvrLXnoVztbz3aa+VtoZmGzpy843PD1OgP7kl5tdgY+y0WRqoG
 dS/3PIDVqJTU1CoVduM1hBFMznlSkuuJ8yFUqqt6XXk5/b8LAA+0zJA5rmemWsGM26vX
 tCRkO3nxsVxdClkOankoLCEzyqdc+6Agu3J5pbzQTsKtBVZpu1IQtWril0nqcEALBZOH
 UICg==
X-Gm-Message-State: AOAM532ROE5efQEVVtZQVrxyAxz20XEpObW3NEFr9F/O/0icr6LD3Rq3
 duuBHfDnLMnYW0osYvQejiCgFw==
X-Google-Smtp-Source: ABdhPJwA0/mdaMZ0zUKmM6gSc0qDTmbylcrcm85b2VC63CraAyQvqNiDlv+Rnjc4q94SDWFNGXViSw==
X-Received: by 2002:a1c:e389:: with SMTP id a131mr17386232wmh.46.1591626745819; 
 Mon, 08 Jun 2020 07:32:25 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id h188sm23593079wmh.2.2020.06.08.07.32.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 07:32:24 -0700 (PDT)
Date: Mon, 8 Jun 2020 16:32:21 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: Re: [PATCH v2 06/18] dma-buf: Use sequence counter with associated
 wound/wait mutex
Message-ID: <20200608143221.GW20149@phenom.ffwll.local>
Mail-Followup-To: "Ahmed S. Darwish" <a.darwish@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Sebastian A. Siewior" <bigeasy@linutronix.de>,
 Steven Rostedt <rostedt@goodmis.org>,
 LKML <linux-kernel@vger.kernel.org>,
 David Airlie <airlied@linux.ie>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200608005729.1874024-1-a.darwish@linutronix.de>
 <20200608005729.1874024-7-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200608005729.1874024-7-a.darwish@linutronix.de>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 amd-gfx@lists.freedesktop.org, "Paul E. McKenney" <paulmck@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 "Sebastian A. Siewior" <bigeasy@linutronix.de>,
 LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Ingo Molnar <mingo@redhat.com>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jun 08, 2020 at 02:57:17AM +0200, Ahmed S. Darwish wrote:
> A sequence counter write side critical section must be protected by some
> form of locking to serialize writers. If the serialization primitive is
> not disabling preemption implicitly, preemption has to be explicitly
> disabled before entering the sequence counter write side critical
> section.
> 
> The dma-buf reservation subsystem uses plain sequence counters to manage
> updates to reservations. Writer serialization is accomplished through a
> wound/wait mutex.
> 
> Acquiring a wound/wait mutex does not disable preemption, so this needs
> to be done manually before and after the write side critical section.
> 
> Use the newly-added seqcount_ww_mutex_t instead:
> 
>   - It associates the ww_mutex with the sequence count, which enables
>     lockdep to validate that the write side critical section is properly
>     serialized.
> 
>   - It removes the need to explicitly add preempt_disable/enable()
>     around the write side critical section because the write_begin/end()
>     functions for this new data type automatically do this.
> 
> If lockdep is disabled this ww_mutex lock association is compiled out
> and has neither storage size nor runtime overhead.
> 
> Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>

I'm not seeing the patch that adds the seqcount ww_mutex glue and not
quite motivated enough to grab it from lore, so someone else needs to
check the details. Just

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

for merging through whatever tree/branch makes sense from me.
-Daniel

> ---
>  drivers/dma-buf/dma-resv.c                       | 8 +-------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 --
>  include/linux/dma-resv.h                         | 2 +-
>  3 files changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-resv.c b/drivers/dma-buf/dma-resv.c
> index 590ce7ad60a0..3aba2b2bfc48 100644
> --- a/drivers/dma-buf/dma-resv.c
> +++ b/drivers/dma-buf/dma-resv.c
> @@ -128,7 +128,7 @@ subsys_initcall(dma_resv_lockdep);
>  void dma_resv_init(struct dma_resv *obj)
>  {
>  	ww_mutex_init(&obj->lock, &reservation_ww_class);
> -	seqcount_init(&obj->seq);
> +	seqcount_ww_mutex_init(&obj->seq, &obj->lock);
>  
>  	RCU_INIT_POINTER(obj->fence, NULL);
>  	RCU_INIT_POINTER(obj->fence_excl, NULL);
> @@ -259,7 +259,6 @@ void dma_resv_add_shared_fence(struct dma_resv *obj, struct dma_fence *fence)
>  	fobj = dma_resv_get_list(obj);
>  	count = fobj->shared_count;
>  
> -	preempt_disable();
>  	write_seqcount_begin(&obj->seq);
>  
>  	for (i = 0; i < count; ++i) {
> @@ -281,7 +280,6 @@ void dma_resv_add_shared_fence(struct dma_resv *obj, struct dma_fence *fence)
>  	smp_store_mb(fobj->shared_count, count);
>  
>  	write_seqcount_end(&obj->seq);
> -	preempt_enable();
>  	dma_fence_put(old);
>  }
>  EXPORT_SYMBOL(dma_resv_add_shared_fence);
> @@ -308,14 +306,12 @@ void dma_resv_add_excl_fence(struct dma_resv *obj, struct dma_fence *fence)
>  	if (fence)
>  		dma_fence_get(fence);
>  
> -	preempt_disable();
>  	write_seqcount_begin(&obj->seq);
>  	/* write_seqcount_begin provides the necessary memory barrier */
>  	RCU_INIT_POINTER(obj->fence_excl, fence);
>  	if (old)
>  		old->shared_count = 0;
>  	write_seqcount_end(&obj->seq);
> -	preempt_enable();
>  
>  	/* inplace update, no shared fences */
>  	while (i--)
> @@ -393,13 +389,11 @@ int dma_resv_copy_fences(struct dma_resv *dst, struct dma_resv *src)
>  	src_list = dma_resv_get_list(dst);
>  	old = dma_resv_get_excl(dst);
>  
> -	preempt_disable();
>  	write_seqcount_begin(&dst->seq);
>  	/* write_seqcount_begin provides the necessary memory barrier */
>  	RCU_INIT_POINTER(dst->fence_excl, new);
>  	RCU_INIT_POINTER(dst->fence, dst_list);
>  	write_seqcount_end(&dst->seq);
> -	preempt_enable();
>  
>  	dma_resv_list_free(src_list);
>  	dma_fence_put(old);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 6a5b91d23fd9..c71c0bb6ce26 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -258,11 +258,9 @@ static int amdgpu_amdkfd_remove_eviction_fence(struct amdgpu_bo *bo,
>  	new->shared_count = k;
>  
>  	/* Install the new fence list, seqcount provides the barriers */
> -	preempt_disable();
>  	write_seqcount_begin(&resv->seq);
>  	RCU_INIT_POINTER(resv->fence, new);
>  	write_seqcount_end(&resv->seq);
> -	preempt_enable();
>  
>  	/* Drop the references to the removed fences or move them to ef_list */
>  	for (i = j, k = 0; i < old->shared_count; ++i) {
> diff --git a/include/linux/dma-resv.h b/include/linux/dma-resv.h
> index a6538ae7d93f..d44a77e8a7e3 100644
> --- a/include/linux/dma-resv.h
> +++ b/include/linux/dma-resv.h
> @@ -69,7 +69,7 @@ struct dma_resv_list {
>   */
>  struct dma_resv {
>  	struct ww_mutex lock;
> -	seqcount_t seq;
> +	seqcount_ww_mutex_t seq;
>  
>  	struct dma_fence __rcu *fence_excl;
>  	struct dma_resv_list __rcu *fence;
> -- 
> 2.20.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
