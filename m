Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB38C35FFC
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Mar 2025 14:18:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 492FE10E57E;
	Tue, 25 Mar 2025 14:18:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bOW1SKAZ";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E018A10E580
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Mar 2025 14:18:17 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-301b4f97cc1so1707822a91.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Mar 2025 07:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742912297; x=1743517097; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SsAWJdJxplaha6zwn8eyyfrkmLzJy7lIOKV/D3lQ1Yg=;
 b=bOW1SKAZFFk/bPKNCLLxdzjtICCA7f77gjecbOwCeiBd+kMfcE4CFOKCbxkcV3ZZhx
 RYVgUTe9FKXf7VCdaiaeZ9iPmAW1O+tepqNModsEhAVOoBODbrirFVK3bzvA2Xi7B5fC
 E7/U0gvvRsdJWLZj5zRo2JvVR8peRw8ch3fw2RynnBeNTQT5W19NXw4oa8llalxHsnkA
 Yz6R5lYLNWAg5eMrh3qf6TRhlaB8D4sPyweuOleQGEntHtn8hIBkYHbuylBuzlVbEXHa
 lFOl+7yxiHO6TTf4R88PFQZ9X1o7+xVH6LotEor0OlgqFFkoxPSrkKtPhrCVzqzcNqEY
 DTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742912297; x=1743517097;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SsAWJdJxplaha6zwn8eyyfrkmLzJy7lIOKV/D3lQ1Yg=;
 b=d43LPkE7mh1Wiqi5lgewd1xBmA+WcejCPXTf97uhF58HtmpkF/qFhXrHHkt+f4rOom
 adFloxmYrGjNns6U5ORri9uk6OB4LGWCWLykeOt93Rqhf/KhM7hKu6xvCcYDEo1zjf0j
 U23KSjMynTwMenSDV8vI4xDfydGt/5In9llsrAmu6ZoyxNlO9Y/sZy9OqRAqoH8bM7Gt
 mEdx4tu0uVbWxFRtgTTwJL/5MgMnKgqeDy48HgT4pGwp9yEkNEg/Ts0koi37FlTqDzj2
 rDlLMrb4sKc7croZfO6ZfyCSiMOEUnutl6NRD3vbxU+76MNvG12LnCgyCbQsyzdN88TQ
 y7DA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjshsIcgMFLUdSFqqtYPBrGQSTN4uHmXYMC61WRy13ypQXMJxDzrqovXBtfLa4hjDSpEg/lgET@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyCY4XronMmdKIBpymEC+ydJk4T0X13O4wC2x85rEVzaakdi+58
 +NNZRtMV12JjJqTEbK+w2NOj72SCFCOBqRpQMy+AemTGA029dIs2rwKpEAZMgTu47Mzz5OZG4dw
 kbbiyuBHCKE/n53kqWJqMbauimz0=
X-Gm-Gg: ASbGncsn/GjoVmcXqMjKezANDvsXpSGs6Awt0aWyPLoQizilxUAkfWG35dBg9gA93/Y
 EwxOG73vuKLK+Zcf9AbwN4//1W6CsoZTaMCp8iPyKwwArW6D6vUMZ4BCNfQInBFqBP9ePBG+gfW
 Bm0pmHIWlq7CcCHV+alsO8YqpAug==
X-Google-Smtp-Source: AGHT+IEOvPD/uuB8UipYi3rtmNGUo9bxowALOhkFpl4fjy9OkTl5Uxa14bJsByJJ0OFTqEhBXc8zy6T39zL0ZFhjHdg=
X-Received: by 2002:a17:90b:4a89:b0:2ee:acea:9ec4 with SMTP id
 98e67ed59e1d1-3030fee30e6mr9112512a91.3.1742912297053; Tue, 25 Mar 2025
 07:18:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250325102652.229756-1-tomasz.pakula.oficjalny@gmail.com>
In-Reply-To: <20250325102652.229756-1-tomasz.pakula.oficjalny@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 Mar 2025 10:18:04 -0400
X-Gm-Features: AQ5f1JqMbCHEXPRC2IYDJ4E_WY7DGPzhYG85-atBnrt2HWYSOTyA3if1hRlckcM
Message-ID: <CADnq5_PEKAYuguPX=eTpxxCzA=VowpQEs_iKKncTCCOaGOA8JA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Add zero RPM enabled OD setting support for
 SMU14.0.2
To: =?UTF-8?Q?Tomasz_Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
Cc: alexander.deucher@amd.com, kenneth.feng@amd.com, KevinYang.Wang@amd.com, 
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

On Tue, Mar 25, 2025 at 8:42=E2=80=AFAM Tomasz Paku=C5=82a
<tomasz.pakula.oficjalny@gmail.com> wrote:
>
> Hook up zero RPM enable for 9070 and 9070 XT based on RDNA3
> (smu 13.0.0 and 13.0.7) code.
>
> Tested on 9070 XT Hellhound
>
> Signed-off-by: Tomasz Paku=C5=82a <tomasz.pakula.oficjalny@gmail.com>

Applied.  Thanks!

Alex

> ---
>  .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 55 ++++++++++++++++++-
>  1 file changed, 54 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> index f7cfe1f35cae..82c2db972491 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> @@ -79,6 +79,7 @@
>  #define PP_OD_FEATURE_FAN_ACOUSTIC_TARGET              8
>  #define PP_OD_FEATURE_FAN_TARGET_TEMPERATURE           9
>  #define PP_OD_FEATURE_FAN_MINIMUM_PWM                  10
> +#define PP_OD_FEATURE_FAN_ZERO_RPM_ENABLE              11
>
>  static struct cmn2asic_msg_mapping smu_v14_0_2_message_map[SMU_MSG_MAX_C=
OUNT] =3D {
>         MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,   =
              1),
> @@ -1052,6 +1053,10 @@ static void smu_v14_0_2_get_od_setting_limits(stru=
ct smu_context *smu,
>                 od_min_setting =3D overdrive_lowerlimits->FanMinimumPwm;
>                 od_max_setting =3D overdrive_upperlimits->FanMinimumPwm;
>                 break;
> +       case PP_OD_FEATURE_FAN_ZERO_RPM_ENABLE:
> +               od_min_setting =3D overdrive_lowerlimits->FanZeroRpmEnabl=
e;
> +               od_max_setting =3D overdrive_upperlimits->FanZeroRpmEnabl=
e;
> +               break;
>         default:
>                 od_min_setting =3D od_max_setting =3D INT_MAX;
>                 break;
> @@ -1330,6 +1335,24 @@ static int smu_v14_0_2_print_clk_levels(struct smu=
_context *smu,
>                                       min_value, max_value);
>                 break;
>
> +       case SMU_OD_FAN_ZERO_RPM_ENABLE:
> +               if (!smu_v14_0_2_is_od_feature_supported(smu,
> +                                                        PP_OD_FEATURE_ZE=
RO_FAN_BIT))
> +                       break;
> +
> +               size +=3D sysfs_emit_at(buf, size, "FAN_ZERO_RPM_ENABLE:\=
n");
> +               size +=3D sysfs_emit_at(buf, size, "%d\n",
> +                               (int)od_table->OverDriveTable.FanZeroRpmE=
nable);
> +
> +               size +=3D sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
> +               smu_v14_0_2_get_od_setting_limits(smu,
> +                                                 PP_OD_FEATURE_FAN_ZERO_=
RPM_ENABLE,
> +                                                 &min_value,
> +                                                 &max_value);
> +               size +=3D sysfs_emit_at(buf, size, "ZERO_RPM_ENABLE: %u %=
u\n",
> +                                     min_value, max_value);
> +               break;
> +
>         case SMU_OD_RANGE:
>                 if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATU=
RE_GFXCLK_BIT) &&
>                     !smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATU=
RE_UCLK_BIT) &&
> @@ -2270,7 +2293,9 @@ static void smu_v14_0_2_set_supported_od_feature_ma=
sk(struct smu_context *smu)
>                                             OD_OPS_SUPPORT_FAN_TARGET_TEM=
PERATURE_RETRIEVE |
>                                             OD_OPS_SUPPORT_FAN_TARGET_TEM=
PERATURE_SET |
>                                             OD_OPS_SUPPORT_FAN_MINIMUM_PW=
M_RETRIEVE |
> -                                           OD_OPS_SUPPORT_FAN_MINIMUM_PW=
M_SET;
> +                                           OD_OPS_SUPPORT_FAN_MINIMUM_PW=
M_SET |
> +                                           OD_OPS_SUPPORT_FAN_ZERO_RPM_E=
NABLE_RETRIEVE |
> +                                           OD_OPS_SUPPORT_FAN_ZERO_RPM_E=
NABLE_SET;
>  }
>
>  static int smu_v14_0_2_get_overdrive_table(struct smu_context *smu,
> @@ -2349,6 +2374,8 @@ static int smu_v14_0_2_set_default_od_settings(stru=
ct smu_context *smu)
>                         user_od_table_bak.OverDriveTable.FanTargetTempera=
ture;
>                 user_od_table->OverDriveTable.FanMinimumPwm =3D
>                         user_od_table_bak.OverDriveTable.FanMinimumPwm;
> +               user_od_table->OverDriveTable.FanZeroRpmEnable =3D
> +                       user_od_table_bak.OverDriveTable.FanZeroRpmEnable=
;
>         }
>
>         smu_v14_0_2_set_supported_od_feature_mask(smu);
> @@ -2396,6 +2423,11 @@ static int smu_v14_0_2_od_restore_table_single(str=
uct smu_context *smu, long inp
>                 od_table->OverDriveTable.FanMode =3D FAN_MODE_AUTO;
>                 od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_F=
EATURE_FAN_CURVE_BIT);
>                 break;
> +       case PP_OD_EDIT_FAN_ZERO_RPM_ENABLE:
> +               od_table->OverDriveTable.FanZeroRpmEnable =3D
> +                                       boot_overdrive_table->OverDriveTa=
ble.FanZeroRpmEnable;
> +               od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_F=
EATURE_ZERO_FAN_BIT);
> +               break;
>         case PP_OD_EDIT_ACOUSTIC_LIMIT:
>                 od_table->OverDriveTable.AcousticLimitRpmThreshold =3D
>                                         boot_overdrive_table->OverDriveTa=
ble.AcousticLimitRpmThreshold;
> @@ -2678,6 +2710,27 @@ static int smu_v14_0_2_od_edit_dpm_table(struct sm=
u_context *smu,
>                 od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_F=
EATURE_FAN_CURVE_BIT);
>                 break;
>
> +       case PP_OD_EDIT_FAN_ZERO_RPM_ENABLE:
> +               if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATU=
RE_ZERO_FAN_BIT)) {
> +                       dev_warn(adev->dev, "Zero RPM setting not support=
ed!\n");
> +                       return -ENOTSUPP;
> +               }
> +
> +               smu_v14_0_2_get_od_setting_limits(smu,
> +                                                 PP_OD_FEATURE_FAN_ZERO_=
RPM_ENABLE,
> +                                                 &minimum,
> +                                                 &maximum);
> +               if (input[0] < minimum ||
> +                   input[0] > maximum) {
> +                       dev_info(adev->dev, "zero RPM enable setting(%ld)=
 must be within [%d, %d]!\n",
> +                                input[0], minimum, maximum);
> +                       return -EINVAL;
> +               }
> +
> +               od_table->OverDriveTable.FanZeroRpmEnable =3D input[0];
> +               od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_F=
EATURE_ZERO_FAN_BIT);
> +               break;
> +
>         case PP_OD_RESTORE_DEFAULT_TABLE:
>                 if (size =3D=3D 1) {
>                         ret =3D smu_v14_0_2_od_restore_table_single(smu, =
input[0]);
>
> base-commit: 7547510d4a915f4f6d9b1262182d8db6763508f4
> --
> 2.49.0
>
