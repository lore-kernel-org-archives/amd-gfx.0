Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB5D606A336
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 16:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jz+/4+YE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 024F710FC1F;
	Wed, 11 Nov 2026 16:49:56 +0000 (UTC)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87F6110EA98
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 16:49:49 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-36e90071735so121546eec.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 08:49:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794415789; cv=none;
 d=google.com; s=arc-20260327;
 b=YN3omURWzZoGAJUTyHTi2mK7U0JYh24yOjjiU5XyEQ2qYaVtbU+hDTslJ1czVWNQCP
 f97yt1M0GVO66UOmeKmKk+9ID+Uxk+J2QKJtw8vg/C5jQqQNp3Vm5IJclFRC1PNreVed
 cQCkFcBkp7uYGdjeZpM5hIN2uJlMvWDz3QeUmuDFkr1qdKLHaidANQ/YRYibHJT6DcC3
 6q/8CUAgSGir03bs0z6klTnmOcP2NVedmZ3s/crcpqb3k8Z6uRvnroUy1RjpAR7ToSrf
 FXs3hsfB3FF+zpYaBHQSyENvuxqXiWjkHnBmCaIXslePrCtULm4BEFiQQXxGjUR0ljrB
 RDpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3KSf5oiA7fw5PXAhjW9yvUP7uWd8t/r+AFUdm9OF7lQ=;
 fh=mu3vZXYZmZ8C5zo51o6kmAvMuWwdMezUK+4D5afwl+U=;
 b=nb2RBhm1YelSlN+7L9Uolt3kcOBzTrXAv2BDew+v4CAcjjL3b+3cXZO+z6rQYv4owj
 8eg8RMyKsC6oox+eGrQGLX4fqwCVRZGEkFpJ1OVz3CsCCne0dDb/iqZV22ce5zGJnHvW
 yhkCr1n4tywySFEL/sJBZ42ElXWr12Z2A0UL8CkWpjlFXX85LG5tRFpjdZFGaDAzTAGI
 NBS7WzZsg3LOyOGwi6ShXkUaNPiLlvmKLRlWskJ+ZW0cIHwMirOZuB8gHk2ef0EVCfb+
 dlAyxG08xjfQcU+3Hm2N+NZGQIXxynJnR4ZKNcYwPOiMDHjcDdQ9GWJ7AXvrlox5aISi
 NRbg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794415789; x=1795020589; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3KSf5oiA7fw5PXAhjW9yvUP7uWd8t/r+AFUdm9OF7lQ=;
 b=jz+/4+YEKdKN68vAsvlrCelY0c0B+zvqJKTgQG3LS1+m7/4Xu9L+D2Mu7bpDuyE5/i
 rEPnVGJmnqXoymerFQXrn+FiU7PqbopJ0ChkMRmNKsX1v1xr+xJgEWPZUMbG6or/GSHW
 dXvWs4guNRaNRTk0zlN4EViBLqiNEm0UdmG/Apbv/4hCO5GR8CoNBd2QdsDmdD5w2fKP
 qV82tYXfswSnt6napNfX2oNUOyGxLPHAXJnVHx2cUn9QkwWN+FoNjvYXcb7LRFopFdZQ
 Fs03W1B6rd4h0PfjeWmqHMMNy+jnS4C+jqo/58muOILYD3fCegBm5V4als0mgNN13wJE
 +35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794415789; x=1795020589;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3KSf5oiA7fw5PXAhjW9yvUP7uWd8t/r+AFUdm9OF7lQ=;
 b=Vhl8qW20n9e7tj8zz/xYnsRJAxX7VxiMYToBQRSqIeB8DI1HB4d9gLvdeKZ92tDrE/
 U3sS6oltkJt7tUbWpe5Mr31pxcsbdsdCm4s0FuI+bltbdpNBDlQcU75rRR9yuzUXjL4D
 zVP60oKm4rVNYMZxTPG6+0WSEUWob37Zmnr2KSz8FBqpKz/E81pJFpXpwiHPVUm/i+IA
 k2FR2ehaJmCLhbPiIAl+oFGNHZ1ThgiZXy6ur3Sko907O6a5C86B3G9vujI1+uGfgn2a
 835XtmtRPUXdRWUhua0dF8OSkpDCkLzsxyr1nYbwwuJbvm4zzMDpQru/uwnyIqhEuRJC
 er1A==
X-Forwarded-Encrypted: i=1;
 AL+hErFuo7A3Euwgdce5G5GJ30rnG7Ta9SRZlGhhYGUxAQP4IK1vz32J8DP3Dslz+B+1ShAiNr1iMCA7@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9EdAU5c6TXRk+UqhUA5jInZlZlx/DfvfDTBbULUxvNEKChAOBy
 7VJ4R1wd07axfzsDD1Nk+AK7sNeWLS8CTFo8tQq3EFDqgnD2nTFrVSiCyX1Wo9Lweqi54CgFrUw
 i2XcqE69iAVDCdO3fWAe5n9rxXHPmjo0=
X-Gm-Gg: AYBFou3PpYy3WrH1iU3FbU0iO44u0Rkh3hEOsUthv4wr7FISRrK1jQSpFNnc87lSsUQ
 MBtz6KG3AJ66RseU+ZEmGo1itI69qgutXtWPdmu46K56IQJHmp47RTZjXZBUVBdqozK6Bu1jWub
 4fz5xLdAUfMbomWYI/GD9SKHa3LS0fPvYRqOE41rSanxYfvbIyZYmAhiNecbyXSCcUlJfknn3h7
 HKbTeFRQPr9RuHhwAQYnMteezDA0tHOWDLOPdpfN+LwfvE7vS1FiinlCwBUwuLBGbmKznI/IL9b
 2kbCeSwn5PbfQGT3XtRZD0Vuzsr0OgZ5xtlQ5VFeNbVa2QfmWQyVRHst19LPcSYUQY1/BO0jy5J
 ovQdmxHVsmQbO/BW5mATELT1qqTyy2Mw9GGt7tbvc9wDbsM8oA56xuRzsRVGiOZRx9kXEFBmyIy
 A0u7X01WZPbTNCQKcW3nTDKoMSfQmKOpwqPkUZu8eiyBQLXnidYFBHkMGkVUg=
X-Received: by 2002:a05:701b:2402:b0:1b3:a881:a67b with SMTP id
 a92af1059eb24-1b3c02dedc1mr4147363c88.1.1794415788453; Wed, 11 Nov 2026
 08:49:48 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261106-amdgpu-dumb-map-offset-v2-1-0abfb77a84b8@gmail.com>
In-Reply-To: <20261106-amdgpu-dumb-map-offset-v2-1-0abfb77a84b8@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 Nov 2026 11:49:36 -0500
X-Gm-Features: AclHuK_GNVp6DqhleU8mNCij6RwE_xjeXa2cpadCyUXA99oBGwkzHbdnsMQTCJY
Message-ID: <CADnq5_OvGqVWG4BRi64EKO3_qEmS7VJiTuG158Og=XUPhYHJ_Q@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: use drm_gem_ttm_dumb_map_offset() for
 dumb_map_offset
To: saad <primecoder8@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed and applied.  Thanks!

Alex

On Fri, Nov 6, 2026 at 4:56=E2=80=AFAM saad <primecoder8@gmail.com> wrote:
>
> As part of the DRM TODO item "Remove custom dumb_map_offset
> implementations", switch amdgpu's &drm_driver.dumb_map_offset callback
> from the driver-specific amdgpu_mode_dumb_mmap() to the generic TTM
> helper drm_gem_ttm_dumb_map_offset(), for both amdgpu_kms_driver and
> amdgpu_partition_driver.
>
> amdgpu_mode_dumb_mmap() additionally rejected userptr BOs and BOs
> created with AMDGPU_GEM_CREATE_NO_CPU_ACCESS with -EPERM. Dropping
> those checks from the dumb path does not allow such BOs to be mapped:
> returning an offset does not create a mapping, and the actual mmap()
> goes through drm_gem_mmap() -> amdgpu_gem_object_mmap(), which performs
> the same two checks and still returns -EPERM. The only user-visible
> difference is that DRM_IOCTL_MODE_MAP_DUMB on such a handle now succeeds
> and the subsequent mmap() fails, instead of the ioctl failing. Dumb
> buffers created by amdgpu_mode_dumb_create() are never userptr BOs and
> always have AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED set, so they are not
> affected.
>
> With that, amdgpu_gem_mmap_ioctl() is the only remaining user of
> amdgpu_mode_dumb_mmap(), so fold it into the ioctl and drop its
> prototype from amdgpu_gem.h. DRM_IOCTL_AMDGPU_GEM_MMAP, used by
> libdrm_amdgpu and Mesa, keeps the userptr and NO_CPU_ACCESS checks
> and behaves as before.
>
> Build-tested with CONFIG_DRM_AMDGPU=3Dm (W=3D1 for amdgpu_drv.o and
> amdgpu_gem.o), no new warnings. Not runtime tested.
>
> The code change was written by hand and reviewed with the help of
> Claude (AI coding assistant); the commit message was written by Claude.
>
> Signed-off-by: saad <primecoder8@gmail.com>
> ---
> Changes in v2:
> - Fold amdgpu_mode_dumb_mmap() into amdgpu_gem_mmap_ioctl() and drop its
>   prototype, as it has no other users (Sashiko)
> - Link to v1: https://lore.kernel.org/r/20261105-amdgpu-dumb-map-offset-v=
1-1-7299d94ede11@gmail.com
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  5 +++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 23 +++++++++--------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h |  3 ---
>  3 files changed, 12 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 731fe8f9e..134d2fe4b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -27,6 +27,7 @@
>  #include <drm/drm_drv.h>
>  #include <drm/drm_fbdev_ttm.h>
>  #include <drm/drm_gem.h>
> +#include <drm/drm_gem_ttm_helper.h>
>  #include <drm/drm_managed.h>
>  #include <drm/drm_pciids.h>
>  #include <drm/drm_probe_helper.h>
> @@ -3151,7 +3152,7 @@ static const struct drm_driver amdgpu_kms_driver =
=3D {
>         .ioctls =3D amdgpu_ioctls_kms,
>         .num_ioctls =3D ARRAY_SIZE(amdgpu_ioctls_kms),
>         .dumb_create =3D amdgpu_mode_dumb_create,
> -       .dumb_map_offset =3D amdgpu_mode_dumb_mmap,
> +       .dumb_map_offset =3D drm_gem_ttm_dumb_map_offset,
>         DRM_FBDEV_TTM_DRIVER_OPS,
>         .fops =3D &amdgpu_driver_kms_fops,
>         .release =3D &amdgpu_driver_release_kms,
> @@ -3177,7 +3178,7 @@ const struct drm_driver amdgpu_partition_driver =3D=
 {
>         .ioctls =3D amdgpu_ioctls_kms,
>         .num_ioctls =3D ARRAY_SIZE(amdgpu_ioctls_kms),
>         .dumb_create =3D amdgpu_mode_dumb_create,
> -       .dumb_map_offset =3D amdgpu_mode_dumb_mmap,
> +       .dumb_map_offset =3D drm_gem_ttm_dumb_map_offset,
>         DRM_FBDEV_TTM_DRIVER_OPS,
>         .fops =3D &amdgpu_driver_kms_fops,
>         .release =3D &amdgpu_driver_release_kms,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.c
> index 4ed1706d8..2a72bdf2d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -644,13 +644,16 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev=
, void *data,
>         return r;
>  }
>
> -int amdgpu_mode_dumb_mmap(struct drm_file *filp,
> -                         struct drm_device *dev,
> -                         uint32_t handle, uint64_t *offset_p)
> +int amdgpu_gem_mmap_ioctl(struct drm_device *dev, void *data,
> +                         struct drm_file *filp)
>  {
> +       union drm_amdgpu_gem_mmap *args =3D data;
> +       uint32_t handle =3D args->in.handle;
>         struct drm_gem_object *gobj;
>         struct amdgpu_bo *robj;
>
> +       memset(args, 0, sizeof(*args));
> +
>         gobj =3D drm_gem_object_lookup(filp, handle);
>         if (!gobj)
>                 return -ENOENT;
> @@ -661,19 +664,11 @@ int amdgpu_mode_dumb_mmap(struct drm_file *filp,
>                 drm_gem_object_put(gobj);
>                 return -EPERM;
>         }
> -       *offset_p =3D amdgpu_bo_mmap_offset(robj);
> -       drm_gem_object_put(gobj);
> -       return 0;
> -}
>
> -int amdgpu_gem_mmap_ioctl(struct drm_device *dev, void *data,
> -                         struct drm_file *filp)
> -{
> -       union drm_amdgpu_gem_mmap *args =3D data;
> -       uint32_t handle =3D args->in.handle;
> +       args->out.addr_ptr =3D amdgpu_bo_mmap_offset(robj);
> +       drm_gem_object_put(gobj);
>
> -       memset(args, 0, sizeof(*args));
> -       return amdgpu_mode_dumb_mmap(filp, dev, handle, &args->out.addr_p=
tr);
> +       return 0;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.h
> index b558336bc..718ffe229 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> @@ -49,9 +49,6 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev=
, unsigned long size,
>  int amdgpu_mode_dumb_create(struct drm_file *file_priv,
>                             struct drm_device *dev,
>                             struct drm_mode_create_dumb *args);
> -int amdgpu_mode_dumb_mmap(struct drm_file *filp,
> -                         struct drm_device *dev,
> -                         uint32_t handle, uint64_t *offset_p);
>
>  int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>                             struct drm_file *filp);
>
> ---
> base-commit: 279235273fc6c0a33df863b4a1cc52ec1e73aba5
> change-id: 20261105-amdgpu-dumb-map-offset-6fa41e8d3fb5
>
> Best regards,
> --
> saad <primecoder8@gmail.com>
>
