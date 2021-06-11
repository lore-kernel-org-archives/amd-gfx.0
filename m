Return-Path: <SRS0=qfa3=LF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FACC4743D
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 07:55:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C6F4610E9
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 07:55:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C6F4610E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C28DD6EE44;
	Fri, 11 Jun 2021 07:55:02 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 721CB6EE43
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jun 2021 07:55:01 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id l2so4998175wrw.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jun 2021 00:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=DDtceujLgXtlsEUKK5ZRi+EzzoWlzeAeda0TaARUvw8=;
 b=WWhgP98vh2b9jHm6Qo7GwoMpKJK92yvUK5Xc0XbHnWDk7DcgZuAdCydKY64Nxv0C2F
 UJcTGwbOdQ22spxPKcIPHvF+1Oa727o0UtMrgr6gvmxhyuXWQUQ4YYVZmG7FQrTUXI6V
 lYIadztaGmtEc/hZvHnJSqHK2DbttUNzIyf9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=DDtceujLgXtlsEUKK5ZRi+EzzoWlzeAeda0TaARUvw8=;
 b=jLzR5Fa/WGkGkF306yvirIQ9Rfzr8KsAA95KlkketGRWRM6/9HQX+FGWOrlInYD5q7
 8jdGG7V6Q6Q6rYIRhL6Xk7C1an9hCGCfIL3ysZv8r4TpYxHXAKi/19eYvhqCCM9P5kuV
 81xJSYO1mbNGpxiEVWAaPwn8CJXxgq/BrQf2qyNmE6emxVQgs0vtmBKkO+GhinV91BkD
 dYV31OEgQWeejfIC1QCNd5dDo75AEl0uwXDIPD50vm3TVgXtShqIefkCHo0s+AuC045A
 VndDzY6SiAyq9Y2c5XtZK0jafkjIw9Ial9q5y4li/Xq4Tz/NGQS22MRkGvfsLzKbfn/9
 GmnQ==
X-Gm-Message-State: AOAM531NDELLCt4xE9MOvfjQJKYc533P32FVdsZzvlPhhBatgjf4n67K
 ZNR7OLH80+fCNzCNxBviv74NqQ==
X-Google-Smtp-Source: ABdhPJwGHUmMC/cZ+OZ17i8YtgBJi8wxDu4rN0PjADaFoB/zb1wZ6lxC3P78VXc7L02svJDl0jaMrA==
X-Received: by 2002:a05:6000:6:: with SMTP id h6mr2571417wrx.24.1623398099990; 
 Fri, 11 Jun 2021 00:54:59 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id y26sm5184216wma.33.2021.06.11.00.54.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jun 2021 00:54:59 -0700 (PDT)
Date: Fri, 11 Jun 2021 09:54:57 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH 2/7] dma-buf: add dma_fence_chain_alloc/free
Message-ID: <YMMW0ROMlgJQyTdU@phenom.ffwll.local>
References: <20210610091800.1833-1-christian.koenig@amd.com>
 <20210610091800.1833-3-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210610091800.1833-3-christian.koenig@amd.com>
X-Operating-System: Linux phenom 5.10.32scarlett+ 
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
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 daniel@ffwll.ch
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jun 10, 2021 at 11:17:55AM +0200, Christian K=F6nig wrote:
> Add a common allocation helper. Cleaning up the mix of kzalloc/kmalloc
> and some unused code in the selftest.
> =

> Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>
> ---
>  drivers/dma-buf/st-dma-fence-chain.c          | 16 ++++----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |  4 ++--
>  drivers/gpu/drm/drm_syncobj.c                 |  6 ++---
>  .../gpu/drm/i915/gem/i915_gem_execbuffer.c    |  6 ++---
>  drivers/gpu/drm/msm/msm_gem_submit.c          |  6 ++---
>  include/linux/dma-fence-chain.h               | 22 +++++++++++++++++++
>  6 files changed, 35 insertions(+), 25 deletions(-)
> =

> diff --git a/drivers/dma-buf/st-dma-fence-chain.c b/drivers/dma-buf/st-dm=
a-fence-chain.c
> index 9525f7f56119..8ce1ea59d31b 100644
> --- a/drivers/dma-buf/st-dma-fence-chain.c
> +++ b/drivers/dma-buf/st-dma-fence-chain.c
> @@ -58,28 +58,20 @@ static struct dma_fence *mock_fence(void)
>  	return &f->base;
>  }
>  =

> -static inline struct mock_chain {
> -	struct dma_fence_chain base;
> -} *to_mock_chain(struct dma_fence *f) {
> -	return container_of(f, struct mock_chain, base.base);
> -}
> -
>  static struct dma_fence *mock_chain(struct dma_fence *prev,
>  				    struct dma_fence *fence,
>  				    u64 seqno)
>  {
> -	struct mock_chain *f;
> +	struct dma_fence_chain *f;
>  =

> -	f =3D kmalloc(sizeof(*f), GFP_KERNEL);
> +	f =3D dma_fence_chain_alloc();
>  	if (!f)
>  		return NULL;
>  =

> -	dma_fence_chain_init(&f->base,
> -			     dma_fence_get(prev),
> -			     dma_fence_get(fence),
> +	dma_fence_chain_init(f, dma_fence_get(prev), dma_fence_get(fence),
>  			     seqno);
>  =

> -	return &f->base.base;
> +	return &f->base;
>  }
>  =

>  static int sanitycheck(void *arg)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cs.c
> index 90136f9dedd6..325e82621467 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1124,7 +1124,7 @@ static int amdgpu_cs_process_syncobj_timeline_out_d=
ep(struct amdgpu_cs_parser *p
>  =

>  		dep->chain =3D NULL;
>  		if (syncobj_deps[i].point) {
> -			dep->chain =3D kmalloc(sizeof(*dep->chain), GFP_KERNEL);
> +			dep->chain =3D dma_fence_chain_alloc();
>  			if (!dep->chain)
>  				return -ENOMEM;
>  		}
> @@ -1132,7 +1132,7 @@ static int amdgpu_cs_process_syncobj_timeline_out_d=
ep(struct amdgpu_cs_parser *p
>  		dep->syncobj =3D drm_syncobj_find(p->filp,
>  						syncobj_deps[i].handle);
>  		if (!dep->syncobj) {
> -			kfree(dep->chain);
> +			dma_fence_chain_free(dep->chain);
>  			return -EINVAL;
>  		}
>  		dep->point =3D syncobj_deps[i].point;
> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
> index fdd2ec87cdd1..1c5b9ef6da37 100644
> --- a/drivers/gpu/drm/drm_syncobj.c
> +++ b/drivers/gpu/drm/drm_syncobj.c
> @@ -861,7 +861,7 @@ static int drm_syncobj_transfer_to_timeline(struct dr=
m_file *file_private,
>  				     &fence);
>  	if (ret)
>  		goto err;
> -	chain =3D kzalloc(sizeof(struct dma_fence_chain), GFP_KERNEL);
> +	chain =3D dma_fence_chain_alloc();
>  	if (!chain) {
>  		ret =3D -ENOMEM;
>  		goto err1;
> @@ -1402,10 +1402,10 @@ drm_syncobj_timeline_signal_ioctl(struct drm_devi=
ce *dev, void *data,
>  		goto err_points;
>  	}
>  	for (i =3D 0; i < args->count_handles; i++) {
> -		chains[i] =3D kzalloc(sizeof(struct dma_fence_chain), GFP_KERNEL);
> +		chains[i] =3D dma_fence_chain_alloc();
>  		if (!chains[i]) {
>  			for (j =3D 0; j < i; j++)
> -				kfree(chains[j]);
> +				dma_fence_chain_free(chains[j]);
>  			ret =3D -ENOMEM;
>  			goto err_chains;
>  		}
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu=
/drm/i915/gem/i915_gem_execbuffer.c
> index 66789111a24b..a22cb86730b3 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> @@ -2983,7 +2983,7 @@ __free_fence_array(struct eb_fence *fences, unsigne=
d int n)
>  	while (n--) {
>  		drm_syncobj_put(ptr_mask_bits(fences[n].syncobj, 2));
>  		dma_fence_put(fences[n].dma_fence);
> -		kfree(fences[n].chain_fence);
> +		dma_fence_chain_free(fences[n].chain_fence);
>  	}
>  	kvfree(fences);
>  }
> @@ -3097,9 +3097,7 @@ add_timeline_fence_array(struct i915_execbuffer *eb,
>  				return -EINVAL;
>  			}
>  =

> -			f->chain_fence =3D
> -				kmalloc(sizeof(*f->chain_fence),
> -					GFP_KERNEL);
> +			f->chain_fence =3D dma_fence_chain_alloc();
>  			if (!f->chain_fence) {
>  				drm_syncobj_put(syncobj);
>  				dma_fence_put(fence);
> diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/m=
sm_gem_submit.c
> index 5480852bdeda..6ff6df6c4791 100644
> --- a/drivers/gpu/drm/msm/msm_gem_submit.c
> +++ b/drivers/gpu/drm/msm/msm_gem_submit.c
> @@ -586,9 +586,7 @@ static struct msm_submit_post_dep *msm_parse_post_dep=
s(struct drm_device *dev,
>  				break;
>  			}
>  =

> -			post_deps[i].chain =3D
> -				kmalloc(sizeof(*post_deps[i].chain),
> -				        GFP_KERNEL);
> +			post_deps[i].chain =3D dma_fence_chain_alloc();
>  			if (!post_deps[i].chain) {
>  				ret =3D -ENOMEM;
>  				break;
> @@ -605,7 +603,7 @@ static struct msm_submit_post_dep *msm_parse_post_dep=
s(struct drm_device *dev,
>  =

>  	if (ret) {
>  		for (j =3D 0; j <=3D i; ++j) {
> -			kfree(post_deps[j].chain);
> +			dma_fence_chain_free(post_deps[j].chain);
>  			if (post_deps[j].syncobj)
>  				drm_syncobj_put(post_deps[j].syncobj);
>  		}
> diff --git a/include/linux/dma-fence-chain.h b/include/linux/dma-fence-ch=
ain.h
> index 9d6a062be640..5f45689a6d2e 100644
> --- a/include/linux/dma-fence-chain.h
> +++ b/include/linux/dma-fence-chain.h
> @@ -12,6 +12,7 @@
>  =

>  #include <linux/dma-fence.h>
>  #include <linux/irq_work.h>
> +#include <linux/slab.h>
>  =

>  /**
>   * struct dma_fence_chain - fence to represent an node of a fence chain
> @@ -53,6 +54,27 @@ to_dma_fence_chain(struct dma_fence *fence)
>  	return container_of(fence, struct dma_fence_chain, base);
>  }
>  =

> +/**
> + * dma_fence_chain_alloc
> + *
> + * Returns a new dma_fence_chain object

... or NULL on failure.

> + */
> +static inline struct dma_fence_chain *dma_fence_chain_alloc(void)
> +{
> +	return kmalloc(sizeof(struct dma_fence_chain), GFP_KERNEL);
> +};
> +
> +/**
> + * dma_fence_chain_free
> + * @chain: chain node to free
> + *
> + * Frees up an allocated but not used dma_fence_chain node.
> + */
> +static inline void dma_fence_chain_free(struct dma_fence_chain *chain)
> +{
> +	kfree(chain);

kfree_rcu, and I guess this means this patch here should be cc: stable.

This is kinda why I'm questioning whether this "dma_fence are protected by
rcu" cross driver api is really a good idea. We largely get it wrong in
the details in a _ton_ of places.

With the details fixed:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> +
>  /**
>   * dma_fence_chain_for_each - iterate over all fences in chain
>   * @iter: current fence
> -- =

> 2.25.1
> =


-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
