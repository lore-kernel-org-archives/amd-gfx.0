Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2BD8C282EC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 14:15:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EC3310E183;
	Mon, 17 Mar 2025 14:15:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iCk/Zzsr";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B5C410E183
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 14:15:07 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-301317939a0so506436a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 07:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742220907; x=1742825707; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cGW64AiIjG5uB7sxkXVZuZyf/R3mtSlfXNij3exUzVc=;
 b=iCk/ZzsrLHjdZUrDmGdOx/NXmgSyxquzcKpphtN4cxMnsqH0Hk5Qo89wgpOfswN07c
 Yth02XE2NcqETBz6db0z6gJVmTqSR6MO5ji0sU7dmJnJeARh3gGvJF0rJ+CqvVP81/+6
 ld1xLP2kgQugz6UD7WclZwWEp6v36j+5LybSmrpZuL47TXMKUD1ErnpkXcg8t9n+O6Eh
 YM3lz1UMnroHS7ub3c6OM5r47AeWJQYlsZu0LhdrO3ioJK4tqMOjRAGFgISrX7LCjT3G
 nwQ8bab1rHrF2H5P7A66a2lpVkLrYmHtVI8j7nCry48O0ZnPJLBqKu5C0igGK+zhBlvv
 GyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742220907; x=1742825707;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cGW64AiIjG5uB7sxkXVZuZyf/R3mtSlfXNij3exUzVc=;
 b=fDrB0hdPiLWl3oSbGZNzUjkeSnkJrn2SaPh/A1lnzGi1wmnJpSWB3ywuzzccKxTyEv
 GxOKvleM+mVHax5U0Z1mRtMsK6mip+w1tlAzu0gio805PhUAOt4AHhH2ivpS3MquULkL
 XXo1Jj883G6qTrI3Pq6XErAF6WN2v/PW+UhwyI2M6BiG92TjmC+pJw2GQzmv5KzFmHWe
 m20Yjwg0hAdnpJUqumEqASfinZHCDknnhClxYLO7B3O+yFV1XGOOaVaCkKs5LUtkhJG1
 3y1rg+d39mTk0+yBEZJtDQMrJb4Q2+SNNv8QPy6NA+HoT2ICogFZZVZq4Y4DHtOsvjPI
 DX1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7CbG4TbI8yyDM9XEoPWXtvgLbDIcNpyXxu+GjGlVW3b3o0AlZePmg81htCV1+Heskc8h5UPTw@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz/BW2DXNf2r6DwqgWMFqUh1ZePaDU86lcBOFDdrmDh3XRm0DI5
 l7nEvoZz9yKS06YAHwJLPh0K5u7fx5r/AvxSLbDoblWiCCY5tA1HlKuiv8c21HmSQg4l5ZefdvH
 uRaUDr4BAzXDtrN1eW/BkFxtwl5uRaw==
X-Gm-Gg: ASbGncvDP5IUjVLif75gaew/raxneao96dN14v7HsDnoKnVLFVvxvfjGLfiL+blBhg0
 9Jg1tZF9UkZIDtgvDhlGXNzAZzdeUgRGdal3xexwLrhRNS86SgTRQd2w8/cwyAc9Hq/MRJAnbok
 eLTBXFt/30yYiT2t0ZRgDu1zm+2A==
X-Google-Smtp-Source: AGHT+IHLPAzzu1ral0g+hvl7AnRbF/5TOoonQQ4bhs+spUPVVsa5alWGi6pqOFPsZQ86vrKxk0ea0DkT89sYiB/NRg8=
X-Received: by 2002:a17:90b:4f82:b0:2ff:7c5a:216d with SMTP id
 98e67ed59e1d1-30151d8178fmr6213074a91.5.1742220906840; Mon, 17 Mar 2025
 07:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250315201558.339913-1-tomasz.pakula.oficjalny@gmail.com>
 <20250315201558.339913-3-tomasz.pakula.oficjalny@gmail.com>
In-Reply-To: <20250315201558.339913-3-tomasz.pakula.oficjalny@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 17 Mar 2025 10:14:54 -0400
X-Gm-Features: AQ5f1JrmAfgJ9zklqVVOQOEdxdzrDlohbhSSKu_gKLOgvsG50eJBn9g1_zVyRTc
Message-ID: <CADnq5_OdsHpqcJCo77ktjnu8nQRMmTz7wqRLL5qZC8Sc-AOVYQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/pm: add zero RPM stop temp OD setting support
 for SMU 14.0.2
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

On Mon, Mar 17, 2025 at 6:53=E2=80=AFAM Tomasz Paku=C5=82a
<tomasz.pakula.oficjalny@gmail.com> wrote:
>
> Hook up zero RPM stop temperature for 9070 and 9070 XT based on RDNA3
> (smu 13.0.0 and 13.0.7) code.
>
> Signed-off-by: Tomasz Paku=C5=82a <tomasz.pakula.oficjalny@gmail.com>
> ---
>  .../swsmu/inc/pmfw_if/smu14_driver_if_v14_0.h |  3 +-
>  .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 50 ++++++++++++++++++-
>  2 files changed, 51 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14=
_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0.h
> index c2fd0a4a13e5..a5eba7b91e2f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0.h
> @@ -846,9 +846,10 @@ typedef struct {
>    uint16_t               FanTargetTemperature; // Degree Celcius
>    //zero fan
>    uint8_t                FanZeroRpmEnable;
> +  uint8_t                FanZeroRpmStopTemp;
>    //temperature
>    uint8_t                MaxOpTemp;
> -  uint8_t                Padding1[2];
> +  uint8_t                Padding1;
>
>    //Full Ctrl
>    uint16_t               GfxVoltageFullCtrlMode;

This makes a change to the firmware interface.  Presumably it works
differently here.  @Kenneth Feng or @Wang, Yang(Kevin) to confirm how
this works with respect to the firmware.

Alex

> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> index fedf0c8c4741..4e7eed0cc41c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> @@ -80,6 +80,7 @@
>  #define PP_OD_FEATURE_FAN_TARGET_TEMPERATURE           9
>  #define PP_OD_FEATURE_FAN_MINIMUM_PWM                  10
>  #define PP_OD_FEATURE_FAN_ZERO_RPM_ENABLE              11
> +#define PP_OD_FEATURE_FAN_ZERO_RPM_STOP_TEMP           12
>
>  static struct cmn2asic_msg_mapping smu_v14_0_2_message_map[SMU_MSG_MAX_C=
OUNT] =3D {
>         MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,   =
              1),
> @@ -1057,6 +1058,10 @@ static void smu_v14_0_2_get_od_setting_limits(stru=
ct smu_context *smu,
>                 od_min_setting =3D overdrive_lowerlimits->FanZeroRpmEnabl=
e;
>                 od_max_setting =3D overdrive_upperlimits->FanZeroRpmEnabl=
e;
>                 break;
> +       case PP_OD_FEATURE_FAN_ZERO_RPM_STOP_TEMP:
> +               od_min_setting =3D overdrive_lowerlimits->FanZeroRpmStopT=
emp;
> +               od_max_setting =3D overdrive_upperlimits->FanZeroRpmStopT=
emp;
> +               break;
>         default:
>                 od_min_setting =3D od_max_setting =3D INT_MAX;
>                 break;
> @@ -1360,6 +1365,24 @@ static int smu_v14_0_2_print_clk_levels(struct smu=
_context *smu,
>                                       min_value, max_value);
>                 break;
>
> +       case SMU_OD_FAN_ZERO_RPM_STOP_TEMP:
> +               if (!smu_v14_0_2_is_od_feature_supported(smu,
> +                                                        PP_OD_FEATURE_ZE=
RO_FAN_BIT))
> +                       break;
> +
> +               size +=3D sysfs_emit_at(buf, size, "FAN_ZERO_RPM_STOP_TEM=
PERATURE:\n");
> +               size +=3D sysfs_emit_at(buf, size, "%d\n",
> +                                       (int)od_table->OverDriveTable.Fan=
ZeroRpmStopTemp);
> +
> +               size +=3D sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
> +               smu_v14_0_2_get_od_setting_limits(smu,
> +                                                 PP_OD_FEATURE_FAN_ZERO_=
RPM_STOP_TEMP,
> +                                                 &min_value,
> +                                                 &max_value);
> +               size +=3D sysfs_emit_at(buf, size, "ZERO_RPM_STOP_TEMPERA=
TURE: %u %u\n",
> +                                     min_value, max_value);
> +               break;
> +
>         case SMU_OD_RANGE:
>                 if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATU=
RE_GFXCLK_BIT) &&
>                     !smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATU=
RE_UCLK_BIT) &&
> @@ -2306,7 +2329,9 @@ static void smu_v14_0_2_set_supported_od_feature_ma=
sk(struct smu_context *smu)
>                                             OD_OPS_SUPPORT_FAN_MINIMUM_PW=
M_RETRIEVE |
>                                             OD_OPS_SUPPORT_FAN_MINIMUM_PW=
M_SET |
>                                             OD_OPS_SUPPORT_FAN_ZERO_RPM_E=
NABLE_RETRIEVE |
> -                                           OD_OPS_SUPPORT_FAN_ZERO_RPM_E=
NABLE_SET;
> +                                           OD_OPS_SUPPORT_FAN_ZERO_RPM_E=
NABLE_SET |
> +                                           OD_OPS_SUPPORT_FAN_ZERO_RPM_S=
TOP_TEMP_RETRIEVE |
> +                                           OD_OPS_SUPPORT_FAN_ZERO_RPM_S=
TOP_TEMP_SET;
>  }
>
>  static int smu_v14_0_2_get_overdrive_table(struct smu_context *smu,
> @@ -2387,6 +2412,8 @@ static int smu_v14_0_2_set_default_od_settings(stru=
ct smu_context *smu)
>                         user_od_table_bak.OverDriveTable.FanMinimumPwm;
>                 user_od_table->OverDriveTable.FanZeroRpmEnable =3D
>                         user_od_table_bak.OverDriveTable.FanZeroRpmEnable=
;
> +               user_od_table->OverDriveTable.FanZeroRpmStopTemp =3D
> +                       user_od_table_bak.OverDriveTable.FanZeroRpmStopTe=
mp;
>         }
>
>         smu_v14_0_2_set_supported_od_feature_mask(smu);
> @@ -2754,6 +2781,27 @@ static int smu_v14_0_2_od_edit_dpm_table(struct sm=
u_context *smu,
>                 od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_F=
EATURE_ZERO_FAN_BIT);
>                 break;
>
> +       case PP_OD_EDIT_FAN_ZERO_RPM_STOP_TEMP:
> +               if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATU=
RE_ZERO_FAN_BIT)) {
> +                       dev_warn(adev->dev, "Zero RPM setting not support=
ed!\n");
> +                       return -ENOTSUPP;
> +               }
> +
> +               smu_v14_0_2_get_od_setting_limits(smu,
> +                                                 PP_OD_FEATURE_FAN_ZERO_=
RPM_STOP_TEMP,
> +                                                 &minimum,
> +                                                 &maximum);
> +               if (input[0] < minimum ||
> +                   input[0] > maximum) {
> +                       dev_info(adev->dev, "zero RPM stop temperature se=
tting(%ld) must be within [%d, %d]!\n",
> +                                input[0], minimum, maximum);
> +                       return -EINVAL;
> +               }
> +
> +               od_table->OverDriveTable.FanZeroRpmStopTemp =3D input[0];
> +               od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_F=
EATURE_ZERO_FAN_BIT);
> +               break;
> +
>         case PP_OD_RESTORE_DEFAULT_TABLE:
>                 if (size =3D=3D 1) {
>                         ret =3D smu_v14_0_2_od_restore_table_single(smu, =
input[0]);
> --
> 2.48.1
>
