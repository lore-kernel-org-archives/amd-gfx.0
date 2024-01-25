Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B4D4C47DDF
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jan 2024 22:57:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAE5710E260;
	Thu, 25 Jan 2024 22:57:57 +0000 (UTC)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com
 [209.85.167.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2359910E260
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jan 2024 22:57:57 +0000 (UTC)
Received: by mail-oi1-f180.google.com with SMTP id
 5614622812f47-3bd7c15a745so5135974b6e.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jan 2024 14:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706223416; x=1706828216; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tvkHUUyJNybDaJ7bdfQxHAcDyD9LjxGCHwN1G88UFG4=;
 b=INfXpeLpJSpoNPq0r2E/WUWGJyLiyxQwZIqdU6wh0qSwhLzcVk7Jm9JXBBjZBk0C2m
 JA8rJcAh/Auq0ba1JouO/CFHgk8y/0OAKG1dtvkX5azVoiKmf7Uk7L4yY51UDAJWKqnO
 kYkWM7+b3iD10fRZ5tcILB9Kh56NQiMRA33NCk+VBV8LOp0OmHtMDNutsQ8BcV8trmTJ
 8HYC8ATRglU1AQ/9tsZ6QthtDEGk3egkvLbMKqqoSws/1fQwSSrw4yLO86mafHogmR5D
 FzUQxdOESi/n75Yln7ra+dqBEYSdT4QHMAsQlFQI0Eyg9XK62gD1qVNfNBoWd5/aemYz
 WSkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706223416; x=1706828216;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tvkHUUyJNybDaJ7bdfQxHAcDyD9LjxGCHwN1G88UFG4=;
 b=l8bIXc9W13+D67o2+Qs3Mqi8Az0PdVWoYPFiYYOBArJ3jqxSGmQlUC+zFsA6KeLHpU
 wSUPKjnerEu2OwYLtX94rFPJAmbX8x/SptjWBnahny6M1mYhFclJ6fpNw+YsokffYBPw
 65NMm/aR++Cywm27YNo+QOKu+pAlkdZqRL0lUgpwnzkN3nDjZGPgu79teeXMbW4Orbbb
 z+J5mNtixiWB+3//Pj2Lfm79UF8KnjvKL7F9LGkxd0yK4UbVPTWzdSmuDtIP2FdHN4KH
 8iIU/nyvioZ3vEJSyZFodsQkT+9gSspJ4OOJw7mNldkc/vvPwqq7Bl0J2X1hvE5kyL3v
 X/8g==
X-Gm-Message-State: AOJu0YxlNGHV66faK9bGs77NosFHnGZe3mmYPGTElcIGNupo0c/iR91s
 9dHEj5c5VCzelJGpSfGuFQhugXSD8j4qCl19EpzIbdB2MaS9yFPT/Vw/LelBLpfLB6rg/n0arRD
 l2WdkQIb5GIr2TcrPeg5zC35sr8RwnSGP
X-Google-Smtp-Source: AGHT+IFWfm0KdD8y0wvbm6zoJ+le6Z+WYkl6ZkI+0ABf6vtgfdCf2MlNz9chXh6BW52ZTiETR17M0E3u0tlCztJgBP8=
X-Received: by 2002:a05:6870:1649:b0:214:911a:e871 with SMTP id
 c9-20020a056870164900b00214911ae871mr429780oae.5.1706223416444; Thu, 25 Jan
 2024 14:56:56 -0800 (PST)
MIME-Version: 1.0
References: <20240125032255.898308-1-Prike.Liang@amd.com>
 <20240125032255.898308-2-Prike.Liang@amd.com>
In-Reply-To: <20240125032255.898308-2-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 25 Jan 2024 17:56:45 -0500
Message-ID: <CADnq5_MKmkrCW0Gia74DJhq297W=AGeW8J4tQxxFxcSjt+-f3A@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: reset gpu for pm abort case
To: Prike Liang <Prike.Liang@amd.com>
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
Cc: Alexander.Deucher@amd.com, Deepak.Sharma@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 24, 2024 at 11:11=E2=80=AFPM Prike Liang <Prike.Liang@amd.com> =
wrote:
>
> In the pm abort case the gfx power rail not turn off from FCH side and
> this will lead to the gfx reinitialized failed base on the unknown gfx
> HW status, so let's reset the gpu to a known good power state.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++++
>  drivers/gpu/drm/amd/amdgpu/soc15.c         | 8 +++++++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 56d9dfa61290..4c40ffaaa5c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4627,6 +4627,11 @@ int amdgpu_device_resume(struct drm_device *dev, b=
ool fbcon)
>                         return r;
>         }
>
> +       if(amdgpu_asic_need_reset_on_init(adev)) {

space between if and (.

Also, I think we need to check that we are not in S0ix as well
otherwise I think we'll always reset in S0ix.  We could probably do
away with the GPU reset in the suspend_noirq callback with this
change, but maybe make that a separate follow up patch.

Alex

> +               DRM_INFO("PM abort case and let's reset asic \n");
> +               amdgpu_asic_reset(adev);
> +       }
> +
>         if (dev->switch_power_state =3D=3D DRM_SWITCH_POWER_OFF)
>                 return 0;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amd=
gpu/soc15.c
> index 15033efec2ba..9329a00b6abc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -804,9 +804,16 @@ static bool soc15_need_reset_on_init(struct amdgpu_d=
evice *adev)
>         if (adev->asic_type =3D=3D CHIP_RENOIR)
>                 return true;
>
> +       sol_reg =3D RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81);
> +
>         /* Just return false for soc15 GPUs.  Reset does not seem to
>          * be necessary.
>          */
> +       if (adev->in_suspend && !adev->in_s0ix &&
> +                       !adev->pm_complete &&
> +                       sol_reg)
> +               return true;
> +
>         if (!amdgpu_passthrough(adev))
>                 return false;
>
> @@ -816,7 +823,6 @@ static bool soc15_need_reset_on_init(struct amdgpu_de=
vice *adev)
>         /* Check sOS sign of life register to confirm sys driver and sOS
>          * are already been loaded.
>          */
> -       sol_reg =3D RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81);
>         if (sol_reg)
>                 return true;
>
> --
> 2.34.1
>
