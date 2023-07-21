Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED91EB64DD
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jul 2023 15:30:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F30810E698;
	Fri, 21 Jul 2023 15:30:38 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED79310E6A3
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jul 2023 15:30:35 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3a426e70575so1267282b6e.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jul 2023 08:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689953435; x=1690558235;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uEK/IPfvZmERXt0Et236X+RemjkGNg2GY0+dAHldgbc=;
 b=hkxUBemBa4R6dn/tFFnUjIT/hO1Fla/Fn3AKr2G0NsKuhZKaNNRg8e9aTiroJLFypV
 AOMUekW5ffUaJ5l6Rd3wRNVcK7MqU5krfMLk1fTow0QSiV9/goWJRVzStswxOhO1BcEK
 h4pX04KcP+uoRlGZdaMoSFTqfYN32unh6Qx7ZLDso1MIME2CQyzrKnH/gi/XXcUD/teG
 LZ0IyZ5k6033p2eYV/wH8w/YgplW52/puJkkeRZT/kBcoXF/anE3CU0QcyCD9kqIb8O1
 2RHt//tjabdNmmHY3YRUbFhwUpezGFW/hOUMzxQdTRrn2qbShrZcdNM3lpZ/L9q0CE6G
 2HUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689953435; x=1690558235;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uEK/IPfvZmERXt0Et236X+RemjkGNg2GY0+dAHldgbc=;
 b=On+6bFzF32uKGiWNOrpMnfwwVCFgTr7CkKUj8NFMnjnOZqLeCBcbkQaU/9aavfzR2W
 WRDj7amZln2hIhd7hLHYg9cld0KBx4gTF/mIhqKL9z2qafF75VKMVmhN6kkXe9z+2Do/
 EWvEvU77HQpRczjtREErgezVKIM1BD/V2MaJWkfZ8sC8W0JJPJlP1S/S7m7uoyQmRhyR
 W2JP2czUh3lld8fd0qdZ/1zwGanrgmYZE98fVkACRdW6X8FpQ9ozjjcUTTVO+sym+KTK
 l/62XnGksSFfAQBk/dtDdbbJu+zzsswNYr/+9g4MxQE2LvGHeAQyTgXL75zwkB7A9vET
 8PWw==
X-Gm-Message-State: ABy/qLbgddVkdvpChv9ksjDqjtSvllrdVdTch7+lu+K8ORj1ceuRQ2Tf
 A8o1MTP7hudCc4dTOnJb0IurOQmH/d9VOojwevM=
X-Google-Smtp-Source: APBJJlHu13JXEujBFP1nb+4FC7iCZtpC+Qv62oAvcmQidHqhQvlQGQkWT6eX3J97gS8mSv3tf3+RQ2CCSzOAKBjTIBw=
X-Received: by 2002:a05:6808:200d:b0:3a3:e638:78d2 with SMTP id
 q13-20020a056808200d00b003a3e63878d2mr2764726oiw.12.1689953435063; Fri, 21
 Jul 2023 08:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230721083652.1427903-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230721083652.1427903-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 21 Jul 2023 11:30:23 -0400
Message-ID: <CADnq5_P4UAacskc2zmR=usaOiOxmTzVc21u2zcHc8OcXH12oaw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix style issues in amdgpu_gem.c
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jul 21, 2023 at 4:37=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Fixes the following to align to linux coding style:
>
> WARNING: braces {} are not necessary for any arm of this statement
> WARNING: Missing a blank line after declarations
> ERROR: space prohibited before that close parenthesis ')'
> WARNING: unnecessary whitespace before a quoted newline
> WARNING: %LX is non-standard C, use %llX
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 38 ++++++++++++-------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.c
> index 4f9de9a0e2ec..1718d7d75eaf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -181,11 +181,10 @@ static int amdgpu_gem_object_open(struct drm_gem_ob=
ject *obj,
>                 return r;
>
>         bo_va =3D amdgpu_vm_bo_find(vm, abo);
> -       if (!bo_va) {
> +       if (!bo_va)
>                 bo_va =3D amdgpu_vm_bo_add(adev, vm, abo);
> -       } else {
> +       else
>                 ++bo_va->ref_count;
> -       }
>         amdgpu_bo_unreserve(abo);
>         return 0;
>  }
> @@ -217,8 +216,8 @@ static void amdgpu_gem_object_close(struct drm_gem_ob=
ject *obj,
>
>         r =3D ttm_eu_reserve_buffers(&ticket, &list, false, &duplicates);
>         if (r) {
> -               dev_err(adev->dev, "leaking bo va because "
> -                       "we fail to reserve bo (%ld)\n", r);
> +               dev_err(adev->dev, "leaking bo va because we fail to rese=
rve bo (%ld)\n",
> +                       r);
>                 return;
>         }
>         bo_va =3D amdgpu_vm_bo_find(vm, bo);
> @@ -238,8 +237,8 @@ static void amdgpu_gem_object_close(struct drm_gem_ob=
ject *obj,
>
>  out_unlock:
>         if (unlikely(r < 0))
> -               dev_err(adev->dev, "failed to clear page "
> -                       "tables on GEM object close (%ld)\n", r);
> +               dev_err(adev->dev, "failed to clear page tables on GEM ob=
ject close (%ld)\n",
> +                       r);
>         ttm_eu_backoff_reservation(&ticket, &list);
>  }
>
> @@ -463,9 +462,9 @@ int amdgpu_mode_dumb_mmap(struct drm_file *filp,
>         struct amdgpu_bo *robj;
>
>         gobj =3D drm_gem_object_lookup(filp, handle);
> -       if (gobj =3D=3D NULL) {
> +       if (!gobj)
>                 return -ENOENT;
> -       }
> +
>         robj =3D gem_to_amdgpu_bo(gobj);
>         if (amdgpu_ttm_tt_get_usermm(robj->tbo.ttm) ||
>             (robj->flags & AMDGPU_GEM_CREATE_NO_CPU_ACCESS)) {
> @@ -482,6 +481,7 @@ int amdgpu_gem_mmap_ioctl(struct drm_device *dev, voi=
d *data,
>  {
>         union drm_amdgpu_gem_mmap *args =3D data;
>         uint32_t handle =3D args->in.handle;
> +
>         memset(args, 0, sizeof(*args));
>         return amdgpu_mode_dumb_mmap(filp, dev, handle, &args->out.addr_p=
tr);
>  }
> @@ -508,7 +508,7 @@ unsigned long amdgpu_gem_timeout(uint64_t timeout_ns)
>
>         timeout_jiffies =3D nsecs_to_jiffies(ktime_to_ns(timeout));
>         /*  clamp timeout to avoid unsigned-> signed overflow */
> -       if (timeout_jiffies > MAX_SCHEDULE_TIMEOUT )
> +       if (timeout_jiffies > MAX_SCHEDULE_TIMEOUT)
>                 return MAX_SCHEDULE_TIMEOUT - 1;
>
>         return timeout_jiffies;
> @@ -526,9 +526,9 @@ int amdgpu_gem_wait_idle_ioctl(struct drm_device *dev=
, void *data,
>         long ret;
>
>         gobj =3D drm_gem_object_lookup(filp, handle);
> -       if (gobj =3D=3D NULL) {
> +       if (!gobj)
>                 return -ENOENT;
> -       }
> +
>         robj =3D gem_to_amdgpu_bo(gobj);
>         ret =3D dma_resv_wait_timeout(robj->tbo.base.resv, DMA_RESV_USAGE=
_READ,
>                                     true, timeout);
> @@ -555,7 +555,7 @@ int amdgpu_gem_metadata_ioctl(struct drm_device *dev,=
 void *data,
>         struct amdgpu_bo *robj;
>         int r =3D -1;
>
> -       DRM_DEBUG("%d \n", args->handle);
> +       DRM_DEBUG("%d\n", args->handle);
>         gobj =3D drm_gem_object_lookup(filp, args->handle);
>         if (gobj =3D=3D NULL)
>                 return -ENOENT;
> @@ -685,7 +685,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void =
*data,
>
>         if (args->va_address < AMDGPU_VA_RESERVED_SIZE) {
>                 dev_dbg(dev->dev,
> -                       "va_address 0x%LX is in reserved area 0x%LX\n",
> +                       "va_address 0x%llx is in reserved area 0x%llx\n",
>                         args->va_address, AMDGPU_VA_RESERVED_SIZE);
>                 return -EINVAL;
>         }
> @@ -693,7 +693,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void =
*data,
>         if (args->va_address >=3D AMDGPU_GMC_HOLE_START &&
>             args->va_address < AMDGPU_GMC_HOLE_END) {
>                 dev_dbg(dev->dev,
> -                       "va_address 0x%LX is in VA hole 0x%LX-0x%LX\n",
> +                       "va_address 0x%llx is in VA hole 0x%llx-0x%llx\n"=
,
>                         args->va_address, AMDGPU_GMC_HOLE_START,
>                         AMDGPU_GMC_HOLE_END);
>                 return -EINVAL;
> @@ -813,9 +813,9 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void =
*data,
>         int r;
>
>         gobj =3D drm_gem_object_lookup(filp, args->handle);
> -       if (gobj =3D=3D NULL) {
> +       if (!gobj)
>                 return -ENOENT;
> -       }
> +
>         robj =3D gem_to_amdgpu_bo(gobj);
>
>         r =3D amdgpu_bo_reserve(robj, false);
> @@ -941,9 +941,9 @@ int amdgpu_mode_dumb_create(struct drm_file *file_pri=
v,
>         r =3D drm_gem_handle_create(file_priv, gobj, &handle);
>         /* drop reference from allocate - handle holds it now */
>         drm_gem_object_put(gobj);
> -       if (r) {
> +       if (r)
>                 return r;
> -       }
> +
>         args->handle =3D handle;
>         return 0;
>  }
> --
> 2.25.1
>
