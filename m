Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6907BCA0EFA
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 15:06:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F409610E265;
	Mon, 25 Aug 2025 15:06:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Cf1PfHjV";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 148E710E265
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 15:06:05 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-24617d3f077so6285315ad.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 08:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756134364; x=1756739164; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UaLrQXYAgMoQxmgyPFnutEqXIfmnpdSW6G+SsHKkWJs=;
 b=Cf1PfHjV4BDVwVQe5Nfk6gT9RKIty7WE4+QG58rTaNHTvWOFC/0G5OXPfOUm4ZmKKv
 KXIdIxqw5UprW0dDspT9zUw1xa8eHYs2nBjysSDdsNBGEknnufuyxBnJjiI8b2B887av
 UTYxNBB+OgeEYjUXMSCW0ygrEiulvZaVq18Oc0dQdT9772FY1caSAgzRAoaQ4zXvmnlb
 HHc15IR4D+D5Um1vis/IZnvGoxGBfKGh61ZXQVx2xkPy+Lusft6biUF0SxkJh32ZZTxJ
 WKK2YTsoRVqmMeWrqUNmzEOwTSVuMV0UIpLwFv2aVKPEhR1wzQAyGcBf2Szb1SNrAUBa
 femw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756134364; x=1756739164;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UaLrQXYAgMoQxmgyPFnutEqXIfmnpdSW6G+SsHKkWJs=;
 b=WVoqUwuecSbHBPBrPhCkAKDqsHf1SHZq3AO9u+Ug5EnzqtO1S2sVzQUvBXznt2ZQ1n
 MXbwo0D/8ShKxq/Qhsq2JqgBySRQiTNjTT5xf3dyWRNpBOrMneBeQkMsDdmYK330UN/2
 3C0JT1/bWSd25RVNvUlf7NN1rUt/aXr3Rc/GZQcXBo8WEwr0bLdi/RupZMi4dGYOTgW9
 ESlfnfNUWPDK3wRyfnYW4XZ1D241tB7AwP/HYISDv5dug3wSVv+2T26eVcO728w1pWr6
 tRf9M5iXtFLpZzwq1BUyYwYgNnTTHeGxhcuTIy+mlmsNMxzmj5PyfI8gqBwUyCsMrk/o
 nkyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcMCJ46Zi1toLzsMsWo+dByopCRjgcEUQ1L1LBVOD88E88eTs98U78IbGJzVf/mcbhxy902oxZ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxieX0zDGk867OwrJuC+wk06Zh+uqJMgx55OwF/Wu+iQVPKNXl/
 rU97WCJKoAkYst15wRFODjprvXuYIp1OwBVT2PMFBqbDdiXeLXNEgUXL6xh0G0XXvWNKjEO/3eJ
 Bv4eN58vS3htzam+XI//VsyalTHHi1knMBg==
X-Gm-Gg: ASbGncsaQeqQzS0ByT/EyakxLT5IjjXmSu0R7ykRpLhqWfqLpjDIbcfDFNNJc/C0BLO
 DrmXofOFhddLjdkXOF4q67zhF/so0F0FbSJAK0zb9DZ7qxnbUxP87jiqBu0Yd2eN/oh7me2+lAM
 s5IW9T180GcSBLxfqgdwiPgreqcQM32n0ExGqIBntMTcCmtlrRYUgBlNNLv3MzzzInzK091ng32
 yQSi00=
X-Google-Smtp-Source: AGHT+IFvDdIou2MPBN9jEOeqgOJblziIwAWfEWiZ25/D/XkMIdyRpgdl5GdRlhYCGt/D/RByIrPQCQC06eLBu0Q6pdY=
X-Received: by 2002:a17:902:d508:b0:246:cc19:17de with SMTP id
 d9443c01a7336-246cc19233cmr29028335ad.4.1756134364365; Mon, 25 Aug 2025
 08:06:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250820113254.3864753-1-srinivasan.shanmugam@amd.com>
 <20250823072016.1272328-1-srinivasan.shanmugam@amd.com>
 <20250823072016.1272328-9-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250823072016.1272328-9-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 25 Aug 2025 11:05:52 -0400
X-Gm-Features: Ac12FXyAevyt--EglYPYdBp6xevcHT1ES0ly4YldHyj-3WYdjuyIClvmTYt1mEs
Message-ID: <CADnq5_NvZhi5F+Z35qfBBiTvirjs_euz_P4Of3ufKXRGVZW78A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 8/8] drm/amdgpu/gem: Return Handle to MMIO_REMAP
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

On Sat, Aug 23, 2025 at 5:48=E2=80=AFAM Srinivasan Shanmugam
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
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 59 +++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.c
> index d8cffd26455b..655281f57a99 100644
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
> +       struct amdgpu_bo *bo =3D READ_ONCE(adev->rmmio_remap.bo);

Why are you using READ_ONCE here?

Alex

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
> --
> 2.34.1
>
