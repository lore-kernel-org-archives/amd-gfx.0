Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E12B5C77B73
	for <amd-gfx@archiver.kernel.org>; Mon,  1 May 2023 14:56:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5441010E101;
	Mon,  1 May 2023 14:56:01 +0000 (UTC)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7005B10E101
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 May 2023 14:55:59 +0000 (UTC)
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-549d872dec8so1525335eaf.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 May 2023 07:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1682952958; x=1685544958;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=px6ofoI2SLGLz0BzjesbPHTyQdwLis2LOj2UVpTPILI=;
 b=IYOwgEicAVqMlzzFgjB5MaViFhurh13JEXz4XgOR6/ryAztBRTZlmpqL1dBcuSLHWA
 l/20IjOhzmfzG3YztK/us+JV4ch9UKbXe1K/8hL9lFbvTWQKSuhLknwYIIvoRdzzPm7h
 LeqvTo8aM+hdpHmdq+9EQgVdiQwMk2N1AcczN0udV5uQfc4y3oYH9bycFI0kkg5OUVus
 GcQ0X1/O32NiSVCWB//CXjPF7yJjuDiSOhvWvf67f4D1seFl1pG2EMR8MMnxLsfyJ2qp
 OeXKEtcWpbO90U34ghOx89xRICe6XA9dcsa8yXOHlsBzyCJ/l/qYy0h/qPFpUA466wHm
 bbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682952958; x=1685544958;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=px6ofoI2SLGLz0BzjesbPHTyQdwLis2LOj2UVpTPILI=;
 b=ZDM522XYbappLPBJCv6nNO5VrtkLTqqjjDV8XO4yf8zis3qTwEXqWiMyzGpSonimYv
 y7ZXEe+p8ObO3iWNuETQkvguBLIOUB8+ThO1laZgKPeNfiws+bnmamk+/fkilGDUrh/b
 T3TSe9Y4+asWhTtbPcHm8Q2SvBeMN93kqSh1lU+AJ7VlwZb4XKdNyRUtucMaK1JLZW7X
 WayQnVG/AzXd8vCtEyYz8u2UHVzmCnjIgI+zNTBnH8MuTuHKfJJ+WebJVnvA1n1zeepW
 OCYul/4Q4FKFnvOoC81SJNjgTC6nfAY2OWl1bA/ZCza3M1dOBs0UKc45TlYpgBSU5iCq
 CmTQ==
X-Gm-Message-State: AC+VfDygJtkx7ewrWvp86+owgzCk2i+Z6bFVZG7rbZnX9dgwqkd3CoLa
 U0HdTZKXD5OwpONVIcUgk2RmZBvgo9bfs8ogsNFQrzaE
X-Google-Smtp-Source: ACHHUZ41QW2VEOxT63V+IU5ZVC24HrKhaORM01iM1MU/DANPDgmrjNPq9ZHFlhI6hmwyROT8uUTfYjtESI9a82Wncao=
X-Received: by 2002:a05:6808:3bb:b0:38e:76c8:39b with SMTP id
 n27-20020a05680803bb00b0038e76c8039bmr6933567oie.0.1682952958375; Mon, 01 May
 2023 07:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230428155714.1141266-1-alexander.deucher@amd.com>
In-Reply-To: <20230428155714.1141266-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 1 May 2023 10:55:47 -0400
Message-ID: <CADnq5_MP+DN0KKPVRik0iqx1c3j+utbGoUDCcppqqf=w6popsg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: put MQDs in VRAM
To: Alex Deucher <alexander.deucher@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

Alex

On Fri, Apr 28, 2023 at 11:57=E2=80=AFAM Alex Deucher <alexander.deucher@am=
d.com> wrote:
>
> Reduces preemption latency.
> Only enable this for gfx10 and 11 for now
> to avoid changing behavior on gfx 8 and 9.
>
> v2: move MES MQDs into VRAM as well (YuBiao)
> v3: enable on gfx10, 11 only (Alex)
> v4: minor style changes, document why gfx10/11 only (Alex)
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 9 +++++++--
>  drivers/gpu/drm/amd/amdgpu/mes_v10_1.c  | 1 +
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 1 +
>  3 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index 90f5d302d5f3..b91be56ba773 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -382,6 +382,11 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *ade=
v,
>         int r, i, j;
>         struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[xcc_id];
>         struct amdgpu_ring *ring =3D &kiq->ring;
> +       u32 domain =3D AMDGPU_GEM_DOMAIN_GTT;
> +
> +       /* Only enable on gfx10 and 11 for now to avoid changing behavior=
 on older chips */
> +       if (adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(10, 0, 0))
> +               domain |=3D AMDGPU_GEM_DOMAIN_VRAM;
>
>         /* create MQD for KIQ */
>         if (!adev->enable_mes_kiq && !ring->mqd_obj) {
> @@ -413,7 +418,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev=
,
>                         ring =3D &adev->gfx.gfx_ring[i];
>                         if (!ring->mqd_obj) {
>                                 r =3D amdgpu_bo_create_kernel(adev, mqd_s=
ize, PAGE_SIZE,
> -                                                           AMDGPU_GEM_DO=
MAIN_GTT, &ring->mqd_obj,
> +                                                           domain, &ring=
->mqd_obj,
>                                                             &ring->mqd_gp=
u_addr, &ring->mqd_ptr);
>                                 if (r) {
>                                         dev_warn(adev->dev, "failed to cr=
eate ring mqd bo (%d)", r);
> @@ -435,7 +440,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev=
,
>                 ring =3D &adev->gfx.compute_ring[j];
>                 if (!ring->mqd_obj) {
>                         r =3D amdgpu_bo_create_kernel(adev, mqd_size, PAG=
E_SIZE,
> -                                                   AMDGPU_GEM_DOMAIN_GTT=
, &ring->mqd_obj,
> +                                                   domain, &ring->mqd_ob=
j,
>                                                     &ring->mqd_gpu_addr, =
&ring->mqd_ptr);
>                         if (r) {
>                                 dev_warn(adev->dev, "failed to create rin=
g mqd bo (%d)", r);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v10_1.c
> index 0599f8a6813e..4560476c7c31 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> @@ -901,6 +901,7 @@ static int mes_v10_1_mqd_sw_init(struct amdgpu_device=
 *adev,
>                 return 0;
>
>         r =3D amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
> +                                   AMDGPU_GEM_DOMAIN_VRAM |
>                                     AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj=
,
>                                     &ring->mqd_gpu_addr, &ring->mqd_ptr);
>         if (r) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v11_0.c
> index e853bcb892fc..3adb450eec07 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -999,6 +999,7 @@ static int mes_v11_0_mqd_sw_init(struct amdgpu_device=
 *adev,
>                 return 0;
>
>         r =3D amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
> +                                   AMDGPU_GEM_DOMAIN_VRAM |
>                                     AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj=
,
>                                     &ring->mqd_gpu_addr, &ring->mqd_ptr);
>         if (r) {
> --
> 2.40.0
>
