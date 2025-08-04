Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 322CCC87FCF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 15:32:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9F9410E0D3;
	Mon,  4 Aug 2025 15:32:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Omlsa9n7";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B93D10E0D3
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 15:32:52 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-23ff92d05acso9981155ad.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Aug 2025 08:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754321571; x=1754926371; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dVEHvd9pjKmLZFoaTVdrkxIQReqCpgGp/D8aK6+fxxY=;
 b=Omlsa9n7v76RkdbLHIn3euD/e4V31JrVQ3UmRg+YMJMmTnfg2SluzpKFetcLEzwHCW
 CYaZe1GqLjm5c12foq40bXKrwDh3kAposCSR8k/qur8rZ192asJpO9FBpqNVaAYN6r1T
 YnV3UFTwHfxoRoYSqRXCRaKLmDxWILefkLNptnmYQsR57/tiF05+nI53KthoZmn5NJJq
 uAatiesj6JEo2OdF8uz+dC4V7S3f+7rAE6gNj46bBcixH48f2I2UNAKk0qrCrwwUIKet
 yyjn6E/0Y58rRdhA9FXzdJ/R0FZSEDoOXsbp/SmZ83sN9vCyHszvwZK1a93XwiqXSiuP
 3Qmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754321571; x=1754926371;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dVEHvd9pjKmLZFoaTVdrkxIQReqCpgGp/D8aK6+fxxY=;
 b=xH52n3olrUhBfu+ViY1PrDLmxXu8SwedSSIodRnDhjDQYkyZ573/SbfW3n/lHIYwC0
 D87W7ZzCZ4DjD9Bs2psu+JsjxJXKmrGHqjS9khjRG/zgkfqvfk7s90KnBH7RkITOK3lH
 w61bAwFiE90KjuShlofkl6EMLemFklu+VKV6YO9uyYvjDjoA15jpSkVsgmztw9ux0J79
 lXiFLQL2t5kVFWyvvhPD4D1FVnkjKc0P8K6SnG6vqGidLk2fFL8NeTOt46emu/+h5+lP
 UTIs93klRK+1WHKPZnfHc1k9Z3LwM9mq2JDhSQhxhzwMmymlEljo8/xT4Lj6lb2UScMV
 Qj5g==
X-Gm-Message-State: AOJu0YzYi5vqILfKxqHsfKwiR5Pb6PSYukFGdFL/XNPdIOBuwhNsHUoi
 BYo+Dk8k6eENqWm6ePYtzoXp9s8w1x4zdWqh4h5WNH4Fvb1q0UiRi2aX5W7DLL+YeZM57un1OMW
 weIsydaPvy7g+psSRMBDFSUxWUkNbos8=
X-Gm-Gg: ASbGncvmQ6iasxs/kSij1PCoLHs6tJkt/w9iaF/WCOX0RAFf5o0doK5mHjtQPmrzSvQ
 KYd3Bl+cWzWaNrqcATKPnYinJw2MkJQfM8nGBQPlH9UJR9FiE7Pseb5lIb9GKQKWVanvDuRZlB5
 MVKvsY8tuIiQCbhYvYw6x7szmbX4x+r6EkHIw4MaF+nbs/Q+6F8z6PrSBHRAqJ+F/A3diHjfVoc
 cEw5PPj
X-Google-Smtp-Source: AGHT+IG0NrQZ8jkUb9VmXLHulRRh/k11TRBmRKx9RyA8gmsWWYGEb56cevurlUktoaB+w/ZiAdMzBcREOgQ420FmWPs=
X-Received: by 2002:a17:902:e74f:b0:240:52d7:e8a4 with SMTP id
 d9443c01a7336-24246fe5ea1mr58806265ad.7.1754321571519; Mon, 04 Aug 2025
 08:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250804134154.95875-1-timur.kristof@gmail.com>
 <20250804134154.95875-5-timur.kristof@gmail.com>
In-Reply-To: <20250804134154.95875-5-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 Aug 2025 11:32:37 -0400
X-Gm-Features: Ac12FXwO1Eip6-CbYhmC5___YL7r2Ep4DFRDdycGXL6Za7hPSXhX4cMrd00QAYg
Message-ID: <CADnq5_P6EsOrX8e8B3bRh_KEaPVisUAEWxZ9uXX62TY=a-dO3g@mail.gmail.com>
Subject: Re: [PATCH 4/6] drm/amd/pm: Fix si_upload_smc_data
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Mon, Aug 4, 2025 at 9:42=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@gm=
ail.com> wrote:
>
> The si_upload_smc_data function uses si_write_smc_soft_register
> to set some register values in the SMC, and expects the result
> to be PPSMC_Result_OK which is 1.
>
> The PPSMC_Result_OK / PPSMC_Result_Failed values are used for
> checking the result of a command sent to the SMC.
>
> However, the si_write_smc_soft_register actually doesn't send
> any commands to the SMC and returns zero on success,
> so this check was incorrect.
>
> Fix that by correctly interpreting zero as success.
> This seems to fix an SMC hang that happens in si_set_sw_state.
>
> Fixes: 841686df9f7d ("drm/amdgpu: add SI DPM support (v4)")
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 31 +++++++++++++---------
>  1 file changed, 19 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm=
/amd/pm/legacy-dpm/si_dpm.c
> index 33b9d4beec84..e9f034ade214 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> @@ -5820,6 +5820,7 @@ static int si_upload_smc_data(struct amdgpu_device =
*adev)
>  {
>         struct amdgpu_crtc *amdgpu_crtc =3D NULL;
>         int i;
> +       int ret;
>
>         if (adev->pm.dpm.new_active_crtc_count =3D=3D 0)
>                 return 0;
> @@ -5837,20 +5838,26 @@ static int si_upload_smc_data(struct amdgpu_devic=
e *adev)
>         if (amdgpu_crtc->line_time <=3D 0)
>                 return 0;
>
> -       if (si_write_smc_soft_register(adev,
> -                                      SI_SMC_SOFT_REGISTER_crtc_index,
> -                                      amdgpu_crtc->crtc_id) !=3D PPSMC_R=
esult_OK)
> -               return 0;
> +       ret =3D si_write_smc_soft_register(
> +               adev,
> +               SI_SMC_SOFT_REGISTER_crtc_index,
> +               amdgpu_crtc->crtc_id);
> +       if (ret)
> +               return ret;
>
> -       if (si_write_smc_soft_register(adev,
> -                                      SI_SMC_SOFT_REGISTER_mclk_change_b=
lock_cp_min,
> -                                      amdgpu_crtc->wm_high / amdgpu_crtc=
->line_time) !=3D PPSMC_Result_OK)
> -               return 0;
> +       ret =3D si_write_smc_soft_register(
> +               adev,
> +               SI_SMC_SOFT_REGISTER_mclk_change_block_cp_min,
> +               amdgpu_crtc->wm_high / amdgpu_crtc->line_time);
> +       if (ret)
> +               return ret;
>
> -       if (si_write_smc_soft_register(adev,
> -                                      SI_SMC_SOFT_REGISTER_mclk_change_b=
lock_cp_max,
> -                                      amdgpu_crtc->wm_low / amdgpu_crtc-=
>line_time) !=3D PPSMC_Result_OK)
> -               return 0;
> +       ret =3D si_write_smc_soft_register(
> +               adev,
> +               SI_SMC_SOFT_REGISTER_mclk_change_block_cp_max,
> +               amdgpu_crtc->wm_low / amdgpu_crtc->line_time);
> +       if (ret)
> +               return ret;

This patch changes the behavior of this function (i.e., it always
returns 0 before this patch).  Not sure if that matters or not.  I
think this could be simplified to something like the following to
retain the current behavior.

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 52e732be59e36..3dd0115aa15f8 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -5836,17 +5836,17 @@ static int si_upload_smc_data(struct
amdgpu_device *adev)

        if (si_write_smc_soft_register(adev,
                                       SI_SMC_SOFT_REGISTER_crtc_index,
-                                      amdgpu_crtc->crtc_id) !=3D PPSMC_Res=
ult_OK)
+                                      amdgpu_crtc->crtc_id))
                return 0;

        if (si_write_smc_soft_register(adev,

SI_SMC_SOFT_REGISTER_mclk_change_block_cp_min,
-                                      amdgpu_crtc->wm_high /
amdgpu_crtc->line_time) !=3D PPSMC_Result_OK)
+                                      amdgpu_crtc->wm_high /
amdgpu_crtc->line_time))
                return 0;

        if (si_write_smc_soft_register(adev,

SI_SMC_SOFT_REGISTER_mclk_change_block_cp_max,
-                                      amdgpu_crtc->wm_low /
amdgpu_crtc->line_time) !=3D PPSMC_Result_OK)
+                                      amdgpu_crtc->wm_low /
amdgpu_crtc->line_time))
                return 0;

        return 0;


>
>         return 0;
>  }
> --
> 2.50.1
>
