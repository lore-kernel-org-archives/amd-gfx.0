Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F10ED116F1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 13:49:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2125110E3EC;
	Mon,  1 Dec 2025 13:49:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CtZ3Q9AL";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9F9410E43C
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 13:49:24 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-7ab689d3fa0so329924b3a.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Dec 2025 05:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764596964; x=1765201764; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EnT45CYebmbcFY569GUSrC94ILduyx/dsHIu7yxmGjc=;
 b=CtZ3Q9ALtd5d6fJVkTzeKWcWqG8T5VHh3AFSU+yzr9K0VgxzXbfro2m8ShIKglu8sq
 Qi2LX5LXN5jqdJw/1e9PiYtXjajFg2NzKOzrk+VRqTMMTLevX6uVj0ym4o/8KgeqvKYp
 3l5fXwLa2edZ/2rS+POGI5DQUMCoMSLZacWrrofcHrgd8Mj/l7flkC5YfrdeeTs8o9+Q
 +p/1fXg0uXU6mcttKBI63yCQ1awNDIzNy6n4rHXhEB6qKoEOL2tlyuJPmcT/nfZtfV2+
 dp3zXYRila/5YvEqLtVJxiBtXf9Zd1EADbqu87Righ3xTYx1pwqfOwKCNSPUKESEQoID
 dAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764596964; x=1765201764;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EnT45CYebmbcFY569GUSrC94ILduyx/dsHIu7yxmGjc=;
 b=Ea8WT3Qsygle6+8BbgXzwTkrDgG2qZ33CUR9EF2Crd61G6d52BwgW4AE3rFsoWP/bc
 zNB/iwfBui4FWmI/RI6cU9FoepOCA9T+5PAQChtY6p4t1KCEl1BWPE8vrd1N2+r06iF4
 +srRHWhI4ai7jX84YyEnz9ZutR5yniuMFPR3zlcIRsHMY0UPbTeV3Kfxf28qQq9BqFe3
 dUVH8WUr7QIOsB/J+h8fZevRyHukwHwRrI35bJiyr08oy/qLDRy3ctz35CbDUJIJZ+b6
 7isGzWdFdcVvEtYqOTGuclSluX3nELLB3MO0ZX5iys/yV5nQzqexW736W5RC0PjWuMvy
 FcgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcle3DjUZ2FtOFmSjQIGqn7LdpJca8bDFufJaVFjzAFebeEbbp30qQKSMkqWfzMX2Aj1w8/WzO@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwBnpjhHKBkRbZ6HZ7hw4gXWBS78+OMM4/ebBAHX6yG2lZvLVkZ
 R1ii8CmZjadQYjaV46DVUXL+xsZF4KF9hzAz+TtuCH7CiuQeLbNV3Lksr/F9totqPYO6vJqlFxm
 9Dl/0gxJ5G8Ur6h9MVdOKGie7v1CBCjM=
X-Gm-Gg: ASbGncsaYUXLKUTF8mt5uNLhGvdxFH9YMXj+O5/qBcQNjmYojfUy4jXkecj35wb3vvP
 szZZF/l7XXjW2aexK8+WWnLgoc6/xOi9IKSTVMG0T+u+8oDFLYt7tlfQq/Qs9/8p1YXluZQr40V
 oThwm+pjbj73Hjeq5CnaLHW9ZQNq7ET8d227fMsqx7CWJM4D5rtNlHgA2nVAkdqkCHiQxnypu5g
 sQDqLlMiMybJSAdFxCcJMd+gyuBJh3kV1mfpI6jpaBTfmMfMre4jzYDQRbhdy3sD/ddS8M=
X-Google-Smtp-Source: AGHT+IFVPGbkJ/XJh2X7idj2pcY+3Y8UjZQIst4p6vAreJD1vCZ/3jqKScbkKg+GEnNNUu4JItzQHuVDzvfHdG9UcTg=
X-Received: by 2002:a05:7022:68a1:b0:11b:862d:8031 with SMTP id
 a92af1059eb24-11c9f216eccmr24483602c88.0.1764596964085; Mon, 01 Dec 2025
 05:49:24 -0800 (PST)
MIME-Version: 1.0
References: <20251125164345.224298-1-srinivasan.shanmugam@amd.com>
 <20251126164637.232668-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20251126164637.232668-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 1 Dec 2025 08:49:12 -0500
X-Gm-Features: AWmQ_bniyN65R6mm5nEFvVKqw05Yrb00C-hgE0gKX6LONTnY7IBQ0x6rpt_WRBI
Message-ID: <CADnq5_OnzAucz1_9SORT90ee89-BCO3p0udagTu5tjGHiXxrGg@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amdgpu: Treat MMIO_REMAP BOs as linear in
 amdgpu_bo_set/_get_tiling_flags() v3
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

On Wed, Nov 26, 2025 at 12:04=E2=80=AFPM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> MMIO_REMAP BOs are created for HDP flush and device<->device MMIO
> mapping.  They are backed by a TTM resource with mem_type =3D=3D
> AMDGPU_PL_MMIO_REMAP and are allocated as a plain struct amdgpu_bo, not
> as struct amdgpu_bo_user.
>
> When such a BO is exported as a dma-buf and imported back, userspace can
> still issue DRM_IOCTL_AMDGPU_GEM_METADATA on it. That ioctl calls
> amdgpu_bo_get_tiling_flags(), which unconditionally casts the BO to
> struct amdgpu_bo_user and reads ubo->tiling_flags.
>
> On MMIO_REMAP BOs this leads to a slab-out-of-bounds read. KASAN reports:
>
>   BUG: KASAN: slab-out-of-bounds in amdgpu_bo_get_tiling_flags+0xbc/0xd0 =
[amdgpu]
>   Read of size 8 at addr ffff8881a19a9ab8 by task amd_bo/4574
>
>   The buggy address is located 0 bytes to the right of
>   allocated 696-byte region [ffff8881a19a9800, ffff8881a19a9ab8)
>   which belongs to the cache kmalloc-1k of size 1024
>
> Using gdb shows that the faulting load is the tiling_flags access:
>
>   (gdb) list *amdgpu_bo_get_tiling_flags+0xbc
>     1150  BUG_ON(bo->tbo.type =3D=3D ttm_bo_type_kernel);
>     1151  dma_resv_assert_held(bo->tbo.base.resv);
>     1152  ubo =3D to_amdgpu_bo_user(bo);
>     1153
>     1154  if (tiling_flags)
>     1155          *tiling_flags =3D ubo->tiling_flags;
>
>   (gdb) p sizeof(struct amdgpu_bo)
>   $1 =3D 696
>
>   (gdb) ptype /o struct amdgpu_bo_user
>   ...
>   /*    696      |       8 */    u64 tiling_flags;
>   /*    704      |       8 */    u64 metadata_flags;
>   ...
>
> So a plain struct amdgpu_bo is exactly 696 (0x2b8) bytes, and in struct
> amdgpu_bo_user the tiling_flags field lives at offset 696.  The
> MMIO_REMAP BO is only a plain struct amdgpu_bo allocated from
> kmalloc-1k; it does not include the larger amdgpu_bo_user layout.  When
> this MMIO_REMAP BO is treated as struct amdgpu_bo_user and the driver
> reads ubo->tiling_flags at +0x2b8, the read happens just past the end of
> the real object, which is what KASAN reports.
>
> Fix this in the GEM tiling helpers:
>
>   - In amdgpu_bo_get_tiling_flags(), if bo->tbo.resource exists and
>     mem_type =3D=3D AMDGPU_PL_MMIO_REMAP, warn (if requested).  MMIO_REMA=
P
>     BOs are a fixed BAR I/O window and are never tiled, and avoids touchi=
ng
>     struct amdgpu_bo_user.
>
> With these checks in place, the slab-out-of-bounds read is gone.
>
> v2:
>   - Also guard amdgpu_bo_set_tiling_flags() for MMIO_REMAP and return
>     -EINVAL (Alex/Christian)
>
> v3:
>   - Move MMIO_REMAP rejection to amdgpu_gem_metadata_ioctl() and warn on
>     amdgpu_bo_set/_get_tiling_flags() (Christian)
>
> Fixes: 9e903e5bc958 ("drm/amdgpu: Map/Unmap MMIO_REMAP as BAR register wi=
ndow; add TTM sg helpers; wire dma-buf")
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    |  9 +++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 11 +++++++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.c
> index f2505ae5fd65..dacfc57dd179 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -719,6 +719,15 @@ int amdgpu_gem_metadata_ioctl(struct drm_device *dev=
, void *data,
>         if (unlikely(r !=3D 0))
>                 goto out;
>
> +       /* Reject MMIO_REMAP BOs at IOCTL level: metadata/tiling does not=
 apply. */
> +       if (robj->tbo.resource &&
> +           robj->tbo.resource->mem_type =3D=3D AMDGPU_PL_MMIO_REMAP) {
> +               DRM_WARN("metadata ioctl on MMIO_REMAP BO (handle %d)\n",
> +                        args->handle);
> +               r =3D -EINVAL;
> +               goto unreserve;
> +       }
> +
>         if (args->op =3D=3D AMDGPU_GEM_METADATA_OP_GET_METADATA) {
>                 amdgpu_bo_get_tiling_flags(robj, &args->data.tiling_info)=
;
>                 r =3D amdgpu_bo_get_metadata(robj, args->data.data,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_object.c
> index 24ebba43a469..138fd62a47a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1126,6 +1126,10 @@ int amdgpu_bo_set_tiling_flags(struct amdgpu_bo *b=
o, u64 tiling_flags)
>         struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
>         struct amdgpu_bo_user *ubo;
>
> +       /* MMIO_REMAP is BAR I/O space; tiling should never be used here.=
 */
> +       WARN_ON_ONCE(bo->tbo.resource &&
> +                    bo->tbo.resource->mem_type =3D=3D AMDGPU_PL_MMIO_REM=
AP);
> +
>         BUG_ON(bo->tbo.type =3D=3D ttm_bo_type_kernel);
>         if (adev->family <=3D AMDGPU_FAMILY_CZ &&
>             AMDGPU_TILING_GET(tiling_flags, TILE_SPLIT) > 6)
> @@ -1148,6 +1152,13 @@ void amdgpu_bo_get_tiling_flags(struct amdgpu_bo *=
bo, u64 *tiling_flags)
>  {
>         struct amdgpu_bo_user *ubo;
>
> +       /*
> +        * MMIO_REMAP BOs are not real VRAM/GTT memory but a fixed BAR I/=
O window.
> +        * They should never go through GEM tiling helpers.
> +        */
> +       WARN_ON_ONCE(bo->tbo.resource &&
> +                    bo->tbo.resource->mem_type =3D=3D AMDGPU_PL_MMIO_REM=
AP);
> +
>         BUG_ON(bo->tbo.type =3D=3D ttm_bo_type_kernel);
>         dma_resv_assert_held(bo->tbo.base.resv);
>         ubo =3D to_amdgpu_bo_user(bo);
> --
> 2.34.1
>
