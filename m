Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED14C77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 24 May 2023 20:42:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05C4810E47D;
	Wed, 24 May 2023 20:42:59 +0000 (UTC)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78E2610E47D
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 May 2023 20:42:56 +0000 (UTC)
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-19eb96bffd4so634428fac.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 May 2023 13:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684960975; x=1687552975;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AHO35CCiwvO4rgWKyPTb5kJ6RPPMIPmAL6O6O6LuKXs=;
 b=Pz06/mPopMM/Kif7vmQZH7Kuy2mXOEGGDO56JblyLcutuQB82KS/3yHXDxQDcqkojo
 w5+0G9aAg+jIFWUbUSAh0P1/Mv680xVyCBaZOefY4tMVXRLxcMVHGiXclseVzPJPrvxc
 XqUQyTpYyYBnUd5KtjahZ3lvNZFXxPDG0zx9qEKWNMc76QEdzAXTiZ+A2MaGfDV5E620
 mCTXfK4OVnb1KJZVj1DSVYYiAbyDh7CrVjzt4FBHaeIk1DQHoyLA7O8uD26PF6+7ljJQ
 bniYde+1rJZRRl7RqkbBtrhOl5jqJGKeIFvvYvrI3PRw58Vl6pct/fvkBFIb8UaZ2Q24
 ghBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684960975; x=1687552975;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AHO35CCiwvO4rgWKyPTb5kJ6RPPMIPmAL6O6O6LuKXs=;
 b=AX3IFuYYuCOMPBDvEVwdyhzGc+PhBOwU5tviZlC0mBsSIU1uorFimoowU6frdiGL2R
 V7oz9kBFS9AhRXw3jLBXmzYG1f2IUKYAQmyiUpQmtJCQB20VqyOTa7F9Pv7fWkxcGRwa
 dhlNhtUXAjzb1ah9arLE6kb/UcP4t4W2FZJEXDlwax49JlvimMt7YlLj2HQrhxZ/vgoj
 mpNcMlWlXXw56SLqQLhF4ZfwMRVCTX641OhJxgv/zRrG9Syy7Ksh0NMRPinOnvGr9eBW
 pq/YtCSc0wVBAERIvC3BqRkHF1cuWZcKaoWBc+WtRQDDKQAoLNgLBkV3rX81niPdq7KI
 i1sw==
X-Gm-Message-State: AC+VfDyvlzZmfcBECNP6FAT+r45pN8L2JXXbH+Z1gyFq+oBVwDCL44Sp
 SlVNSF/pSSo7Cg3PXvq+Fqs3vzyhCGGbfc+RW84=
X-Google-Smtp-Source: ACHHUZ62EMFLKYOh/H0o6Y9wZsduR+VWXWGBqRPcBvOF/Nf6YfAsdD2tkA/CN0wROtfcXtVHVeBg3YJT2/dOV070UWY=
X-Received: by 2002:a54:4893:0:b0:398:2da0:21d2 with SMTP id
 r19-20020a544893000000b003982da021d2mr3494144oic.59.1684960975245; Wed, 24
 May 2023 13:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230524203504.3568374-1-James.Zhu@amd.com>
In-Reply-To: <20230524203504.3568374-1-James.Zhu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 24 May 2023 16:42:44 -0400
Message-ID: <CADnq5_ObB=t-yWNribww=RNxfjmvBkfyERwBS5Ou3qepkR053A@mail.gmail.com>
Subject: Re: [PATCH] drm/jpeg: add init value for num_jpeg_rings
To: James Zhu <James.Zhu@amd.com>
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
Cc: ying.li@amd.com, bonnie.deng@amd.com, richardqi.liang@amd.com,
 amd-gfx@lists.freedesktop.org, jason.wu2@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, May 24, 2023 at 4:35=E2=80=AFPM James Zhu <James.Zhu@amd.com> wrote=
:
>
> Need init new num_jpeg_rings to 1 on jpeg.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c | 1 +
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 1 +
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 1 +
>  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 1 +
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c | 1 +
>  5 files changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v1_0.c
> index 1c5b60604a19..77595e9622da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> @@ -460,6 +460,7 @@ int jpeg_v1_0_early_init(void *handle)
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>
>         adev->jpeg.num_jpeg_inst =3D 1;
> +       adev->jpeg.num_jpeg_rings =3D 1;
>
>         jpeg_v1_0_set_dec_ring_funcs(adev);
>         jpeg_v1_0_set_irq_funcs(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v2_0.c
> index 3aeeceae34a5..c25d4a07350b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> @@ -49,6 +49,7 @@ static int jpeg_v2_0_early_init(void *handle)
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>
>         adev->jpeg.num_jpeg_inst =3D 1;
> +       adev->jpeg.num_jpeg_rings =3D 1;
>
>         jpeg_v2_0_set_dec_ring_funcs(adev);
>         jpeg_v2_0_set_irq_funcs(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v2_5.c
> index f533ede484d4..aadb74de52bc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> @@ -60,6 +60,7 @@ static int jpeg_v2_5_early_init(void *handle)
>         u32 harvest;
>         int i;
>
> +       adev->jpeg.num_jpeg_rings =3D 1;
>         adev->jpeg.num_jpeg_inst =3D JPEG25_MAX_HW_INSTANCES_ARCTURUS;
>         for (i =3D 0; i < adev->jpeg.num_jpeg_inst; i++) {
>                 harvest =3D RREG32_SOC15(JPEG, i, mmCC_UVD_HARVESTING);
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v3_0.c
> index cb5494effc0f..79791379fc2b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> @@ -64,6 +64,7 @@ static int jpeg_v3_0_early_init(void *handle)
>         }
>
>         adev->jpeg.num_jpeg_inst =3D 1;
> +       adev->jpeg.num_jpeg_rings =3D 1;
>
>         jpeg_v3_0_set_dec_ring_funcs(adev);
>         jpeg_v3_0_set_irq_funcs(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v4_0.c
> index 86383fbf9358..a707d407fbd0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> @@ -58,6 +58,7 @@ static int jpeg_v4_0_early_init(void *handle)
>
>
>         adev->jpeg.num_jpeg_inst =3D 1;
> +       adev->jpeg.num_jpeg_rings =3D 1;
>
>         jpeg_v4_0_set_dec_ring_funcs(adev);
>         jpeg_v4_0_set_irq_funcs(adev);
> --
> 2.34.1
>
