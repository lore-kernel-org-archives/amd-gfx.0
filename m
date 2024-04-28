Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B877C4345F
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Apr 2024 14:18:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D4C310EBBB;
	Sun, 28 Apr 2024 14:18:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cjAWaIfx";
	dkim-atps=neutral
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4D0110E956
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Apr 2024 14:18:16 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-6ed04c91c46so3571494b3a.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Apr 2024 07:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714313896; x=1714918696; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=89gotI9GFIGOKKX5tkk2l5wTI//pf0JLtFMzR2TbOU8=;
 b=cjAWaIfxg124OwCSnPeUwvi1rV6CyWWzt3quydE1YCV0wkp5AJRu6+RxMb4SYBWn0z
 HvyV4uIBsyH7HSCzUNcwfLyPSIZUOpF3Ir0rNmuqLL8p5uQkLWX5xATAVTXeldY0QN0U
 JYnmbRsRcVvoLJxL/+3pDkotZJN9DUHao5XR1TjNxrxDPCxVJOfiidOcbR8mFGqfSaBf
 i7m7HiFIScpnYb6PT0V+f83dQD+JyGDARfvqVtSWceX7tHz5qIO4HRjH88doqEYuT4Sj
 3Q5YaUIAZsVMXQ3SDTUeBGVPpkTJOdn99DLWvzoWqzc0vel956RJ/WKH4CBiNHzTmZ9r
 EL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714313896; x=1714918696;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=89gotI9GFIGOKKX5tkk2l5wTI//pf0JLtFMzR2TbOU8=;
 b=eQsPQ5q1qmdh7QgzbeBPBZroB2UFy5ezhN7xMQ97Z6NxDrco+3S1P3IGojLUewdFj5
 8AAL+4BeuJP3x7wx20Ea1ShSaQnqDjp9IF5PqGX1AALdXjcX08wodurpvzyQeITSICNT
 o5x/8TvxIFBhcuI+Y/L1+qom57Uekwav1fUe7hxhpGz04hLfiizXUISIboHWUAzkv07O
 1zzNmsTqCXr+5Z9pb402BEIZPmKsR3E4aoClsd/vf5REgmICtqGFCW8V6vYjszYLg059
 hs5VL6oX4+CfRJDFgImACrxpO1xXCRkpqfqEmpa0DQdPTo6YT5ltaoT89ODRD0vE6lg5
 St9Q==
X-Gm-Message-State: AOJu0YypSbIOWeqA9BOWw0ERzLxxyAXgffO00mqnsJp7h5rg3AtMePQa
 0d+8iGlhGuMb8Nj5VgkvG94poVX0vijRqPnjFLJ3o0+Kf48LXosIP5LRl00IpknmNSoZWDGfEKZ
 IYAdu3tUyFGjTrtaiQvEaDK/ajB1hhjXL
X-Google-Smtp-Source: AGHT+IG229ArnrxGHvEuUTUYaVjVfB1QiFxJpypXQc6spkrrj02huL93029DV+eEFCxWUjQdeuZUO9SD8krA8YK1aos=
X-Received: by 2002:a17:902:a50a:b0:1e0:983c:d686 with SMTP id
 s10-20020a170902a50a00b001e0983cd686mr8843454plq.20.1714313896050; Sun, 28
 Apr 2024 07:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240428095435.126980-1-Jun.Ma2@amd.com>
 <20240428095435.126980-2-Jun.Ma2@amd.com>
In-Reply-To: <20240428095435.126980-2-Jun.Ma2@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Sun, 28 Apr 2024 10:18:04 -0400
Message-ID: <CADnq5_OxXXU_2ezR3ruUWK8otWL2MU9gLP=SF8c9z4NsNSMe=A@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu/pm: Fix uninitialized variable warning
To: Ma Jun <Jun.Ma2@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Kenneth.Feng@amd.com, 
 Alexander.Deucher@amd.com, kevinyang.wang@amd.com, christian.koenig@amd.com
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

On Sun, Apr 28, 2024 at 7:12=E2=80=AFAM Ma Jun <Jun.Ma2@amd.com> wrote:
>
> Check return value of smum_send_msg_to_smc to fix
> uninitialized variable varning
>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>  .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  | 21 ++++++++++++++-----
>  .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c |  8 +++++--
>  .../drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c |  6 ++++--
>  .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c |  6 ++++--
>  4 files changed, 30 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drive=
rs/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> index 0b181bc8931c..f62381b189ad 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> @@ -1554,7 +1554,10 @@ static int smu10_set_fine_grain_clk_vol(struct pp_=
hwmgr *hwmgr,
>                 }
>
>                 if (input[0] =3D=3D 0) {
> -                       smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMinGfxcl=
kFrequency, &min_freq);
> +                       ret =3D smum_send_msg_to_smc(hwmgr, PPSMC_MSG_Get=
MinGfxclkFrequency, &min_freq);
> +                       if (ret)
> +                               return ret;
> +
>                         if (input[1] < min_freq) {
>                                 pr_err("Fine grain setting minimum sclk (=
%ld) MHz is less than the minimum allowed (%d) MHz\n",
>                                         input[1], min_freq);
> @@ -1562,7 +1565,10 @@ static int smu10_set_fine_grain_clk_vol(struct pp_=
hwmgr *hwmgr,
>                         }
>                         smu10_data->gfx_actual_soft_min_freq =3D input[1]=
;
>                 } else if (input[0] =3D=3D 1) {
> -                       smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxGfxcl=
kFrequency, &max_freq);
> +                       ret =3D smum_send_msg_to_smc(hwmgr, PPSMC_MSG_Get=
MaxGfxclkFrequency, &max_freq);
> +                       if (ret)
> +                               return ret;
> +
>                         if (input[1] > max_freq) {
>                                 pr_err("Fine grain setting maximum sclk (=
%ld) MHz is greater than the maximum allowed (%d) MHz\n",
>                                         input[1], max_freq);
> @@ -1577,10 +1583,15 @@ static int smu10_set_fine_grain_clk_vol(struct pp=
_hwmgr *hwmgr,
>                         pr_err("Input parameter number not correct\n");
>                         return -EINVAL;
>                 }
> -               smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMinGfxclkFrequen=
cy, &min_freq);
> -               smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxGfxclkFrequen=
cy, &max_freq);
> -
> +               ret =3D smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMinGfxcl=
kFrequency, &min_freq);
> +               if (ret)
> +                       return ret;
>                 smu10_data->gfx_actual_soft_min_freq =3D min_freq;
> +
> +               ret =3D smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxGfxcl=
kFrequency, &max_freq);
> +               if (ret)
> +                       return ret;
> +
>                 smu10_data->gfx_actual_soft_max_freq =3D max_freq;
>         } else if (type =3D=3D PP_OD_COMMIT_DPM_TABLE) {
>                 if (size !=3D 0) {
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/driv=
ers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> index 74a33b9ace6c..c60666f64601 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> @@ -2486,9 +2486,13 @@ static int vega10_populate_and_upload_avfs_fuse_ov=
erride(struct pp_hwmgr *hwmgr)
>         struct vega10_hwmgr *data =3D hwmgr->backend;
>         AvfsFuseOverride_t *avfs_fuse_table =3D &(data->smc_state_table.a=
vfs_fuse_override_table);
>
> -       smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &top32)=
;
> +       result =3D smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop=
32, &top32);
> +       if (result)
> +               return result;
>
> -       smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, &bot=
tom32);
> +       result =3D smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBot=
tom32, &bottom32);
> +       if (result)
> +               return result;
>
>         serial_number =3D ((uint64_t)bottom32 << 32) | top32;
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/driv=
ers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
> index c223e3a6bfca..9dd407134770 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
> @@ -364,8 +364,10 @@ static void vega12_init_dpm_defaults(struct pp_hwmgr=
 *hwmgr)
>         }
>
>         /* Get the SN to turn into a Unique ID */
> -       smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &top32)=
;
> -       smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, &bot=
tom32);
> +       if (smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &to=
p32))
> +               return;
> +       if (smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, =
&bottom32))
> +               return;
>
>         adev->unique_id =3D ((uint64_t)bottom32 << 32) | top32;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/driv=
ers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> index f9efb0bad807..3a95f7c4c6e3 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> @@ -404,8 +404,10 @@ static void vega20_init_dpm_defaults(struct pp_hwmgr=
 *hwmgr)
>         }
>
>         /* Get the SN to turn into a Unique ID */
> -       smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &top32)=
;
> -       smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, &bot=
tom32);
> +       if (smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &to=
p32))
> +               return;
> +       if (smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, =
&bottom32))
> +               return;
>
>         adev->unique_id =3D ((uint64_t)bottom32 << 32) | top32;
>  }

Please align with Tim on the powerplay changes.  E.g., See this patch:
drm/amd/pm: fix uninitialized variable warnings for vega10_hwmgr
I'd like to have consistent function signatures for these functions.

Alex

> --
> 2.34.1
>
