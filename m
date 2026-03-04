Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E6C5EDEC01
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2026 03:05:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD35310E0D7;
	Wed,  4 Mar 2026 03:05:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e5Deh+5T";
	dkim-atps=neutral
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 122E510E0D7
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2026 03:05:00 +0000 (UTC)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-12739fe9a0eso377394c88.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Mar 2026 19:05:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772593499; cv=none;
 d=google.com; s=arc-20240605;
 b=cQz0yGVXHazz/d60YMBi26kQMgeybKcDX+ak5O9h+p9DzMS8hMkPaWNZE/61usjR2A
 BcZGC043ZuZMo8/kkYqbwnAASNGHFyEdtG4sfkCuYuw1n55SfY5GG282006DyWsQm6ak
 iz8/SDZQaqKkhCQtvVlFOcokSFWMHfvv1PhyVWAVk9VZF3BhIwnMcORN4jZJ4tRYZYd0
 L3YSzQsHNTGFZOO50MNYm2dPCrq1gIypHiHR/Q0FgoHYyNeAhh/8A4fr+Sxt3s4KLTfj
 Fd61NgPtal8SKgxGWO4vNcntyByBT5KIO57MX2E3rbgpfec59cHwaYMVXRJGpxBuRJ+6
 0enw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rrmNDmW9/gyoOL9F9f0qdEUnnBQpVaKXF45+OzxSuX0=;
 fh=ef20Xe9w3moUMLSr91PnwNIFupJfidka0pXpS8D+8d0=;
 b=RGRtI8vfNH3XZmeA1MA1mVqR+ouxBZAdllxDmDvVF8AJDVQAS/Zs0qNWFukQbF3Bg3
 zcyi3ib7eYS8WBNwKvQfGMeTure/lmgMZBNRDpgjAqx2T9JxDuKgZ7+gAevqUsuHtEX3
 uO6hjNq4QQqLUVnJkwvubM/j5og4UsC6vFHEyj+TZqDys3DraXbYenBHSopwW+3nVl/Q
 mRQcF9vvZDUGFFdetWohJDrXg0zR9PH09xgYrvzSgnVLhqmj7QPpl2kLC853s3Sbw7EH
 rqFhjzQ2C1fKd+GI7PE4csTbgBGDe02skFq5pj8YLC+M/cFB1KNeQU6adOBI2opWbVix
 wVrw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772593499; x=1773198299; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rrmNDmW9/gyoOL9F9f0qdEUnnBQpVaKXF45+OzxSuX0=;
 b=e5Deh+5TFpLiP8XcaGVquQmq1n0GSvqXPBjmv4mX3uZgQh+pxUNsm37HoyvLXko6wN
 2T2Xpmn7zX4aZZSUu0/kd1TjlnoeGjQCudhboY4eBfDnj5g66MKAkbGUySbS3iiFqKbd
 XTP3ZzaE3JSIciotXZMaXVdXezB2MKsqKIoBG44JvJg9PgxXgi49Oii31kpRTJkQF6MV
 8NudzvPb6rf9diIV5Uor4oiB5zf0SZeei23AXXrnRdfKY7DCa9OEiP/WhB0QWRIe5Nix
 sfLNraLUWT4oblNofKUkhiHvsXyH64DTWJuk+DTYX3PEQDdmrJlxsJFE4aqdH0f45VCV
 /zlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772593499; x=1773198299;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rrmNDmW9/gyoOL9F9f0qdEUnnBQpVaKXF45+OzxSuX0=;
 b=gfZf/7BS3MqzYQ4Hq4/1NvTJU6hYNoRbFBojq3NV7jFuwKTX7xibV+H78kSV1RqlNc
 bd2dGsD21WgOJbTJZMNv5RX6Ozy/pdqpkT67uvANyL8aDT5YsryZEi+7+Z9UHaEj5sOF
 BvxBauEMuE5SMaAs8xq1IdZHhpc3ovKxbcMhDTAwjMZk/+dEc7V063DECbstZXtFbmb6
 bKBr3FcQf6FgnpA35LgHIv/oXU5SqIfEVBdkapU8nINCJ0H16gpalNJk8LGj6JJwf0ST
 aVlUY+ed8DQyAWwR1iCFLgB3J5AymV+JGEikYlj3pCEDgesXI1j5i6aGzBuEUPn9VmXE
 axjw==
X-Gm-Message-State: AOJu0YxbMUteWrGf75qi5fAJXKP9GFCLFct9dY6Eo5OnZ1yxzXZgRwzr
 CBhW8W1hFnDMDjh/PyRj4bSevNVClSyJNz0icxChAddOt47/NnOcdYvHBq6cIBZ4J64bvrVMeMa
 7KGYbfvqhJDSsX848mjlRKfRxktx8E78=
X-Gm-Gg: ATEYQzztjxBtgMGOwM4ZpEDixtEgJ7ufAMKILuh176UZ/Br79Y6WOkPCoGAtZ7X7GSC
 /54FjrAtrRVy3sDuGeryymMhIAsXQ48ZxZhjEwiM/HFUTgXKOsIPP6WQxz/Wh2uUKYgX3QsMvIK
 uOOu6MlUU+7IfLCPvOMaqA3GGVWeVIFhJbrDYpdDJB9JTOlFuYFvSXlzRs1KeGv17v4OCooHsId
 L/jqchfgW1RofZeX7v+gA/pHdaBflTNRvcufmjCcwZ/AVGkzFO5iI1iHikyA+/ElqF9oGotjWX1
 sYsIcpGQjfKhReic0iygnvutknZkcnd+957RA0LiDUR/0neX0sSog7Bg/B5KHjAXmogs3ITtpSc
 utrzI
X-Received: by 2002:a05:7022:6baa:b0:119:e56b:46ba with SMTP id
 a92af1059eb24-128b70b90d5mr82173c88.4.1772593499235; Tue, 03 Mar 2026
 19:04:59 -0800 (PST)
MIME-Version: 1.0
References: <20260304024811.897237-1-kevinyang.wang@amd.com>
In-Reply-To: <20260304024811.897237-1-kevinyang.wang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 3 Mar 2026 22:04:47 -0500
X-Gm-Features: AaiRm52996IUtLpsFe_kyPWpRk_RIYCi-6wUgH7FvfY3q42NZFPVgfnVnhB_hAI
Message-ID: <CADnq5_NhvdRV-GrnP+9DnTVK0zL2jNRsDrHM9XEYFM-bDaiLYQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd/pm: add missing od setting
 PP_OD_FEATURE_ZERO_FAN_BIT for smu v13
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

On Tue, Mar 3, 2026 at 9:48=E2=80=AFPM Yang Wang <kevinyang.wang@amd.com> w=
rote:
>
> add missing od setting PP_OD_FEATURE_ZERO_FAN_BIT for smu v13.0.0/13.0.7
>
> Fixes: cfffd980bf21 ("drm/amd/pm: add zero RPM OD setting support for SMU=
13")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5018
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 3 ++-
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 35d36f2fe7dd..0a7307f5eb4c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -2223,7 +2223,8 @@ static int smu_v13_0_0_restore_user_od_settings(str=
uct smu_context *smu)
>         user_od_table->OverDriveTable.FeatureCtrlMask =3D BIT(PP_OD_FEATU=
RE_GFXCLK_BIT) |
>                                                         BIT(PP_OD_FEATURE=
_UCLK_BIT) |
>                                                         BIT(PP_OD_FEATURE=
_GFX_VF_CURVE_BIT) |
> -                                                       BIT(PP_OD_FEATURE=
_FAN_CURVE_BIT);
> +                                                       BIT(PP_OD_FEATURE=
_FAN_CURVE_BIT) |
> +                                                       BIT(PP_OD_FEATURE=
_ZERO_FAN_BIT);

Is it ok to always set these, or should they only be restored based on
the user's settings?  Same question for the existing feature bits.

Alex

>         res =3D smu_v13_0_0_upload_overdrive_table(smu, user_od_table);
>         user_od_table->OverDriveTable.FeatureCtrlMask =3D 0;
>         if (res =3D=3D 0)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index 4f729f54a64c..fa23f3d4a3fd 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -2225,7 +2225,8 @@ static int smu_v13_0_7_restore_user_od_settings(str=
uct smu_context *smu)
>         user_od_table->OverDriveTable.FeatureCtrlMask =3D BIT(PP_OD_FEATU=
RE_GFXCLK_BIT) |
>                                                         BIT(PP_OD_FEATURE=
_UCLK_BIT) |
>                                                         BIT(PP_OD_FEATURE=
_GFX_VF_CURVE_BIT) |
> -                                                       BIT(PP_OD_FEATURE=
_FAN_CURVE_BIT);
> +                                                       BIT(PP_OD_FEATURE=
_FAN_CURVE_BIT) |
> +                                                       BIT(PP_OD_FEATURE=
_ZERO_FAN_BIT);
>         res =3D smu_v13_0_7_upload_overdrive_table(smu, user_od_table);
>         user_od_table->OverDriveTable.FeatureCtrlMask =3D 0;
>         if (res =3D=3D 0)
> --
> 2.47.3
>
