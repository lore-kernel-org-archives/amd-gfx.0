Return-Path: <SRS0=qfa3=LF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D11C48BD1
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 14:52:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CADA4611CD
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 14:52:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CADA4611CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 931E06E838;
	Fri, 11 Jun 2021 14:52:07 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B477E6EE9A
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jun 2021 14:52:04 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id f2so6367800wri.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jun 2021 07:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=4LoyqH/pL2mhEAc9qjc8YOfLpOE6Aljc3R6meb3Zeis=;
 b=jrG4iKNN14+GZpLDHSMYpwX5jy1sYwylW0x7b0hxU8Shj+y5ugV3j2r6S4nBJ5r7ru
 QbfdHH6fKr5BTFArOdM6LRnldTXPB2bNeaSXmm1EbVg6nwEFbdOA/ajp7FEzL3GOrNg4
 SAPR3m1bMuhbcxd7fIHnHKvpgkrnX/4u5t1Lk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=4LoyqH/pL2mhEAc9qjc8YOfLpOE6Aljc3R6meb3Zeis=;
 b=pEGnpMfrqnQRyWBCcoRR1t2ejVSrWvPsacGa3kq68z+brFqur/n6rgbBsq03Uza1/K
 edDoRtaIzQ79Od6aDoxGX5/mfnjVvKVbzsgOBevnnsRkKqNjfOjFGviImFAsYxQapsTn
 WVDGSNepkR2yEweK+GOpjg8rWVQbuBo/nbMnpDnUIEW5sjAeaa/9oOIKLQ0RA1e7XUIo
 lC+FE3JJcrOSZW+z9bKgHtyQX6qmWtGNCjoO0wvG9o5KU5q71vds92Uo+9IWYGgBLVs3
 YOKILxlgxfGZuWH2HMHTjBkWznHEB15omOAI45PQyPz2WvDH2YjVNvS/9hbeS6e//hEZ
 r1QA==
X-Gm-Message-State: AOAM531WJhK0YTXkJt/Whw+bq0uMGHZ8eeeqmuAhjlSY0Eo3jMp6lKsn
 yrnolFqEYf6wjjzdeDsRhjSCSSNG5a0Yxw==
X-Google-Smtp-Source: ABdhPJwSG2yaJwNTsiM1yM7aQg2nz//PupOD39Qk51PWl+iU/2RAqE1RzyCfXj3ARkljhO6H0bZlHw==
X-Received: by 2002:a5d:6584:: with SMTP id q4mr4501529wru.230.1623423123517; 
 Fri, 11 Jun 2021 07:52:03 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id g17sm9427748wrh.72.2021.06.11.07.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jun 2021 07:52:03 -0700 (PDT)
Date: Fri, 11 Jun 2021 16:52:01 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH 3/5] dma-buf: add dma_fence_chain_alloc/free v2
Message-ID: <YMN4kUt7dpysElsD@phenom.ffwll.local>
References: <20210611120301.10595-1-christian.koenig@amd.com>
 <20210611120301.10595-3-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210611120301.10595-3-christian.koenig@amd.com>
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

On Fri, Jun 11, 2021 at 02:02:59PM +0200, Christian K=F6nig wrote:
> Add a common allocation helper. Cleaning up the mix of kzalloc/kmalloc
> and some unused code in the selftest.
> =

> v2: polish kernel doc a bit
> =

> Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Given how absolutely wrong I was I'm not sure this r-b here is justified
:-)

> ---
>  drivers/dma-buf/st-dma-fence-chain.c          | 16 ++++---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |  4 ++--
>  drivers/gpu/drm/drm_syncobj.c                 |  6 ++---
>  .../gpu/drm/i915/gem/i915_gem_execbuffer.c    |  6 ++---
>  drivers/gpu/drm/msm/msm_gem_submit.c          |  6 ++---
>  include/linux/dma-fence-chain.h               | 23 +++++++++++++++++++
>  6 files changed, 36 insertions(+), 25 deletions(-)
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
> index c6eb3aa45668..7ec36d850363 100644
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
> @@ -66,6 +67,28 @@ to_dma_fence_chain(struct dma_fence *fence)
>  	return container_of(fence, struct dma_fence_chain, base);
>  }
>  =

> +/**
> + * dma_fence_chain_alloc
> + *
> + * Returns a new dma_fence_chain object or NULL on failure.

		struct dma_fence_chain for that hyperlink goodness

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
> + * Frees up an allocated but not used dma_fence_chain node. This doesn't=
 need

Same here.

> + * an RCU grace period since the fence was never initialized nor publish=
ed.

I'd add even more clarification, like:

"After dma_fence_chain_init() has been called the fence must be released
by calling dma_fence_put(), and not through this function."

That's still a notch too strict (in theory as long as the fence isn't
published anywhere it's all fine), but it keeps the door open for some
validation.

With the doc polish:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>


> + */
> +static inline void dma_fence_chain_free(struct dma_fence_chain *chain)
> +{
> +	kfree(chain);
> +};
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
