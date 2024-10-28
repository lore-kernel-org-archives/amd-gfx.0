Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E20ACD5B146
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 20:28:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B35F10E17D;
	Mon, 28 Oct 2024 20:28:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kiwCZvdg";
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 881BF10E17D
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 20:28:21 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-71e5a00d676so178155b3a.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 13:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730147301; x=1730752101; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D4kkJr5PORcoNQBo89eUVl38DR3vXUvITPRMmClRNR0=;
 b=kiwCZvdgzJmgIr2kxNSpeCneLf4ssAY30mNYkW7kHB/SBBheN9dx02FSsIltUNcIkn
 V/pNj1+UkpkRABl/sXq52kg5cseqLmvWhGI+o/tcMXohX7PqLEWNvKjhtsuAVAiPrr+9
 EoYzA3d/JLd5DVyk7odczGRjF1Ywf1dKr6CMcPZEXOte0KForQvZ2RnW16Bd3iRgUH0p
 bKLf1cn7dZMyeSDCarOteU1UEYxYWV2WDELSqM+QRn2N/tOpRHnovag+WzfkjhG97Fd0
 oD5OhEZQJBwTQzfxYlc7pDfFZIuJIFJ4u0N2/OtmqVySoDRDDu605kuxXbVD5mbA7PqW
 9Sxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730147301; x=1730752101;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D4kkJr5PORcoNQBo89eUVl38DR3vXUvITPRMmClRNR0=;
 b=CZ2C3BFKxFPnWWr8ZaisQb62J+sQIu13nR+ZYI21trnSo9dJI4zHFXnzJo4dN7IgMj
 ec4gG55KWeBtWAqNbERK5NI4zIPcFtXFgMZ21q/1KaGjlYsXZGR+M8S3sVU0OvIGuk/N
 Iaey5IvJ1rolLnvsIJqyHfGmgDvi04GEk5z+Dp/zFsUc380S0KdM6jG428P1W1jj1xBM
 sgLFqZEM0LsEzVf3ulPZmjvz93mUVa1v3VF8svtx14qY+4qPDle0wLihR3Rw+W0sGbpN
 gsU/ikVlRgmUfTD2cmCslEbj7mBZ9WDcwnhPMczmvJqN1Jyv+S7jG11ntlIs+Tsofaww
 41UA==
X-Gm-Message-State: AOJu0YzYiB/fBM/gZV1MBawxclUPEUAoNE3QR3kK+HJSAaUU2aRwVKMD
 nRe/5iEfDbYyV2yjRz4d29aCthx187q5t3n+34LGLh72s1u8Waz1TXh1S2e2oC4LQS3frInLUnH
 sdK6VdCEEYVb4xNz3eS3aHlE7jDM=
X-Google-Smtp-Source: AGHT+IE3n5UgyW0ijo0atMuDyDiP481EERBMInZNz4ZaeJ8TrRRlClgB3fGXktCu+9pmxKVmp8LT5ZDuHmOHpdtSBkQ=
X-Received: by 2002:a05:6a00:cc7:b0:71e:596a:a392 with SMTP id
 d2e1a72fcca58-72062f1dfd8mr5736992b3a.2.1730147300781; Mon, 28 Oct 2024
 13:28:20 -0700 (PDT)
MIME-Version: 1.0
References: <20241019143706.18779-1-wolf@oriole.systems>
In-Reply-To: <20241019143706.18779-1-wolf@oriole.systems>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Oct 2024 16:28:09 -0400
Message-ID: <CADnq5_MvJET2hk0aeTbUTEvUb57-figFbfPfNvfsjsTuSY0ing@mail.gmail.com>
Subject: Re: [RFC PATCH] drm/amd/pm: add zero RPM OD setting support for SMU13
To: =?UTF-8?Q?Wolfgang_M=C3=BCller?= <wolf@oriole.systems>, 
 Kenneth Feng <kenneth.feng@amd.com>
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

+ Kenneth to help review

On Sat, Oct 19, 2024 at 10:43=E2=80=AFAM Wolfgang M=C3=BCller <wolf@oriole.=
systems> wrote:
>
> Whilst we have support for setting fan curves there is no support for
> disabling the zero RPM feature. Since the relevant bits are already
> present in the OverDriveTable, hook them up to a sysctl setting so users
> can influence this behaviour.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3489
> Signed-off-by: Wolfgang M=C3=BCller <wolf@oriole.systems>
> ---
> I've been wanting this feature for a while so today I sat down and had a
> look at how to best implement it. This is my first ever look at amdgpu
> code, so I've marked it with RFC. I've based it on the implementation of
> eedd5a343d22 (drm/amd/pm: add fan target temperature OD setting support
> for SMU13, 2023-08-11) and also hooked resetting the knob with "r".
>
> One thing I'm unsure about is using PP_OD_FEATURE_ZERO_FAN_BIT for
> FeatureCtrlMask. I'm not sure this is the right thing to use there.
>
> I successfully tested this on my own system with a 7900XTX; enabling and
> disabling as well as resetting the knob to its default value work fine.
>
> Thanks!
>
>  Documentation/gpu/amdgpu/thermal.rst          |  6 ++
>  .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 +
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 62 +++++++++++++++++++
>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  2 +
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  2 +
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  1 +
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 55 +++++++++++++++-
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 55 +++++++++++++++-
>  8 files changed, 183 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/gpu/amdgpu/thermal.rst b/Documentation/gpu/amd=
gpu/thermal.rst
> index 6d942b5c5..442b242f9 100644
> --- a/Documentation/gpu/amdgpu/thermal.rst
> +++ b/Documentation/gpu/amdgpu/thermal.rst
> @@ -100,6 +100,12 @@ fan_minimum_pwm
>  .. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
>     :doc: fan_minimum_pwm
>
> +fan_zero_rpm
> +----------------------
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +   :doc: fan_zero_rpm
> +
>  GFXOFF
>  =3D=3D=3D=3D=3D=3D
>
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu=
/drm/amd/include/kgd_pp_interface.h
> index 2fa71f682..c6343e813 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -119,6 +119,7 @@ enum pp_clock_type {
>         OD_ACOUSTIC_TARGET,
>         OD_FAN_TARGET_TEMPERATURE,
>         OD_FAN_MINIMUM_PWM,
> +       OD_FAN_ZERO_RPM,
>  };
>
>  enum amd_pp_sensors {
> @@ -199,6 +200,7 @@ enum PP_OD_DPM_TABLE_COMMAND {
>         PP_OD_EDIT_ACOUSTIC_TARGET,
>         PP_OD_EDIT_FAN_TARGET_TEMPERATURE,
>         PP_OD_EDIT_FAN_MINIMUM_PWM,
> +       PP_OD_EDIT_FAN_ZERO_RPM,
>  };
>
>  struct pp_states_info {
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/=
amdgpu_pm.c
> index ea9407733..52efc5ac6 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -4109,6 +4109,60 @@ static umode_t fan_minimum_pwm_visible(struct amdg=
pu_device *adev)
>         return umode;
>  }
>
> +/**
> + * DOC: fan_zero_rpm
> + *
> + * The amdgpu driver provides a sysfs API for checking and adjusting the
> + * zero RPM feature.
> + *
> + * Reading back the file shows you the current setting and the permitted
> + * ranges if changable.
> + *
> + * Writing an integer to the file, change the setting accordingly.
> + *
> + * When you have finished the editing, write "c" (commit) to the file to=
 commit
> + * your changes.
> + *
> + * If you want to reset to the default value, write "r" (reset) to the f=
ile to
> + * reset them.
> + */
> +static ssize_t fan_zero_rpm_show(struct kobject *kobj,
> +                                          struct kobj_attribute *attr,
> +                                          char *buf)
> +{
> +       struct od_kobj *container =3D container_of(kobj, struct od_kobj, =
kobj);
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)container-=
>priv;
> +
> +       return (ssize_t)amdgpu_retrieve_od_settings(adev, OD_FAN_ZERO_RPM=
, buf);
> +}
> +
> +static ssize_t fan_zero_rpm_store(struct kobject *kobj,
> +                                           struct kobj_attribute *attr,
> +                                           const char *buf,
> +                                           size_t count)
> +{
> +       struct od_kobj *container =3D container_of(kobj, struct od_kobj, =
kobj);
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)container-=
>priv;
> +
> +       return (ssize_t)amdgpu_distribute_custom_od_settings(adev,
> +                                                            PP_OD_EDIT_F=
AN_ZERO_RPM,
> +                                                            buf,
> +                                                            count);
> +}
> +
> +static umode_t fan_zero_rpm_visible(struct amdgpu_device *adev)
> +{
> +       umode_t umode =3D 0000;
> +
> +       if (adev->pm.od_feature_mask & OD_OPS_SUPPORT_FAN_ZERO_RPM_RETRIE=
VE)
> +               umode |=3D S_IRUSR | S_IRGRP | S_IROTH;
> +
> +       if (adev->pm.od_feature_mask & OD_OPS_SUPPORT_FAN_ZERO_RPM_SET)
> +               umode |=3D S_IWUSR;
> +
> +       return umode;
> +}
> +
>  static struct od_feature_set amdgpu_od_set =3D {
>         .containers =3D {
>                 [0] =3D {
> @@ -4154,6 +4208,14 @@ static struct od_feature_set amdgpu_od_set =3D {
>                                                 .store =3D fan_minimum_pw=
m_store,
>                                         },
>                                 },
> +                               [5] =3D {
> +                                       .name =3D "fan_zero_rpm",
> +                                       .ops =3D {
> +                                               .is_visible =3D fan_zero_=
rpm_visible,
> +                                               .show =3D fan_zero_rpm_sh=
ow,
> +                                               .store =3D fan_zero_rpm_s=
tore,
> +                                       },
> +                               },
>                         },
>                 },
>         },
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/am=
d/pm/inc/amdgpu_dpm.h
> index f5bf41f21..be8de30ae 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -328,6 +328,8 @@ struct config_table_setting
>  #define OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_SET              BIT(7)
>  #define OD_OPS_SUPPORT_FAN_MINIMUM_PWM_RETRIEVE                BIT(8)
>  #define OD_OPS_SUPPORT_FAN_MINIMUM_PWM_SET             BIT(9)
> +#define OD_OPS_SUPPORT_FAN_ZERO_RPM_RETRIEVE           BIT(10)
> +#define OD_OPS_SUPPORT_FAN_ZERO_RPM_SET                BIT(11)
>
>  struct amdgpu_pm {
>         struct mutex            mutex;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/=
amd/pm/swsmu/amdgpu_smu.c
> index accc96a03..3c6b14f7b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2874,6 +2874,8 @@ static enum smu_clk_type smu_convert_to_smuclk(enum=
 pp_clock_type type)
>                 clk_type =3D SMU_OD_FAN_TARGET_TEMPERATURE; break;
>         case OD_FAN_MINIMUM_PWM:
>                 clk_type =3D SMU_OD_FAN_MINIMUM_PWM; break;
> +       case OD_FAN_ZERO_RPM:
> +               clk_type =3D SMU_OD_FAN_ZERO_RPM; break;
>         default:
>                 clk_type =3D SMU_CLK_COUNT; break;
>         }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/d=
rm/amd/pm/swsmu/inc/smu_types.h
> index e71a721c1..4d0558470 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> @@ -313,6 +313,7 @@ enum smu_clk_type {
>         SMU_OD_ACOUSTIC_TARGET,
>         SMU_OD_FAN_TARGET_TEMPERATURE,
>         SMU_OD_FAN_MINIMUM_PWM,
> +       SMU_OD_FAN_ZERO_RPM,
>         SMU_CLK_COUNT,
>  };
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 3e2277abc..092fd4806 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -107,6 +107,7 @@
>  #define PP_OD_FEATURE_FAN_ACOUSTIC_TARGET              8
>  #define PP_OD_FEATURE_FAN_TARGET_TEMPERATURE           9
>  #define PP_OD_FEATURE_FAN_MINIMUM_PWM                  10
> +#define PP_OD_FEATURE_FAN_ZERO_RPM                     11
>
>  #define LINK_SPEED_MAX                                 3
>
> @@ -1130,6 +1131,10 @@ static void smu_v13_0_0_get_od_setting_limits(stru=
ct smu_context *smu,
>                 od_min_setting =3D overdrive_lowerlimits->FanMinimumPwm;
>                 od_max_setting =3D overdrive_upperlimits->FanMinimumPwm;
>                 break;
> +       case PP_OD_FEATURE_FAN_ZERO_RPM:
> +               od_min_setting =3D overdrive_lowerlimits->FanZeroRpmEnabl=
e;
> +               od_max_setting =3D overdrive_upperlimits->FanZeroRpmEnabl=
e;
> +               break;
>         default:
>                 od_min_setting =3D od_max_setting =3D INT_MAX;
>                 break;
> @@ -1450,6 +1455,24 @@ static int smu_v13_0_0_print_clk_levels(struct smu=
_context *smu,
>                                       min_value, max_value);
>                 break;
>
> +       case SMU_OD_FAN_ZERO_RPM:
> +               if (!smu_v13_0_0_is_od_feature_supported(smu,
> +                                                        PP_OD_FEATURE_ZE=
RO_FAN_BIT))
> +                       break;
> +
> +               size +=3D sysfs_emit_at(buf, size, "FAN_ZERO_RPM:\n");
> +               size +=3D sysfs_emit_at(buf, size, "%d\n",
> +                                       (int)od_table->OverDriveTable.Fan=
ZeroRpmEnable);
> +
> +               size +=3D sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
> +               smu_v13_0_0_get_od_setting_limits(smu,
> +                                                 PP_OD_FEATURE_FAN_ZERO_=
RPM,
> +                                                 &min_value,
> +                                                 &max_value);
> +               size +=3D sysfs_emit_at(buf, size, "ZERO_RPM: %u %u\n",
> +                                     min_value, max_value);
> +               break;
> +
>         case SMU_OD_RANGE:
>                 if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATU=
RE_GFXCLK_BIT) &&
>                     !smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATU=
RE_UCLK_BIT) &&
> @@ -1547,6 +1570,11 @@ static int smu_v13_0_0_od_restore_table_single(str=
uct smu_context *smu, long inp
>                 od_table->OverDriveTable.FanMode =3D FAN_MODE_AUTO;
>                 od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_F=
EATURE_FAN_CURVE_BIT);
>                 break;
> +       case PP_OD_EDIT_FAN_ZERO_RPM:
> +               od_table->OverDriveTable.FanZeroRpmEnable =3D
> +                                       boot_overdrive_table->OverDriveTa=
ble.FanZeroRpmEnable;
> +               od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_F=
EATURE_ZERO_FAN_BIT);
> +               break;
>         default:
>                 dev_info(adev->dev, "Invalid table index: %ld\n", input);
>                 return -EINVAL;
> @@ -1840,6 +1868,27 @@ static int smu_v13_0_0_od_edit_dpm_table(struct sm=
u_context *smu,
>                 od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_F=
EATURE_FAN_CURVE_BIT);
>                 break;
>
> +       case PP_OD_EDIT_FAN_ZERO_RPM:
> +               if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATU=
RE_ZERO_FAN_BIT)) {
> +                       dev_warn(adev->dev, "Zero RPM setting not support=
ed!\n");
> +                       return -ENOTSUPP;
> +               }
> +
> +               smu_v13_0_0_get_od_setting_limits(smu,
> +                                                 PP_OD_FEATURE_FAN_ZERO_=
RPM,
> +                                                 &minimum,
> +                                                 &maximum);
> +               if (input[0] < minimum ||
> +                   input[0] > maximum) {
> +                       dev_info(adev->dev, "zero RPM setting(%ld) must b=
e within [%d, %d]!\n",
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
>                         ret =3D smu_v13_0_0_od_restore_table_single(smu, =
input[0]);
> @@ -2110,7 +2159,9 @@ static void smu_v13_0_0_set_supported_od_feature_ma=
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
> +                                           OD_OPS_SUPPORT_FAN_ZERO_RPM_R=
ETRIEVE|
> +                                           OD_OPS_SUPPORT_FAN_ZERO_RPM_S=
ET;
>  }
>
>  static int smu_v13_0_0_set_default_od_settings(struct smu_context *smu)
> @@ -2176,6 +2227,8 @@ static int smu_v13_0_0_set_default_od_settings(stru=
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
>         smu_v13_0_0_set_supported_od_feature_mask(smu);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index 23f133884..735ed3d4f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -83,6 +83,7 @@
>  #define PP_OD_FEATURE_FAN_ACOUSTIC_TARGET              8
>  #define PP_OD_FEATURE_FAN_TARGET_TEMPERATURE           9
>  #define PP_OD_FEATURE_FAN_MINIMUM_PWM                  10
> +#define PP_OD_FEATURE_FAN_ZERO_RPM                     11
>
>  #define LINK_SPEED_MAX                                 3
>
> @@ -1119,6 +1120,10 @@ static void smu_v13_0_7_get_od_setting_limits(stru=
ct smu_context *smu,
>                 od_min_setting =3D overdrive_lowerlimits->FanMinimumPwm;
>                 od_max_setting =3D overdrive_upperlimits->FanMinimumPwm;
>                 break;
> +       case PP_OD_FEATURE_FAN_ZERO_RPM:
> +               od_min_setting =3D overdrive_lowerlimits->FanZeroRpmEnabl=
e;
> +               od_max_setting =3D overdrive_upperlimits->FanZeroRpmEnabl=
e;
> +               break;
>         default:
>                 od_min_setting =3D od_max_setting =3D INT_MAX;
>                 break;
> @@ -1439,6 +1444,24 @@ static int smu_v13_0_7_print_clk_levels(struct smu=
_context *smu,
>                                       min_value, max_value);
>                 break;
>
> +       case SMU_OD_FAN_ZERO_RPM:
> +               if (!smu_v13_0_7_is_od_feature_supported(smu,
> +                                                        PP_OD_FEATURE_ZE=
RO_FAN_BIT))
> +                       break;
> +
> +               size +=3D sysfs_emit_at(buf, size, "FAN_ZERO_RPM:\n");
> +               size +=3D sysfs_emit_at(buf, size, "%d\n",
> +                                       (int)od_table->OverDriveTable.Fan=
ZeroRpmEnable);
> +
> +               size +=3D sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
> +               smu_v13_0_7_get_od_setting_limits(smu,
> +                                                 PP_OD_FEATURE_FAN_ZERO_=
RPM,
> +                                                 &min_value,
> +                                                 &max_value);
> +               size +=3D sysfs_emit_at(buf, size, "ZERO_RPM: %u %u\n",
> +                                     min_value, max_value);
> +               break;
> +
>         case SMU_OD_RANGE:
>                 if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATU=
RE_GFXCLK_BIT) &&
>                     !smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATU=
RE_UCLK_BIT) &&
> @@ -1535,6 +1558,11 @@ static int smu_v13_0_7_od_restore_table_single(str=
uct smu_context *smu, long inp
>                 od_table->OverDriveTable.FanMode =3D FAN_MODE_AUTO;
>                 od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_F=
EATURE_FAN_CURVE_BIT);
>                 break;
> +       case PP_OD_EDIT_FAN_ZERO_RPM:
> +               od_table->OverDriveTable.FanZeroRpmEnable =3D
> +                                       boot_overdrive_table->OverDriveTa=
ble.FanZeroRpmEnable;
> +               od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_F=
EATURE_ZERO_FAN_BIT);
> +               break;
>         default:
>                 dev_info(adev->dev, "Invalid table index: %ld\n", input);
>                 return -EINVAL;
> @@ -1828,6 +1856,27 @@ static int smu_v13_0_7_od_edit_dpm_table(struct sm=
u_context *smu,
>                 od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_F=
EATURE_FAN_CURVE_BIT);
>                 break;
>
> +       case PP_OD_EDIT_FAN_ZERO_RPM:
> +               if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATU=
RE_ZERO_FAN_BIT)) {
> +                       dev_warn(adev->dev, "Zero RPM setting not support=
ed!\n");
> +                       return -ENOTSUPP;
> +               }
> +
> +               smu_v13_0_7_get_od_setting_limits(smu,
> +                                                 PP_OD_FEATURE_FAN_ZERO_=
RPM,
> +                                                 &minimum,
> +                                                 &maximum);
> +               if (input[0] < minimum ||
> +                   input[0] > maximum) {
> +                       dev_info(adev->dev, "zero RPM setting(%ld) must b=
e within [%d, %d]!\n",
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
>                         ret =3D smu_v13_0_7_od_restore_table_single(smu, =
input[0]);
> @@ -2094,7 +2143,9 @@ static void smu_v13_0_7_set_supported_od_feature_ma=
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
> +                                           OD_OPS_SUPPORT_FAN_ZERO_RPM_R=
ETRIEVE|
> +                                           OD_OPS_SUPPORT_FAN_ZERO_RPM_S=
ET;
>  }
>
>  static int smu_v13_0_7_set_default_od_settings(struct smu_context *smu)
> @@ -2160,6 +2211,8 @@ static int smu_v13_0_7_set_default_od_settings(stru=
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
>         smu_v13_0_7_set_supported_od_feature_mask(smu);
>
> base-commit: 3631f572ee38bed4c3d0a9003570c63eaa9fd4e3
> --
> 2.47.0
>
