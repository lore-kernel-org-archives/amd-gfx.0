Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A779D0E6EC
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Nov 2025 14:43:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 395E210E416;
	Tue, 25 Nov 2025 14:43:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NXYzwQNL";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 172FF10E416
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Nov 2025 14:43:49 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-b63e5da0fdeso496940a12.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Nov 2025 06:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764081828; x=1764686628; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5UQiLE2mz4QAqSudK+e8wkfRuVUS8bDfyhxGkjQQU4g=;
 b=NXYzwQNL1AiBbZF0DOkIUOfcx7kCKla0/OibS0VZwc5NSHoO6mXyweTBP3NjHFOvxD
 fy6NybRZlQ34hDhmW3TtdJiZGInvsjfd6QwLABO1VwnNFlHHTJpBLa3WZL0Ne9RsNJN9
 rECpYOnIs+tG6fvsKiRLocjOqkAjfirJ2r3zMnWPk/xXi3dgyT20Nl928TdDDts2rFAL
 +rZsBenw0fK2z5oPCmIR2hczwXf2MBNW0iIaAaN/KSbJbvpr27YyJZVAlV/x26ED9POt
 CXJwOfe6LhIuNBMQK5dLMh4WkTK0p2s1Ta7FNnTeQQ9aKSSwtU8hjtRPCEj21mfyEf2w
 NwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764081828; x=1764686628;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5UQiLE2mz4QAqSudK+e8wkfRuVUS8bDfyhxGkjQQU4g=;
 b=cm7DMWZ5SQttYTiLkIkqQHmVKVFWBshakd+R5ZK74EJhs+5HEd7BzhamW4tgU3dXj1
 yg5/zDGP5GjusM9IJF5285+W0hm7vuGy5ZyVEjdMwdtFH2HaIbgDYsz0wJ0sqi6/+JWJ
 zyg7zf+SkptEwUKeU+W2OTN2w0GF42VdKqjoXDtzYUgUr3EDRV3YTDIuQVly4kO6s19M
 HHYYm6kQAnUeJbUTYRdrjgh8/p7omhq9Nu6s41ywTL6AffbEN1WROnK6QqjPnCZ7Scrx
 MdC0jIZoNYLXrXnb5vN5xO9Z25UV+Oky9slun5t3o4CgAVJbfV0ehvlCFIsWTKUOqloJ
 LRlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyYoVNKnSLZjupYQKExqc1MdBUtiWM5AtOHFsvjC65PrVnVwqyqeoThLZkZBTDTvoQYWWRJEIT@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwPqP/bMXWqbSGUGsl/qE2eb/jfEUCMKSfCAYkQqquGSe4cKnpv
 9lRYGXV7QfcKY38R4MAQ6A7zzS0Cdb7hIQHGfGxk4hmca7RLdiJ5cSCv6aE2/cE91m0l2FWy1tH
 35LqzWchyMa+DwFOUGHOXUb3V7hgZijs=
X-Gm-Gg: ASbGncuhCCXhYsG5MzJTKL50F5Zeg2jfBcjFDAH4PFxVp6Zjtvn92alBjXrrkOe2luk
 nx5Jl6Q+eyE39jIP3ejzB+w0gDDqViA+9sbji1hoEJye+nWSE2JdoAg7JuTHXrI21dp2AxWRcEC
 Lo86XCnxXrR0j3zn1ZSgJc2Tpgb+QpXVYu5vJqe65km7x71DRQA4Xb5nSNTkMG7NTP8TK7qkt/h
 sxEHCIisuvetNKKI/t9oZYIYsw950AH3Gc/wijBxA19KTtBlKKMYOv3tbdLtxt0MkFa0Rg=
X-Google-Smtp-Source: AGHT+IH+IJ5DIsd81WoeBfzUDHoz2iC4GFuhc9wyhuvksQLG3IXYrfjuseAa2BShLrb9tqdTgtpDLnuET7UctfSSqig=
X-Received: by 2002:a05:7022:4414:b0:119:e55a:95a0 with SMTP id
 a92af1059eb24-11c9d71a68cmr8717145c88.2.1764081828446; Tue, 25 Nov 2025
 06:43:48 -0800 (PST)
MIME-Version: 1.0
References: <20251125053634.219308-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20251125053634.219308-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 Nov 2025 09:43:37 -0500
X-Gm-Features: AWmQ_blaqn3Wlvk5BD-rsp7FbnIwZrRAx05tMCSTFIqKiHjLwMISdXlMwcAvS04
Message-ID: <CADnq5_OQzsXJDzVu0M_xqLWxs2BKma8uHtkgnBRYrS+Ry=Yquw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Treat MMIO_REMAP BOs as linear in
 amdgpu_bo_get_tiling_flags()
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

On Tue, Nov 25, 2025 at 12:36=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> MMIO_REMAP BOs are created for HDP flush and device<->device MMIO
> mapping. They are backed by a TTM resource with mem_type =3D=3D
> AMDGPU_PL_MMIO_REMAP and are allocated as a plain struct amdgpu_bo, not
> as struct amdgpu_bo_user.
>
> When such a BO is exported via dma-buf and then imported, userspace can
> still issue DRM_IOCTL_AMDGPU_GEM_METADATA on it. That ioctl calls
> amdgpu_bo_get_tiling_flags(), which unconditionally treats the BO as
> amdgpu_bo_user and reads ubo->tiling_flags.
>
> On MMIO_REMAP BOs this causes a slab-out-of-bounds read. KASAN reports:
>
>   BUG: KASAN: slab-out-of-bounds in amdgpu_bo_get_tiling_flags+0xbc/0xd0 =
[amdgpu]
>   Read of size 8 at addr ffff8881a19a9ab8 by task amd_bo/4574
>
>   The buggy address is located 0 bytes to the right of
>   allocated 696-byte region [ffff8881a19a9800, ffff8881a19a9ab8)
>   which belongs to the cache kmalloc-1k of size 1024
>
> Triggered by the amd_bo IGT test:
>
>   igt@amdgpu/amd_bo@mmio_remap_dmabuf_loopback
>
> gdb shows that the faulting access is the tiling_flags load:
>
>   (gdb) list *amdgpu_bo_get_tiling_flags+0xbc
>   1150         BUG_ON(bo->tbo.type =3D=3D ttm_bo_type_kernel);
>   1151         dma_resv_assert_held(bo->tbo.base.resv);
>   1152         ubo =3D to_amdgpu_bo_user(bo);
>   1153
>   1154         if (tiling_flags)
>   1155                 *tiling_flags =3D ubo->tiling_flags;
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
> amdgpu_bo_user the tiling_flags field lives at offset 696. The
> MMIO_REMAP BO is only a plain struct amdgpu_bo from kmalloc-1k. It does
> not include the larger amdgpu_bo_user layout. When this MMIO_REMAP BO is
> treated as a struct amdgpu_bo_user, the driver tries to read the field
> tiling_flags at offset 0x2b8. But the MMIO_REMAP BO is only a plain
> struct amdgpu_bo, which is exactly 696 bytes (0x2b8) in size. So the
> read happens just outside the real object, because the field does not
> exist in this MMIO_REMAP BO. This is why KASAN reports a
> =E2=80=98slab-out-of-bounds=E2=80=99 error
>
> Fix this by treating MMIO_REMAP BOs as linear in
> amdgpu_bo_get_tiling_flags(): if bo->tbo.resource exists and mem_type =3D=
=3D
> AMDGPU_PL_MMIO_REMAP, set *tiling_flags =3D 0 (no tiling) and return
> early, without touching struct amdgpu_bo_user. MMIO_REMAP BOs never use
> tiling or metadata, so this is the correct behaviour and avoids the
> out-of-bounds access.

I think you should also fix amdgpu_bo_set_tiling_flags().

Alex

>
> Fixes: 9e903e5bc958 ("drm/amdgpu: Map/Unmap MMIO_REMAP as BAR register wi=
ndow; add TTM sg helpers; wire dma-buf")
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_object.c
> index 24ebba43a469..3c8c2b64af83 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1148,6 +1148,15 @@ void amdgpu_bo_get_tiling_flags(struct amdgpu_bo *=
bo, u64 *tiling_flags)
>  {
>         struct amdgpu_bo_user *ubo;
>
> +       /* Avoid slab-out-of-bounds for MMIO_REMAP BOs */
> +       /* MMIO_REMAP is a fixed BAR I/O window, never tiled */
> +       if (bo->tbo.resource &&
> +           bo->tbo.resource->mem_type =3D=3D AMDGPU_PL_MMIO_REMAP) {
> +               if (tiling_flags)
> +                       *tiling_flags =3D 0; /* linear layout */
> +               return;
> +       }
> +
>         BUG_ON(bo->tbo.type =3D=3D ttm_bo_type_kernel);
>         dma_resv_assert_held(bo->tbo.base.resv);
>         ubo =3D to_amdgpu_bo_user(bo);
> --
> 2.34.1
>
