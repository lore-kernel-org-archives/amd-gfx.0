Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 419E2C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 15:02:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2506A10F6B6;
	Fri, 12 Apr 2024 15:02:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JeKh2fSm";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22CB410F6B8
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 15:02:51 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-2a52c544077so724872a91.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 08:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712934170; x=1713538970; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UmFUC9KhpdncCS0F5Oh7TT55jSarEga6yVLwHDBs7ho=;
 b=JeKh2fSm/snZJP6s7bQj+ei0pNha9TzqMSr4lIH8G+uDlbKxUl3i8FQ2hHeWT5pjQX
 p/xUa6ZaoIYpilNKnD7uiVUGAQY3CDvQrJwRXqU1GyjeqHq4dm5MVgezC5iSG67wBUPY
 0fmQYCkf7s/7tpvAWF39lmSEVWwoIfO+Bifa3u/DYAgRilN2YN4oSqzIjSHJltXzbaZ+
 TFCQ23VySKz9K3ZDlOfKn8cHBwVE6fNTSuQex74u7uyiIbylAv3nGxAbr+6fUPYpuUC2
 rhcgHqB01o3LssQK9aEIIiUhIbHKhy4BuczKYvo1MHtkEJ0/G+ESsZfXJ3M2Y/nK1QLT
 880Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712934170; x=1713538970;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UmFUC9KhpdncCS0F5Oh7TT55jSarEga6yVLwHDBs7ho=;
 b=tKc6sVVluy4zbrpJbmpc328D8KOjYmzd9zhOi9dwWtbENnAbOrqIArBDuqyvAJH+ef
 GBdpU4NJwap0ix/HYcIgjJwzSDM2ayUQRPEh9b2keDXfmxVZLHTTUta2HU/iXRMWOCb1
 LUvMZundVF3haLXjsrTItuuL6zGaDv+cIUPhQSfd4yFdps2HkC2+yE2NcTftp2o58MeH
 Av6oP7qs++IvvCjSs+C5+4h5gRZnAnG5/zlL6Vp28ySON9S54516E/QibfBM/OvzNkK7
 NXdp1vLkZlSPgWdDgEqgnlMt+25XqgMF3D0VQLY5QlQZjlqlTfSrXiLyPyGSCuBXjHYm
 SlZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyDuS+3W26v3tkxo5LMsA6htKiorQbbDZulKS+Pm+w5OfHqRF8DMEZLnpiXMZxcLpctboufTvQQgQlIJC1iITT6wAdljPuEt6DrGljgg==
X-Gm-Message-State: AOJu0Yw1ZP7SDYFkMB85xAcicyfplDKoVmbgA/TIF5b6UNrfF/C6OW0B
 89bXRQBKn37YMJS05w3K4wF4EGnLZR+SyBQUxccpSLUuw4R/MPvRgmi9DE1bfI8ta1yYiaNlpZd
 1TOfAPSGmAbZlQ3A42j+bZpUZM9Ppkw==
X-Google-Smtp-Source: AGHT+IGk+xadMWfY6n7TrSdlrAcUNiBn4n5Vj9v0WZo3b1SO2a/vbiXJkbm+U+EthLS2kABXTo9AyxoJpbr0K8nQFdY=
X-Received: by 2002:a17:90a:7781:b0:29d:fe34:fa16 with SMTP id
 v1-20020a17090a778100b0029dfe34fa16mr2770820pjk.21.1712934170420; Fri, 12 Apr
 2024 08:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240412112510.25575-1-sunil.khatri@amd.com>
In-Reply-To: <20240412112510.25575-1-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 12 Apr 2024 11:02:38 -0400
Message-ID: <CADnq5_OiQuRv9nGFOrMTtDPfP23RivJct1oNC-9YF8gRWZa_Sw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add missing vbios version from devcoredump
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
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

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Fri, Apr 12, 2024 at 7:25=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com>=
 wrote:
>
> Add vbios version in the devcoredump along with formatting
> the information with proper alignment.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> index 1129e5e5fb42..64fe564b8036 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> @@ -188,10 +188,11 @@ static void amdgpu_devcoredump_fw_info(struct amdgp=
u_device *adev,
>                    adev->vpe.feature_version, adev->vpe.fw_version);
>
>         drm_printf(p, "\nVBIOS Information\n");
> -       drm_printf(p, "name: %s\n", ctx->name);
> -       drm_printf(p, "pn %s\n", ctx->vbios_pn);
> -       drm_printf(p, "version: %s\n", ctx->vbios_ver_str);
> -       drm_printf(p, "date: %s\n", ctx->date);
> +       drm_printf(p, "vbios name       : %s\n", ctx->name);
> +       drm_printf(p, "vbios pn         : %s\n", ctx->vbios_pn);
> +       drm_printf(p, "vbios version    : %d\n", ctx->version);
> +       drm_printf(p, "vbios ver_str    : %s\n", ctx->vbios_ver_str);
> +       drm_printf(p, "vbios date       : %s\n", ctx->date);
>  }
>
>  static ssize_t
> --
> 2.34.1
>
