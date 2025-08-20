Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF43CA0EDC
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 21:39:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3049610E03E;
	Wed, 20 Aug 2025 21:39:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QqzRROds";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B55B110E03E
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 21:39:52 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-24457f4ff1aso442935ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 14:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755725992; x=1756330792; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n9etAzU51U6MUfU0BUGU9zBd4WohhM9koi091pAhvD4=;
 b=QqzRROds5bZ5RuNNhNU79/QSSFYjeoDOSn0MERBxZuGGe3N+Tzm0usB8OvDpC4bdpJ
 4Dcu79CgIBDG34yl+6z2T/wiC2EMibYfHJicLipvJgkJ/K//xAukjgtYcXXTR8sRDq8Y
 bORohsvFkik35pkt6fyEbQmvXrZDGD7pOcWvl9P0KvsTdQU4XMVzXgfXollTpdtdnfhq
 +/LmEUkWU5yPtTzFltgs0I8g5m7+V4X2MSykEB6EIdmQmikdEbAFqk62SZuYCBBLscQj
 UhEpYJaqOO1ZFrYRV87Bn5l058+RdXQRkk8G4oBzSlo37hcwQDhutfLDHT6uDpf69bkC
 5IYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755725992; x=1756330792;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n9etAzU51U6MUfU0BUGU9zBd4WohhM9koi091pAhvD4=;
 b=JB9oIFWiBy/xyCFEkIzMkrVihURbp+u8a53Tn93774FvjZYXJ3rUF20ayRGM9mOxgc
 952PvmkiJ/kEIMC0ix/vgpuF2hhm5hkUyY3G+hi2zHr48uHYB+S6SBc4b+j/E3G8CEVG
 PiciMogf5U2cKyxcIauMxlOy6l+bt5hP4oEmD3Nd6MUehYFq1m/fKWHUQ6hJQfNFQy1f
 HFM53+AFAk/qx13bXDDPynyUVAgyzQwVR5ygZdsGTZJ4py6hjDFFaA9bU/qLS6ka4KUU
 XHH167DTdW++reA2ECQwaSuvAACuXwXFoP7sX1QXU0/Uin88GWSD10Zqtna4AUgxasYh
 FOqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCtKJDcsByPPkM7q+E0FA8QzEBJr0AFpnxWR1UySDgbm8DMPxogEB1ib8YAvwnNd44m94i11vr@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzZd/q5oX072rxWSUeGxFWMvVgnPCb+W2OXc4ASabqf1EhMXfJx
 vF1LoNuqZSLCpizUfp6v5OTbprYbts0Bu6ZYI1fkcC/g7eOjmqJMDOFnjvs5u1k7bmzga1JXNeQ
 oLymk9MdKty81vdTpCWYA/LowYhOjVxg=
X-Gm-Gg: ASbGncuua+mX9p459pefscN57evHyAStQK8mr4otFlOLgiLi2AHlTyYtbiU84/A30r+
 f3M4Y/8dVJoO4Sl2UrTRtxuUnUIWeKJ8dGGBMWkdNA4/wMqrpawhlMAOda5fOGRpxy93YPD2qfP
 gq6jEcNS7IQV7NEYvKQrV0bJJmG0TyMCblu/eqAFvfjVh7jHhkGlmpjdjmWRO8i6A3uhbnTwM8H
 cq8oF0OusOrfS8IWaN7mkADmRos
X-Google-Smtp-Source: AGHT+IHbrG4ceJgn1CTInsACnKtu+BX/Fl7TxQdzgsqi47m1JBlcT3dmhIXobtFUgmqmiSIbyaUP9t8t1YAIPgMSQWM=
X-Received: by 2002:a17:902:ec86:b0:240:5c13:979a with SMTP id
 d9443c01a7336-245ff8dfd49mr1478695ad.9.1755725992146; Wed, 20 Aug 2025
 14:39:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250820113254.3864753-1-srinivasan.shanmugam@amd.com>
 <20250820113254.3864753-8-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250820113254.3864753-8-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 20 Aug 2025 17:39:39 -0400
X-Gm-Features: Ac12FXybnstcIrD8CUTpZGGJa4mDSQmzc1AkgPdV-EzW3Kq0zPaQIaXRA2DtWd4
Message-ID: <CADnq5_MG_nr3xJ6qKSTweZva61xnqecBrB1MGkeiKyMTjfMsjg@mail.gmail.com>
Subject: Re: [RFC PATCH 7/7] drm/amdgpu: Return Handle to MMIO_REMAP Singleton
 for GEM Create
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

On Wed, Aug 20, 2025 at 7:43=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> When userspace requests a GEM in AMDGPU_GEM_DOMAIN_MMIO_REMAP, return a
> handle to the kernel-owned singleton BO instead of allocating a new one.
>
> Validate inputs (exact PAGE_SIZE, alignment PAGE_SIZE, no extra flags)
> and zero the ioctl out-struct on success for a clean echo.
>
> This puts the userspace-visible behavior last, after all internal kernel
> plumbing and initialization are in place.
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 56 +++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.c
> index e3f65977eeee..1345e81214e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -424,6 +424,26 @@ const struct drm_gem_object_funcs amdgpu_gem_object_=
funcs =3D {
>         .vm_ops =3D &amdgpu_gem_vm_ops,
>  };
>
> +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D MMIO remap (HDP flush) GEM handle helper =
=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> +static int amdgpu_gem_get_mmio_remap_handle(struct drm_file *file_priv,
> +                                           struct amdgpu_device *adev,
> +                                           u32 *handle)
> +{
> +       struct amdgpu_bo *bo =3D adev->mmio_remap_bo;
> +       struct drm_gem_object *gobj;
> +       int r;
> +
> +       if (!bo)
> +               return -ENODEV;
> +
> +       /* Take a temporary ref; the handle creation will hold its own re=
f. */
> +       bo =3D amdgpu_bo_ref(bo);
> +       gobj =3D &bo->tbo.base;
> +       r =3D drm_gem_handle_create(file_priv, gobj, handle);
> +       amdgpu_bo_unref(&bo);  /* drops our temporary ref */
> +       return r;
> +}
> +
>  /*
>   * GEM ioctls.
>   */
> @@ -465,6 +485,42 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, =
void *data,
>         /* always clear VRAM */
>         flags |=3D AMDGPU_GEM_CREATE_VRAM_CLEARED;
>
> +       /*
> +        * =3D=3D=3D MMIO remap (HDP flush) fast-path =3D=3D=3D
> +        * If userspace asks for the MMIO_REMAP domain, don't allocate a =
new BO.
> +        * Return a handle to the singleton BO created at device init.
> +        */
> +       if (args->in.domains & AMDGPU_GEM_DOMAIN_MMIO_REMAP) {
> +               u32 mmio_handle;

Can drop this and just use handle from the top of this function.

> +               /* Enforce fixed size & alignment (exactly one page). */

This needs to check that the PAGE_SIZE is 4K.  E.g.,

If (PAGE_SIZE > 4096)
    return -EINVAL;

Alex

> +               if (size && size !=3D PAGE_SIZE)
> +                       return -EINVAL;
> +               if (args->in.alignment && args->in.alignment !=3D PAGE_SI=
ZE)
> +                       return -EINVAL;
> +               /* No extra domain flags for this special object. */
> +               if (args->in.domain_flags)
> +                       return -EINVAL;
> +               /* Disallow flags that don't make sense for a fixed I/O p=
age. */
> +               if (flags & (AMDGPU_GEM_CREATE_CPU_GTT_USWC |
> +                            AMDGPU_GEM_CREATE_ENCRYPTED |
> +                            AMDGPU_GEM_CREATE_DISCARDABLE))

I think all flags would be irrelevant in this case.

> +                       return -EINVAL;
> +
> +               /* Normalize inputs (optional, for user-visible echo/debu=
g). */
> +               args->in.bo_size     =3D PAGE_SIZE;
> +               args->in.alignment   =3D PAGE_SIZE;
> +               args->in.domains     =3D AMDGPU_GEM_DOMAIN_MMIO_REMAP;
> +               args->in.domain_flags =3D 0;

Why are you setting all of these?

Alex

> +
> +               r =3D amdgpu_gem_get_mmio_remap_handle(filp, adev, &mmio_=
handle);
> +               if (r)
> +                       return r;
> +
> +               memset(args, 0, sizeof(*args));
> +               args->out.handle =3D mmio_handle;
> +               return 0;
> +       }
> +
>         /* create a gem object to contain this object in */
>         if (args->in.domains & (AMDGPU_GEM_DOMAIN_GDS |
>             AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA)) {
> --
> 2.34.1
>
