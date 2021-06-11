Return-Path: <SRS0=qfa3=LF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D8FC48BE5
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 09:07:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3D9F6100A
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 09:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3D9F6100A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 701E16EE54;
	Fri, 11 Jun 2021 09:07:29 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E9A66EE55
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jun 2021 09:07:28 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id a11so5217096wrt.13
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jun 2021 02:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=v21KKQzll9R0YfaiRjmlIqWbMoPlP2MmVWyU0c10zBw=;
 b=EN45abN0G4uSRlXtfQk1xxxIokti7e65qY9fPMwgXEEVlLVmguU+7A33VMbdvW+W1B
 AdeTvFdjjkirtZmtu7cjyYAleSly4PkQX2HaNGrcGJVjjr+k3qlUbVcY01nWqojYrnjE
 LkphDMSQVXeXrioXVeWefXGwYqUxzOsJj8RNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=v21KKQzll9R0YfaiRjmlIqWbMoPlP2MmVWyU0c10zBw=;
 b=tTyVwnhKl3ERJZM3WQmv8E3CanBdZ7OlTkdSIkMqWLly5nBYr8srJgnpZeFcPtujD4
 klKx52ObM4eqjBqcamhawbCOp0VLO5AjcIR9yUu7h/7YibeNfV6NiQb5tcBGmVMTRu3G
 shbd0pDEWGv6WwlBejbrLNohVW+DuvazJ0pashfyKW2uybClW6Go9xL9gqNI2m1Lsrji
 mulHxbkix2cFDWDsYzJ5Q+4a1z/Vglgq8fRYWSIfr9malz56gUqM9mLjSoYUDCsid0kz
 RsrHuW+T/ltLab/yohQLZZ6m+bQJJ5vUnmjvZk9gVLR3hMQfPpudmCtWN+w1kchrSixU
 RCKg==
X-Gm-Message-State: AOAM532Hb32bLA3vfh+6PFnpFgzbJOEU2ONGQTcFSke/CARxGffhoJJh
 G0CTQpgxgORVVZkjUkq7widk4w==
X-Google-Smtp-Source: ABdhPJxTEW1FkvNi27QxV8GfcShhg+CWBBWO9mLAxNj2IglWZ/6UBlEHd5CBYNiHXVKyDIP1DRnJpQ==
X-Received: by 2002:adf:ef06:: with SMTP id e6mr2855936wro.393.1623402447481; 
 Fri, 11 Jun 2021 02:07:27 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id a12sm5295615wmj.36.2021.06.11.02.07.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jun 2021 02:07:27 -0700 (PDT)
Date: Fri, 11 Jun 2021 11:07:25 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH 6/7] drm/amdgpu: unwrap fence chains in the explicit sync
 fence
Message-ID: <YMMnzbky0W72PH1d@phenom.ffwll.local>
References: <20210610091800.1833-1-christian.koenig@amd.com>
 <20210610091800.1833-7-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210610091800.1833-7-christian.koenig@amd.com>
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

On Thu, Jun 10, 2021 at 11:17:59AM +0200, Christian K=F6nig wrote:
> Unwrap a the explicit fence if it is a dma_fence_chain and
> sync to the first fence not matching the owner rules.
> =

> Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 118 +++++++++++++----------
>  1 file changed, 68 insertions(+), 50 deletions(-)
> =

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_sync.c
> index 1b2ceccaf5b0..862eb3c1c4c5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> @@ -28,6 +28,8 @@
>   *    Christian K=F6nig <christian.koenig@amd.com>
>   */
>  =

> +#include <linux/dma-fence-chain.h>
> +
>  #include "amdgpu.h"
>  #include "amdgpu_trace.h"
>  #include "amdgpu_amdkfd.h"
> @@ -186,6 +188,55 @@ int amdgpu_sync_vm_fence(struct amdgpu_sync *sync, s=
truct dma_fence *fence)
>  	return amdgpu_sync_fence(sync, fence);
>  }
>  =

> +/* Determine based on the owner and mode if we should sync to a fence or=
 not */
> +static bool amdgpu_sync_test_fence(struct amdgpu_device *adev,
> +				   enum amdgpu_sync_mode mode,
> +				   void *owner, struct dma_fence *f)
> +{
> +	void *fence_owner =3D amdgpu_sync_get_owner(f);
> +
> +	/* Always sync to moves, no matter what */
> +	if (fence_owner =3D=3D AMDGPU_FENCE_OWNER_UNDEFINED)
> +		return true;
> +
> +	/* We only want to trigger KFD eviction fences on
> +	 * evict or move jobs. Skip KFD fences otherwise.
> +	 */
> +	if (fence_owner =3D=3D AMDGPU_FENCE_OWNER_KFD &&
> +	    owner !=3D AMDGPU_FENCE_OWNER_UNDEFINED)
> +		return false;
> +
> +	/* Never sync to VM updates either. */
> +	if (fence_owner =3D=3D AMDGPU_FENCE_OWNER_VM &&
> +	    owner !=3D AMDGPU_FENCE_OWNER_UNDEFINED)
> +		return false;
> +
> +	/* Ignore fences depending on the sync mode */
> +	switch (mode) {
> +	case AMDGPU_SYNC_ALWAYS:
> +		return true;
> +
> +	case AMDGPU_SYNC_NE_OWNER:
> +		if (amdgpu_sync_same_dev(adev, f) &&
> +		    fence_owner =3D=3D owner)
> +			return false;
> +		break;
> +
> +	case AMDGPU_SYNC_EQ_OWNER:
> +		if (amdgpu_sync_same_dev(adev, f) &&
> +		    fence_owner !=3D owner)
> +			return false;
> +		break;
> +
> +	case AMDGPU_SYNC_EXPLICIT:
> +		return false;
> +	}
> +
> +	WARN(debug_evictions && fence_owner =3D=3D AMDGPU_FENCE_OWNER_KFD,
> +	     "Adding eviction fence to sync obj");
> +	return true;
> +}
> +
>  /**
>   * amdgpu_sync_resv - sync to a reservation object
>   *
> @@ -211,67 +262,34 @@ int amdgpu_sync_resv(struct amdgpu_device *adev, st=
ruct amdgpu_sync *sync,
>  =

>  	/* always sync to the exclusive fence */
>  	f =3D dma_resv_excl_fence(resv);
> -	r =3D amdgpu_sync_fence(sync, f);
> +	dma_fence_chain_for_each(f, f) {

Jason has some helper for deep-walking fence chains/arrays here I think.
Might want to look into that, so that we have some consistency in how we
pile up multiple exclusive fences.

Anyway pretty much one of the versions I had in mind too, except I didn't
type it up.

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> +		struct dma_fence_chain *chain =3D to_dma_fence_chain(f);
> +
> +		if (amdgpu_sync_test_fence(adev, mode, owner, chain ?
> +					   chain->fence : f)) {
> +			r =3D amdgpu_sync_fence(sync, f);
> +			dma_fence_put(f);
> +			if (r)
> +				return r;
> +			break;
> +		}
> +	}
>  =

>  	flist =3D dma_resv_shared_list(resv);
> -	if (!flist || r)
> -		return r;
> +	if (!flist)
> +		return 0;
>  =

>  	for (i =3D 0; i < flist->shared_count; ++i) {
> -		void *fence_owner;
> -
>  		f =3D rcu_dereference_protected(flist->shared[i],
>  					      dma_resv_held(resv));
>  =

> -		fence_owner =3D amdgpu_sync_get_owner(f);
> -
> -		/* Always sync to moves, no matter what */
> -		if (fence_owner =3D=3D AMDGPU_FENCE_OWNER_UNDEFINED) {
> +		if (amdgpu_sync_test_fence(adev, mode, owner, f)) {
>  			r =3D amdgpu_sync_fence(sync, f);
>  			if (r)
> -				break;
> -		}
> -
> -		/* We only want to trigger KFD eviction fences on
> -		 * evict or move jobs. Skip KFD fences otherwise.
> -		 */
> -		if (fence_owner =3D=3D AMDGPU_FENCE_OWNER_KFD &&
> -		    owner !=3D AMDGPU_FENCE_OWNER_UNDEFINED)
> -			continue;
> -
> -		/* Never sync to VM updates either. */
> -		if (fence_owner =3D=3D AMDGPU_FENCE_OWNER_VM &&
> -		    owner !=3D AMDGPU_FENCE_OWNER_UNDEFINED)
> -			continue;
> -
> -		/* Ignore fences depending on the sync mode */
> -		switch (mode) {
> -		case AMDGPU_SYNC_ALWAYS:
> -			break;
> -
> -		case AMDGPU_SYNC_NE_OWNER:
> -			if (amdgpu_sync_same_dev(adev, f) &&
> -			    fence_owner =3D=3D owner)
> -				continue;
> -			break;
> -
> -		case AMDGPU_SYNC_EQ_OWNER:
> -			if (amdgpu_sync_same_dev(adev, f) &&
> -			    fence_owner !=3D owner)
> -				continue;
> -			break;
> -
> -		case AMDGPU_SYNC_EXPLICIT:
> -			continue;
> +				return r;
>  		}
> -
> -		WARN(debug_evictions && fence_owner =3D=3D AMDGPU_FENCE_OWNER_KFD,
> -		     "Adding eviction fence to sync obj");
> -		r =3D amdgpu_sync_fence(sync, f);
> -		if (r)
> -			break;
>  	}
> -	return r;
> +	return 0;
>  }
>  =

>  /**
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
