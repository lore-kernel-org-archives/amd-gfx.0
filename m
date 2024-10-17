Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9AF2D374BC
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 16:16:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9798310E201;
	Thu, 17 Oct 2024 16:16:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dFM8jzJ2";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1655C10E201
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 16:16:16 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2e2d1b7bd57so149321a91.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 09:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729181775; x=1729786575; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oBRmcbDbmo9c6XsIZuSTlLu9BP+ceovI8GTR/SDJ1no=;
 b=dFM8jzJ27bQFxLzQsD6Ns349hA7oCkbZCpUEd/KH8J+n/wKQer3rZpRB05cXCIwA8q
 gtwxb60Xe0G9Aq9o7yqM8JpqpfDmkYEDwfsUVS6ZkfZNVdC+SaGM9ufj2zzfyt25ksiN
 90vM+zFUir3O/NMWGRSocv2RcF4oxgZ/dmVOhtP8alpw3K/4pHJUeqzUrx54cc/Xij+O
 Y/Gel/L8wSXOhyMDhtKW8yDeBrgrME10OiyWmWdmjLVETEOoLngzs7sOFdAKg+yzRZQm
 E0vylnOALcQjHQENnggSKhpIsRl7b+y1p/5Z9obofbWy187t0E0bi/3qDU0323hizC42
 lyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729181775; x=1729786575;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oBRmcbDbmo9c6XsIZuSTlLu9BP+ceovI8GTR/SDJ1no=;
 b=bCBEaE1GiQX0628hkfbrIKGfIpl7l0/0p7GZ9UG27T6ni3YVF2P9cx4PuuzK18d5aE
 N8NptFCwJPpNizvZi95JdXzVSedA5ScDemM81HbvT7Dg4BtbJNkgGMUJkTf1UUaYs86s
 G4eMxe46lnhZv5w8t9eE9Nvf0ZB/IRx9UtRxUWEMdVYy5PtFdte5sTpGqgfsNP6i1KTi
 73jZb97Du7QUvEdRsN7JkMoDv4E0M2zjJwEPbk/Fk/q/xnPF2jasSkYhHUFwPI2Xd3gf
 hR2AVcZM90z+wgvLw5yWRa2vwfKwS7uweEwYdYleFdJgxlnkQvHBRHv/7iKCLxySC7mf
 wubg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1V9ahmMYpThTL+QVhORiRo3GgPqGdWy10mp9F5w0XsEmPaBqPJrBJP4OiLBPPOYjmsYCUrP+D@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwgDE0UEdcPZ2ymYnPpAK7omEX7FHdRptFTcUEJ3AYjZnKbUeO3
 NSPSPLAXV+5IZf8wVrUe40N6MFHeUvBgWwwzPFj9UvjcdNvfBY1C+6/Y48QmOc5mSSaFuDmh20J
 oIkwfC1awteKC50+Hv8v0OFMfW5/tpA==
X-Google-Smtp-Source: AGHT+IFipBh4jAmSKcR8Mm+sJvjPhlyHpqCJAU0e7B5Qpctox3ua38rx2ji+DcqhOUBL3gxMB2gSsxDRO9krYaDn8nE=
X-Received: by 2002:a17:90b:110c:b0:2e2:cd6b:c6b8 with SMTP id
 98e67ed59e1d1-2e3dc2a4054mr2032606a91.8.1729181775414; Thu, 17 Oct 2024
 09:16:15 -0700 (PDT)
MIME-Version: 1.0
References: <20241017064904.3500946-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20241017064904.3500946-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 17 Oct 2024 12:16:03 -0400
Message-ID: <CADnq5_MzAhDzFRcKdPKRmKPkN6i_8zgHTeF=R4k9QHVasWYcGw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu/gfx9: Enable Cleaner Shader for GFX9.4.2
 Hardware
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

On Thu, Oct 17, 2024 at 2:49=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> This patch adds support for the cleaner shader feature onto GFX9.4.2
> hardware, as part of the leftover locals feature. The cleaner shader is
> important for ensuring process isolation and maintaining KGD/KFD
> serialization by clearing GPU memory before it is reused.
>
> The patch updates the `gfx_v9_0_sw_init` function to initialize the
> cleaner shader if the MEC firmware version is 88 or higher. It sets the
> `cleaner_shader_ptr` and `cleaner_shader_size` to the appropriate values
> and attempts to initialize the cleaner shader.
>
> This change ensures that the GPU memory is properly cleared between
> different processes, preventing data leakage and enhancing security. It
> also aligns with the serialization mechanism between KGD and KFD,
> ensuring that the GPU state is consistent across different workloads.
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

You could probably merge these two patches into one or if you prefer,
switch the order of the patches.  Otherwise, if you only apply patch
1, the code will work, but the shader will be invalid.  Either way:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                | 12 ++++++++++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0_cleaner_shader.h |  7 ++++++-
>  2 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index b4c4b9916289..66947850d7e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2223,6 +2223,18 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
>         }
>
>         switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> +       case IP_VERSION(9, 4, 2):
> +               adev->gfx.cleaner_shader_ptr =3D gfx_9_4_2_cleaner_shader=
_hex;
> +               adev->gfx.cleaner_shader_size =3D sizeof(gfx_9_4_2_cleane=
r_shader_hex);
> +               if (adev->gfx.mec_fw_version >=3D 88) {
> +                       adev->gfx.enable_cleaner_shader =3D true;
> +                       r =3D amdgpu_gfx_cleaner_shader_sw_init(adev, ade=
v->gfx.cleaner_shader_size);
> +                       if (r) {
> +                               adev->gfx.enable_cleaner_shader =3D false=
;
> +                               dev_err(adev->dev, "Failed to initialize =
cleaner shader\n");
> +                       }
> +               }
> +               break;
>         default:
>                 adev->gfx.enable_cleaner_shader =3D false;
>                 break;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0_cleaner_shader.h b/drive=
rs/gpu/drm/amd/amdgpu/gfx_v9_0_cleaner_shader.h
> index 36c0292b5110..cfb73e729b0a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0_cleaner_shader.h
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0_cleaner_shader.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: MIT */
>  /*
> - * Copyright 2018 Advanced Micro Devices, Inc.
> + * Copyright 2024 Advanced Micro Devices, Inc.
>   *
>   * Permission is hereby granted, free of charge, to any person obtaining=
 a
>   * copy of this software and associated documentation files (the "Softwa=
re"),
> @@ -24,3 +24,8 @@
>  static const u32 __maybe_unused gfx_9_0_cleaner_shader_hex[] =3D {
>         /* Add the cleaner shader code here */
>  };
> +
> +/* Define the cleaner shader gfx_9_4_2 */
> +static const u32 __maybe_unused gfx_9_4_2_cleaner_shader_hex[] =3D {
> +       /* Add the cleaner shader code here */
> +};
> --
> 2.34.1
>
