Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D84C87FCB
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 15:33:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F37310E594;
	Mon,  4 Aug 2025 15:33:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y1SbeSs8";
	dkim-atps=neutral
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7395510E594
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 15:33:24 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-b350c85cf4eso514897a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Aug 2025 08:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754321604; x=1754926404; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N0GwzgqhVbFZD2jUokUudYKiZ+5INPhDFnP12OF82tg=;
 b=Y1SbeSs8838gviItF4GTPyJ6EKSvlQWcHmg6kdd9nnaP2XxILBbjcBOjVrAbQe1E8Q
 t3UvsPPh1e08QOyPPQNXrOLhiNpydvrxzBQ+BW+vSs1rjglePoiv1cPaY7W3fVmP02wK
 Z0DL5n7P8hLEylUmiDtnOQihg+03P2ALnj+rX2qggH5gEVuwtAnXiyNJBcsJdaOQFxg0
 IA+l0JeQFPwM1go3oMJGV/usFvkdnqsDQCSk98l8wjtm9NC7JE/ZxFy8oyT8NIoldPaf
 9s24wDvqPZyMrw5X3plxDDTBqRh9v2a378gcou7WIzA89EDKuNHCLTuWfs/mpoci9iJn
 J4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754321604; x=1754926404;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N0GwzgqhVbFZD2jUokUudYKiZ+5INPhDFnP12OF82tg=;
 b=jRHFwdq2FrdMvHOuwL204D5Wau499AIIAZI8oxHxCDVktqBlj4iJmTZ54n8eiVjlDd
 Plsgxt+3zJmsqrUdZDfIDRWJ/CI4Cb+IoueOPs+wk7PAWagmFiZdTjVoIj6KKxphvUjO
 MyoFs5c1yaRA+GsmR7+F0g8bta+wlSHMkCbLtW3hI6xOp84H8UZeDq41K/chAIVMXY2y
 BCC46abYNrfIaMozIZ5zEIhm44BD6BFi49LBpxiqGvBdeFTaVfpggKblsQKX3p4GRRCG
 jtJ33IYjfT4AIjtoa8wpm3MGvw6MUZumMJTUqFiqogXWbsPh0KWRjsDZqX5HcnKjsIDP
 N4vw==
X-Gm-Message-State: AOJu0YyE6fMOSVa55UyEEYSrnqSV4kpG8fAeZpLzm+vmMOD8DfT/UR3m
 2VDbCFpWW9IXS8rLC21ypSK0KwmIFiMjfJG3dvzzcCQ+ld/EIH8JRdAom+wWXxwtsyRPbMKDeEv
 LXJCWjG3U9+2Csq5/EgNkzuiyeRSGbIQ=
X-Gm-Gg: ASbGncu0zWgoOkAl7BU1pPXNTDnzzicV2BXbmKUTMsY9zWRKSu9EjFOUbKec/tHIKKQ
 JupKIV41szpOhrvaAYQIDJClyb7KiWSxsvbtSQ5/mf1p8YPDW1i83gAIR/h8i8whGSgzr8q+CPv
 r1seIPLHWU17xvEwQOyxIrtzq9J3f/vJA0AYijpxMzwLU2l1UIHkqtoc4WP9rZ9XZQ0lxZVpesU
 XnIPrCO
X-Google-Smtp-Source: AGHT+IHl/BXUTL/JpLxFh0OAwTOt1cwH/A1CAan7PyRT0WVTtLyES0gjI4G0CK96v5kkes7KnmpD3X1S6w1qdrZDg4U=
X-Received: by 2002:a17:90b:1c10:b0:312:e9d:4001 with SMTP id
 98e67ed59e1d1-321162d2568mr5330372a91.8.1754321603633; Mon, 04 Aug 2025
 08:33:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250804134154.95875-1-timur.kristof@gmail.com>
 <20250804134154.95875-6-timur.kristof@gmail.com>
In-Reply-To: <20250804134154.95875-6-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 Aug 2025 11:33:12 -0400
X-Gm-Features: Ac12FXwCxI4k785LnvBGd5yZQq7mLBHajxXABqkKuP1E947ZRr1rDMczWdh70YM
Message-ID: <CADnq5_PXfjhGGWdfRuVz=0QqZq7U32_VGpsNeuTpTH82Xx8_sg@mail.gmail.com>
Subject: Re: [PATCH 5/6] drm/radeon: Fix si_upload_smc_data
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

On Mon, Aug 4, 2025 at 9:48=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@gm=
ail.com> wrote:
>
> Backport of the fix to the same amdgpu issue.
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
> Fixes: a9e61410921b ("drm/radeon/kms: add dpm support for SI (v7)")
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

Same comment here as the previous patch.

Alex


> ---
>  drivers/gpu/drm/radeon/si_dpm.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_=
dpm.c
> index 47fba85436a7..8bda1e655468 100644
> --- a/drivers/gpu/drm/radeon/si_dpm.c
> +++ b/drivers/gpu/drm/radeon/si_dpm.c
> @@ -5257,6 +5257,7 @@ static int si_upload_smc_data(struct radeon_device =
*rdev)
>  {
>         struct radeon_crtc *radeon_crtc =3D NULL;
>         int i;
> +       int ret;
>
>         if (rdev->pm.dpm.new_active_crtc_count =3D=3D 0)
>                 return 0;
> @@ -5274,20 +5275,26 @@ static int si_upload_smc_data(struct radeon_devic=
e *rdev)
>         if (radeon_crtc->line_time <=3D 0)
>                 return 0;
>
> -       if (si_write_smc_soft_register(rdev,
> -                                      SI_SMC_SOFT_REGISTER_crtc_index,
> -                                      radeon_crtc->crtc_id) !=3D PPSMC_R=
esult_OK)
> -               return 0;
> +       ret =3D si_write_smc_soft_register(
> +               rdev,
> +               SI_SMC_SOFT_REGISTER_crtc_index,
> +               radeon_crtc->crtc_id);
> +       if (ret)
> +               return ret;
>
> -       if (si_write_smc_soft_register(rdev,
> -                                      SI_SMC_SOFT_REGISTER_mclk_change_b=
lock_cp_min,
> -                                      radeon_crtc->wm_high / radeon_crtc=
->line_time) !=3D PPSMC_Result_OK)
> -               return 0;
> +       ret =3D si_write_smc_soft_register(
> +               rdev,
> +               SI_SMC_SOFT_REGISTER_mclk_change_block_cp_min,
> +               radeon_crtc->wm_high / radeon_crtc->line_time);
> +       if (ret)
> +               return ret;
>
> -       if (si_write_smc_soft_register(rdev,
> -                                      SI_SMC_SOFT_REGISTER_mclk_change_b=
lock_cp_max,
> -                                      radeon_crtc->wm_low / radeon_crtc-=
>line_time) !=3D PPSMC_Result_OK)
> -               return 0;
> +       ret =3D si_write_smc_soft_register(
> +               rdev,
> +               SI_SMC_SOFT_REGISTER_mclk_change_block_cp_max,
> +               radeon_crtc->wm_low / radeon_crtc->line_time);
> +       if (ret)
> +               return ret;
>
>         return 0;
>  }
> --
> 2.50.1
>
