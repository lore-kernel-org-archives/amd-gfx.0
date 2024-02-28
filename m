Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F414C5478C
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 14:25:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA6F710E49A;
	Wed, 28 Feb 2024 14:25:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y2c0saPa";
	dkim-atps=neutral
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 528AE10E49A
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 14:25:38 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-5dbf7b74402so4416126a12.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 06:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709130338; x=1709735138; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7fVEHGf7n/Z5tsOGvlb7khpwnTvIN9sEFj2KS5bzEn0=;
 b=Y2c0saPa+VBsZmxqB0vF23Yl6XfUjWVK43Mog/LvRU8wuQuEkFTVuktAkbuZtUuuyH
 g9SraHuiqINPG3VigKJ/sgYE2dSiiUvViGiOGkzMhRwnqFDIQW9B4k/YFXSbAmYzKNAz
 X+3mYPJ3xL6xDsuXHeaz2G5D3e3iUpPJHRKZrObyFh7mtn0WMPRHq7P+JixkDp/++jP8
 tcwBiDzJGaaqF+7ncOxF1AngFImxabritka8ouxaGdk6JZ3Ca5yTqJJ6VTGuUu5XzCRI
 v9IK/O1dKRfDn2Tv09yQNFBpQcVu10dSANDv0t4e48MS31C9sk6ylhz/QtON8kSgEZ8q
 8NUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709130338; x=1709735138;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7fVEHGf7n/Z5tsOGvlb7khpwnTvIN9sEFj2KS5bzEn0=;
 b=HKLRK+5606V3zcA7nE3z7w+Xguspxeq7dlWEnmJwZ4wpaxS0Ew9+tpjjBdvT3Vlz/Z
 Rzcyc/9ewNxKu65c1MpZ7xjix+em2oKl3FvFs72q4UYAnG1GaBUdHsC6iG9Bk2tDsHiW
 cnImQ5CyQp3G2hKbdvynPWTdVH/9k08EKKj9sD+FKeJzsAcFUcv+aXFrrjm8o2KBllS2
 eaeZsXRhQoE4ZG2je6IM/TavvXweNhOhHHhDycRj/LoXLsOac0czn9L64Cns0kq57ZEg
 f/wjCeu7gOOpnRbFHRbTOKufQ6U5lAcvA/jfbtMBGohgjfKaNm+hSNdreFE/jJ89OVK5
 ZJFQ==
X-Gm-Message-State: AOJu0Yyu/0tzC9seTIVbpt/fUQMEHzj3re1oba0M/h757t32O0+EJ8wn
 Cgls/P7AZdSbSwpnoO+2Q/cJiIHdgNIUcqUz6P94msLywotHRjT0EtCEANdkkhh/l4gr6CrdqHS
 EZMYAozLz7ETDdvy9QDWIQQMzrjc=
X-Google-Smtp-Source: AGHT+IHZ+F54Dl9NPyta1GGdr/nlYVfrYfd2s8QYcZhvXEgK48EQBNtjLEdjtVS/EXM+E+zT47ZBbJYQwZzCsPlBARs=
X-Received: by 2002:a17:90b:4f86:b0:29a:e05f:3f55 with SMTP id
 qe6-20020a17090b4f8600b0029ae05f3f55mr5147495pjb.2.1709130337633; Wed, 28 Feb
 2024 06:25:37 -0800 (PST)
MIME-Version: 1.0
References: <20240228113916.235390-1-li.ma@amd.com>
In-Reply-To: <20240228113916.235390-1-li.ma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 28 Feb 2024 09:25:26 -0500
Message-ID: <CADnq5_Puy+-6xfhjPSF_DjVo9ZJ65zZqkEMJB3qm3U+=tWrYaQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/swsmu: modify the gfx activity scaling
To: Li Ma <li.ma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 yifan1.zhang@amd.com, lang.yu@amd.com
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

On Wed, Feb 28, 2024 at 6:39=E2=80=AFAM Li Ma <li.ma@amd.com> wrote:
>
> Add an if condition for gfx activity because the scaling has been changed=
 after smu fw version 5d4600.
> And remove a warning log.
>
> Signed-off-by: Li Ma <li.ma@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c       | 2 --
>  drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c | 5 ++++-
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> index 2aa7e9945a0b..7ac9bc0df8fd 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> @@ -229,8 +229,6 @@ int smu_v14_0_check_fw_version(struct smu_context *sm=
u)
>                 smu->smc_driver_if_version =3D SMU14_DRIVER_IF_VERSION_SM=
U_V14_0_2;
>                 break;
>         case IP_VERSION(14, 0, 0):
> -               if ((smu->smc_fw_version < 0x5d3a00))
> -                       dev_warn(smu->adev->dev, "The PMFW version(%x) is=
 behind in this BIOS!\n", smu->smc_fw_version);
>                 smu->smc_driver_if_version =3D SMU14_DRIVER_IF_VERSION_SM=
U_V14_0_0;
>                 break;
>         default:
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> index 47fdbae4adfc..9310c4758e38 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> @@ -261,7 +261,10 @@ static int smu_v14_0_0_get_smu_metrics_data(struct s=
mu_context *smu,
>                 *value =3D metrics->MpipuclkFrequency;
>                 break;
>         case METRICS_AVERAGE_GFXACTIVITY:
> -               *value =3D metrics->GfxActivity / 100;
> +               if ((smu->smc_fw_version > 0x5d4600))
> +                       *value =3D metrics->GfxActivity;
> +               else
> +                       *value =3D metrics->GfxActivity / 100;
>                 break;
>         case METRICS_AVERAGE_VCNACTIVITY:
>                 *value =3D metrics->VcnActivity / 100;
> --
> 2.25.1
>
