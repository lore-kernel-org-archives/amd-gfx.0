Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8408FCA0EED
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 15:35:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 294CA10EA33;
	Thu, 28 Aug 2025 15:35:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eECeRERI";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7F0310EA30
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 15:35:20 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2488be81066so2365985ad.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 08:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756395320; x=1757000120; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ollLL1vTUUrNUcjLD0HbBWTpEmCC0OqaUhhYB7kR07w=;
 b=eECeRERIkYM64IH1iy9saYqqqo9LzvAtyWGz79hkDlo5N86eiCirxTwdGWe9KlN9mB
 pLNxr/FrcLczugQOKpIWi39Xoerjel3PAsofbZ5oQGK7t4H8VXXvgXvPsZrLugKhlrP0
 h+CM3qRKlqnDiavdi/QVLekzc7JC+2xT0u0qhM+iH8KHZNiAtnHlxf0phzKn2o06IcBl
 DoxRvuylpfekBcRpJT7FkCpSC+VSb45h/WGq6rg9nYXJ4bdz0vIbdhZUgJM92I8PJWMR
 uJAcYFTUZ8zlOSTLj9qgko9z6GF49aWwdG72WW3e1EXr3RI+/7wbafiZL6PWcHIMS01B
 Ge7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756395320; x=1757000120;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ollLL1vTUUrNUcjLD0HbBWTpEmCC0OqaUhhYB7kR07w=;
 b=dPHy0TvZnirxdUByRfT6u5AboTEOPjSdgCq4VgJI14uZVAFzuhZq5UW6XTxasoNjA6
 VlqYF8lZ798fJXvuCCpaf3ZsZGXpsk19ITllJP//shBOW3KJX58pfRjQUnFonHWff/H8
 J77Tpn2Rsz8vv0T/olPPllDA28c7ofAXV74lWdIqB7xfnFkNKOHIGkSiXJVH9CtxRnA4
 u1uLIw8fUqs1kVg+bkEdKZTBi3Z5rYqrpwaruzH70FaWnUeTjAhS/4mcumA9zoaGiUns
 9SbQDcX7Fyaxk0F22oYmJ1EDXClrEEVwC4sPv2S8Wm8Q0uLViFX2iwmnfqhzT4g+KZ/2
 pLBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUkZMUHfa2EnO1E5IdY0xBpntMVheyMIzeiZsU1zwM5202Q14u2lUkokLdqpTG+RZjZmWXTXq0@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwgRc6vtwzGtHq9TF167QHK39ay/WBG62hTC6wrZaSY/AzN09TU
 QkZZ+sU2ZPzLl3TDUC4we8cegsfuaWF+ojQ1cqBVWyuO1ORjKyATgfl9BZYPCp8bTEFhV5SXfHF
 xYNE9nNB2jGESNw0/hpERmuwYc6tXcWk=
X-Gm-Gg: ASbGncsKLL+e2Z7hEwQHu7ad4vldak6iOCqTKAYU4H1qEXMaHdv1ylsLbH1SO0VWWAN
 Wn3K5cAEwILK4tYl7N3bfMJ9h6n9S+pGtOdW3i+V4yKowl0GEroeneVDa6ncXbGg7lnZtCQSE0I
 np3UVRqqLTWdcyMR76lOGEf+K0BDadVvcHu+qodJchCr0EI8wDRSFDQ9ygPYOQ/svcNgEYcvkps
 rjA/6BGTZM2tVDmYA==
X-Google-Smtp-Source: AGHT+IFZ5nSD8I8cHwW40QpaVjk2i5d3USqVAa8nhIhwkacHHJeqWVaTchm9KOilrJJS9Lm0sPaH9JvRfHcB2mwjYMw=
X-Received: by 2002:a17:902:e888:b0:240:8717:e393 with SMTP id
 d9443c01a7336-2462ee8e35dmr150818445ad.5.1756395320218; Thu, 28 Aug 2025
 08:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250828071335.3948819-1-srinivasan.shanmugam@amd.com>
 <20250828071335.3948819-9-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250828071335.3948819-9-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 28 Aug 2025 11:35:08 -0400
X-Gm-Features: Ac12FXzM_Scum_h2fHYksoPbcP-Cjr89p-QP2FPTRSomjPiLCLDPQu97gYKnyeA
Message-ID: <CADnq5_MhrYFbREmt6XQ5Zxz=XWW-0yr7GMx=fYK-Bf8KK4GU+g@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] drm/amdgpu/ttm: Allocate/Free 4K MMIO_REMAP
 Singleton BO
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Aug 28, 2025 at 5:28=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Add amdgpu_ttm_mmio_remap_bo_init()/fini() to manage the kernel-owned
> one-page(4K) MMIO_REMAP BO. The allocator runs during TTM init when the
> hardware exposes a remap base (adev->rmmio_base) and the host PAGE_SIZE
> is <=3D AMDGPU_GPU_PAGE_SIZE (4K).
>
> The helper is idempotent (returns 0 if already allocated) and only
> returns an error when the actual allocation fails.
>
> This keeps MMIO_REMAP lifetime handling localized and prepares for the
> subsequent patch that exposes a userspace handle.
>
> v2:
>  - Check mmio_remap bus address (adev->rmmio_remap.bus_addr) instead of
>    rmmio_base. (Alex)
>  - Skip quietly if PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE or no bus address
>    (no warn). (Alex)
>  - Use `amdgpu_bo_create()` (not *_kernel) - Only with this The object
>    is stored in adev->mmio_remap.bo and will later be exposed to
>    userspace via a GEM handle. (Christian)
>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 64 +++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 7822d8969c9f..0e301cab74e0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1853,6 +1853,63 @@ static void amdgpu_ttm_pools_fini(struct amdgpu_de=
vice *adev)
>         adev->mman.ttm_pools =3D NULL;
>  }
>
> +/**
> + * amdgpu_ttm_mmio_remap_bo_init - allocate the singleton 4K MMIO_REMAP =
BO
> + * @adev: amdgpu device
> + *
> + * Allocates a one-page (4K) GEM BO in AMDGPU_GEM_DOMAIN_MMIO_REMAP when=
 the
> + * hardware exposes a remap base (adev->rmmio_remap.bus_addr) and the ho=
st
> + * PAGE_SIZE is <=3D AMDGPU_GPU_PAGE_SIZE (4K). The BO is created as a r=
egular
> + * GEM object (amdgpu_bo_create), then reserved and kmap=E2=80=99ed once=
 to exercise
> + * the io-mem setup path. If prerequisites are not met, this is a no-op.
> + *
> + * Return:
> + *  * 0 on success or intentional skip (feature not present/unsupported)
> + *  * negative errno on allocation failure
> + */
> +static int amdgpu_ttm_mmio_remap_bo_init(struct amdgpu_device *adev)
> +{
> +       int r;
> +       struct amdgpu_bo_param bp =3D { 0 };
> +       void *kptr;
> +
> +       /* Skip if HW doesn=E2=80=99t expose remap or system PAGE > GPU 4=
K */
> +       if (!adev->rmmio_remap.bus_addr || PAGE_SIZE > AMDGPU_GPU_PAGE_SI=
ZE)
> +               return 0;
> +
> +       /* Hardware remap page is fixed 4K; skip on larger PAGE_SIZE. */
> +       if (PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE)
> +               return 0;

This can be dropped (as per your later patch).

> +
> +       /* Create exactly one GEM BO in the MMIO_REMAP domain. */
> +       bp.type        =3D ttm_bo_type_device;          /* userspace-mapp=
able GEM */
> +       bp.size        =3D AMDGPU_GPU_PAGE_SIZE;        /* 4K */
> +       bp.byte_align  =3D AMDGPU_GPU_PAGE_SIZE;
> +       bp.domain      =3D AMDGPU_GEM_DOMAIN_MMIO_REMAP;
> +       bp.flags       =3D 0;
> +       bp.resv        =3D NULL;
> +       bp.bo_ptr_size =3D sizeof(struct amdgpu_bo);
> +
> +       r =3D amdgpu_bo_create(adev, &bp, &adev->rmmio_remap.bo);
> +       if (r)
> +               return r;
> +
> +       return 0;
> +}
> +
> +/**
> + * amdgpu_ttm_mmio_remap_bo_fini - free the singleton MMIO_REMAP BO
> + * @adev: amdgpu device
> + *
> + * Frees the kernel-owned MMIO_REMAP BO if it was allocated by
> + * amdgpu_ttm_mmio_remap_bo_init().
> + */
> +static void amdgpu_ttm_mmio_remap_bo_fini(struct amdgpu_device *adev)
> +{
> +       amdgpu_bo_unref(&adev->rmmio_remap.bo);
> +       adev->mmio_remap.bo =3D NULL;
> +}
> +
>  /*
>   * amdgpu_ttm_init - Init the memory management (ttm) as well as various
>   * gtt/vram related fields.
> @@ -2027,6 +2084,11 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>                 return r;
>         }
>
> +       /* Allocate the singleton MMIO_REMAP BO (4K) if supported */
> +       r =3D amdgpu_ttm_mmio_remap_bo_init(adev);
> +       if (r)
> +               return r;
> +
>         /* Initialize preemptible memory pool */
>         r =3D amdgpu_preempt_mgr_init(adev);
>         if (r) {
> @@ -2090,6 +2152,8 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>         amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
>                                         &adev->mman.sdma_access_ptr);
>
> +       /* Drop the singleton MMIO_REMAP BO (if allocated) */

You can drop this comment.

Alex

> +       amdgpu_ttm_mmio_remap_bo_fini(adev);
>         amdgpu_ttm_fw_reserve_vram_fini(adev);
>         amdgpu_ttm_drv_reserve_vram_fini(adev);
>
> --
> 2.34.1
>
