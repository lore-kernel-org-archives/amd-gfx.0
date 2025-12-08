Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17754D3B7EA
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 22:26:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 987C210E335;
	Mon,  8 Dec 2025 22:26:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c0wJoAZY";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BC2810E335
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 22:26:38 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-295395ceda3so7353925ad.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Dec 2025 14:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765232797; x=1765837597; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6nYXTbrXeAvfIb22vlvgjOJzOc0AsGyF993PbIdDirU=;
 b=c0wJoAZYmTV9P0Vz1aXrWm3VfPzo2pwOJZ/ZdjoOfKex4qukn6lccic/0x0EVFL6GM
 F3e3alewcy3nViYMZN+p0khHtx1L8fGLi82WYdc/4+RNj4m3DKwm7BuT0g8zU5VLRd12
 T/o4SoTkmgUJoOXE4rxvlmCy7aXpulynGUtEsZOnrbOtNeq2+PySezCBp+UP78LLwKIU
 ftL0V25loi3tR8K1NguaHj2BON42fpjSuA3obQR40y/mNE7HNo7Qa6eKO9FvULF/OjJz
 ERYZnWSqJcZ8SGvqKuIqsf8ZlQZyPi1plnRGP310xBeuWWNYjvAGf+ZCBnoMfRee8J7f
 QDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765232797; x=1765837597;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6nYXTbrXeAvfIb22vlvgjOJzOc0AsGyF993PbIdDirU=;
 b=onEgE8PmxEdiNOyuz2tLR8QCgfsic5g3Yq5AxGEs72BRuI/s5KPpbXR3PMCpVUIpHT
 aBF18P6/iyuSPPhDtG0Pv9rB1SnUEEIh/cxW4yrQYyyCKLD3FbijegNyrtPFHJOPUQ+C
 /vRR7yILZ9E7bP4o9kCFRu/LGQSUU6FFvMeek/qI9BA940EiyTfQddQ+mw0L0bB+zhff
 i6VLobBrAXul32ldB+wueo3SfsOuKU390x87rzGW5ZAxzt2O9HLa53EIdnAN05NGafwk
 2KuBk3kmOJpq+xB1/KJS/N8lSdsipU+SOadP7Xc7MLlH7/WpxoYbU+i470ZW5PMWDzCI
 NUug==
X-Gm-Message-State: AOJu0YyWc/BJAKB9DbUDgZm07C0a6OKbaBiTFNthn0B1qRTAVb9Dqofg
 LnLgqrhGaagxbiBMCUb98cA+/S5lirmL/X4S2PZ8X1kgjRU0cPbfaSmIeT+ICGpPUqlUzPzmyFD
 sYmqQwqePNjycrEnR6nlYNpiiDPd88hE=
X-Gm-Gg: ASbGncs/A+Ka38PXcWI0NxHKw1VSaM4tc+6W+puskoY2dKR5I+v9mblLf298LMdGpH8
 8VG0ZkmD5gkMDuIugJwTqgUGxV9/R6iOn47I9Zz/68ruBEZB3uOXvndl/9do2vzOh/53bMGWJRv
 OZlo6eV7/pvckNn2apMAw7zOH0oYUk0UGxKf9NBbp6wB7Lsg53d6xzK9vn4wPx4quQ5F5/YgWGX
 D6eb++Zy23yBKeFANKM0yy8Q6aB1Q4eoAkHtnWPs1F7LJ0QtWhJ9PIv9VWh7U8MpNIrqRk=
X-Google-Smtp-Source: AGHT+IGw+I6cgWl32IsOGrRtapzTKfXlfenezJOLPopcEpkXdzQYO1TwCbtffLOuzX5YPV6FlyyUJu45o+h4QrqbZcY=
X-Received: by 2002:a05:7022:6624:b0:119:e55a:95a0 with SMTP id
 a92af1059eb24-11e0326c0bdmr4202340c88.2.1765232797316; Mon, 08 Dec 2025
 14:26:37 -0800 (PST)
MIME-Version: 1.0
References: <20251204121035.504066-1-mythilam@amd.com>
In-Reply-To: <20251204121035.504066-1-mythilam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 8 Dec 2025 17:26:26 -0500
X-Gm-Features: AQt7F2rlGpQznB6iTGIE2lAM7wKMtIYRyhyc3BULuvnsZaenFHAcnm8PJdSubK8
Message-ID: <CADnq5_OUx1ivUWznzHK_9n2+7uCrpGmuvEkaSReCD6SUAQLo7w@mail.gmail.com>
Subject: Re: [PATCH v1] drm/amd/pm: restore SCLK settings after S0ix resume
To: mythilam <mythilam@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
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

+ Kevin

On Thu, Dec 4, 2025 at 7:19=E2=80=AFAM mythilam <mythilam@amd.com> wrote:
>
> User-configured SCLK(GPU core clock) frequency are not persisting
> across S0ix suspend/resume cycles on smu v14 hardware. The issue
> is because of the code updating the clock frequency during resume.
>
> This patch resolves the issue by:
> - Preserving user-configured values in driver and sets the clock
>   frequency during resume
> - Preserved settings are sent to the smu hardware
>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

Looks good to me, but would be good to get an ack from Kevin as well.

Thanks,

Alex


> Signed-off-by: mythilam <mythilam@amd.com>
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
> index fe00c84b1cc6..8d72a962aef7 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> @@ -1513,9 +1513,10 @@ static int smu_v14_0_1_set_fine_grain_gfx_freq_par=
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
> @@ -1525,8 +1526,10 @@ static int smu_v14_0_0_set_fine_grain_gfx_freq_par=
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
> @@ -1664,6 +1667,29 @@ static int smu_v14_0_common_set_mall_enable(struct=
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
> +               dev_err(smu->adev->dev, "Failed to restore hard min sclk =
on resume!\n");
> +               return ret;
> +       }
> +
> +       ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxGf=
xClk,
> +                                             smu->gfx_actual_soft_max_fr=
eq,
> +                                             NULL);
> +       if (ret) {
> +               dev_err(smu->adev->dev, "Failed to restore soft max sclk =
on resume!\n");
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
>  static const struct pptable_funcs smu_v14_0_0_ppt_funcs =3D {
>         .check_fw_status =3D smu_v14_0_check_fw_status,
>         .check_fw_version =3D smu_v14_0_check_fw_version,
> @@ -1687,6 +1713,7 @@ static const struct pptable_funcs smu_v14_0_0_ppt_f=
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
