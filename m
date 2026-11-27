Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18919606A31C
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2026 10:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lcjQslaY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABA5E10E4C0;
	Fri, 27 Nov 2026 10:37:19 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 366A010E4C0
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2026 10:37:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4C66E613A9;
 Fri, 27 Nov 2026 10:37:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4C61F0089A;
 Fri, 27 Nov 2026 10:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795775831;
 bh=UYedC4RxNMo6dP3lc87iGL4579tFMw1tYSjjpAT4iDQ=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=lcjQslaYDVMbriK3BmO4SyIsZ50VjtBQJFmww+OIGFOtxPuMh0QBC9Pf697VSJ3zC
 ByS+q+tKtlTzVbclIDTZg75hdzvo9gfbB3E7c4heubxyQvfM4xR13OVpN1u0if4Jbm
 xVZJGeAqy8kLuSIclWYLt/9tR96rLxW1RliW0/Kee3U+7sbrnfOqQssERS+nH9uI+d
 jtoOyX+8DMyDkdRnpoumv3FCAWOe9PDus5QeKq2Xiy9Yl40WeXj3VeuLyAp0bCspX9
 gI+YBIW0VYlXIvF5a3SrWFzGf49cZc1TUaTsJsSL3o6OpJeFc6WUT6GSVouHV/vDlD
 APFUA1eIuYDeA==
Message-ID: <sashiko-outbox-237145@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu: validate the WPTR BO before handing its
 address to the MES
To: "Jesse Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261127100941.738014-1-Jesse.Zhang@amd.com>
References: <20261127100941.738014-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 10:37:11 +0000
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
- [High] drm/amdgpu: missing userptr and domain checks in
  mes_userq_create_wptr_mapping()
--

commit c8808f07dff4b49d4c3e4db4a9b93588681aeec7
Author: Jesse Zhang <Jesse.Zhang@amd.com>

drm/amdgpu: validate the WPTR BO before handing its address to the MES

This commit validates wptr_obj->obj into its allowed domains before calling
amdgpu_ttm_alloc_gart() in mes_userq_create_wptr_mapping().

> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index 7abb9d95ef59a..105c9866b2a3f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -37,6 +37,7 @@ mes_userq_create_wptr_mapping(struct amdgpu_device *ade=
v,
>  			      struct amdgpu_usermode_queue *queue,
>  			      uint64_t wptr)
>  {
> +	struct ttm_operation_ctx ctx =3D { false, false };
>  	struct amdgpu_bo_va_mapping *wptr_mapping;
>  	struct amdgpu_userq_obj *wptr_obj =3D &queue->wptr_obj;
>  	struct amdgpu_bo *obj;
> @@ -84,6 +85,12 @@ mes_userq_create_wptr_mapping(struct amdgpu_device *ad=
ev,
>  		goto fail_map;
>  	}
> =20
> +	/* The BO may have been evicted, it needs a GPU address for the MES */
> +	amdgpu_bo_placement_from_domain(wptr_obj->obj, wptr_obj->obj->allowed_d=
omains);
> +	ret =3D ttm_bo_validate(&wptr_obj->obj->tbo, &wptr_obj->obj->placement,=
 &ctx);
> +	if (ret)
> +		goto fail_map;

[Severity: High]
Can calling ttm_bo_validate() with wptr_obj->obj->allowed_domains cause a
NULL pointer dereference in amdgpu_ttm_tt_pin_userptr() or leave
wptr_obj->obj outside GTT?

Before 7264bc10c7c6 ("drm/amdgpu: dont pin wptr bo instead use eviction fen=
ce"),
amdgpu_bo_pin(wptr_obj->obj, AMDGPU_GEM_DOMAIN_GTT) rejected userptr BOs
via amdgpu_ttm_tt_get_usermm() and validated the BO into
AMDGPU_GEM_DOMAIN_GTT.

If userspace registers a userptr BO without AMDGPU_GEM_USERPTR_VALIDATE
while the eviction fence is in its initial signaled stub state, the BO
stays in TTM_PL_SYSTEM with allowed_domains =3D AMDGPU_GEM_DOMAIN_GTT and
ttm->pages[0] =3D=3D NULL.  Validating it directly here moves it to TTM_PL_=
TT
without fetching user pages via amdgpu_ttm_tt_get_user_pages(), so
amdgpu_bo_move() -> amdgpu_ttm_backend_bind() ->
amdgpu_ttm_tt_pin_userptr() passes the unpopulated ttm->pages array to
sg_alloc_table_from_pages() and dma_map_sgtable().

In addition, if wptr_obj->obj was created with AMDGPU_GEM_DOMAIN_CPU or
non-contiguous AMDGPU_GEM_DOMAIN_VRAM, validating into allowed_domains
leaves it in TTM_PL_SYSTEM or TTM_PL_VRAM, causing amdgpu_ttm_alloc_gart()
to return 0 without binding GART space and amdgpu_bo_gpu_offset() to warn
and pass an invalid GPU address to MES.

Should mes_userq_create_wptr_mapping() reject userptr BOs and require
AMDGPU_GEM_DOMAIN_GTT placement?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127100941.7380=
14-1-Jesse.Zhang@amd.com?part=3D1
