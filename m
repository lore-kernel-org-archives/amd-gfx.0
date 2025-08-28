Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32716C8303F
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 15:15:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB96D10EA0F;
	Thu, 28 Aug 2025 15:15:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cr2b7Whl";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01AEC10EA0F
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 15:15:03 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-248cd112855so1802275ad.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 08:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756394103; x=1756998903; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iXldMMITd9O+agQB0ntLrgH9F5LJ09ZPbiPncKNdixY=;
 b=cr2b7WhlblK7TTkWtm5/96NT4VAJmhMLyur0Gm7U3OJuLV41+7cwRlvav984rzfzvh
 F5JpoUBFn5OvKs4zP1/XSpk5H+uxIXkhAq03baJps6ZFUI8bw3NaudaTO1EeYchGSqv3
 c0MM3KxKDfiVfNV/OHzoEQLNAdK0d5WmaHtnu6UFU5vCIHlPXVyeoLSQqu1LbhRs9neV
 UadjFnJGdYvhV08035sFNNED2LBLCLEoWBOwBT4nu31Dn+GQoVJ0Gk74LzfSb9IVo03n
 toiVPNHgJ5k2hN79gmiebjmSTcvLiVK/lonWN/rilsFGrm9Okw5KTSQHJBgIcZzPLn+j
 kezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756394103; x=1756998903;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iXldMMITd9O+agQB0ntLrgH9F5LJ09ZPbiPncKNdixY=;
 b=iw6kzhnw7r1rwTi/7fe0IeErJDs/FHnK/6oTNijmjEo8YKzYUT5PcahsYup0f2zNbF
 1Hye+903aabyqPTiZQkd8FzfCtcD6i0ALmqf3Bm2KXX/xsjv7YDUpa4QaB7zA674B2Xn
 flBfNPTpzTu1v+tzTRI9IBKIpiqxeqG41fp70TmucURnqFBew82okPBZV9e8tzCK+V5f
 N43Tg6l2wijYO/QPnrmfglS4/N8cfzHvIsy1nIpgebqOPHcxLRpNKh+1r9gbLd2/ckRq
 WjYy2EWlFQBzaEN2QDDb7IprGP30DapSvBRCiYQMlrHZ/maNk7XhdjYli6voy50GXkBd
 T0zA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtmYssUHcCx6AD9pw3idIgvH0avsCxs2zcvcxzJfhMrMi4N7hVPZA6OEKFakymzR0KyZdVLXe5@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyIRo29t83r8M9mEbs3Ie2z/9rB2WdNZuQEe/musB4+2uMKVruE
 btYGfbrFsZG3IR/1kazgQHKKL/1yehIzc9sbZ+RBzY8qJykV344aR5zCnapvc7Feey5rUrFdxMX
 o+YkGX/+IMB4rsq23WXgiDAD/v9xttIY=
X-Gm-Gg: ASbGnctWSKmHmXzDLiML9anRu4P6iyXvZY6jfxTt+OHu03bb/6vv/3tP8uylQhVcSXg
 aUL+iIaissuNklvC0n1zHXC2/VqQohO9Z0eg4nTn161VzD2HpCN2BwlvsRosyGp+dxPAKJRvqPU
 HKyB08vlKwwqPWAselQLiqq2y8yVnmTOSagG6yjPVBRZxU27ITfydLXOg3sgpp+rgoW8HzfHGbU
 v8Z/RuAMnMMLUbwLg==
X-Google-Smtp-Source: AGHT+IFdoec1fRKaIz5EITN5OIXv5QVXUYWBVHpkRiNOl2rcDylPzSnvEQ+GoCLzykEjN4JKrVATNYXNIzWvSQV5Bno=
X-Received: by 2002:a17:902:ecd0:b0:246:d736:cc2c with SMTP id
 d9443c01a7336-246d736d20cmr116357415ad.9.1756394103227; Thu, 28 Aug 2025
 08:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250828071335.3948819-1-srinivasan.shanmugam@amd.com>
 <20250828071335.3948819-10-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250828071335.3948819-10-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 28 Aug 2025 11:14:51 -0400
X-Gm-Features: Ac12FXwfCzRavTA2MHXQX4W1E9egb5yc9NsLqybjstMDf8yuATR7cX-sJiCXYKk
Message-ID: <CADnq5_NhqfQOogdafa-OgQ4k=7Kg1rrfToH3u3ee=Y_39rqn3g@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] drm/amdgpu/gem: Return Handle to MMIO_REMAP
 Singleton in GEM_CREATE
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
> Enable userspace to obtain a handle to the kernel-owned MMIO_REMAP
> singleton when AMDGPU_GEM_DOMAIN_MMIO_REMAP is requested via
> amdgpu_gem_create_ioctl().
>
> Validate the fixed 4K constraint: if PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE
> return -EINVAL; when provided, size and alignment must equal
> AMDGPU_GPU_PAGE_SIZE.
>
> If the singleton BO is not available, return -ENODEV.
>
> v2:
> - Drop READ_ONCE() on adev->mmio_remap.bo (use a plain pointer load).
>   The pointer is set `bo =3D adev->mmio_remap.bo;` ie., The pointer is
>   written once during init and not changed while IOCTLs run. There=E2=80=
=99s no
>   concurrent writer in this execution path, so a normal read is safe.
>   (Alex)
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 59 +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 18 +++-----
>  2 files changed, 66 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.c
> index d3c369742124..465f9d4a79d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -424,6 +424,38 @@ const struct drm_gem_object_funcs amdgpu_gem_object_=
funcs =3D {
>         .vm_ops =3D &amdgpu_gem_vm_ops,
>  };
>
> +/**
> + * amdgpu_gem_get_mmio_remap_handle - Create a GEM handle for the MMIO_R=
EMAP BO
> + * @file_priv: DRM file corresponding to the calling process
> + * @adev: amdgpu device
> + * @handle: returned userspace GEM handle (out)
> + *
> + * Creates a GEM handle to the kernel-owned singleton MMIO_REMAP buffer =
object
> + * (adev->rmmio_remap.bo). The BO is expected to be allocated during TTM=
 init
> + * when the hardware exposes a remap base and PAGE_SIZE <=3D 4K.
> + *
> + * drm_gem_handle_create() acquires the handle reference, which will be =
dropped
> + * by GEM_CLOSE in userspace.
> + *
> + * * Return:
> + * * 0 on success
> + * * -ENODEV if the MMIO_REMAP BO is not available
> + * * A negative errno from drm_gem_handle_create() on failure
> + *
> + */
> +static int amdgpu_gem_get_mmio_remap_handle(struct drm_file *file_priv,
> +                                           struct amdgpu_device *adev,
> +                                           u32 *handle)
> +{
> +       struct amdgpu_bo *bo =3D adev->rmmio_remap.bo;
> +
> +       if (!bo)
> +               return -ENODEV;
> +
> +       /* drm_gem_handle_create() gets the ref; GEM_CLOSE drops it */
> +       return drm_gem_handle_create(file_priv, &bo->tbo.base, handle);
> +}
> +
>  /*
>   * GEM ioctls.
>   */
> @@ -468,6 +500,33 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, =
void *data,
>         if (args->in.domains & AMDGPU_GEM_DOMAIN_MMIO_REMAP)
>                 return -EINVAL;
>
> +       /*
> +        * =3D=3D=3D MMIO remap (HDP flush) fast-path =3D=3D=3D
> +        * If userspace asks for the MMIO_REMAP domain, don't allocate a =
new BO.
> +        * Return a handle to the singleton BO created at ttm init.
> +        */
> +       if (args->in.domains & AMDGPU_GEM_DOMAIN_MMIO_REMAP) {
> +               /*
> +                * The MMIO remap page is fixed 4K on the GPU side. Do no=
t
> +                * allow use if the system PAGE_SIZE is larger than the G=
PU
> +                * page size.
> +                */
> +               if (PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE)
> +                       return -EINVAL;
> +
> +               /* Enforce fixed size/alignment when provided by userspac=
e. */
> +               if (size && size !=3D AMDGPU_GPU_PAGE_SIZE)
> +                       return -EINVAL;
> +               if (args->in.alignment && args->in.alignment !=3D AMDGPU_=
GPU_PAGE_SIZE)
> +                       return -EINVAL;
> +
> +               r =3D amdgpu_gem_get_mmio_remap_handle(filp, adev, &handl=
e);
> +               if (r)
> +                       return r;
> +               args->out.handle =3D handle;
> +               return 0;
> +       }
> +
>         /* create a gem object to contain this object in */
>         if (args->in.domains & (AMDGPU_GEM_DOMAIN_GDS |
>             AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA)) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 0e301cab74e0..14af9b0b8673 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1854,14 +1854,13 @@ static void amdgpu_ttm_pools_fini(struct amdgpu_d=
evice *adev)
>  }
>
>  /**
> - * amdgpu_ttm_mmio_remap_bo_init - allocate the singleton 4K MMIO_REMAP =
BO
> + * amdgpu_ttm_mmio_remap_bo_init - Allocate the singleton 4K MMIO_REMAP =
BO
>   * @adev: amdgpu device
>   *
>   * Allocates a one-page (4K) GEM BO in AMDGPU_GEM_DOMAIN_MMIO_REMAP when=
 the
>   * hardware exposes a remap base (adev->rmmio_remap.bus_addr) and the ho=
st
>   * PAGE_SIZE is <=3D AMDGPU_GPU_PAGE_SIZE (4K). The BO is created as a r=
egular
> - * GEM object (amdgpu_bo_create), then reserved and kmap=E2=80=99ed once=
 to exercise
> - * the io-mem setup path. If prerequisites are not met, this is a no-op.
> + * GEM object (amdgpu_bo_create).
>   *
>   * Return:
>   *  * 0 on success or intentional skip (feature not present/unsupported)
> @@ -1871,16 +1870,13 @@ static int amdgpu_ttm_mmio_remap_bo_init(struct a=
mdgpu_device *adev)
>  {
>         int r;
>         struct amdgpu_bo_param bp =3D { 0 };
> -       void *kptr;
>
> -       /* Skip if HW doesn=E2=80=99t expose remap or system PAGE > GPU 4=
K */
> +       /* Skip if HW doesn=E2=80=99t expose remap or
> +        * Hardware remap page is fixed 4K; skip on larger PAGE_SIZE.
> +        */
>         if (!adev->rmmio_remap.bus_addr || PAGE_SIZE > AMDGPU_GPU_PAGE_SI=
ZE)
>                 return 0;
>
> -       /* Hardware remap page is fixed 4K; skip on larger PAGE_SIZE. */
> -       if (PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE)
> -               return 0;
> -
>         /* Create exactly one GEM BO in the MMIO_REMAP domain. */
>         bp.type        =3D ttm_bo_type_device;          /* userspace-mapp=
able GEM */
>         bp.size        =3D AMDGPU_GPU_PAGE_SIZE;        /* 4K */
> @@ -1898,7 +1894,7 @@ static int amdgpu_ttm_mmio_remap_bo_init(struct amd=
gpu_device *adev)
>  }
>
>  /**
> - * amdgpu_ttm_mmio_remap_bo_fini - free the singleton MMIO_REMAP BO
> + * amdgpu_ttm_mmio_remap_bo_fini - Free the singleton MMIO_REMAP BO
>   * @adev: amdgpu device
>   *
>   * Frees the kernel-owned MMIO_REMAP BO if it was allocated by
> @@ -1907,7 +1903,7 @@ static int amdgpu_ttm_mmio_remap_bo_init(struct amd=
gpu_device *adev)
>  static void amdgpu_ttm_mmio_remap_bo_fini(struct amdgpu_device *adev)
>  {
>         amdgpu_bo_unref(&adev->rmmio_remap.bo);
> -       adev->mmio_remap.bo =3D NULL;
> +       adev->rmmio_remap.bo =3D NULL;
>  }

The above cleanups in amdgpu_ttm.c should be folded into the original
patches.  They are unrelated to this patch.

Alex

>
>  /*
> --
> 2.34.1
>
