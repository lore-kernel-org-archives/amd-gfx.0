Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 377BAC624A4
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 13:35:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A957E10E85A;
	Mon, 31 Aug 2026 13:35:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LZp8HrlG";
	dkim-atps=neutral
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F009A10E85A
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 13:35:14 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-c2531f453eeso535808266b.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 06:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788183313; x=1788788113; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AlPRm+hvhQgi2x1KLA+phsQE2yTD0m72zobSh9ptdrs=;
 b=LZp8HrlGmbutbwktErnHI2nwTVOLWwd7sV5FVTBmV3LGt7X9K4dCEOtDqGVfSmFBEI
 KLTAt3XJkyYVcE+dh7ATFA+30obh9VFoqQ2x3XXl1AiY0yrXmzcMeLOgEYoIHxVfx1tT
 3Eks13bE2S4w8D42KZI/0b5bmbqdtsycoZnaLUzoadZeLYk8hxpaNcxUoU6MWXRnBdg1
 9jCLYut7TZiv4dYVfatONzIUOe/Vq40wR6DFk0Kl1DDw+DuACkYq4Gd0KUQjwc2nOYK6
 jNuNclik23NmC+LyugW4nieFLFiiB0CrzNx4zRRBfHTNKvcmh9mHXosX4mBMpfBMpIoF
 RLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788183313; x=1788788113;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AlPRm+hvhQgi2x1KLA+phsQE2yTD0m72zobSh9ptdrs=;
 b=EGn/lAUIACzRMvFTTbQLtKrVSJM+Ttj5jFgiZV8dHnnuhr90Ce5S4eofYTe79PR9bL
 W0/Z1tBZRHj54WAHBO4LYHG4cM9B/a8MgNPnxaF1slKPYxQlQHuo/cVY2Y6C043xXFAn
 IAlT+T0t8yntCVtXDslc8BR0N/6cby398YFs56O1CXuio2/+6T4Yjs+UqpLpn/5YDGQP
 sSFLJIxRRP/6YT/bDaPV7ZGNr4wAX5EQGtaPlUbOQVIHnAOMe0211yT19/ktt/yRU8Dm
 DFsOTB+mpuskwg62p5ds8R1DGHu8KYMDAqvmmNYfJ/S6djPEPVqqyG5F7oTEg4aLDltJ
 YGpQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqsOKwA3nGuqzm1264wgvx1pID8x2/UW3TZwqh7YcA4cNXijuqaG3bm41dyoqhcZeSvzWgIPX96@lists.freedesktop.org
X-Gm-Message-State: AFuF++lSu5PQiNuMn6XWL6t8NCYAxeaC2a6pljYD+eBdU/80ih5A2987
 ZlxxGnd6/auS23ckMAKp4aN8Qt5F0RBL1PfZQrr9q30OSd5t9dA3G6Lp
X-Gm-Gg: AR+sD13HF1l59NicnOe9dioK7fSA+EdCWEgkOiMzTI+6FzX6D85+pYvgcsp28E6g03O
 hRb+uP4JGo+r5Pd+0gU6VDtmATmO47Oez8V2wWTOW38E4JPa1Kd4xarkiN6EfA40Fgu4YKuTiwY
 /QoeXMsULbsFOA7iZQanhQIyaULSUSL4vktV/9E2jZoyiN4EQa+b9oEl8VZHeU63OHK6sF0uWiC
 wAbHcFcc6DwlyDAjpdkHALDOHQ62Gpl7FyHylnRbne6Nehm86jwXGbXefRrmVVb3Nj4daDkd9AH
 ETR+Yk6/dwt25/AvHASLIYV7o5I6xQ1k4w2Zt0EAZZkkFfNo/JgGXBIN/hjtVVd1TCs1gmSbvcq
 lpkqp91rfSrFjZhdPEZbF48P2JHEqgcrd0A6E2jzE4cHFC9sneShCjl20x1jt2fsVyk61lu2VuM
 radRAMWNzWkb90KoEIavMNo/q43o9OFli0O6vdnztE5e+RibFTnW5/7KS6dnhB+RCk0XQVVtS9G
 XEc5PQerpy54OHbCAusSQs+NNeoXMLE7U3F
X-Received: by 2002:a17:907:73cd:b0:c24:b11a:470f with SMTP id
 a640c23a62f3a-c25b39d698cmr47469566b.0.1788183312971; 
 Mon, 31 Aug 2026 06:35:12 -0700 (PDT)
Received: from timur-hyperion.localnet (5E1B9A5E.dsl.pool.telekom.hu.
 [94.27.154.94]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255f1b1fdasm456873266b.37.2026.08.31.06.35.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 06:35:11 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: christian.koenig@amd.com, amd-gfx@lists.freedesktop.org,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Cc: alexander.deucher@amd.com,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/amdgpu: skip the VMID 0 flush for VRAM
 clear-on-release
Date: Mon, 31 Aug 2026 15:35:11 +0200
Message-ID: <SGE410JQTUO82TOt1oxM1w@gmail.com>
In-Reply-To: <20260831122841.42160-1-Arunpravin.PaneerSelvam@amd.com>
References: <20260831122841.42160-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On Monday, August 31, 2026 2:28:41=E2=80=AFPM Central European Summer Time =
Arunpravin=20
Paneer Selvam wrote:
> Clear-on-release only runs on VRAM, which amdgpu_ttm_map_buffer() reaches
> via its direct MC address without programming a GART window, yet the wipe
> still forces a VMID 0 flush. On GFX11 (e.g. Navi33) that spurious SDMA
> flush can wedge the engine; only flush when a GART window is actually use=
d.
>=20
> v2: Let amdgpu_ttm_map_buffer() return whether the VMID 0 flush is needed,
>     and drive the clear and copy paths from that. (Christian)
>=20
> Fixes: a68c7eaa7a8f ("drm/amdgpu: Enable clear page functionality")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5413
> Cc: stable@vger.kernel.org
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

Looks good, thank you!

Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c index
> 6c07cee8e8777..e0bdd95c64de8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -190,6 +190,8 @@ amdgpu_ttm_job_submit(struct amdgpu_device *adev, str=
uct
> amdgpu_ttm_buffer_entit * @tmz: if we should setup a TMZ enabled mapping
>   * @size: in number of bytes to map, out number of bytes mapped
>   * @addr: resulting address inside the MC address space
> + * @vm_needs_flush: out, set true if a GART window was programmed (VMID 0
> flush + *		    needed) or false for a direct address; may be NULL
>   *
>   * Setup one of the GART windows to access a specific piece of memory or
> return * the physical address for local memory.
> @@ -199,7 +201,8 @@ static int amdgpu_ttm_map_buffer(struct
> amdgpu_ttm_buffer_entity *entity, struct ttm_resource *mem,
>  				 struct amdgpu_res_cursor=20
*mm_cur,
>  				 unsigned int window,
> -				 bool tmz, uint64_t *size,=20
uint64_t *addr)
> +				 bool tmz, uint64_t *size,=20
uint64_t *addr,
> +				 bool *vm_needs_flush)
>  {
>  	struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->bdev);
>  	unsigned int offset, num_pages, num_dw, num_bytes;
> @@ -220,9 +223,14 @@ static int amdgpu_ttm_map_buffer(struct
> amdgpu_ttm_buffer_entity *entity, if (!tmz && mem->start !=3D
> AMDGPU_BO_INVALID_OFFSET) {
>  		*addr =3D amdgpu_ttm_domain_start(adev, mem->mem_type) +
>  			mm_cur->start;
> +		if (vm_needs_flush)
> +			*vm_needs_flush =3D false;
>  		return 0;
>  	}
>=20
> +	/* A GART window is programmed below, so its VMID 0 TLB needs a=20
flush */
> +	if (vm_needs_flush)
> +		*vm_needs_flush =3D true;
>=20
>  	/*
>  	 * If start begins at an offset inside the page, then adjust the=20
size
> @@ -322,6 +330,7 @@ static int amdgpu_ttm_copy_mem_to_mem(struct
> amdgpu_device *adev, while (src_mm.remaining) {
>  		uint64_t from, to, cur_size, tiling_flags;
>  		uint32_t num_type, data_format, max_com,=20
write_compress_disable;
> +		bool src_vm_flush, dst_vm_flush;
>  		struct dma_fence *next;
>=20
>  		/* Never copy more than 256MiB at once to avoid a=20
timeout */
> @@ -329,12 +338,12 @@ static int amdgpu_ttm_copy_mem_to_mem(struct
> amdgpu_device *adev,
>=20
>  		/* Map src to window 0 and dst to window 1. */
>  		r =3D amdgpu_ttm_map_buffer(entity, src->bo, src->mem,=20
&src_mm,
> -					  0, tmz, &cur_size,=20
&from);
> +					  0, tmz, &cur_size,=20
&from, &src_vm_flush);
>  		if (r)
>  			goto error;
>=20
>  		r =3D amdgpu_ttm_map_buffer(entity, dst->bo, dst->mem,=20
&dst_mm,
> -					  1, tmz, &cur_size,=20
&to);
> +					  1, tmz, &cur_size,=20
&to, &dst_vm_flush);
>  		if (r)
>  			goto error;
>=20
> @@ -362,7 +371,7 @@ static int amdgpu_ttm_copy_mem_to_mem(struct
> amdgpu_device *adev, }
>=20
>  		r =3D amdgpu_copy_buffer(adev, entity, from, to, cur_size,=20
resv,
> -				       &next, true, copy_flags);
> +				       &next, src_vm_flush ||=20
dst_vm_flush, copy_flags);
>  		if (r)
>  			goto error;
>=20
> @@ -2578,6 +2587,7 @@ int amdgpu_ttm_clear_buffer(struct
> amdgpu_ttm_buffer_entity *entity, struct amdgpu_device *adev =3D
> amdgpu_ttm_adev(bo->tbo.bdev);
>  	struct dma_fence *fence =3D NULL;
>  	struct amdgpu_res_cursor dst;
> +	bool vm_needs_flush =3D false;
>  	int r;
>=20
>  	if (!entity)
> @@ -2599,13 +2609,13 @@ int amdgpu_ttm_clear_buffer(struct
> amdgpu_ttm_buffer_entity *entity, cur_size =3D min(dst.size, 256ULL << 20=
);
>=20
>  		r =3D amdgpu_ttm_map_buffer(entity, &bo->tbo, bo-
>tbo.resource, &dst,
> -					  0, false, &cur_size,=20
&to);
> +					  0, false, &cur_size,=20
&to, &vm_needs_flush);
>  		if (r)
>  			goto error;
>=20
>  		r =3D amdgpu_ttm_fill_mem(adev, entity,
>  					0, to, cur_size, resv,
> -					&next, true,=20
k_job_id);
> +					&next, vm_needs_flush,=20
k_job_id);
>  		if (r)
>  			goto error;




