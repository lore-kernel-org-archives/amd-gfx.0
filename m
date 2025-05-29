Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B44BC5AD49
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 13:57:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A96F10E048;
	Thu, 29 May 2025 13:57:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eRG0wP+Y";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E63F10E048
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 13:57:06 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-3108652400cso140776a91.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 06:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748527026; x=1749131826; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V4b4SZZcN0p+Ah0jChIUYcIArY5D2uGTSZVMdeARWCg=;
 b=eRG0wP+YxNyOsZf0ufYoidGjNeaXCKuLCDJCaCR1eyohtmgXaoRs3OWhbYQwOh8Rm3
 0ARZuUe2MOovNM8TgbBJ6q3Q1n/fRTzxUFdbdhIlQQwOOKn6MXXNh/8z+WxTTnj2thOP
 cluYjyxybtGtivzgo3wS8LJke+8XK+lzkT02mOpIm4mLvEqQvODzxiu40QmW6FPeUT2Z
 OHUsAfqEY0ubjxhuiX5v9Su3mPmi8MX27RtUib8pJCElNjhunGRMI7sjqyPF3DRZeFvs
 mvpNqwa7sfaScfDms8BSNN3Yj2fzbkTjj25JwFraJrMzcDIG3gmMiBBCUDSeqdCXQUXW
 ErHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748527026; x=1749131826;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V4b4SZZcN0p+Ah0jChIUYcIArY5D2uGTSZVMdeARWCg=;
 b=bBI29CPUYZq7wzItxfjzEniQq1W/945V61XZzyVficQrdlgn49CVxRya2QmKj4DG1s
 bi2HnPWfahGYLFW6XMCxZk0M9lKqkqvxRRRwKVURMefkx30ktzHdQVfwT3CEgzMAf+bf
 WGa2RBINLAr115CqgJpfWRcSrJ5ESWBhyyBqD3yv6u7bNTYZ76LQrOg1BKqCPBwxKzYD
 AmDdLHHlKncU3SP74rRgvZF6TI9cNIB4228TExhkXsprrVYMd8SWzNNqIe68euv75Onx
 yESPiHfY2fDc2gsuaSmY3hsb+vuwtT6dwPfZDUYixIkNoeYHMS+mpQEfOfu5JhDz9HEC
 XXPw==
X-Gm-Message-State: AOJu0Ywjti0iPSBM36iSq6cBKQQDwAvSxnXLC7tXHpMZS1PzPvQ5Ekhn
 YuLQ1ls/tt3F+FRqUoRqJpTFtf+I1TIZP9M3Zr4SzjgXnXa6QJZd5YIwbFsJ2uXhugKUK2KTySP
 dRu4CKci8ZBtPg+9gML2MNCVoZ6qVOIY=
X-Gm-Gg: ASbGnctQl5Ews7Vd2aCfR1g7RYoAeLHfk78O7TEHQuEhR1H1hpxL4KTsJOqoSs+asw/
 s8IeE2tOcOWa8r1W8UKB+AwIIdztbY2o3MSRgerP9yNfa1yFMH93vXS0wXxQ2ZHOKmL+JLvTwX0
 X86+p5Hcthb6WF0dStqoVGipGi+/LdxIqzWQ==
X-Google-Smtp-Source: AGHT+IGrDmiKFxxQjIGy/UiNM8p0FL+RjLhIQof2nSJ+HUbJiZSfi4SiF9TcRxu/+rs32jwNtnYEUAq2WEgiBFeKYN4=
X-Received: by 2002:a17:90b:38cb:b0:311:b0d3:851 with SMTP id
 98e67ed59e1d1-311b0d30b35mr5600382a91.4.1748527025965; Thu, 29 May 2025
 06:57:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250529114655.592455-1-lijo.lazar@amd.com>
In-Reply-To: <20250529114655.592455-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 29 May 2025 09:56:54 -0400
X-Gm-Features: AX0GCFtEwO6j155VafxbNd9zfCNOScjO8DBRLabTOWezZLdgsLwKv_KmeGjA_hU
Message-ID: <CADnq5_PC8bBdfMPenSOa-Uyh=otaskDyy=90GgwoYHPE2Udx0Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add more checks to discovery fetch
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com
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

On Thu, May 29, 2025 at 7:47=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> Add more checks for valid vram size and log error, if any.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index 9e738fae2b74..a0e9bf9b2710 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -270,9 +270,10 @@ static int amdgpu_discovery_read_binary_from_sysmem(=
struct amdgpu_device *adev,
>  static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *a=
dev,
>                                                  uint8_t *binary)
>  {
> +       bool sz_valid =3D true;
>         uint64_t vram_size;
> -       u32 msg;
>         int i, ret =3D 0;
> +       u32 msg;
>
>         if (!amdgpu_sriov_vf(adev)) {
>                 /* It can take up to a second for IFWI init to complete o=
n some dGPUs,
> @@ -291,9 +292,13 @@ static int amdgpu_discovery_read_binary_from_mem(str=
uct amdgpu_device *adev,
>                 }
>         }
>
> -       vram_size =3D (uint64_t)RREG32(mmRCC_CONFIG_MEMSIZE) << 20;
> +       vram_size =3D RREG32(mmRCC_CONFIG_MEMSIZE);
> +       if (!vram_size || vram_size =3D=3D U32_MAX)
> +               sz_valid =3D false;
> +       else
> +               vram_size <<=3D 20;
>
> -       if (vram_size) {
> +       if (sz_valid) {
>                 uint64_t pos =3D vram_size - DISCOVERY_TMR_OFFSET;
>                 amdgpu_device_vram_access(adev, pos, (uint32_t *)binary,
>                                           adev->mman.discovery_tmr_size, =
false);
> @@ -301,6 +306,11 @@ static int amdgpu_discovery_read_binary_from_mem(str=
uct amdgpu_device *adev,
>                 ret =3D amdgpu_discovery_read_binary_from_sysmem(adev, bi=
nary);
>         }
>
> +       if (ret)
> +               dev_err(adev->dev,
> +                       "failed to read discovery info from memory, vram =
size read: %llx",
> +                       vram_size);
> +
>         return ret;
>  }
>
> --
> 2.25.1
>
