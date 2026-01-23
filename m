Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38F8D72371
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 11:16:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 309EE10EAB4;
	Fri, 23 Jan 2026 11:16:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U5AigHkj";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9443510EAC3
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 11:16:18 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-47ee2715254so11393655e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 03:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769166977; x=1769771777; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1kk/yZdzj6dquRrpZrGFmMtdXrOrptq8ptA2M7NwdHQ=;
 b=U5AigHkjlZfBDWIeSuo4R9cwkVz47BcUYKGvLe42JLVcRFJqKgeX7udX9BgJM7/MYc
 bXcDt9lI8bmiqY7bGoNJt9s1twDF4FRcQGxrdSoZGotOcUTEn4Nc0qkBidU+je3Q1XBm
 K/Czr/TpkEBpOBcIXhfSZRCkBQzY3wEpONR5TLAc1pBpNwrxOFh5O6XuBYiwq3Sfp+CG
 SnxKwaeNfP5JrV/i4Q+owv4K5Ex5AJ30bfDbHcK37W7lJyFG0Ju8dZX1GmdsLHzIHWXu
 kNux3+W/vubfZ8MGcFzc/D+AkKN4q36lkQo+ceFt6zcR+l4wbQ9v1G7oKOI75eDnKXuc
 rcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769166977; x=1769771777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1kk/yZdzj6dquRrpZrGFmMtdXrOrptq8ptA2M7NwdHQ=;
 b=AShq3EUroRBYEEistpWX/S2QA17e4AdY2BFcYvxQ5uKnv0Ex6wPxLQ0ZoYitgcGabx
 4EYKxOXrybpxVy2Rv8wk/knnGEHAD0umbXE0/It/HgtBN6UdtRrs27J4ei7aYHUHAJuQ
 xNjIdA0JOolVDVssjYNIICm9xdRzdKTfypOZcgzdBPSC6VbpLo3+dB4XFIuPRt3zKdX6
 F4MGjs5y8ISr8hGHlqrow9rERBe99pOVmZdSfQWk8OIlypHHi7+bkQ917b8bgEK+vbG9
 TTKGoeJZBmm70DercGcC3Ovh3HhMOGeVyfqkJvwJijxjDebH37Afkgka7VTVuNugWwDF
 HltA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJRDFur6Oe+HcJU1+WRrZbHpvXcFPyygvm0S/Ia7LOdsaLIx6Wl2iSYadurmGfZksLEw78e5Mm@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyH186miIREayVqJ+UQSjx+vzqVUI5wDnn+aBt20IE4JTXAf9yP
 bMlBqQKnkFqmVCazCTlvchxZvwOQvJL8szfvks8g0kN0J61IPC6Fdz5n
X-Gm-Gg: AZuq6aIaBUybeQRfF+fopzzNBRvXkfbSt5VCHIxgyQKm1sFbwiyZV1E361upFYEkPeC
 eEBgRJMV4ghJZCBUp83TyywUpS0yjuGd4GWtAbnEoY7mg5kKqYqtaLxq2ISoAUCc+2WxokJKzdW
 jmHuCVYfD0Oq69h+dKheuxlwe2xHlwMn42l57mlHZ3nPa9vFnxgWIT3mVxkfjkbT54VO7GZT1LK
 vuu9Zzr+RzJeXWlSS7/Hvb88xE9x1/faTIMWi62/HGotgr5nCOKmepR09qDId7FehGxRG30Fe0U
 sYtK9Y8zPXqLWkDua6aQRMlA08sWmTfz4ZRHsMEEXPLX5ZJPWdR3o3HTB7GntsLzE0UstXJ0cZz
 Re3fANhGYJN76WbZOoR3z95NI3WbwaNarx3Ht8WK29+khff/ih4k+cGr6/U/Vp4OZxgscsDjcEg
 YQAv3KTH7CDlPrtuaM+pvCXBx25hYfE3OxeCq8R2yXVaumrwZ/JHF2ZthGQg==
X-Received: by 2002:a05:600c:528c:b0:47a:935f:61a0 with SMTP id
 5b1f17b1804b1-4804c8ec74dmr44670655e9.0.1769166976779; 
 Fri, 23 Jan 2026 03:16:16 -0800 (PST)
Received: from timur-hyperion.localnet (54001FF2.dsl.pool.telekom.hu.
 [84.0.31.242]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f744e2sm6377640f8f.31.2026.01.23.03.16.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 03:16:16 -0800 (PST)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Subject: Re: [PATCH v5 04/10] drm/amdgpu: remove
 AMDGPU_GTT_NUM_TRANSFER_WINDOWS
Date: Fri, 23 Jan 2026 12:16:15 +0100
Message-ID: <3698448.dWV9SEqChM@timur-hyperion>
In-Reply-To: <20260122170218.3077-5-pierre-eric.pelloux-prayer@amd.com>
References: <20260122170218.3077-1-pierre-eric.pelloux-prayer@amd.com>
 <20260122170218.3077-5-pierre-eric.pelloux-prayer@amd.com>
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

On Thursday, January 22, 2026 6:02:01=E2=80=AFPM Central European Standard =
Time=20
Pierre-Eric Pelloux-Prayer wrote:
> Instead use amdgpu_gtt_mgr_alloc_entries to avoid hardcoding
> the number of windows we need.
>=20
> It also allows to simplify amdgpu_gtt_mgr_init because we don't
> need to reserve some pages anymore and this makes the
> amdgpu_vce_required_gart_pages function unneeded.

I suggest to split this patch into two if possible in order to make it clea=
ner=20
and also allow for easier bisection in the future:
1. First patch to remove amdgpu_vce_required_gart_pages() and use
the amdgpu_gtt_mgr_alloc_entries() function instead.
2. Second patch to get rid of AMDGPU_GTT_NUM_TRANSFER_WINDOWS

>=20
> ---
> v5: switch to amdgpu_gtt_mgr_alloc_entries
> ---
>=20
> Signed-off-by: Pierre-Eric Pelloux-Prayer
> <pierre-eric.pelloux-prayer@amd.com> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c |  6 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 66 +++++++++++++--------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c     | 18 ------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h     |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vce_v1_0.c       | 27 ++++++---
>  6 files changed, 63 insertions(+), 58 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c index
> dd9b845d5783..9b0bcf6aca44 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> @@ -324,17 +324,13 @@ int amdgpu_gtt_mgr_init(struct amdgpu_device *adev,
> uint64_t gtt_size) {
>  	struct amdgpu_gtt_mgr *mgr =3D &adev->mman.gtt_mgr;
>  	struct ttm_resource_manager *man =3D &mgr->manager;
> -	uint64_t start, size;
>=20
>  	man->use_tt =3D true;
>  	man->func =3D &amdgpu_gtt_mgr_func;
>=20
>  	ttm_resource_manager_init(man, &adev->mman.bdev, gtt_size);
>=20
> -	start =3D AMDGPU_GTT_MAX_TRANSFER_SIZE *=20
AMDGPU_GTT_NUM_TRANSFER_WINDOWS;
> -	start +=3D amdgpu_vce_required_gart_pages(adev);
> -	size =3D (adev->gmc.gart_size >> PAGE_SHIFT) - start;
> -	drm_mm_init(&mgr->mm, start, size);
> +	drm_mm_init(&mgr->mm, 0, adev->gmc.gart_size >> PAGE_SHIFT);
>  	spin_lock_init(&mgr->lock);
>=20
>  	ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_TT, &mgr-
>manager);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c index 8b38b5ed9a9c..d23d3046919b
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2012,37 +2012,47 @@ static void amdgpu_ttm_free_mmio_remap_bo(struct
> amdgpu_device *adev) adev->rmmio_remap.bo =3D NULL;
>  }
>=20
> -static int amdgpu_ttm_buffer_entity_init(struct amdgpu_ttm_buffer_entity
> *entity, +static int amdgpu_ttm_buffer_entity_init(struct amdgpu_gtt_mgr
> *mgr, +					 struct=20
amdgpu_ttm_buffer_entity *entity,
>  					 enum=20
drm_sched_priority prio,
>  					 struct=20
drm_gpu_scheduler **scheds,
>  					 int num_schedulers,
> -					 int=20
starting_gart_window,
>  					 u32 num_gart_windows)
>  {
> -	int i, r;
> +	int i, r, num_pages;
>=20
>  	r =3D drm_sched_entity_init(&entity->base, prio, scheds,=20
num_schedulers,
> NULL); if (r)
>  		return r;
>=20
> -
>  	mutex_init(&entity->lock);
>=20
>  	if (ARRAY_SIZE(entity->gart_window_offs) < num_gart_windows)
> -		return starting_gart_window;
> +		return -EINVAL;
> +	if (num_gart_windows =3D=3D 0)
> +		return 0;
> +
> +	num_pages =3D num_gart_windows * AMDGPU_GTT_MAX_TRANSFER_SIZE;
> +	r =3D amdgpu_gtt_mgr_alloc_entries(mgr, &entity->node, num_pages,
> +					 DRM_MM_INSERT_BEST);
> +	if (r) {
> +		drm_sched_entity_destroy(&entity->base);
> +		return r;
> +	}
>=20
>  	for (i =3D 0; i < num_gart_windows; i++) {
>  		entity->gart_window_offs[i] =3D
> -			(u64)starting_gart_window *=20
AMDGPU_GTT_MAX_TRANSFER_SIZE *
> -				AMDGPU_GPU_PAGE_SIZE;
> -		starting_gart_window++;
> +			(entity->node.start + (u64)i *=20
AMDGPU_GTT_MAX_TRANSFER_SIZE) *
> +			AMDGPU_GPU_PAGE_SIZE;
>  	}
>=20
> -	return starting_gart_window;
> +	return 0;
>  }
>=20
> -static void amdgpu_ttm_buffer_entity_fini(struct amdgpu_ttm_buffer_entity
> *entity) +static void amdgpu_ttm_buffer_entity_fini(struct amdgpu_gtt_mgr
> *mgr, +					  struct=20
amdgpu_ttm_buffer_entity *entity)
>  {
> +	amdgpu_gtt_mgr_free_entries(mgr, &entity->node);
>  	drm_sched_entity_destroy(&entity->base);
>  }
>=20
> @@ -2343,36 +2353,42 @@ void amdgpu_ttm_set_buffer_funcs_status(struct
> amdgpu_device *adev, bool enable)
>=20
>  		ring =3D adev->mman.buffer_funcs_ring;
>  		sched =3D &ring->sched;
> -		r =3D amdgpu_ttm_buffer_entity_init(&adev-
>mman.default_entity,
> -						 =20
DRM_SCHED_PRIORITY_KERNEL, &sched, 1,
> -						  0, 0);
> +		r =3D amdgpu_ttm_buffer_entity_init(&adev->mman.gtt_mgr,
> +						  &adev-
>mman.default_entity,
> +						 =20
DRM_SCHED_PRIORITY_KERNEL,
> +						  &sched, 1,=20
0);
>  		if (r < 0) {
>  			dev_err(adev->dev,
>  				"Failed setting up TTM entity=20
(%d)\n", r);
>  			return;
>  		}
>=20
> -		r =3D amdgpu_ttm_buffer_entity_init(&adev-
>mman.clear_entity,
> -						 =20
DRM_SCHED_PRIORITY_NORMAL, &sched, 1,
> -						  r, 1);
> +		r =3D amdgpu_ttm_buffer_entity_init(&adev->mman.gtt_mgr,
> +						  &adev-
>mman.clear_entity,
> +						 =20
DRM_SCHED_PRIORITY_NORMAL,
> +						  &sched, 1,=20
1);
>  		if (r < 0) {
>  			dev_err(adev->dev,
>  				"Failed setting up TTM BO clear=20
entity (%d)\n", r);
>  			goto error_free_default_entity;
>  		}
>=20
> -		r =3D amdgpu_ttm_buffer_entity_init(&adev-
>mman.move_entity,
> -						 =20
DRM_SCHED_PRIORITY_NORMAL, &sched, 1,
> -						  r, 2);
> +		r =3D amdgpu_ttm_buffer_entity_init(&adev->mman.gtt_mgr,
> +						  &adev-
>mman.move_entity,
> +						 =20
DRM_SCHED_PRIORITY_NORMAL,
> +						  &sched, 1,=20
2);
>  		if (r < 0) {
>  			dev_err(adev->dev,
>  				"Failed setting up TTM BO move=20
entity (%d)\n", r);
>  			goto error_free_clear_entity;
>  		}
>  	} else {
> -		amdgpu_ttm_buffer_entity_fini(&adev-
>mman.default_entity);
> -		amdgpu_ttm_buffer_entity_fini(&adev->mman.clear_entity);
> -		amdgpu_ttm_buffer_entity_fini(&adev->mman.move_entity);
> +		amdgpu_ttm_buffer_entity_fini(&adev->mman.gtt_mgr,
> +					      &adev-
>mman.default_entity);
> +		amdgpu_ttm_buffer_entity_fini(&adev->mman.gtt_mgr,
> +					      &adev-
>mman.clear_entity);
> +		amdgpu_ttm_buffer_entity_fini(&adev->mman.gtt_mgr,
> +					      &adev-
>mman.move_entity);
>  		/* Drop all the old fences since re-creating the=20
scheduler entities
>  		 * will allocate new contexts.
>  		 */
> @@ -2390,9 +2406,11 @@ void amdgpu_ttm_set_buffer_funcs_status(struct
> amdgpu_device *adev, bool enable) return;
>=20
>  error_free_clear_entity:
> -	amdgpu_ttm_buffer_entity_fini(&adev->mman.clear_entity);
> +	amdgpu_ttm_buffer_entity_fini(&adev->mman.gtt_mgr,
> +				      &adev->mman.clear_entity);
>  error_free_default_entity:
> -	amdgpu_ttm_buffer_entity_fini(&adev->mman.default_entity);
> +	amdgpu_ttm_buffer_entity_fini(&adev->mman.gtt_mgr,
> +				      &adev->mman.default_entity);
>  }
>=20
>  static int amdgpu_ttm_prepare_job(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h index 871388b86503..c8284cb2d22c
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -40,7 +40,6 @@
>  #define __AMDGPU_PL_NUM	(TTM_PL_PRIV + 6)
>=20
>  #define AMDGPU_GTT_MAX_TRANSFER_SIZE	512
> -#define AMDGPU_GTT_NUM_TRANSFER_WINDOWS	3
>=20
>  extern const struct attribute_group amdgpu_vram_mgr_attr_group;
>  extern const struct attribute_group amdgpu_gtt_mgr_attr_group;
> @@ -56,6 +55,7 @@ struct amdgpu_gtt_mgr {
>  struct amdgpu_ttm_buffer_entity {
>  	struct drm_sched_entity base;
>  	struct mutex		lock;
> +	struct drm_mm_node	node;
>  	u64			gart_window_offs[2];
>  };
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c index a7d8f1ce6ac2..eb4a15db2ef2
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -450,24 +450,6 @@ void amdgpu_vce_free_handles(struct amdgpu_device
> *adev, struct drm_file *filp) }
>  }
>=20
> -/**
> - * amdgpu_vce_required_gart_pages() - gets number of GART pages required=
 by
> VCE - *
> - * @adev: amdgpu_device pointer
> - *
> - * Returns how many GART pages we need before GTT for the VCE IP block.
> - * For VCE1, see vce_v1_0_ensure_vcpu_bo_32bit_addr for details.
> - * For VCE2+, this is not needed so return zero.
> - */
> -u32 amdgpu_vce_required_gart_pages(struct amdgpu_device *adev)
> -{
> -	/* VCE IP block not added yet, so can't use amdgpu_ip_version */
> -	if (adev->family =3D=3D AMDGPU_FAMILY_SI)
> -		return 512;
> -
> -	return 0;
> -}
> -
>  /**
>   * amdgpu_vce_get_create_msg - generate a VCE create msg
>   *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h index 1c3464ce5037..a59d87e09004
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
> @@ -52,6 +52,7 @@ struct amdgpu_vce {
>  	uint32_t                srbm_soft_reset;
>  	unsigned		num_rings;
>  	uint32_t		keyselect;
> +	struct drm_mm_node	node;
>  };
>=20
>  int amdgpu_vce_early_init(struct amdgpu_device *adev);
> @@ -61,7 +62,6 @@ int amdgpu_vce_entity_init(struct amdgpu_device *adev,
> struct amdgpu_ring *ring) int amdgpu_vce_suspend(struct amdgpu_device
> *adev);
>  int amdgpu_vce_resume(struct amdgpu_device *adev);
>  void amdgpu_vce_free_handles(struct amdgpu_device *adev, struct drm_file
> *filp); -u32 amdgpu_vce_required_gart_pages(struct amdgpu_device *adev);
>  int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p, struct amdgpu_j=
ob
> *job, struct amdgpu_ib *ib);
>  int amdgpu_vce_ring_parse_cs_vm(struct amdgpu_cs_parser *p,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c index 9ae424618556..bd47fda52e7e
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> @@ -47,11 +47,6 @@
>  #define VCE_V1_0_DATA_SIZE	(7808 * (AMDGPU_MAX_VCE_HANDLES + 1))
>  #define VCE_STATUS_VCPU_REPORT_FW_LOADED_MASK	0x02
>=20
> -#define VCE_V1_0_GART_PAGE_START \
> -	(AMDGPU_GTT_MAX_TRANSFER_SIZE * AMDGPU_GTT_NUM_TRANSFER_WINDOWS)
> -#define VCE_V1_0_GART_ADDR_START \
> -	(VCE_V1_0_GART_PAGE_START * AMDGPU_GPU_PAGE_SIZE)
> -
>  static void vce_v1_0_set_ring_funcs(struct amdgpu_device *adev);
>  static void vce_v1_0_set_irq_funcs(struct amdgpu_device *adev);
>=20
> @@ -541,6 +536,16 @@ static int vce_v1_0_ensure_vcpu_bo_32bit_addr(struct
> amdgpu_device *adev) u64 num_pages =3D ALIGN(bo_size, AMDGPU_GPU_PAGE_SIZ=
E) /
> AMDGPU_GPU_PAGE_SIZE; u64 pa =3D amdgpu_gmc_vram_pa(adev, adev->vce.vcpu_=
bo);
>  	u64 flags =3D AMDGPU_PTE_READABLE | AMDGPU_PTE_WRITEABLE |=20
AMDGPU_PTE_VALID;
> +	u64 vce_gart_start;
> +	int r;
> +
> +	r =3D amdgpu_gtt_mgr_alloc_entries(&adev->mman.gtt_mgr,
> +					 &adev->vce.node,=20
num_pages,
> +					 DRM_MM_INSERT_LOW);
> +	if (r)
> +		return r;
> +
> +	vce_gart_start =3D adev->vce.node.start * AMDGPU_GPU_PAGE_SIZE;

When the VCPU BO already has a 32-bit address, VCE does not need to use any=
=20
GART space at all. I think you can just safely remove the "Check if the VCP=
U=20
BO already has a 32-bit address". That is practically never going to be cas=
e=20
anyway.

>=20
>  	/*
>  	 * Check if the VCPU BO already has a 32-bit address.
> @@ -550,12 +555,12 @@ static int vce_v1_0_ensure_vcpu_bo_32bit_addr(struct
> amdgpu_device *adev) return 0;
>=20
>  	/* Check if we can map the VCPU BO in GART to a 32-bit address. */
> -	if (adev->gmc.gart_start + VCE_V1_0_GART_ADDR_START >=20
max_vcpu_bo_addr)
> +	if (adev->gmc.gart_start + vce_gart_start > max_vcpu_bo_addr)
>  		return -EINVAL;
>=20
> -	amdgpu_gart_map_vram_range(adev, pa, VCE_V1_0_GART_PAGE_START,
> +	amdgpu_gart_map_vram_range(adev, pa, adev->vce.node.start,
>  				   num_pages, flags, adev-
>gart.ptr);
> -	adev->vce.gpu_addr =3D adev->gmc.gart_start +=20
VCE_V1_0_GART_ADDR_START;
> +	adev->vce.gpu_addr =3D adev->gmc.gart_start + vce_gart_start;
>  	if (adev->vce.gpu_addr > max_vcpu_bo_addr)
>  		return -EINVAL;
>=20
> @@ -610,7 +615,11 @@ static int vce_v1_0_sw_fini(struct amdgpu_ip_block
> *ip_block) if (r)
>  		return r;
>=20
> -	return amdgpu_vce_sw_fini(adev);
> +	r =3D amdgpu_vce_sw_fini(adev);
> +
> +	amdgpu_gtt_mgr_free_entries(&adev->mman.gtt_mgr, &adev->vce.node);
> +
> +	return r;
>  }
>=20
>  /**




