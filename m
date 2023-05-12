Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBAE9C7EE23
	for <amd-gfx@archiver.kernel.org>; Fri, 12 May 2023 13:13:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 644D210E6A9;
	Fri, 12 May 2023 13:13:17 +0000 (UTC)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07A2010E6A9
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 May 2023 13:13:14 +0000 (UTC)
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-18f4a6d2822so57340266fac.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 May 2023 06:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1683897193; x=1686489193;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CngAmmFuRqIswlP+CfD/veCE+5BJl/MKvsCecVSZMnQ=;
 b=WXmA5DI7O+5sY9N1cqvEy96CcmdacZK9X7zZihv6GhgGcLVU0JoLdvBlXqn3Y8dT5k
 g2hzj6I0nrCrMgg+SE4FQTPN6jWF3j7gk+JEK5QxO+UUQycdt3AQVBBymYTdfCvt+8Q0
 +9Wz8IH8a+kPJc/aKYay50vLqSzZYuHlvufqEBLgjWO2O9zDmV01pVgJjeglnA0gEaB8
 gzL+qA8MuzJ9iw+a4aICc9B7dPSV/F1ZnSjzA75PsZzUD7xK3jklc5I1+PJnnuvliLhs
 2ZqwaTdCX0rR7CECTX/OZCXVMBFU/8ZphFHPeht8E220Bob3f9wFlngTrpFwf/gM7vY5
 hmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683897193; x=1686489193;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CngAmmFuRqIswlP+CfD/veCE+5BJl/MKvsCecVSZMnQ=;
 b=jyv390k+RZrmU0vW62wNagTmII8uQQnECZ9B9bxiP+oX0dtZ/eP9UVnyEkr2a+TuTG
 80KCnnZBL7x+7OPrTNM7DmzXTe7EDTgoR3dFvu+/Ti2CGCWSwMuNyd81v/9ufPJb0eMr
 YUeSLV71oKcEASkdhNsh/hyuwplnpSA4ME+1Gs6SWMthjVAMr53qcfG+m8zORqy6idqE
 mmFtMe2iKsIZQ0KkAfArw1PWDcsLp/QSdReA2eUxN4quBVPJkze2mxXrFYWMkvj3bWwi
 LcABboJDR519ENXyH62ZsmQKccLs5MDCA2SJ40XLjII+ZvelRLyJ4xq7M45x+pYYpdJj
 5pZw==
X-Gm-Message-State: AC+VfDzDhfcT2qAqN/mfbGEzscZTWNEugI/Lme5evTTnaaaSmueX28uy
 fmicWwSWn4N+DY7HkqVKUBIuAI3hBGv9TohIUsMMHnGG
X-Google-Smtp-Source: ACHHUZ6wEzEoDk24x+Dz9K9LTog4VZTwghCdh604I3V/BWzi4CX6EBqR7c8yDztTdI+MEefKYolU8Ind7nXvtdl3sYY=
X-Received: by 2002:aca:b98a:0:b0:394:3d94:b165 with SMTP id
 j132-20020acab98a000000b003943d94b165mr3981512oif.19.1683897191726; Fri, 12
 May 2023 06:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230512081547.1006052-1-Jack.Xiao@amd.com>
In-Reply-To: <20230512081547.1006052-1-Jack.Xiao@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 12 May 2023 09:13:00 -0400
Message-ID: <CADnq5_PGQG4vu+DBUmMZwK=A-v1AgTemy1Z15=GSqep5_ymvgA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix S3 issue if MQD in VRAM
To: Jack Xiao <Jack.Xiao@amd.com>
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
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, May 12, 2023 at 4:16=E2=80=AFAM Jack Xiao <Jack.Xiao@amd.com> wrote=
:
>
> Make the preemption optimization effect only for SRIOV,
> for it caused failure to resume from S3.

Can you elaborate?  We ultimately want MQDs in VRAM for performance
reasons even for bare metal.

Alex

>
> Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/mes_v10_1.c  | 7 +++++--
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 7 +++++--
>  3 files changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index a22d88a4178a..1b795b7bbf38 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -385,7 +385,8 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev=
,
>         u32 domain =3D AMDGPU_GEM_DOMAIN_GTT;
>
>         /* Only enable on gfx10 and 11 for now to avoid changing behavior=
 on older chips */
> -       if (adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(10, 0, 0))
> +       if (adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(10, 0, 0) &&
> +           amdgpu_sriov_vf(adev))
>                 domain |=3D AMDGPU_GEM_DOMAIN_VRAM;
>
>         /* create MQD for KIQ */
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v10_1.c
> index 4560476c7c31..5c3d3f6c7ebd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> @@ -889,6 +889,7 @@ static int mes_v10_1_mqd_sw_init(struct amdgpu_device=
 *adev,
>  {
>         int r, mqd_size =3D sizeof(struct v10_compute_mqd);
>         struct amdgpu_ring *ring;
> +       u32 domain =3D AMDGPU_GEM_DOMAIN_GTT;
>
>         if (pipe =3D=3D AMDGPU_MES_KIQ_PIPE)
>                 ring =3D &adev->gfx.kiq[0].ring;
> @@ -900,9 +901,11 @@ static int mes_v10_1_mqd_sw_init(struct amdgpu_devic=
e *adev,
>         if (ring->mqd_obj)
>                 return 0;
>
> +       if (amdgpu_sriov_vf(adev))
> +               domain |=3D AMDGPU_GEM_DOMAIN_VRAM;
> +
>         r =3D amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
> -                                   AMDGPU_GEM_DOMAIN_VRAM |
> -                                   AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj=
,
> +                                   domain, &ring->mqd_obj,
>                                     &ring->mqd_gpu_addr, &ring->mqd_ptr);
>         if (r) {
>                 dev_warn(adev->dev, "failed to create ring mqd bo (%d)", =
r);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v11_0.c
> index 3adb450eec07..79a4d2bfd94a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -987,6 +987,7 @@ static int mes_v11_0_mqd_sw_init(struct amdgpu_device=
 *adev,
>  {
>         int r, mqd_size =3D sizeof(struct v11_compute_mqd);
>         struct amdgpu_ring *ring;
> +       u32 domain =3D AMDGPU_GEM_DOMAIN_GTT;
>
>         if (pipe =3D=3D AMDGPU_MES_KIQ_PIPE)
>                 ring =3D &adev->gfx.kiq[0].ring;
> @@ -998,9 +999,11 @@ static int mes_v11_0_mqd_sw_init(struct amdgpu_devic=
e *adev,
>         if (ring->mqd_obj)
>                 return 0;
>
> +       if (amdgpu_sriov_vf(adev))
> +               domain |=3D AMDGPU_GEM_DOMAIN_VRAM;
> +
>         r =3D amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
> -                                   AMDGPU_GEM_DOMAIN_VRAM |
> -                                   AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj=
,
> +                                   domain, &ring->mqd_obj,
>                                     &ring->mqd_gpu_addr, &ring->mqd_ptr);
>         if (r) {
>                 dev_warn(adev->dev, "failed to create ring mqd bo (%d)", =
r);
> --
> 2.37.3
>
