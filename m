Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A55EAD5CCB8
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2024 15:10:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4630E10E2B8;
	Wed, 30 Oct 2024 15:10:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B84O2+2l";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A063710E2B8
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2024 15:10:10 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-2e56750bb13so816220a91.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2024 08:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730301010; x=1730905810; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fv8WilLyYrf59zJ6y520wRp+gJ+bITyLPS+2dTGCO0g=;
 b=B84O2+2lgHSIrK8J/lKm0O05r/a7l/jqrI+lOJskZcm8rIOJpogwHCxqwIowlyU1aG
 LLIMEkLI/Kjexs0UGBjWKLPldTC7gxNuWpeMhl6licF/ZgO+xmqHrLRceAyiEv8mmn2N
 4VZHyClBDnZP8eP9BO6cGFyfVjZ5GGNxfoAZzvaaBtga+f7d/hiuTnIbIOk5bxd5t7RH
 yZZzIgDROk06HxUCV0YCFEkiYsula8kbOSsyoOakzN0NJLl4V2ND+3mVDvYHLD4FXqLx
 sY4KkgT7wmlrb0mgRsc96eSLe9+MrvLG/njochpYcjtRwyKn6UXoTBgmhB+3a1YwaPTu
 RYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730301010; x=1730905810;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fv8WilLyYrf59zJ6y520wRp+gJ+bITyLPS+2dTGCO0g=;
 b=dwWauQpMaiJ52dsUnWjrZ6rXvny/WOmXQAgw75IFvmjFcwa6izyaicA//KJQxgNB+h
 eG0ORj8uwE7mXXxkMq2WvyKnVEV7ysM0jNcUaiTz7kaXdtViV/78RVv9joWxK30lTpgy
 aajIzZ/lHBZvbkPglhV+cPhc+lsIn1+p6pf7UeOkbVy28xkKHUuqHZ5x/xyTWuIiRmv5
 zk83TIXgllE/1u8bgBTCaRiA3R10MITuXdx6cmnPjdWZXWTK9GEVIi3my/B5N1fijWZl
 q8UVrNWbwV4mevKFLz9m870g6p6j5Gt88Lonv3COvQrPQJ3rh6nokGhhSbVDq8f4BcpM
 tmgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWY19uZPafHcZgIBX27oH9pfQzKmFnYL7mBAXlHkgykH9byOA4UJ1fuvXmcNP5NN7XWz7V5aozs@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyd7LhjklWE+zH8/8SQYF3sOc4QxrJuU1/4+dssB/1M6zkuHuwQ
 rM0PPBe9WaqDSgxsdTVkDkL8VYf6XRFN7kha7sCcam2knOwOuDXkL+lRgJ8Vwwma2Dfq1X/arIT
 SXbgUdXZdM2RasW7PDlViPFK/wCI=
X-Google-Smtp-Source: AGHT+IGnWL90Fymwj/Ce/OqkCaQPXKPMOVLJ7WAQAR9blKa6u3VqKeIrBirMPV18SxQHxhpJyWj3tI6FtSUyd1Lpinw=
X-Received: by 2002:a17:90b:1d85:b0:2e2:a60f:289e with SMTP id
 98e67ed59e1d1-2e8f0d5d8ddmr7345958a91.0.1730301010078; Wed, 30 Oct 2024
 08:10:10 -0700 (PDT)
MIME-Version: 1.0
References: <20241019143706.18779-1-wolf@oriole.systems>
 <20241029111753.5132-1-wolf@oriole.systems>
 <20241029111753.5132-3-wolf@oriole.systems>
 <DM4PR12MB516570C59A4F85DE7EC8C5398E542@DM4PR12MB5165.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB516570C59A4F85DE7EC8C5398E542@DM4PR12MB5165.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 30 Oct 2024 11:09:58 -0400
Message-ID: <CADnq5_PKF4u2dsi9UUfOK9vhf1ZRt=1s56DqzsMLQkqbsQ6KZA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/amd/pm: add zero RPM stop temperature OD
 setting support for SMU13
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Cc: =?UTF-8?Q?Wolfgang_M=C3=BCller?= <wolf@oriole.systems>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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

Applied.  Thanks!

Alex

On Tue, Oct 29, 2024 at 9:02=E2=80=AFPM Feng, Kenneth <Kenneth.Feng@amd.com=
> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Series is Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
>
>
> -----Original Message-----
> From: Wolfgang M=C3=BCller <wolf@oriole.systems>
> Sent: Tuesday, October 29, 2024 7:18 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
> Subject: [PATCH v2 2/2] drm/amd/pm: add zero RPM stop temperature OD sett=
ing support for SMU13
>
> Caution: This message originated from an External Source. Use proper caut=
ion when opening attachments, clicking links, or responding.
>
>
> Together with the feature to enable or disable zero RPM in the last commi=
t, it also makes sense to expose the OD setting determining under which tem=
perature the fan should stop if zero RPM is enabled.
>
> Signed-off-by: Wolfgang M=C3=BCller <wolf@oriole.systems>
> ---
>  Documentation/gpu/amdgpu/thermal.rst          |  6 ++
>  .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 +
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 65 +++++++++++++++++++
>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  2 +
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  2 +
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  1 +  .../drm/amd/pm/sws=
mu/smu13/smu_v13_0_0_ppt.c  | 55 +++++++++++++++-  .../drm/amd/pm/swsmu/smu=
13/smu_v13_0_7_ppt.c  | 55 +++++++++++++++-
>  8 files changed, 186 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/gpu/amdgpu/thermal.rst b/Documentation/gpu/amd=
gpu/thermal.rst
> index ec6c1f1d5..1768a106a 100644
> --- a/Documentation/gpu/amdgpu/thermal.rst
> +++ b/Documentation/gpu/amdgpu/thermal.rst
> @@ -106,6 +106,12 @@ fan_zero_rpm_enable  .. kernel-doc:: drivers/gpu/drm=
/amd/pm/amdgpu_pm.c
>     :doc: fan_zero_rpm_enable
>
> +fan_zero_rpm_stop_temperature
> +-----------------------------
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +   :doc: fan_zero_rpm_stop_temperature
> +
>  GFXOFF
>  =3D=3D=3D=3D=3D=3D
>
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu=
/drm/amd/include/kgd_pp_interface.h
> index 80e4b5a7d..bb27c0d2a 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -120,6 +120,7 @@ enum pp_clock_type {
>         OD_FAN_TARGET_TEMPERATURE,
>         OD_FAN_MINIMUM_PWM,
>         OD_FAN_ZERO_RPM_ENABLE,
> +       OD_FAN_ZERO_RPM_STOP_TEMP,
>  };
>
>  enum amd_pp_sensors {
> @@ -201,6 +202,7 @@ enum PP_OD_DPM_TABLE_COMMAND {
>         PP_OD_EDIT_FAN_TARGET_TEMPERATURE,
>         PP_OD_EDIT_FAN_MINIMUM_PWM,
>         PP_OD_EDIT_FAN_ZERO_RPM_ENABLE,
> +       PP_OD_EDIT_FAN_ZERO_RPM_STOP_TEMP,
>  };
>
>  struct pp_states_info {
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/=
amdgpu_pm.c
> index cb96f1f8c..136e81938 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -4163,6 +4163,63 @@ static umode_t fan_zero_rpm_enable_visible(struct =
amdgpu_device *adev)
>         return umode;
>  }
>
> +/**
> + * DOC: fan_zero_rpm_stop_temperature
> + *
> + * The amdgpu driver provides a sysfs API for checking and adjusting
> +the
> + * zero RPM stop temperature feature.
> + *
> + * Reading back the file shows you the current setting and the
> +permitted
> + * ranges if changable.
> + *
> + * Writing an integer to the file, change the setting accordingly.
> + *
> + * When you have finished the editing, write "c" (commit) to the file
> +to commit
> + * your changes.
> + *
> + * If you want to reset to the default value, write "r" (reset) to the
> +file to
> + * reset them.
> + *
> + * This setting works only if the Zero RPM setting is enabled. It
> +adjusts the
> + * temperature below which the fan can stop.
> + */
> +static ssize_t fan_zero_rpm_stop_temp_show(struct kobject *kobj,
> +                                          struct kobj_attribute *attr,
> +                                          char *buf) {
> +       struct od_kobj *container =3D container_of(kobj, struct od_kobj, =
kobj);
> +       struct amdgpu_device *adev =3D (struct amdgpu_device
> +*)container->priv;
> +
> +       return (ssize_t)amdgpu_retrieve_od_settings(adev,
> +OD_FAN_ZERO_RPM_STOP_TEMP, buf); }
> +
> +static ssize_t fan_zero_rpm_stop_temp_store(struct kobject *kobj,
> +                                           struct kobj_attribute *attr,
> +                                           const char *buf,
> +                                           size_t count) {
> +       struct od_kobj *container =3D container_of(kobj, struct od_kobj, =
kobj);
> +       struct amdgpu_device *adev =3D (struct amdgpu_device
> +*)container->priv;
> +
> +       return (ssize_t)amdgpu_distribute_custom_od_settings(adev,
> +                                                            PP_OD_EDIT_F=
AN_ZERO_RPM_STOP_TEMP,
> +                                                            buf,
> +                                                            count); }
> +
> +static umode_t fan_zero_rpm_stop_temp_visible(struct amdgpu_device
> +*adev) {
> +       umode_t umode =3D 0000;
> +
> +       if (adev->pm.od_feature_mask & OD_OPS_SUPPORT_FAN_ZERO_RPM_STOP_T=
EMP_RETRIEVE)
> +               umode |=3D S_IRUSR | S_IRGRP | S_IROTH;
> +
> +       if (adev->pm.od_feature_mask & OD_OPS_SUPPORT_FAN_ZERO_RPM_STOP_T=
EMP_SET)
> +               umode |=3D S_IWUSR;
> +
> +       return umode;
> +}
> +
>  static struct od_feature_set amdgpu_od_set =3D {
>         .containers =3D {
>                 [0] =3D {
> @@ -4216,6 +4273,14 @@ static struct od_feature_set amdgpu_od_set =3D {
>                                                 .store =3D fan_zero_rpm_e=
nable_store,
>                                         },
>                                 },
> +                               [6] =3D {
> +                                       .name =3D "fan_zero_rpm_stop_temp=
erature",
> +                                       .ops =3D {
> +                                               .is_visible =3D fan_zero_=
rpm_stop_temp_visible,
> +                                               .show =3D fan_zero_rpm_st=
op_temp_show,
> +                                               .store =3D fan_zero_rpm_s=
top_temp_store,
> +                                       },
> +                               },
>                         },
>                 },
>         },
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/am=
d/pm/inc/amdgpu_dpm.h
> index b5daa12c0..363af8990 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -330,6 +330,8 @@ struct config_table_setting
>  #define OD_OPS_SUPPORT_FAN_MINIMUM_PWM_SET             BIT(9)
>  #define OD_OPS_SUPPORT_FAN_ZERO_RPM_ENABLE_RETRIEVE    BIT(10)
>  #define OD_OPS_SUPPORT_FAN_ZERO_RPM_ENABLE_SET         BIT(11)
> +#define OD_OPS_SUPPORT_FAN_ZERO_RPM_STOP_TEMP_RETRIEVE BIT(12)
> +#define OD_OPS_SUPPORT_FAN_ZERO_RPM_STOP_TEMP_SET      BIT(13)
>
>  struct amdgpu_pm {
>         struct mutex            mutex;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/=
amd/pm/swsmu/amdgpu_smu.c
> index 8d3f3e735..8148933cc 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2876,6 +2876,8 @@ static enum smu_clk_type smu_convert_to_smuclk(enum=
 pp_clock_type type)
>                 clk_type =3D SMU_OD_FAN_MINIMUM_PWM; break;
>         case OD_FAN_ZERO_RPM_ENABLE:
>                 clk_type =3D SMU_OD_FAN_ZERO_RPM_ENABLE; break;
> +       case OD_FAN_ZERO_RPM_STOP_TEMP:
> +               clk_type =3D SMU_OD_FAN_ZERO_RPM_STOP_TEMP; break;
>         default:
>                 clk_type =3D SMU_CLK_COUNT; break;
>         }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/d=
rm/amd/pm/swsmu/inc/smu_types.h
> index e0abb449a..a299dc4a8 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> @@ -314,6 +314,7 @@ enum smu_clk_type {
>         SMU_OD_FAN_TARGET_TEMPERATURE,
>         SMU_OD_FAN_MINIMUM_PWM,
>         SMU_OD_FAN_ZERO_RPM_ENABLE,
> +       SMU_OD_FAN_ZERO_RPM_STOP_TEMP,
>         SMU_CLK_COUNT,
>  };
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 0d9a4638e..93cc82fe2 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -108,6 +108,7 @@
>  #define PP_OD_FEATURE_FAN_TARGET_TEMPERATURE           9
>  #define PP_OD_FEATURE_FAN_MINIMUM_PWM                  10
>  #define PP_OD_FEATURE_FAN_ZERO_RPM_ENABLE              11
> +#define PP_OD_FEATURE_FAN_ZERO_RPM_STOP_TEMP           12
>
>  #define LINK_SPEED_MAX                                 3
>
> @@ -1135,6 +1136,10 @@ static void smu_v13_0_0_get_od_setting_limits(stru=
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
> @@ -1473,6 +1478,24 @@ static int smu_v13_0_0_print_clk_levels(struct smu=
_context *smu,
>                                       min_value, max_value);
>                 break;
>
> +       case SMU_OD_FAN_ZERO_RPM_STOP_TEMP:
> +               if (!smu_v13_0_0_is_od_feature_supported(smu,
> +                                                        PP_OD_FEATURE_ZE=
RO_FAN_BIT))
> +                       break;
> +
> +               size +=3D sysfs_emit_at(buf, size, "FAN_ZERO_RPM_STOP_TEM=
PERATURE:\n");
> +               size +=3D sysfs_emit_at(buf, size, "%d\n",
> +
> + (int)od_table->OverDriveTable.FanZeroRpmStopTemp);
> +
> +               size +=3D sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
> +               smu_v13_0_0_get_od_setting_limits(smu,
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
>                 if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATU=
RE_GFXCLK_BIT) &&
>                     !smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATU=
RE_UCLK_BIT) && @@ -1575,6 +1598,11 @@ static int smu_v13_0_0_od_restore_ta=
ble_single(struct smu_context *smu, long inp
>                                         boot_overdrive_table->OverDriveTa=
ble.FanZeroRpmEnable;
>                 od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_F=
EATURE_ZERO_FAN_BIT);
>                 break;
> +       case PP_OD_EDIT_FAN_ZERO_RPM_STOP_TEMP:
> +               od_table->OverDriveTable.FanZeroRpmStopTemp =3D
> +                                       boot_overdrive_table->OverDriveTa=
ble.FanZeroRpmStopTemp;
> +               od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_F=
EATURE_ZERO_FAN_BIT);
> +               break;
>         default:
>                 dev_info(adev->dev, "Invalid table index: %ld\n", input);
>                 return -EINVAL;
> @@ -1889,6 +1917,27 @@ static int smu_v13_0_0_od_edit_dpm_table(struct sm=
u_context *smu,
>                 od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_F=
EATURE_ZERO_FAN_BIT);
>                 break;
>
> +       case PP_OD_EDIT_FAN_ZERO_RPM_STOP_TEMP:
> +               if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATU=
RE_ZERO_FAN_BIT)) {
> +                       dev_warn(adev->dev, "Zero RPM setting not support=
ed!\n");
> +                       return -ENOTSUPP;
> +               }
> +
> +               smu_v13_0_0_get_od_setting_limits(smu,
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
>                         ret =3D smu_v13_0_0_od_restore_table_single(smu, =
input[0]); @@ -2161,7 +2210,9 @@ static void smu_v13_0_0_set_supported_od_f=
eature_mask(struct smu_context *smu)
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
> +
> + OD_OPS_SUPPORT_FAN_ZERO_RPM_STOP_TEMP_SET;
>  }
>
>  static int smu_v13_0_0_set_default_od_settings(struct smu_context *smu) =
@@ -2229,6 +2280,8 @@ static int smu_v13_0_0_set_default_od_settings(struct=
 smu_context *smu)
>                         user_od_table_bak.OverDriveTable.FanMinimumPwm;
>                 user_od_table->OverDriveTable.FanZeroRpmEnable =3D
>                         user_od_table_bak.OverDriveTable.FanZeroRpmEnable=
;
> +               user_od_table->OverDriveTable.FanZeroRpmStopTemp =3D
> +
> + user_od_table_bak.OverDriveTable.FanZeroRpmStopTemp;
>         }
>
>         smu_v13_0_0_set_supported_od_feature_mask(smu);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index 6b61655f9..0b3c53324 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -84,6 +84,7 @@
>  #define PP_OD_FEATURE_FAN_TARGET_TEMPERATURE           9
>  #define PP_OD_FEATURE_FAN_MINIMUM_PWM                  10
>  #define PP_OD_FEATURE_FAN_ZERO_RPM_ENABLE              11
> +#define PP_OD_FEATURE_FAN_ZERO_RPM_STOP_TEMP           12
>
>  #define LINK_SPEED_MAX                                 3
>
> @@ -1124,6 +1125,10 @@ static void smu_v13_0_7_get_od_setting_limits(stru=
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
> @@ -1462,6 +1467,24 @@ static int smu_v13_0_7_print_clk_levels(struct smu=
_context *smu,
>                                       min_value, max_value);
>                 break;
>
> +       case SMU_OD_FAN_ZERO_RPM_STOP_TEMP:
> +               if (!smu_v13_0_7_is_od_feature_supported(smu,
> +                                                        PP_OD_FEATURE_ZE=
RO_FAN_BIT))
> +                       break;
> +
> +               size +=3D sysfs_emit_at(buf, size, "FAN_ZERO_RPM_STOP_TEM=
PERATURE:\n");
> +               size +=3D sysfs_emit_at(buf, size, "%d\n",
> +
> + (int)od_table->OverDriveTable.FanZeroRpmStopTemp);
> +
> +               size +=3D sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
> +               smu_v13_0_7_get_od_setting_limits(smu,
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
>                 if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATU=
RE_GFXCLK_BIT) &&
>                     !smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATU=
RE_UCLK_BIT) && @@ -1563,6 +1586,11 @@ static int smu_v13_0_7_od_restore_ta=
ble_single(struct smu_context *smu, long inp
>                                         boot_overdrive_table->OverDriveTa=
ble.FanZeroRpmEnable;
>                 od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_F=
EATURE_ZERO_FAN_BIT);
>                 break;
> +       case PP_OD_EDIT_FAN_ZERO_RPM_STOP_TEMP:
> +               od_table->OverDriveTable.FanZeroRpmStopTemp =3D
> +                                       boot_overdrive_table->OverDriveTa=
ble.FanZeroRpmStopTemp;
> +               od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_F=
EATURE_ZERO_FAN_BIT);
> +               break;
>         default:
>                 dev_info(adev->dev, "Invalid table index: %ld\n", input);
>                 return -EINVAL;
> @@ -1877,6 +1905,27 @@ static int smu_v13_0_7_od_edit_dpm_table(struct sm=
u_context *smu,
>                 od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_F=
EATURE_ZERO_FAN_BIT);
>                 break;
>
> +       case PP_OD_EDIT_FAN_ZERO_RPM_STOP_TEMP:
> +               if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATU=
RE_ZERO_FAN_BIT)) {
> +                       dev_warn(adev->dev, "Zero RPM setting not support=
ed!\n");
> +                       return -ENOTSUPP;
> +               }
> +
> +               smu_v13_0_7_get_od_setting_limits(smu,
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
>                         ret =3D smu_v13_0_7_od_restore_table_single(smu, =
input[0]); @@ -2145,7 +2194,9 @@ static void smu_v13_0_7_set_supported_od_f=
eature_mask(struct smu_context *smu)
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
> +
> + OD_OPS_SUPPORT_FAN_ZERO_RPM_STOP_TEMP_SET;
>  }
>
>  static int smu_v13_0_7_set_default_od_settings(struct smu_context *smu) =
@@ -2213,6 +2264,8 @@ static int smu_v13_0_7_set_default_od_settings(struct=
 smu_context *smu)
>                         user_od_table_bak.OverDriveTable.FanMinimumPwm;
>                 user_od_table->OverDriveTable.FanZeroRpmEnable =3D
>                         user_od_table_bak.OverDriveTable.FanZeroRpmEnable=
;
> +               user_od_table->OverDriveTable.FanZeroRpmStopTemp =3D
> +
> + user_od_table_bak.OverDriveTable.FanZeroRpmStopTemp;
>         }
>
>         smu_v13_0_7_set_supported_od_feature_mask(smu);
> --
> 2.47.0
>
