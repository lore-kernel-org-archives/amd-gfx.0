Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7EF0FCE086
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Feb 2026 14:02:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BDA410E02E;
	Thu, 26 Feb 2026 14:02:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fl7k3QCf";
	dkim-atps=neutral
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 962E210E02E
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Feb 2026 14:02:42 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-127337e3870so66191c88.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Feb 2026 06:02:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772114562; cv=none;
 d=google.com; s=arc-20240605;
 b=SszP585YScpEU02CFkc5mxHKXThqFY8OCb60siEmuHhTM6ZUsealE21vvxOoBbMTE8
 7XqRNI3hWUOooP/7euGOFYKjvO0RnsTPX9SWoe6dqH5HXngQaeLVMgHXbTz/dBY/rTtL
 pbIdC/LfMeDDT1/9rkL4mZCK5k6DttP8jYHGdX+C3jeA8xaPG5i4NUTrwDe2otlI4Xzf
 Zz1w/1fCR+kke55aKvcqwYTCCpFBX0C8hz1WP2OmZq+oxtKzwCQvj8T0k83ROj88e8PR
 3K2bBNSfqmN0PPSdW+gM1aiYbydsrNGLGwhs57MSZ2RAbcEogI/Y0GYKGELyOWr3SF5x
 pt+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iSF0navodOevTeizK1AapY2+gsXpGc1nL2EptESoAnI=;
 fh=ef20Xe9w3moUMLSr91PnwNIFupJfidka0pXpS8D+8d0=;
 b=WMFc3J/sfJqrI8ThUmwivxfcRKSYRxR76IUycoazctzOgX6z98rZwvd2o6mXULw6XI
 FBJL+ib9/H2jrRfNuakG1zpfICqxJ2T4frFZmul8U0zGifHRMr7dAyT09u+MVDXxW/ji
 t49mEOe4W4OVp0lez0XUZza9q/WAQPDn/ZKk52Pui03VqvGtnjP28ZEkAQzc9KeC2v/F
 x76Fpwsad3f5I4pIMlDI9hWEEY+c0uqXGLy5eJ5qR0KARg7lhhya1L0v7ObSi+W9uBVG
 B1/THQmkeD2kJ9FLusIYwWy3RmfwK6TrA9Hdof42NNC/iVhPQByUcsON7Lvi5iDTTUSS
 8v/w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772114562; x=1772719362; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iSF0navodOevTeizK1AapY2+gsXpGc1nL2EptESoAnI=;
 b=fl7k3QCf0VhKUqU/UQP3nKuUaeMKF3kwlMH7GPBJYk2hPlfHLRWu7BwCXXqScayA4r
 FMNmnxHJGJbI03vuGijuZndicrQ5bW5n7ds5v7afyx9q/+pOz/2y+X15p7sGp1wtLTHD
 OTH/H2D7IW2otlZsgrslTojn+GE7gFUcThbFoMqR6+I41kDmPWlvZ0I9YRgi4QFTtI/7
 mCRosbBjWMmiPn2vl2bDPn80DUanDm4oELuyeZWJdf9hxliHcPQVN5wlqITtMBBfLX70
 kv+T5ZX0E7iIqcZlVc/sDMEkCzM2leKbXxMiNidpU79LWRO5FbaBukIThvgAOd4NYGvi
 2sPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772114562; x=1772719362;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iSF0navodOevTeizK1AapY2+gsXpGc1nL2EptESoAnI=;
 b=RDJCDT3eY4efE4XIs60h9EyeqLBcjilr0VqGk//kLoB205Ie9ByUVaPrbFNwmmPhI/
 q2AJpka+zaF/A00ykDPxQC0wddkjiYq5181fRdp0A3pcViPpk6kDRAcwlocI601FrKOL
 UAz0ZMOVIiM0a0gSyGxPTshccqQgPEutaMMjnGrnzzxqHnurqCIpT/8InGwosXrVWsFz
 Wc+b0CBEnuQ91TeZRwaEvgtGSNXT6bEFy6Chd5aQzAsSuwNemrxDgrAmihS4y96FIcXM
 L6Tf3JF1HUQ1e8X8mElm13IKgzZtm71xWbSY1PhwqUyGizz+93OZR/AZPZpIiK/6mDmb
 9cgA==
X-Gm-Message-State: AOJu0YwwctdRBZxrG0HAY93sNG+o+sfZZkYzR8rHQ4DAasRdL8YeJX6g
 oktPSYku+yy6EWfRYzyrIRNAqREhDPtMN9eKcSWSZ0o5kti8mfBkwLtu/9eISsNrg+FEic/1RAb
 nVPSJSv0Ns5Mda+DVsXzQatdxwub5tJg=
X-Gm-Gg: ATEYQzwKlSJHRMAS5SU7H7PJUcgHQtAJKVafyaYaF2c84x4O98q3+H1E5ih66EZpYzm
 AL2yeCUX9+CjCOZumMP/zpzQIVDTwPR8Ebwr8Uwm/WWjsaiTX8SFJrgAg8VjLzNDqVqXSD0VLNw
 Dm2rf4KdBkAKt2HIxqeNs4eWIrvvjYSrMcnuRJ+eHb7RznNZ9JwSkc56UvnC3mi/w86w1ZFTJm3
 2k6olb4EkP2keE4Lig+1UNiMARCZUjnvMU4vyn7bX6wWai6nRon8c6PlD8sadfexkg1jEBwcdGm
 Gj55TeAGNbFs6fZteoncbX7Op3EWVH1VoFZwCxSG8WNknAcEd1jLnzYfwl0e4HZySSoBCASKS1F
 Y/EF3
X-Received: by 2002:a05:7022:521:b0:11e:3e9:3e88 with SMTP id
 a92af1059eb24-1276ad1a953mr3821893c88.6.1772114561503; Thu, 26 Feb 2026
 06:02:41 -0800 (PST)
MIME-Version: 1.0
References: <20260226063415.509989-1-kevinyang.wang@amd.com>
In-Reply-To: <20260226063415.509989-1-kevinyang.wang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 26 Feb 2026 09:02:28 -0500
X-Gm-Features: AaiRm53I3xhf3q0EDkmg5DRwEgTXzERfrQdIr8mde1LFyamOezypEFkIxXaKV2Q
Message-ID: <CADnq5_OhVy3vw-jvW0k0gCVc9+xKyR4GgKv=2ycnvmE14jVedQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/pm: remove invalid
 gpu_metrics.energy_accumulator on smu v13.0.x
To: Yang Wang <kevinyang.wang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 hawking.zhang@amd.com, kenneth.feng@amd.com
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

On Thu, Feb 26, 2026 at 1:54=E2=80=AFAM Yang Wang <kevinyang.wang@amd.com> =
wrote:
>
> v1:
> The metrics->EnergyAccumulator field has been deprecated on newer pmfw.
>
> v2:
> add smu 13.0.0/13.0.7/13.0.10 support.
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 8 +++++++-
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 3 ++-
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 468d51f5f918..35d36f2fe7dd 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -2035,6 +2035,7 @@ static ssize_t smu_v13_0_0_get_gpu_metrics(struct s=
mu_context *smu,
>                         smu, SMU_DRIVER_TABLE_GPU_METRICS);
>         SmuMetricsExternal_t metrics_ext;
>         SmuMetrics_t *metrics =3D &metrics_ext.SmuMetrics;
> +       uint32_t mp1_ver =3D amdgpu_ip_version(smu->adev, MP1_HWIP, 0);
>         int ret =3D 0;
>
>         ret =3D smu_cmn_get_metrics_table(smu,
> @@ -2059,7 +2060,12 @@ static ssize_t smu_v13_0_0_get_gpu_metrics(struct =
smu_context *smu,
>                                                metrics->Vcn1ActivityPerce=
ntage);
>
>         gpu_metrics->average_socket_power =3D metrics->AverageSocketPower=
;
> -       gpu_metrics->energy_accumulator =3D metrics->EnergyAccumulator;
> +
> +       if ((mp1_ver =3D=3D IP_VERSION(13, 0, 0) && smu->smc_fw_version <=
=3D 0x004e1e00) ||
> +           (mp1_ver =3D=3D IP_VERSION(13, 0, 10) && smu->smc_fw_version =
<=3D 0x00500800))
> +               gpu_metrics->energy_accumulator =3D metrics->EnergyAccumu=
lator;
> +       else
> +               gpu_metrics->energy_accumulator =3D UINT_MAX;
>
>         if (metrics->AverageGfxActivity <=3D SMU_13_0_0_BUSY_THRESHOLD)
>                 gpu_metrics->average_gfxclk_frequency =3D metrics->Averag=
eGfxclkFrequencyPostDs;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index a6c22ae86c98..4f729f54a64c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -2066,7 +2066,8 @@ static ssize_t smu_v13_0_7_get_gpu_metrics(struct s=
mu_context *smu,
>                                                metrics->Vcn1ActivityPerce=
ntage);
>
>         gpu_metrics->average_socket_power =3D metrics->AverageSocketPower=
;
> -       gpu_metrics->energy_accumulator =3D metrics->EnergyAccumulator;
> +       gpu_metrics->energy_accumulator =3D smu->smc_fw_version <=3D 0x00=
521400 ?
> +               metrics->EnergyAccumulator : UINT_MAX;
>
>         if (metrics->AverageGfxActivity <=3D SMU_13_0_7_BUSY_THRESHOLD)
>                 gpu_metrics->average_gfxclk_frequency =3D metrics->Averag=
eGfxclkFrequencyPostDs;
> --
> 2.47.3
>
