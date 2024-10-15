Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E908D1D88B
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Oct 2024 16:51:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B80C10E0D7;
	Tue, 15 Oct 2024 16:51:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TOLeQ7MX";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B91F410E0D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 16:51:10 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-20cafd36ed0so1934865ad.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 09:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729011070; x=1729615870; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VeVfaHD3MrOsQE+QxyrnCQrbcMxZRX5ffE43jGr1vvI=;
 b=TOLeQ7MXMkPJuqvntfnnNPwDSiRTzmxYEp8BQTh6gJ9uob2oaOxSAPcBvZ79gmP8A0
 /KLinryPqEooAHc/Tih4dPKSLV9II5Cvu2FIHrjiv9x1EXJaXXfo7z7f/L14XJ+0RQK1
 imYMaadct1VA4lCor5aG4H7fetv7zfx4Fm+g9jHFLEiB9UdomQJqZny19cnCz30Bm3j/
 kp3ZlgCBt0ur4pynmGhQjPasGGaCAdNGkYFr6uaYE6dKCUSGk5eAJk4w2yRwpQXRP5zr
 xeSc7fKNOYk1Hm1YHuJ9oiUzkbjrhX9p6fBchOUu1i0XbBaFcII/nLw1c9lAhDAg52dm
 n0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729011070; x=1729615870;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VeVfaHD3MrOsQE+QxyrnCQrbcMxZRX5ffE43jGr1vvI=;
 b=I5Kq7BQvxFdRKHHqmpeyJXq65szGspXFSRNHwa3rdg7wZMYJESmD2GQo7hJ4sXxd/c
 ccFec3yluLAQQrW+b6r6JP2Z/WBgQ0CTZlX+s8J1q8yoNSLDq7QGROWOrKs+XupPPDrg
 GYYTNqJxZ3yF3lWhHv0Vn0x/AKOCl68PQcH9nbEzMv31YKSQCyUCTfRZ35UWfrGIzSeg
 B/Vl8kAeK7z8FNoj0Bi5EK+RYIKY88JV0xyAL62cHQflVlqPZN6mbFc/wPAyYH3ya3IG
 uDgeOr34c+IB9cNjFkxGR4bwkLvjH5d33Wzc1Ut38uWOsBHya7/4fm4YC6nQUIOajTDg
 RDBw==
X-Gm-Message-State: AOJu0YwEJheqN+h+ra9RG94EhVNO7EPKSL57p1D2podJA9bWjWyqiKmT
 hxSQFlxzz2WO2YiY8kNu5AHAnj2W6vl06tOjOZaTG7cArIeQD7m1BoR8kCCOS+BJDVj20xyMfiv
 jo+of2KhPmlDZfTy720bGVky7qqQ=
X-Google-Smtp-Source: AGHT+IGTQF08DGK3BBXrrLUW/44fE52cOwGcyia3xoq3E6gFbF4Bqf8JYn4rrVXdJG9ke/JRaOt81idCCQHlRlwcXsE=
X-Received: by 2002:a17:902:f685:b0:20b:7a43:3693 with SMTP id
 d9443c01a7336-20d2cb18e40mr169475ad.1.1729011070249; Tue, 15 Oct 2024
 09:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <20241015162355.881-1-shashank.sharma@amd.com>
In-Reply-To: <20241015162355.881-1-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Oct 2024 12:50:58 -0400
Message-ID: <CADnq5_P_TuHCFOuTRRBBCB0XqMB3eQ=Zk2e1UoZEZemyLzMAqA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: set MES GFX HQD mask
To: Shashank Sharma <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <Christian.Koenig@amd.com>, 
 Arvind Yadav <arvind.yadav@amd.com>
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

On Tue, Oct 15, 2024 at 12:33=E2=80=AFPM Shashank Sharma
<shashank.sharma@amd.com> wrote:
>
> This patch sets MES HQD mask to setup GFX queues for MES and KIQ
> operations. We are using one queue each for KIQ operations, and
> setting rest of the queues for MES scheduling.
>
> This also fixes a regression for missing Navi 4x MES mask from
> usermode queue series.
>
> V2: Rebase on staging, accommodate existing changes on Navi 3X
>
> Fixes: 1d316a52498f ("drm/amdgpu: fix MES GFX mask")
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <Christian.Koenig@amd.com>
> Cc: Arvind Yadav <arvind.yadav@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 20 +++++++++++++-------
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 15 ++++++++++++---
>  2 files changed, 25 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v11_0.c
> index 03bf865fbdd4..1f8ce64a5bff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -654,6 +654,18 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
>                         offsetof(union MESAPI__MISC, api_status));
>  }
>
> +static void mes_v11_0_set_gfx_hqd_mask(union MESAPI_SET_HW_RESOURCES *pk=
t)
> +{
> +       /*
> +        * GFX pipe 0 queue 0 is being used by KIQ

Minor nit, pipe 0 queue 0 is the kernel gfx queue.  KIQ is in the MEC
and managed by MES on gfx11+.

> +        * Set GFX pipe 0 queue 1 for MES scheduling
> +        * mask =3D 10b
> +        * GFX pipe 1 can't be used for MES due to HW limitation.
> +        */
> +       pkt->gfx_hqd_mask[0] =3D 0x2;
> +       pkt->gfx_hqd_mask[1] =3D 0;
> +}
> +
>  static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
>  {
>         int i;
> @@ -678,13 +690,7 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_=
mes *mes)
>                 mes_set_hw_res_pkt.compute_hqd_mask[i] =3D
>                         mes->compute_hqd_mask[i];
>
> -       /*
> -        * GFX pipe 0 queue 0 is being used by kernel
> -        * Set GFX pipe 0 queue 1 for MES scheduling
> -        * GFX pipe 1 can't be used for MES due to HW limitation.
> -        */
> -       mes_set_hw_res_pkt.gfx_hqd_mask[0] =3D 0x2;
> -       mes_set_hw_res_pkt.gfx_hqd_mask[1] =3D 0;
> +       mes_v11_0_set_gfx_hqd_mask(&mes_set_hw_res_pkt);
>
>         for (i =3D 0; i < MAX_SDMA_PIPES; i++)
>                 mes_set_hw_res_pkt.sdma_hqd_mask[i] =3D mes->sdma_hqd_mas=
k[i];
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_0.c
> index 3daa8862e622..78aad9c4ddbc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -557,6 +557,17 @@ static int mes_v12_0_set_hw_resources_1(struct amdgp=
u_mes *mes, int pipe)
>                         offsetof(union MESAPI_SET_HW_RESOURCES_1, api_sta=
tus));
>  }
>
> +static void mes_v12_0_set_gfx_hqd_mask(union MESAPI_SET_HW_RESOURCES *pk=
t)
> +{
> +       /*
> +        * GFX V12 has only one GFX pipe, but 8 queues in it.
> +        * GFX pipe 0 queue 0 is being used by KIQ.

Same comment here.

With those addressed, the patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> +        * Set GFX pipe 0 queue 1-7 for MES scheduling
> +        * mask =3D 1111 1110b
> +        */
> +       pkt->gfx_hqd_mask[0] =3D 0xFE;
> +}
> +
>  static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
>  {
>         int i;
> @@ -579,9 +590,7 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_m=
es *mes, int pipe)
>                         mes_set_hw_res_pkt.compute_hqd_mask[i] =3D
>                                 mes->compute_hqd_mask[i];
>
> -               for (i =3D 0; i < MAX_GFX_PIPES; i++)
> -                       mes_set_hw_res_pkt.gfx_hqd_mask[i] =3D
> -                               mes->gfx_hqd_mask[i];
> +               mes_v12_0_set_gfx_hqd_mask(&mes_set_hw_res_pkt);
>
>                 for (i =3D 0; i < MAX_SDMA_PIPES; i++)
>                         mes_set_hw_res_pkt.sdma_hqd_mask[i] =3D
> --
> 2.46.2
>
