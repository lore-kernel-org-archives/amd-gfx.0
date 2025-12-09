Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6AF3D3B991
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 19:35:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 591D810E546;
	Tue,  9 Dec 2025 19:35:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AXWQaXlr";
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56F2C10E546
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 19:35:48 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-bc0d28903c9so461165a12.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Dec 2025 11:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765308948; x=1765913748; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hNC6Nc0bfUwfJ45Alf59pBwwstvknYG9MncFmIGc9R4=;
 b=AXWQaXlrTcgIAyqEuSRw2A5TLv0UhnNdu12+2FgIXictnuDUJf55d8xA7FhFgwkxsw
 xvpe8t/8BTpuT7NGEg3ojSNx0hHC8/M0DGyvywcJ4qAaF9rYKOUNsd6ZiWUEvdEeKKba
 55Wvkiiyo1UUhjNUPacx6+T+yXtDBi2q9UOL2LiWsriPbX5JngN2u3lq8JYFe58xTHfX
 PcM8I+3dqrxGlWTd6uONHIAnwacUfukDQvNxnknyvlqoNU3UnluRhtU6A9jVV4GOVjpg
 wKTZ+lra2wGy2CgBRvjlvITt0Uc6psU6zONCM3G3gIi/+7gj5dXbMsW84kEraBAUuCsI
 x1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765308948; x=1765913748;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hNC6Nc0bfUwfJ45Alf59pBwwstvknYG9MncFmIGc9R4=;
 b=trQPTj0MNOl7iO9sHI/HIwCizC+4479qL1wbF372qtdCd7Tn9+4+BurKBxfb0gNLsI
 UOebPOkBxGxXWxkVeDBlmAQ6p7BPRBPFES4chRLMz6i4yOSJ6Xmj6/n19NHX9C40Ddv/
 U+EsZwOercNcy6FMXkQcQ8mgFgA4NqjAHs6v+h2aUYNQL1G2hR/su8ugoD8liGpF8eDS
 9II73N1hYgMs850WOHltFF9+IAuQ2MSFawXO6sL1M+0JjkOPCkOlWPSGK7vQ6avc0N6n
 +5lTOshgI5TuQulTF+9UL3bpZ5OlzLHtNmXdv75IYYSR5Ah+6oQrmhE/kzqo3VJMZbSO
 TMaQ==
X-Gm-Message-State: AOJu0Yw946NU/gTSoJs0Hbd33TVdLYvawd5+hPjwp5WGW8wfm2p5EgPb
 fh2Y87+3JYwfHf04w8Viz7GcCJS+qSHd2PPVFnER4DE5fUQPceFeOi9BHH4yPBfBjz4+tx5jbsV
 n6/qHNke0q+VFdYbUud8MJb05i/hLzMQ=
X-Gm-Gg: ASbGncsJm43tjyXZXvDAHZSuMulgEIEB6R049yNDprudYLlQ3WfPyVhXMNxMKGrNwRu
 ZVo35Zc0g7iulkzYBhi59bQURDVph2O+s6Kykvga2EnkzxbjMlsYFAlcd/ptPFrPZpp2lWxjKQz
 btYlWg5UrVSn41P74dWsmse5VxC67uhY0Qte1ZMMJlpIMRgfLtEsVSSeKAN0DONRHSZnQWA84SR
 qczS+48dLfcqr6RfQ0zYj0bQea1+xvq2/WT/61eW/dzYXnXxkI+JTwRcJmyW7E4jR/rEQtZmdkv
 wrFw1A==
X-Google-Smtp-Source: AGHT+IE6S6bCqGtnvLXfYJn0Oa1X3UlSQ/pQRatbrE6EO+JIGkT8aGtufQU0vkvnkJnincvq57HtpskxXb4swM136BQ=
X-Received: by 2002:a05:701a:c948:b0:119:e56b:c3f5 with SMTP id
 a92af1059eb24-11f28e2ec06mr70676c88.5.1765308947648; Tue, 09 Dec 2025
 11:35:47 -0800 (PST)
MIME-Version: 1.0
References: <20251209162259.1604207-1-mythilam@amd.com>
In-Reply-To: <20251209162259.1604207-1-mythilam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 9 Dec 2025 14:35:36 -0500
X-Gm-Features: AQt7F2o6GLBQk4ryPLeBr4MDddcw6pkSjjboKWBbV0gE2wdYdtVyTI3RkpjVOT8
Message-ID: <CADnq5_PnqFSdBXJdgYXkGWLHGjej3fyAZ-tv2mFQADR-_xQHdw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/pm: restore SCLK settings after S0ix resume
To: mythilam <mythilam@amd.com>
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

On Tue, Dec 9, 2025 at 11:29=E2=80=AFAM mythilam <mythilam@amd.com> wrote:
>
> User-configured SCLK (GPU core clock) frequencies were not persisting
> across S0ix suspend/resume cycles on smu v14 hardware.
> The issue occurred because of the code resetting clock frequency
> to zero during resume.
>
> This patch addresses the problem by:
> - Preserving user-configured values in driver and sets the
>   clock frequency across resume
> - Preserved settings are sent to the hardware during resume
>
> Signed-off-by: mythilam <mythilam@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> ---
>  .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    |  5 +++
>  .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 37 ++++++++++++++++---
>  2 files changed, 37 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> index f9b0938c57ea..f2a16dfee599 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> @@ -1939,6 +1939,11 @@ int smu_v14_0_od_edit_dpm_table(struct smu_context=
 *smu,
>                         dev_err(smu->adev->dev, "Set soft max sclk failed=
!");
>                         return ret;
>                 }
> +               if (smu->gfx_actual_hard_min_freq !=3D smu->gfx_default_h=
ard_min_freq ||
> +                   smu->gfx_actual_soft_max_freq !=3D smu->gfx_default_s=
oft_max_freq)
> +                       smu->user_dpm_profile.user_od =3D true;
> +               else
> +                       smu->user_dpm_profile.user_od =3D false;
>                 break;
>         default:
>                 return -ENOSYS;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> index b1bd946d8e30..97414bc39764 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> @@ -1514,9 +1514,10 @@ static int smu_v14_0_1_set_fine_grain_gfx_freq_par=
ameters(struct smu_context *sm
>
>         smu->gfx_default_hard_min_freq =3D clk_table->MinGfxClk;
>         smu->gfx_default_soft_max_freq =3D clk_table->MaxGfxClk;
> -       smu->gfx_actual_hard_min_freq =3D 0;
> -       smu->gfx_actual_soft_max_freq =3D 0;
> -
> +       if (smu->gfx_actual_hard_min_freq =3D=3D 0)
> +               smu->gfx_actual_hard_min_freq =3D smu->gfx_default_hard_m=
in_freq;
> +       if (smu->gfx_actual_soft_max_freq =3D=3D 0)
> +               smu->gfx_actual_soft_max_freq =3D smu->gfx_default_soft_m=
ax_freq;
>         return 0;
>  }
>
> @@ -1526,8 +1527,10 @@ static int smu_v14_0_0_set_fine_grain_gfx_freq_par=
ameters(struct smu_context *sm
>
>         smu->gfx_default_hard_min_freq =3D clk_table->MinGfxClk;
>         smu->gfx_default_soft_max_freq =3D clk_table->MaxGfxClk;
> -       smu->gfx_actual_hard_min_freq =3D 0;
> -       smu->gfx_actual_soft_max_freq =3D 0;
> +       if (smu->gfx_actual_hard_min_freq =3D=3D 0)
> +               smu->gfx_actual_hard_min_freq =3D smu->gfx_default_hard_m=
in_freq;
> +       if (smu->gfx_actual_soft_max_freq =3D=3D 0)
> +               smu->gfx_actual_soft_max_freq =3D smu->gfx_default_soft_m=
ax_freq;
>
>         return 0;
>  }
> @@ -1665,6 +1668,29 @@ static int smu_v14_0_common_set_mall_enable(struct=
 smu_context *smu)
>         return ret;
>  }
>
> +static int smu_v14_0_0_restore_user_od_settings(struct smu_context *smu)
> +{
> +       int ret;
> +
> +       ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinGf=
xClk,
> +                                             smu->gfx_actual_hard_min_fr=
eq,
> +                                             NULL);
> +       if (ret) {
> +               dev_err(smu->adev->dev, "Failed to restore hard min sclk!=
\n");
> +               return ret;
> +       }
> +
> +       ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxGf=
xClk,
> +                                             smu->gfx_actual_soft_max_fr=
eq,
> +                                             NULL);
> +       if (ret) {
> +               dev_err(smu->adev->dev, "Failed to restore soft max sclk!=
\n");
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
>  static const struct pptable_funcs smu_v14_0_0_ppt_funcs =3D {
>         .check_fw_status =3D smu_v14_0_check_fw_status,
>         .check_fw_version =3D smu_v14_0_check_fw_version,
> @@ -1688,6 +1714,7 @@ static const struct pptable_funcs smu_v14_0_0_ppt_f=
uncs =3D {
>         .mode2_reset =3D smu_v14_0_0_mode2_reset,
>         .get_dpm_ultimate_freq =3D smu_v14_0_common_get_dpm_ultimate_freq=
,
>         .set_soft_freq_limited_range =3D smu_v14_0_0_set_soft_freq_limite=
d_range,
> +       .restore_user_od_settings =3D smu_v14_0_0_restore_user_od_setting=
s,
>         .od_edit_dpm_table =3D smu_v14_0_od_edit_dpm_table,
>         .print_clk_levels =3D smu_v14_0_0_print_clk_levels,
>         .force_clk_levels =3D smu_v14_0_0_force_clk_levels,
> --
> 2.17.1
>
