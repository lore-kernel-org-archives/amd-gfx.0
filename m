Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB22C60A2623
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 10:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QxJnT3Kn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55A2E10E20E;
	Thu, 19 Nov 2026 10:13:29 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7BEA10E20E
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 10:13:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2C82A60D35;
 Thu, 19 Nov 2026 10:13:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB7D1F000C5;
 Thu, 19 Nov 2026 10:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795083202;
 bh=0py4tHfeTdHQ+TWlVBmf3r1P3mLKemJd5zhNKsbTEP4=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=QxJnT3KnXJ9swBcyFPd8IZm/ecDdhcHQckp4GogBQRujlx5WxbrkPRSz7MwL9AGDt
 5zKDiRZTmSU81+jcoApZ3NkIbqoScK/930ANKueKONVV1pDHAa7AdRAqdnkLDAoSQw
 73bgkuTwnQ7+mqrQpCSoK+axo7OHlrTehuEA6Heo09Loa6U3cd2CEC5xzr2lyVQj/v
 ITRJe48GHpuzKtgKxZqe4cigxf8tY8JSwCpcdHaTVYiXebP4+quldjyB603LXX8dpO
 dFpJiW43y/+TSu+sf7eh2Gp9pY/LX/ssJn02KPCvDAEPtSW2NDl/h70+8qMNZegjbw
 nb8UmzHImwOXg==
Message-ID: <sashiko-outbox-222926@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/amdgpu: reserve a fence slot before adding the
 eviction fence
To: "Jesse Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261119095652.3510341-1-Jesse.Zhang@amd.com>
References: <20261119095652.3510341-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 10:13:22 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] drm/amdgpu: missing return value assignment in
  amdgpu_evf_mgr_attach_fence()
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [High] drm/amdgpu: infinite loop in amdgpu_evf_mgr_rearm() [1]
--

commit 48f419fb19e05e772f024f2aeb82afb2c8d3447c
Author: Jesse Zhang <Jesse.Zhang@amd.com>

drm/amdgpu: reserve a fence slot before adding the eviction fence

This commit calls dma_resv_reserve_fences() in amdgpu_evf_mgr_attach_fence()
before attaching the eviction fence to a BO's reservation object.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> index f8652fd0525df..f01e08c4de4a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> @@ -108,13 +108,21 @@ int amdgpu_evf_mgr_attach_fence(struct amdgpu_evict=
ion_fence_mgr *evf_mgr,
> =20
>  		amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
>  		ret =3D ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> -		if (!ret)
> -			dma_resv_add_fence(resv, ev_fence,
> -					   DMA_RESV_USAGE_BOOKKEEP);
> +		if (ret)
> +			goto out;
> +
> +		/* BOs prelocked by drm_exec may not have reserved fence slots. */
> +		dma_resv_reserve_fences(resv, 1);
> +		if (ret)
> +			goto out;

[Severity: High]
Should the return value of dma_resv_reserve_fences() be assigned to ret?
Because ret is already 0 from ttm_bo_validate(), an allocation failure in
dma_resv_reserve_fences() is ignored and execution proceeds to
dma_resv_add_fence() without a reserved slot, triggering the BUG_ON() in
dma_resv_add_fence() or a NULL pointer dereference if resv->fences is NULL.

> +
> +		dma_resv_add_fence(resv, ev_fence,
> +				   DMA_RESV_USAGE_BOOKKEEP);
>  	} else {
>  		ret =3D 0;
>  	}
> =20
> +out:
>  	dma_fence_put(ev_fence);
>  	return ret;
>  }

[Severity: High]
This problem wasn't introduced by this patch, but can dropping the old
evf_mgr->ev_fence reference before updating the pointer in
amdgpu_evf_mgr_rearm() [1] trap a concurrent RCU reader in an
infinite loop?

drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c:amdgpu_evf_mgr_rearm() {
    ...
	/* Remember it for newly added BOs */
	dma_fence_put(evf_mgr->ev_fence);
	evf_mgr->ev_fence =3D &ev_fence->base;
    ...
}

When dma_fence_put() drops the old fence's refcount to zero while
evf_mgr->ev_fence still points to it, a concurrent reader calling
dma_fence_get_rcu_safe() sees a zero refcount and an unchanged pointer:

CPU0                                CPU1
amdgpu_evf_mgr_rearm()
  dma_fence_put(evf_mgr->ev_fence)
                                    amdgpu_evf_mgr_get_fence()
                                      dma_fence_get_rcu_safe()
                                        fence =3D rcu_dereference(...)
                                        dma_fence_get_rcu(fence) -> NULL
                                        /* pointer unchanged, retries */
                                        <-- spins until pointer updates
  evf_mgr->ev_fence =3D &ev_fence->base

Because dma_fence_get_rcu_safe() loops until it either acquires a reference
or observes the pointer change, a reader that preempts CPU0 after
dma_fence_put() will spin indefinitely and cause a CPU lockup.  Updating
evf_mgr->ev_fence via rcu_replace_pointer() before calling dma_fence_put()
on the old fence would avoid this window.

[1] https://sashiko.dev/#/bug/linux-6debe0c7-cdae-40ca-8882-4e7c8c922581

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119095652.3510=
341-1-Jesse.Zhang@amd.com?part=3D1
