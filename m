Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416B5606A323
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 15:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lxXM03ah
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7CB410E42C;
	Thu, 22 Oct 2026 15:37:16 +0000 (UTC)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com
 [209.85.217.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A74E110E42C
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 15:37:10 +0000 (UTC)
Received: by mail-vs1-f54.google.com with SMTP id
 ada2fe7eead31-7cc3df7eb05so123588137.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 08:37:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792683427; cv=none;
 d=google.com; s=arc-20260327;
 b=dYrd/7ZQkI6PsPd9KSgJ/oii70he0Dsr0324bajFCcDEUUpaaGV5aU94jO1XDiVgEk
 xrTCOAc4LEKywnNpAQCqDBs/lLf5FJaN2czqbSFVWc3VQql+qvraSdZUrwU12IVS17WM
 MqJMmge0C7AqUwcIb7sicj+E0UpeS3G1gIvMVm1eZ2NttqocXS8MjIDRYSglmNyp5oFj
 zXtvpxlxEtka7hZSXo/MGqvZdAx1ZkaXQLQnuWDL9I+3ppLVS3cRDcN8bTI2Rl6VJySh
 QJ/J4MP9Yp6ZZzEGCP7eN06+UZCmyosb6KjGpEWMv5CA+O1m/XEkbhUa5Uj5yddydDxp
 ahIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XOYzdXrYRfYrzeQrBaTVKlwEqvPeoO3BLURZAPfM7yA=;
 fh=ha0IybXjterB+Z+WUE68InDk1auUb5RYFaNgjgSrE9I=;
 b=NZ+OyG9yJ1QXWV275c7SIKTq0JdVIomU+mS68+Fh3HaF70hkt7XOsG46hCd4XmBMoY
 17wsaXr5eKTqMSwITll1w7Kjg3LxzJw1gRJuSLwpAyE3YR7HHkSPcsFtsbz+uxKOh8YU
 pqQOvOKIXgORjaEtaGglyNz6ssRh3RE1Pj6JjUNwy0uF0SWHtwjQSHLXfekzJgGAvNex
 804QuomZxM3oODIOk8d8DjCrtBdoBeZZRVIOfcSyQwMg2RMkaoN+KLtKUV2DpwORPHeb
 izDofAr9ZG8EosYUy8r+GF3aJWW92Y63d36Z8/oZ7vVCFOFnSkNCNIA1XSteBnfCZbKY
 dLsw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792683427; x=1793288227; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XOYzdXrYRfYrzeQrBaTVKlwEqvPeoO3BLURZAPfM7yA=;
 b=lxXM03ahdvSwAUB71huftTAogwxTphVrNXaMeuWyIWBICC5Jd/tx2AdXfo1YLkXykJ
 86zLkR8/i7cFrhOY5+R77odpxqfeZYUFv92GNqQ6ZJuN5JMwLFnXhGB27cteka+Ecwgz
 PmzMU17+YS2eKFmq1drlQRE/bSSsizzP/mcOc5rs02F8GPcujAS1y3zqOOXRN1g9pxeD
 GSgh5blqBHRr3m3QRXJ7DXrSDMA9/hT9iM8dPVirjxTN2ryt34t5pbdH2sssHCnr9vCa
 fasnz0+BM8/8y2cMh6h+HL6asuu+PghRxM2WJAzZKl7DXeNNIkBqUFzQW0jvKtP9OaQN
 Z7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792683427; x=1793288227;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XOYzdXrYRfYrzeQrBaTVKlwEqvPeoO3BLURZAPfM7yA=;
 b=Lw8eaC9pKiSBzN5Rq4q+IUQYxNYiOAts1GsZ2a1iRugGNmin/plVegHPAESmZAvXEd
 vbch8sJKh0M/bEJwo46WGayNJq9kOh0WKffiAsxCn1J8EtCttnKWC4xDKAWUnTF0hhrZ
 bk1Dlf+tvKh4WcQ570XZOCnI6s6zRPXea17hg/fqiRBXbRGVIkzY0pyIzSH4g5yp+dBc
 AAn8kKhZpCS8MI2HP7HH84tq3M7g0jArGy2TTP4sFcQC1wp6v6KXF0rBMoWz7vpEnwbQ
 rELCkP53eIxWx9iDD4R+jxMhVaZr0pDsycDThGLeKN1J4nCtbF5Ta16AKZV0qQQ9h47Z
 rw5w==
X-Gm-Message-State: AFq9FYJvIwQnBuALK2s/wB+1LwgJome9ajkGx1r22h63jt8p1WwkxG2p
 zFQW3iTswtYCe2LuBYMM3hnpBg9RjVC2ewU9SWDcgaj/UdX9xWsoEiLsDAbR2SKXEdA2cY9pFXL
 fc6DEgk87SP1JHaSATMXmVVnoZON8yU8=
X-Gm-Gg: AYBFou3geeiuAMdxvy0JSa1k/4fZIoD25nW6veQVLc+0fc2LX68PdFv7Y5BswM9XS0L
 IQAWhxeVgmhnfVdSu6WoyB8HUr5thH5/GQGZqqUrSeyZAo7E5+bBlpnl0QCl178Ihab86mAx7ob
 4sRnD/66MktakFJOngOPCma7KLKSIt1uYPzuDwtgIL7s077MDTx+LQdHYDUvMvgantSa9eXJ6r8
 FhgPbglxPoFNCdae/ufJNEM7PijqlXVRMNmSGOU/H8tLsGg9r7979N0wgQ3D3agbIb9WcbN8m+b
 AWK2YJW+Cg8EWdvFxZ3X6xDLuQmOsn/JIAdbODNuUGGYljhdIgcRMlqI/HlXwY+GQhyVsgineF1
 Ywdtw20d5qy51nMwvHvWrJ+pAr+OjGa47DAspWYa7la7VWZ+FY0iHrO6unn2i5ukn8mtVYwGrSD
 CWfcCq3Fca1zimWZEmlC5j5Mc=
X-Received: by 2002:a05:6102:4194:b0:7c8:3b8c:82ae with SMTP id
 ada2fe7eead31-7cc926171f6mr1812950137.2.1792683426755; Thu, 22 Oct 2026
 08:37:06 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022014728.84081-1-amber.lin@amd.com>
 <20261022014728.84081-2-amber.lin@amd.com>
In-Reply-To: <20261022014728.84081-2-amber.lin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 22 Oct 2026 11:36:52 -0400
X-Gm-Features: AclHuK-XpUTRPvR1My1gHo9vM0d3B7OT_UytcxRtRGeDSymu1MlBz5FcpAahxGs
Message-ID: <CADnq5_Mf1B3j-wjzPhUri4MMueaULkxJCQMXevRnJkqE2DiRpA@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: Add debug messages for MES queue reset
To: Amber Lin <amber.lin@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Shaoyun.Liu@amd.com, 
 alexander.deucher@amd.com
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
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 9:56=E2=80=AFPM Amber Lin <amber.lin@amd.com> wrote=
:
>
> This patch adds debug messages to collect some MES queue reset data.
>
> Signed-off-by: Amber Lin <amber.lin@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 12 ++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c |  1 +
>  2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index 0ae6e990c310..0c1c8ae822d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -2495,15 +2495,21 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_de=
vice *adev,
>          */
>         r =3D amdgpu_mes_suspend(adev, 0);
>         /* if suspend all success, it should no hang queue */
> -       if (!r)
> +       if (!r) {
> +               dev_dbg(adev->dev, "Suspend all succeeds. xcc_id %d\n", x=
cc_id);
>                 /* always reset the KCQ/userq since we need to signal the=
 fence
>                  * and we could be stuck in a loop which is preemptable.
>                  */
>                 goto fence_reset;
> +       }
>         r =3D amdgpu_mes_detect_and_reset_hung_queues(adev, AMDGPU_RING_T=
YPE_COMPUTE,
>                                                     true, &num_hung, adev=
->gfx.mec.mes_hung_db_array, 0);
> -       if (r)
> +       if (r) {
> +               dev_dbg(adev->dev, "MES fails on detecting hung queues\n"=
);
>                 goto out;
> +       }
> +       dev_dbg(adev->dev, "Detected %d hung queues\n", num_hung);
> +
>         if (hung_queue_count)
>                 *hung_queue_count =3D num_hung;
>
> @@ -2530,6 +2536,8 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_devi=
ce *adev,
>                 pipe =3D hqd_info[i].pipe_index;
>                 queue =3D hqd_info[i].queue_index;
>                 queue_type =3D hqd_info[i].queue_type;
> +               dev_dbg(adev->dev, "Hung queue: queue_id %d at pipe %d ty=
pe %d\n",
> +                                       queue, pipe, queue_type);
>
>                 /* reset any KCQs */
>                 r =3D amdgpu_gfx_reset_mes_kcq(adev, ring,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index 2ff1816adfc4..58766b27e150 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -557,6 +557,7 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct am=
dgpu_device *adev,
>         for (i =3D 0; i < adev->mes.hung_queue_hqd_info_offset; i++) {
>                 /* Finding hung queues where db_array[i] is a valid doorb=
ell */
>                 if (db_array[i] !=3D AMDGPU_MES_INVALID_DB_OFFSET) {
> +                       dev_dbg(adev->dev, "MES: hung queue doorbell 0x%x=
\n", db_array[i]);
>                         hung_db_array[i] =3D db_array[i];
>                         *hung_db_num +=3D 1;
>                 }
> --
> 2.43.0
>
