Return-Path: <SRS0=YeOH=4B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9BFC3B18A
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2020 09:54:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D57482173E
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2020 09:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="c2jdtDXh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D57482173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72F9C6F58D;
	Thu, 13 Feb 2020 09:54:43 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D7B66F58E
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2020 09:54:42 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id m16so5808662wrx.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2020 01:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=F6Xrs4G40eT7CiCAVDNye9fsE7epdUzKv1jzBy2mCcY=;
 b=c2jdtDXhA5myh3XLlxgB0otaXBeycNhWoeaw0LyVBeFfpEYTRE2XNIjWNV5JPAuHzG
 n4eEI7qMYJ7RGOCLg3sGEqoMbIeRhVnYX7PhiSk3hFW7T1Di+BQzIax8peR9cU23foYh
 FoZlIC8bdHe4DpsEFHua9PEVhMmE4zbCRQnk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=F6Xrs4G40eT7CiCAVDNye9fsE7epdUzKv1jzBy2mCcY=;
 b=daqn2gbtElXXH3iOyG4yGYqUWh7ceZifjWDyQuKtVZYNcMRlheWj0ZeMYPCvfduC90
 qs9/UVcW/TX0wmNViNLnvCP8Ekd70ALGq9V7VPX/0l+yxWnfrAKV47P3zCPLLx6Q8BWZ
 gDf5VCrzSTGBagdFS/A/ThBUcdfDs6iGElFp/My8ng3rTbwd1d7ugFL+cewB768Nsmsn
 fpPtj8dry/CKuLzr+RpUx97eTPMECBgYWq8G0tArsRxbgBqDtHq/BcbPZXmoogF7IJEg
 JH1vMwgzqZheIoPl8OkJCciMsEYXeSIYtJ0tTT1EcIkrK9EL2McdWyPnVWEjiDkWmF1w
 M+Mw==
X-Gm-Message-State: APjAAAUV/R62PfbrQJfx8AlNV07CUTQeFEJIbIILdV3TsjMl/5Tn+4mz
 WHRH9RApjkeKkI0/TiZ+h7Enlw==
X-Google-Smtp-Source: APXvYqwsjtPrUalJFogK9WuuFtePqrPA0+e261yCARpeQbzvDsYFFYV0oqXbOb5zMEcO3AHIFjqK7Q==
X-Received: by 2002:adf:df0f:: with SMTP id y15mr20439926wrl.26.1581587680659; 
 Thu, 13 Feb 2020 01:54:40 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id y12sm2270484wmj.6.2020.02.13.01.54.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 01:54:39 -0800 (PST)
Date: Thu, 13 Feb 2020 10:54:38 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 14/15] drm/amdgpu/ring: move debugfs init into core
 amdgpu debugfs
Message-ID: <20200213095438.GS2363188@phenom.ffwll.local>
References: <20200207195058.2354-1-alexander.deucher@amd.com>
 <20200207195058.2354-15-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200207195058.2354-15-alexander.deucher@amd.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
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
Cc: Alex Deucher <alexander.deucher@amd.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Feb 07, 2020 at 02:50:57PM -0500, Alex Deucher wrote:
> In order to remove the load and unload drm callbacks,
> we need to reorder the init sequence to move all the drm
> debugfs file handling.  Do this for rings.
> =

> Acked-by: Christian K=F6nig <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 23 ++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    | 15 +++-----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  4 ++++
>  3 files changed, 29 insertions(+), 13 deletions(-)
> =

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_debugfs.c
> index df3919ef886b..7379910790c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1218,7 +1218,7 @@ DEFINE_SIMPLE_ATTRIBUTE(fops_ib_preempt, NULL,
>  =

>  int amdgpu_debugfs_init(struct amdgpu_device *adev)
>  {
> -	int r;
> +	int r, i;
>  =

>  	adev->debugfs_preempt =3D
>  		debugfs_create_file("amdgpu_preempt_ib", 0600,
> @@ -1268,12 +1268,33 @@ int amdgpu_debugfs_init(struct amdgpu_device *ade=
v)
>  	}
>  #endif
>  =

> +	for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
> +		struct amdgpu_ring *ring =3D adev->rings[i];
> +
> +		if (!ring)
> +			continue;
> +
> +		if (amdgpu_debugfs_ring_init(adev, ring)) {
> +			DRM_ERROR("Failed to register debugfs file for rings !\n");
> +		}
> +	}
> +
>  	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_list,
>  					ARRAY_SIZE(amdgpu_debugfs_list));
>  }
>  =

>  void amdgpu_debugfs_fini(struct amdgpu_device *adev)

btw debugfs_fini shouldn't be needed anymore, Greg KH removed this all.
drm core removes all debugfs files recusrively for you, there should be 0
need for debugfs cleanup.

Also at least my tree doesn't even have this, where does this apply to?
-Daniel

>  {
> +	int i;
> +
> +	for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
> +		struct amdgpu_ring *ring =3D adev->rings[i];
> +
> +		if (!ring)
> +			continue;
> +
> +		amdgpu_debugfs_ring_fini(ring);
> +	}
>  	amdgpu_ttm_debugfs_fini(adev);
>  	debugfs_remove(adev->debugfs_preempt);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ring.c
> index e5c83e164d82..539be138260e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -48,9 +48,6 @@
>   * wptr.  The GPU then starts fetching commands and executes
>   * them until the pointers are equal again.
>   */
> -static int amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
> -				    struct amdgpu_ring *ring);
> -static void amdgpu_debugfs_ring_fini(struct amdgpu_ring *ring);
>  =

>  /**
>   * amdgpu_ring_alloc - allocate space on the ring buffer
> @@ -334,10 +331,6 @@ int amdgpu_ring_init(struct amdgpu_device *adev, str=
uct amdgpu_ring *ring,
>  	for (i =3D 0; i < DRM_SCHED_PRIORITY_MAX; ++i)
>  		atomic_set(&ring->num_jobs[i], 0);
>  =

> -	if (amdgpu_debugfs_ring_init(adev, ring)) {
> -		DRM_ERROR("Failed to register debugfs file for rings !\n");
> -	}
> -
>  	return 0;
>  }
>  =

> @@ -367,8 +360,6 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
>  			      &ring->gpu_addr,
>  			      (void **)&ring->ring);
>  =

> -	amdgpu_debugfs_ring_fini(ring);
> -
>  	dma_fence_put(ring->vmid_wait);
>  	ring->vmid_wait =3D NULL;
>  	ring->me =3D 0;
> @@ -485,8 +476,8 @@ static const struct file_operations amdgpu_debugfs_ri=
ng_fops =3D {
>  =

>  #endif
>  =

> -static int amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
> -				    struct amdgpu_ring *ring)
> +int amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
> +			     struct amdgpu_ring *ring)
>  {
>  #if defined(CONFIG_DEBUG_FS)
>  	struct drm_minor *minor =3D adev->ddev->primary;
> @@ -507,7 +498,7 @@ static int amdgpu_debugfs_ring_init(struct amdgpu_dev=
ice *adev,
>  	return 0;
>  }
>  =

> -static void amdgpu_debugfs_ring_fini(struct amdgpu_ring *ring)
> +void amdgpu_debugfs_ring_fini(struct amdgpu_ring *ring)
>  {
>  #if defined(CONFIG_DEBUG_FS)
>  	debugfs_remove(ring->ent);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ring.h
> index 5134d0dd6dc2..0d098dafd23c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -329,4 +329,8 @@ static inline void amdgpu_ring_write_multiple(struct =
amdgpu_ring *ring,
>  =

>  int amdgpu_ring_test_helper(struct amdgpu_ring *ring);
>  =

> +int amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
> +			     struct amdgpu_ring *ring);
> +void amdgpu_debugfs_ring_fini(struct amdgpu_ring *ring);
> +
>  #endif
> -- =

> 2.24.1
> =

> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
