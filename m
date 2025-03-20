Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56179C28B30
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 13:04:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 082C510E39E;
	Thu, 20 Mar 2025 13:04:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nZR3qAGx";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7235610E39B
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 13:04:21 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-2ff67f44fcaso184641a91.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 06:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742475861; x=1743080661; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WDpQOs58iG53kaYVrEZ0oTRRZWOq+OksOVLojzzW85E=;
 b=nZR3qAGxjTLDkjh5+bL/vhl8Rs0Ee9D7TNWsPHAavrlne+A8e9q/5IeJRO9QuNE/6k
 YBcsME/98V67kv5Dk/rG12SIsaqtLh/WiiReRwXT1sMGC4wEDOi5/udqbH6jt/IE+b1C
 wwtnHkm2PTH+c20IgT6Kqu1oYJdf4BDUbOJ6RPyKOy4GcyH4mah21P4xmezfwVfctcac
 hgG0gIr2ytFUfXXHYg7zS0NV8lln6ti+4K8mfDKk3DvUnbmYNjJ6R2/RXe41/c8lew/0
 HdpBfNXfY9m6yhkuKW+DgWLpADg9C0tqSAYV1QF+xlf595YYYSZZGH1aUCy0tbGkQ5Ca
 PhMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742475861; x=1743080661;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WDpQOs58iG53kaYVrEZ0oTRRZWOq+OksOVLojzzW85E=;
 b=JKT3W8jn/gG12CCBu0NWbPzFjCYP1Yaj+s45Dy8gEGba21bmd8NHNoXCeTdMs2L+De
 zKGJnCL2f+NWNAI+Ldk2KvSTDgkcfOcB8RV64IBVU2urLH9JdRpCY7rbFK+VTKb/BkkB
 8wzkaSRj7MJaRrBpkOfhKxAkfRqWlcftnJPTES88Jvpk/M2Ab+jksqUM5Hu/OiaW9ysx
 kjnbpdi92A3YzLTZ5ALoV+3UNisFgiDDCTkbSNJmthHH9ZBZ2q/yNvah5tHABpg94lpO
 YiAmjsP2K5c07AzoHHf24O3bLjpj1sy7L0hrkBFlL1DLW6iXGuhM/j+lqRy2X+aMR/9/
 OWaQ==
X-Gm-Message-State: AOJu0YyzegC5g5zH+chLmC7yB4TNMUm7qpTMmMGn2PWCpYArzCdD2/cP
 eOWJdqKHCgJlsZHhMl7Oqpy51yFdpzmnHWuvxtpHr995x7ACBBWw3KVGlJL/XWSL4ajyUCQH1TJ
 I5NZwsbb0Hfhjg2yeL9cRTbIYkDbPrZOd
X-Gm-Gg: ASbGnctOAhUPTA4YyV3keVc6ilnuUMosQujkYpveMuDx3rURYnOWIH8ntnjaL2NuVwQ
 qd++za56F3xytql59azZw14PHP/L4m88Cyae8pa16clwybsRIX91M7JaPc2+tbe+Csj0YqdNJ0L
 o8hSakxOhKL1LWGZQeznmrxnzO70r50z40i5cN
X-Google-Smtp-Source: AGHT+IHZPK2+ThdFurXo2AeaFdh8MbFYBWUb2CPNSO1K4+0xaC6YSGI4S1ChtvnOz+bUzCmdnnhZmPQMhGM2Jew4+xQ=
X-Received: by 2002:a17:90b:1e53:b0:2ff:6bcf:5411 with SMTP id
 98e67ed59e1d1-301bfbd33acmr3414673a91.1.1742475860180; Thu, 20 Mar 2025
 06:04:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250320130251.2089-1-christian.koenig@amd.com>
In-Reply-To: <20250320130251.2089-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 Mar 2025 09:04:08 -0400
X-Gm-Features: AQ5f1JrER-g_pYxoqKrolv5Y7AOeTvJoXRAbGbk4Kmuj4KBxB8hROxR1zKMGcXU
Message-ID: <CADnq5_M9vB+cQPgphbinWURTUdowQgLv5+t+sqzUgkY25JJftA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: stop unmapping MQD for kernel queues v2
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Thu, Mar 20, 2025 at 9:02=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> This looks unnecessary and actually extremely harmful since using kmap()
> is not possible while inside the ring reset.
>
> Remove all the extra mapping and unmapping of the MQDs.
>
> v2: also fix debugfs
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com> (v1)

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c |  58 ++-----------
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |  88 +++----------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   |  88 +++----------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   | 102 ++++-------------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    |  45 ++--------
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  57 ++-----------
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  |  61 +++-----------
>  7 files changed, 67 insertions(+), 432 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ring.c
> index ba8f2785865a..c877769f0883 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -572,59 +572,17 @@ static ssize_t amdgpu_debugfs_mqd_read(struct file =
*f, char __user *buf,
>                                        size_t size, loff_t *pos)
>  {
>         struct amdgpu_ring *ring =3D file_inode(f)->i_private;
> -       volatile u32 *mqd;
> -       u32 *kbuf;
> -       int r, i;
> -       uint32_t value, result;
> +       ssize_t bytes =3D min_t(ssize_t, ring->mqd_size - *pos, size);
> +       void *from =3D ((u8*)ring->mqd_ptr) + *pos;
>
> -       if (*pos & 3 || size & 3)
> -               return -EINVAL;
> -
> -       kbuf =3D kmalloc(ring->mqd_size, GFP_KERNEL);
> -       if (!kbuf)
> -               return -ENOMEM;
> -
> -       r =3D amdgpu_bo_reserve(ring->mqd_obj, false);
> -       if (unlikely(r !=3D 0))
> -               goto err_free;
> -
> -       r =3D amdgpu_bo_kmap(ring->mqd_obj, (void **)&mqd);
> -       if (r)
> -               goto err_unreserve;
> -
> -       /*
> -        * Copy to local buffer to avoid put_user(), which might fault
> -        * and acquire mmap_sem, under reservation_ww_class_mutex.
> -        */
> -       for (i =3D 0; i < ring->mqd_size/sizeof(u32); i++)
> -               kbuf[i] =3D mqd[i];
> +       if (*pos > ring->mqd_size)
> +               return 0;
>
> -       amdgpu_bo_kunmap(ring->mqd_obj);
> -       amdgpu_bo_unreserve(ring->mqd_obj);
> +       if (copy_to_user(buf, from, bytes))
> +               return -EFAULT;
>
> -       result =3D 0;
> -       while (size) {
> -               if (*pos >=3D ring->mqd_size)
> -                       break;
> -
> -               value =3D kbuf[*pos/4];
> -               r =3D put_user(value, (uint32_t *)buf);
> -               if (r)
> -                       goto err_free;
> -               buf +=3D 4;
> -               result +=3D 4;
> -               size -=3D 4;
> -               *pos +=3D 4;
> -       }
> -
> -       kfree(kbuf);
> -       return result;
> -
> -err_unreserve:
> -       amdgpu_bo_unreserve(ring->mqd_obj);
> -err_free:
> -       kfree(kbuf);
> -       return r;
> +       *pos +=3D bytes;
> +       return bytes;
>  }
>
>  static const struct file_operations amdgpu_debugfs_mqd_fops =3D {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v10_0.c
> index 6d514efb0a6d..a63ce747863f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -6851,22 +6851,9 @@ static int gfx_v10_0_kgq_init_queue(struct amdgpu_=
ring *ring, bool reset)
>  static int gfx_v10_0_cp_async_gfx_ring_resume(struct amdgpu_device *adev=
)
>  {
>         int r, i;
> -       struct amdgpu_ring *ring;
>
>         for (i =3D 0; i < adev->gfx.num_gfx_rings; i++) {
> -               ring =3D &adev->gfx.gfx_ring[i];
> -
> -               r =3D amdgpu_bo_reserve(ring->mqd_obj, false);
> -               if (unlikely(r !=3D 0))
> -                       return r;
> -
> -               r =3D amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_p=
tr);
> -               if (!r) {
> -                       r =3D gfx_v10_0_kgq_init_queue(ring, false);
> -                       amdgpu_bo_kunmap(ring->mqd_obj);
> -                       ring->mqd_ptr =3D NULL;
> -               }
> -               amdgpu_bo_unreserve(ring->mqd_obj);
> +               r =3D gfx_v10_0_kgq_init_queue(&adev->gfx.gfx_ring[i], fa=
lse);
>                 if (r)
>                         return r;
>         }
> @@ -7173,55 +7160,24 @@ static int gfx_v10_0_kcq_init_queue(struct amdgpu=
_ring *ring, bool restore)
>
>  static int gfx_v10_0_kiq_resume(struct amdgpu_device *adev)
>  {
> -       struct amdgpu_ring *ring;
> -       int r;
> -
> -       ring =3D &adev->gfx.kiq[0].ring;
> -
> -       r =3D amdgpu_bo_reserve(ring->mqd_obj, false);
> -       if (unlikely(r !=3D 0))
> -               return r;
> -
> -       r =3D amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
> -       if (unlikely(r !=3D 0)) {
> -               amdgpu_bo_unreserve(ring->mqd_obj);
> -               return r;
> -       }
> -
> -       gfx_v10_0_kiq_init_queue(ring);
> -       amdgpu_bo_kunmap(ring->mqd_obj);
> -       ring->mqd_ptr =3D NULL;
> -       amdgpu_bo_unreserve(ring->mqd_obj);
> +       gfx_v10_0_kiq_init_queue(&adev->gfx.kiq[0].ring);
>         return 0;
>  }
>
>  static int gfx_v10_0_kcq_resume(struct amdgpu_device *adev)
>  {
> -       struct amdgpu_ring *ring =3D NULL;
> -       int r =3D 0, i;
> +       int i, r;
>
>         gfx_v10_0_cp_compute_enable(adev, true);
>
>         for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
> -               ring =3D &adev->gfx.compute_ring[i];
> -
> -               r =3D amdgpu_bo_reserve(ring->mqd_obj, false);
> -               if (unlikely(r !=3D 0))
> -                       goto done;
> -               r =3D amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_p=
tr);
> -               if (!r) {
> -                       r =3D gfx_v10_0_kcq_init_queue(ring, false);
> -                       amdgpu_bo_kunmap(ring->mqd_obj);
> -                       ring->mqd_ptr =3D NULL;
> -               }
> -               amdgpu_bo_unreserve(ring->mqd_obj);
> +               r =3D gfx_v10_0_kcq_init_queue(&adev->gfx.compute_ring[i]=
,
> +                                            false);
>                 if (r)
> -                       goto done;
> +                       return r;
>         }
>
> -       r =3D amdgpu_gfx_enable_kcq(adev, 0);
> -done:
> -       return r;
> +       return amdgpu_gfx_enable_kcq(adev, 0);
>  }
>
>  static int gfx_v10_0_cp_resume(struct amdgpu_device *adev)
> @@ -9579,20 +9535,9 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring =
*ring, unsigned int vmid)
>         if (r)
>                 return r;
>
> -       r =3D amdgpu_bo_reserve(ring->mqd_obj, false);
> -       if (unlikely(r !=3D 0)) {
> -               DRM_ERROR("fail to resv mqd_obj\n");
> -               return r;
> -       }
> -       r =3D amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
> -       if (!r) {
> -               r =3D gfx_v10_0_kgq_init_queue(ring, true);
> -               amdgpu_bo_kunmap(ring->mqd_obj);
> -               ring->mqd_ptr =3D NULL;
> -       }
> -       amdgpu_bo_unreserve(ring->mqd_obj);
> +       r =3D gfx_v10_0_kgq_init_queue(ring, true);
>         if (r) {
> -               DRM_ERROR("fail to unresv mqd_obj\n");
> +               DRM_ERROR("fail to init kgq\n");
>                 return r;
>         }
>
> @@ -9649,20 +9594,9 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring =
*ring,
>                 return r;
>         }
>
> -       r =3D amdgpu_bo_reserve(ring->mqd_obj, false);
> -       if (unlikely(r !=3D 0)) {
> -               dev_err(adev->dev, "fail to resv mqd_obj\n");
> -               return r;
> -       }
> -       r =3D amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
> -       if (!r) {
> -               r =3D gfx_v10_0_kcq_init_queue(ring, true);
> -               amdgpu_bo_kunmap(ring->mqd_obj);
> -               ring->mqd_ptr =3D NULL;
> -       }
> -       amdgpu_bo_unreserve(ring->mqd_obj);
> +       r =3D gfx_v10_0_kcq_init_queue(ring, true);
>         if (r) {
> -               dev_err(adev->dev, "fail to unresv mqd_obj\n");
> +               dev_err(adev->dev, "fail to init kcq\n");
>                 return r;
>         }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 8261308fc1f2..91afb7d5929a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -4117,22 +4117,9 @@ static int gfx_v11_0_kgq_init_queue(struct amdgpu_=
ring *ring, bool reset)
>  static int gfx_v11_0_cp_async_gfx_ring_resume(struct amdgpu_device *adev=
)
>  {
>         int r, i;
> -       struct amdgpu_ring *ring;
>
>         for (i =3D 0; i < adev->gfx.num_gfx_rings; i++) {
> -               ring =3D &adev->gfx.gfx_ring[i];
> -
> -               r =3D amdgpu_bo_reserve(ring->mqd_obj, false);
> -               if (unlikely(r !=3D 0))
> -                       return r;
> -
> -               r =3D amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_p=
tr);
> -               if (!r) {
> -                       r =3D gfx_v11_0_kgq_init_queue(ring, false);
> -                       amdgpu_bo_kunmap(ring->mqd_obj);
> -                       ring->mqd_ptr =3D NULL;
> -               }
> -               amdgpu_bo_unreserve(ring->mqd_obj);
> +               r =3D gfx_v11_0_kgq_init_queue(&adev->gfx.gfx_ring[i], fa=
lse);
>                 if (r)
>                         return r;
>         }
> @@ -4458,57 +4445,24 @@ static int gfx_v11_0_kcq_init_queue(struct amdgpu=
_ring *ring, bool reset)
>
>  static int gfx_v11_0_kiq_resume(struct amdgpu_device *adev)
>  {
> -       struct amdgpu_ring *ring;
> -       int r;
> -
> -       ring =3D &adev->gfx.kiq[0].ring;
> -
> -       r =3D amdgpu_bo_reserve(ring->mqd_obj, false);
> -       if (unlikely(r !=3D 0))
> -               return r;
> -
> -       r =3D amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
> -       if (unlikely(r !=3D 0)) {
> -               amdgpu_bo_unreserve(ring->mqd_obj);
> -               return r;
> -       }
> -
> -       gfx_v11_0_kiq_init_queue(ring);
> -       amdgpu_bo_kunmap(ring->mqd_obj);
> -       ring->mqd_ptr =3D NULL;
> -       amdgpu_bo_unreserve(ring->mqd_obj);
> -       ring->sched.ready =3D true;
> +       gfx_v11_0_kiq_init_queue(&adev->gfx.kiq[0].ring);
>         return 0;
>  }
>
>  static int gfx_v11_0_kcq_resume(struct amdgpu_device *adev)
>  {
> -       struct amdgpu_ring *ring =3D NULL;
> -       int r =3D 0, i;
> +       int i, r;
>
>         if (!amdgpu_async_gfx_ring)
>                 gfx_v11_0_cp_compute_enable(adev, true);
>
>         for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
> -               ring =3D &adev->gfx.compute_ring[i];
> -
> -               r =3D amdgpu_bo_reserve(ring->mqd_obj, false);
> -               if (unlikely(r !=3D 0))
> -                       goto done;
> -               r =3D amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_p=
tr);
> -               if (!r) {
> -                       r =3D gfx_v11_0_kcq_init_queue(ring, false);
> -                       amdgpu_bo_kunmap(ring->mqd_obj);
> -                       ring->mqd_ptr =3D NULL;
> -               }
> -               amdgpu_bo_unreserve(ring->mqd_obj);
> +               r =3D gfx_v11_0_kcq_init_queue(&adev->gfx.compute_ring[i]=
, false);
>                 if (r)
> -                       goto done;
> +                       return r;
>         }
>
> -       r =3D amdgpu_gfx_enable_kcq(adev, 0);
> -done:
> -       return r;
> +       return amdgpu_gfx_enable_kcq(adev, 0);
>  }
>
>  static int gfx_v11_0_cp_resume(struct amdgpu_device *adev)
> @@ -6644,20 +6598,9 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring =
*ring, unsigned int vmid)
>         if (r)
>                 return r;
>
> -       r =3D amdgpu_bo_reserve(ring->mqd_obj, false);
> -       if (unlikely(r !=3D 0)) {
> -               dev_err(adev->dev, "fail to resv mqd_obj\n");
> -               return r;
> -       }
> -       r =3D amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
> -       if (!r) {
> -               r =3D gfx_v11_0_kgq_init_queue(ring, true);
> -               amdgpu_bo_kunmap(ring->mqd_obj);
> -               ring->mqd_ptr =3D NULL;
> -       }
> -       amdgpu_bo_unreserve(ring->mqd_obj);
> +       r =3D gfx_v11_0_kgq_init_queue(ring, true);
>         if (r) {
> -               dev_err(adev->dev, "fail to unresv mqd_obj\n");
> +               dev_err(adev->dev, "failed to init kgq\n");
>                 return r;
>         }
>
> @@ -6684,20 +6627,9 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring =
*ring, unsigned int vmid)
>                 return r;
>         }
>
> -       r =3D amdgpu_bo_reserve(ring->mqd_obj, false);
> -       if (unlikely(r !=3D 0)) {
> -               dev_err(adev->dev, "fail to resv mqd_obj\n");
> -               return r;
> -       }
> -       r =3D amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
> -       if (!r) {
> -               r =3D gfx_v11_0_kcq_init_queue(ring, true);
> -               amdgpu_bo_kunmap(ring->mqd_obj);
> -               ring->mqd_ptr =3D NULL;
> -       }
> -       amdgpu_bo_unreserve(ring->mqd_obj);
> +       r =3D gfx_v11_0_kcq_init_queue(ring, true);
>         if (r) {
> -               dev_err(adev->dev, "fail to unresv mqd_obj\n");
> +               dev_err(adev->dev, "fail to init kcq\n");
>                 return r;
>         }
>         r =3D amdgpu_mes_map_legacy_queue(adev, ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index 85dc6d8f0571..80a16cc13e80 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -3030,37 +3030,19 @@ static int gfx_v12_0_kgq_init_queue(struct amdgpu=
_ring *ring, bool reset)
>
>  static int gfx_v12_0_cp_async_gfx_ring_resume(struct amdgpu_device *adev=
)
>  {
> -       int r, i;
> -       struct amdgpu_ring *ring;
> +       int i, r;
>
>         for (i =3D 0; i < adev->gfx.num_gfx_rings; i++) {
> -               ring =3D &adev->gfx.gfx_ring[i];
> -
> -               r =3D amdgpu_bo_reserve(ring->mqd_obj, false);
> -               if (unlikely(r !=3D 0))
> -                       goto done;
> -
> -               r =3D amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_p=
tr);
> -               if (!r) {
> -                       r =3D gfx_v12_0_kgq_init_queue(ring, false);
> -                       amdgpu_bo_kunmap(ring->mqd_obj);
> -                       ring->mqd_ptr =3D NULL;
> -               }
> -               amdgpu_bo_unreserve(ring->mqd_obj);
> +               r =3D gfx_v12_0_kgq_init_queue(&adev->gfx.gfx_ring[i], fa=
lse);
>                 if (r)
> -                       goto done;
> +                       return r;
>         }
>
>         r =3D amdgpu_gfx_enable_kgq(adev, 0);
>         if (r)
> -               goto done;
> -
> -       r =3D gfx_v12_0_cp_gfx_start(adev);
> -       if (r)
> -               goto done;
> +               return r;
>
> -done:
> -       return r;
> +       return gfx_v12_0_cp_gfx_start(adev);
>  }
>
>  static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *=
m,
> @@ -3377,57 +3359,25 @@ static int gfx_v12_0_kcq_init_queue(struct amdgpu=
_ring *ring, bool reset)
>
>  static int gfx_v12_0_kiq_resume(struct amdgpu_device *adev)
>  {
> -       struct amdgpu_ring *ring;
> -       int r;
> -
> -       ring =3D &adev->gfx.kiq[0].ring;
> -
> -       r =3D amdgpu_bo_reserve(ring->mqd_obj, false);
> -       if (unlikely(r !=3D 0))
> -               return r;
> -
> -       r =3D amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
> -       if (unlikely(r !=3D 0)) {
> -               amdgpu_bo_unreserve(ring->mqd_obj);
> -               return r;
> -       }
> -
> -       gfx_v12_0_kiq_init_queue(ring);
> -       amdgpu_bo_kunmap(ring->mqd_obj);
> -       ring->mqd_ptr =3D NULL;
> -       amdgpu_bo_unreserve(ring->mqd_obj);
> -       ring->sched.ready =3D true;
> +       gfx_v12_0_kiq_init_queue(&adev->gfx.kiq[0].ring);
> +       adev->gfx.kiq[0].ring.sched.ready =3D true;
>         return 0;
>  }
>
>  static int gfx_v12_0_kcq_resume(struct amdgpu_device *adev)
>  {
> -       struct amdgpu_ring *ring =3D NULL;
> -       int r =3D 0, i;
> +       int i, r;
>
>         if (!amdgpu_async_gfx_ring)
>                 gfx_v12_0_cp_compute_enable(adev, true);
>
>         for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
> -               ring =3D &adev->gfx.compute_ring[i];
> -
> -               r =3D amdgpu_bo_reserve(ring->mqd_obj, false);
> -               if (unlikely(r !=3D 0))
> -                       goto done;
> -               r =3D amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_p=
tr);
> -               if (!r) {
> -                       r =3D gfx_v12_0_kcq_init_queue(ring, false);
> -                       amdgpu_bo_kunmap(ring->mqd_obj);
> -                       ring->mqd_ptr =3D NULL;
> -               }
> -               amdgpu_bo_unreserve(ring->mqd_obj);
> +               r =3D gfx_v12_0_kcq_init_queue(&adev->gfx.compute_ring[i]=
, false);
>                 if (r)
> -                       goto done;
> +                       return r;
>         }
>
> -       r =3D amdgpu_gfx_enable_kcq(adev, 0);
> -done:
> -       return r;
> +       return amdgpu_gfx_enable_kcq(adev, 0);
>  }
>
>  static int gfx_v12_0_cp_resume(struct amdgpu_device *adev)
> @@ -5187,20 +5137,9 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring =
*ring, unsigned int vmid)
>                 return r;
>         }
>
> -       r =3D amdgpu_bo_reserve(ring->mqd_obj, false);
> -       if (unlikely(r !=3D 0)) {
> -               dev_err(adev->dev, "fail to resv mqd_obj\n");
> -               return r;
> -       }
> -       r =3D amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
> -       if (!r) {
> -               r =3D gfx_v12_0_kgq_init_queue(ring, true);
> -               amdgpu_bo_kunmap(ring->mqd_obj);
> -               ring->mqd_ptr =3D NULL;
> -       }
> -       amdgpu_bo_unreserve(ring->mqd_obj);
> +       r =3D gfx_v12_0_kgq_init_queue(ring, true);
>         if (r) {
> -               DRM_ERROR("fail to unresv mqd_obj\n");
> +               dev_err(adev->dev, "failed to init kgq\n");
>                 return r;
>         }
>
> @@ -5227,20 +5166,9 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring =
*ring, unsigned int vmid)
>                 return r;
>         }
>
> -       r =3D amdgpu_bo_reserve(ring->mqd_obj, false);
> -       if (unlikely(r !=3D 0)) {
> -               DRM_ERROR("fail to resv mqd_obj\n");
> -               return r;
> -       }
> -       r =3D amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
> -       if (!r) {
> -               r =3D gfx_v12_0_kcq_init_queue(ring, true);
> -               amdgpu_bo_kunmap(ring->mqd_obj);
> -               ring->mqd_ptr =3D NULL;
> -       }
> -       amdgpu_bo_unreserve(ring->mqd_obj);
> +       r =3D gfx_v12_0_kcq_init_queue(ring, true);
>         if (r) {
> -               DRM_ERROR("fail to unresv mqd_obj\n");
> +               dev_err(adev->dev, "failed to init kcq\n");
>                 return r;
>         }
>         r =3D amdgpu_mes_map_legacy_queue(adev, ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v8_0.c
> index d116a2e2f469..bfedd487efc5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -4683,60 +4683,25 @@ static void gfx_v8_0_set_mec_doorbell_range(struc=
t amdgpu_device *adev)
>
>  static int gfx_v8_0_kiq_resume(struct amdgpu_device *adev)
>  {
> -       struct amdgpu_ring *ring;
> -       int r;
> -
> -       ring =3D &adev->gfx.kiq[0].ring;
> -
> -       r =3D amdgpu_bo_reserve(ring->mqd_obj, false);
> -       if (unlikely(r !=3D 0))
> -               return r;
> -
> -       r =3D amdgpu_bo_kmap(ring->mqd_obj, &ring->mqd_ptr);
> -       if (unlikely(r !=3D 0)) {
> -               amdgpu_bo_unreserve(ring->mqd_obj);
> -               return r;
> -       }
> -
> -       gfx_v8_0_kiq_init_queue(ring);
> -       amdgpu_bo_kunmap(ring->mqd_obj);
> -       ring->mqd_ptr =3D NULL;
> -       amdgpu_bo_unreserve(ring->mqd_obj);
> +       gfx_v8_0_kiq_init_queue(&adev->gfx.kiq[0].ring);
>         return 0;
>  }
>
>  static int gfx_v8_0_kcq_resume(struct amdgpu_device *adev)
>  {
> -       struct amdgpu_ring *ring =3D NULL;
> -       int r =3D 0, i;
> +       int i, r;
>
>         gfx_v8_0_cp_compute_enable(adev, true);
>
>         for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
> -               ring =3D &adev->gfx.compute_ring[i];
> -
> -               r =3D amdgpu_bo_reserve(ring->mqd_obj, false);
> -               if (unlikely(r !=3D 0))
> -                       goto done;
> -               r =3D amdgpu_bo_kmap(ring->mqd_obj, &ring->mqd_ptr);
> -               if (!r) {
> -                       r =3D gfx_v8_0_kcq_init_queue(ring);
> -                       amdgpu_bo_kunmap(ring->mqd_obj);
> -                       ring->mqd_ptr =3D NULL;
> -               }
> -               amdgpu_bo_unreserve(ring->mqd_obj);
> +               r =3D gfx_v8_0_kcq_init_queue(&adev->gfx.compute_ring[i])=
;
>                 if (r)
> -                       goto done;
> +                       return r;
>         }
>
>         gfx_v8_0_set_mec_doorbell_range(adev);
>
> -       r =3D gfx_v8_0_kiq_kcq_enable(adev);
> -       if (r)
> -               goto done;
> -
> -done:
> -       return r;
> +       return gfx_v8_0_kiq_kcq_enable(adev);
>  }
>
>  static int gfx_v8_0_cp_test_all_rings(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index 5bf9d27d1ead..3e87a234d4b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -3890,55 +3890,23 @@ static int gfx_v9_0_kcq_init_queue(struct amdgpu_=
ring *ring, bool restore)
>
>  static int gfx_v9_0_kiq_resume(struct amdgpu_device *adev)
>  {
> -       struct amdgpu_ring *ring;
> -       int r;
> -
> -       ring =3D &adev->gfx.kiq[0].ring;
> -
> -       r =3D amdgpu_bo_reserve(ring->mqd_obj, false);
> -       if (unlikely(r !=3D 0))
> -               return r;
> -
> -       r =3D amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
> -       if (unlikely(r !=3D 0)) {
> -               amdgpu_bo_unreserve(ring->mqd_obj);
> -               return r;
> -       }
> -
> -       gfx_v9_0_kiq_init_queue(ring);
> -       amdgpu_bo_kunmap(ring->mqd_obj);
> -       ring->mqd_ptr =3D NULL;
> -       amdgpu_bo_unreserve(ring->mqd_obj);
> +       gfx_v9_0_kiq_init_queue(&adev->gfx.kiq[0].ring);
>         return 0;
>  }
>
>  static int gfx_v9_0_kcq_resume(struct amdgpu_device *adev)
>  {
> -       struct amdgpu_ring *ring =3D NULL;
> -       int r =3D 0, i;
> +       int i, r;
>
>         gfx_v9_0_cp_compute_enable(adev, true);
>
>         for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
> -               ring =3D &adev->gfx.compute_ring[i];
> -
> -               r =3D amdgpu_bo_reserve(ring->mqd_obj, false);
> -               if (unlikely(r !=3D 0))
> -                       goto done;
> -               r =3D amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_p=
tr);
> -               if (!r) {
> -                       r =3D gfx_v9_0_kcq_init_queue(ring, false);
> -                       amdgpu_bo_kunmap(ring->mqd_obj);
> -                       ring->mqd_ptr =3D NULL;
> -               }
> -               amdgpu_bo_unreserve(ring->mqd_obj);
> +               r =3D gfx_v9_0_kcq_init_queue(&adev->gfx.compute_ring[i],=
 false);
>                 if (r)
> -                       goto done;
> +                       return r;
>         }
>
> -       r =3D amdgpu_gfx_enable_kcq(adev, 0);
> -done:
> -       return r;
> +       return amdgpu_gfx_enable_kcq(adev, 0);
>  }
>
>  static int gfx_v9_0_cp_resume(struct amdgpu_device *adev)
> @@ -7278,20 +7246,9 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *=
ring,
>                 return r;
>         }
>
> -       r =3D amdgpu_bo_reserve(ring->mqd_obj, false);
> -       if (unlikely(r !=3D 0)){
> -               dev_err(adev->dev, "fail to resv mqd_obj\n");
> -               return r;
> -       }
> -       r =3D amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
> -       if (!r) {
> -               r =3D gfx_v9_0_kcq_init_queue(ring, true);
> -               amdgpu_bo_kunmap(ring->mqd_obj);
> -               ring->mqd_ptr =3D NULL;
> -       }
> -       amdgpu_bo_unreserve(ring->mqd_obj);
> +       r =3D gfx_v9_0_kcq_init_queue(ring, true);
>         if (r) {
> -               dev_err(adev->dev, "fail to unresv mqd_obj\n");
> +               dev_err(adev->dev, "fail to init kcq\n");
>                 return r;
>         }
>         spin_lock_irqsave(&kiq->ring_lock, flags);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_4_3.c
> index efe45e4edfd7..bfd3efe8ebe4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -2169,55 +2169,27 @@ static int gfx_v9_4_3_xcc_kcq_fini_register(struc=
t amdgpu_device *adev, int xcc_
>
>  static int gfx_v9_4_3_xcc_kiq_resume(struct amdgpu_device *adev, int xcc=
_id)
>  {
> -       struct amdgpu_ring *ring;
> -       int r;
> -
> -       ring =3D &adev->gfx.kiq[xcc_id].ring;
> -
> -       r =3D amdgpu_bo_reserve(ring->mqd_obj, false);
> -       if (unlikely(r !=3D 0))
> -               return r;
> -
> -       r =3D amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
> -       if (unlikely(r !=3D 0)) {
> -               amdgpu_bo_unreserve(ring->mqd_obj);
> -               return r;
> -       }
> -
> -       gfx_v9_4_3_xcc_kiq_init_queue(ring, xcc_id);
> -       amdgpu_bo_kunmap(ring->mqd_obj);
> -       ring->mqd_ptr =3D NULL;
> -       amdgpu_bo_unreserve(ring->mqd_obj);
> +       gfx_v9_4_3_xcc_kiq_init_queue(&adev->gfx.kiq[xcc_id].ring, xcc_id=
);
>         return 0;
>  }
>
>  static int gfx_v9_4_3_xcc_kcq_resume(struct amdgpu_device *adev, int xcc=
_id)
>  {
> -       struct amdgpu_ring *ring =3D NULL;
> -       int r =3D 0, i;
> +       struct amdgpu_ring *ring;
> +       int i, r;
>
>         gfx_v9_4_3_xcc_cp_compute_enable(adev, true, xcc_id);
>
>         for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
> -               ring =3D &adev->gfx.compute_ring[i + xcc_id * adev->gfx.n=
um_compute_rings];
> -
> -               r =3D amdgpu_bo_reserve(ring->mqd_obj, false);
> -               if (unlikely(r !=3D 0))
> -                       goto done;
> -               r =3D amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_p=
tr);
> -               if (!r) {
> -                       r =3D gfx_v9_4_3_xcc_kcq_init_queue(ring, xcc_id,=
 false);
> -                       amdgpu_bo_kunmap(ring->mqd_obj);
> -                       ring->mqd_ptr =3D NULL;
> -               }
> -               amdgpu_bo_unreserve(ring->mqd_obj);
> +               ring =3D &adev->gfx.compute_ring[i + xcc_id *
> +                       adev->gfx.num_compute_rings];
> +
> +               r =3D gfx_v9_4_3_xcc_kcq_init_queue(ring, xcc_id, false);
>                 if (r)
> -                       goto done;
> +                       return r;
>         }
>
> -       r =3D amdgpu_gfx_enable_kcq(adev, xcc_id);
> -done:
> -       return r;
> +       return amdgpu_gfx_enable_kcq(adev, xcc_id);
>  }
>
>  static int gfx_v9_4_3_xcc_cp_resume(struct amdgpu_device *adev, int xcc_=
id)
> @@ -3589,20 +3561,9 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring=
 *ring,
>                         return r;
>         }
>
> -       r =3D amdgpu_bo_reserve(ring->mqd_obj, false);
> -       if (unlikely(r !=3D 0)){
> -               dev_err(adev->dev, "fail to resv mqd_obj\n");
> -               return r;
> -       }
> -       r =3D amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
> -       if (!r) {
> -               r =3D gfx_v9_4_3_xcc_kcq_init_queue(ring, ring->xcc_id, t=
rue);
> -               amdgpu_bo_kunmap(ring->mqd_obj);
> -               ring->mqd_ptr =3D NULL;
> -       }
> -       amdgpu_bo_unreserve(ring->mqd_obj);
> +       r =3D gfx_v9_4_3_xcc_kcq_init_queue(ring, ring->xcc_id, true);
>         if (r) {
> -               dev_err(adev->dev, "fail to unresv mqd_obj\n");
> +               dev_err(adev->dev, "fail to init kcq\n");
>                 return r;
>         }
>         spin_lock_irqsave(&kiq->ring_lock, flags);
> --
> 2.34.1
>
