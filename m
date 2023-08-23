Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9697CEE49A3
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 13:34:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AF7E10E422;
	Wed, 23 Aug 2023 13:34:27 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53FF910E423
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 13:34:25 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3a412653335so4140467b6e.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 06:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692797664; x=1693402464;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=97FOAy+5WKTvn52WOBRefvVtyVgOjvFBe4utz3hckMI=;
 b=iUkijiFMLBrK9f4DUsdI0eFNlXix1GFweVlLmFz4I978Bq2IglRWBtd0SlzBunqt+H
 RQxA0woIR1r0c/7lW3JnvrnntKtpim9arwtEPz5wA25Du74Vpj2qmBJ/4JTyBUqknAaU
 a467MYWo4NfwD4Up395NA3ALC5gE1sJobO81SPaLQJHiTwDkJ9wrRVUKhfuesd49/G/x
 JFfzzoLf0KTu2yfoYGQlAnQTyDjhXb74HGOjVjvZBmEFNkAehgS9SghmdFV1QTCWVaj5
 T0Ta+76l1HCpNtAJnWAb7n2lB5x51EMaiP4/jW2BVMkjaOmwnbST5Vcp83aOaRgVrriC
 bntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692797664; x=1693402464;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=97FOAy+5WKTvn52WOBRefvVtyVgOjvFBe4utz3hckMI=;
 b=dwFBWezF8oNHqOihoNhnza647CqFzvIsdLZqNSjrvesR7OYDdMax6mWrJROlYXhL31
 4kyqAL8GG/xB2XhgnWy0OrfvtAb6SR8vyGTO8+agtkXUPBYB4QoFRFSDCddSxDNuvzSF
 tmMPeRfaYlVLpsTCRgz9/hT+W9Le+RtNvtFih3/vzPLG0gW4P9StKHxVnZnO5HWucAUM
 9mQLZX9yNA8qOQ8gMAGzCK1BYWKiI3BrfBoUZWoQVAdXYZPwRqL+mtRecE2Bh20x1taA
 dqQzLjICfnu7tc2QKLtxQHBsH6AZrG195CZ3qqAahDDQW/BqA2m1rPd8G1kOe1wy2ZQ/
 NYLQ==
X-Gm-Message-State: AOJu0YxGEE23EU3QaigCpxKIrAHoWlbx1vzSgpBtJOuxfgNqRCk5avp4
 SvVtRfNP9At3HNqkjJ3Bykbn3RBcrRKHA2wuxRHQjHEp
X-Google-Smtp-Source: AGHT+IG5Q4u5Sc0gEii2TREx4jeERpTlN1JYTu9YssCSW/xmojzQwWzhY2r1SNj3c5CEs2KEBlslWSNQG7/IDsFYlJ0=
X-Received: by 2002:a05:6808:17a2:b0:3a7:3b6f:ed46 with SMTP id
 bg34-20020a05680817a200b003a73b6fed46mr17964674oib.27.1692797664304; Wed, 23
 Aug 2023 06:34:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230823063406.1195151-1-evan.quan@amd.com>
 <20230823063406.1195151-8-evan.quan@amd.com>
In-Reply-To: <20230823063406.1195151-8-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 23 Aug 2023 09:34:13 -0400
Message-ID: <CADnq5_PhD4ZuHHbyksi=bLx5YGhdYfCEBKqjp3rapLxDk8pg-g@mail.gmail.com>
Subject: Re: [V2 8/8] drm/amd/pm: add fan minimum pwm OD setting support for
 SMU13
To: Evan Quan <evan.quan@amd.com>
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
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Are there any restrictions on which fan control options you can
enable?  I.e., can you mess with all of these or are there several
discrete fan modes (acoustic, curve, min fan, etc.) that you have to
set up independently?  We should document the restrictions.

Alex

On Wed, Aug 23, 2023 at 2:45=E2=80=AFAM Evan Quan <evan.quan@amd.com> wrote=
:
>
> Add SMU13 fan minimum pwm OD setting support.
>
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> --
> v1->v2:
>   - add missing kerneldoc for the new interface(Alex)
> ---
>  Documentation/gpu/amdgpu/thermal.rst          |  6 ++
>  .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 +
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 59 +++++++++++++++++++
>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  2 +
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  2 +
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  1 +
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 51 +++++++++++++++-
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 51 +++++++++++++++-
>  8 files changed, 172 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/gpu/amdgpu/thermal.rst b/Documentation/gpu/amd=
gpu/thermal.rst
> index 073ab9e418b1..940f723472b8 100644
> --- a/Documentation/gpu/amdgpu/thermal.rst
> +++ b/Documentation/gpu/amdgpu/thermal.rst
> @@ -94,6 +94,12 @@ fan_target_temperature
>  .. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
>     :doc: fan_target_temperature
>
> +fan_minimum_pwm
> +---------------
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +   :doc: fan_minimum_pwm
> +
>  GFXOFF
>  =3D=3D=3D=3D=3D=3D
>
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu=
/drm/amd/include/kgd_pp_interface.h
> index c1065136f527..528c892f7c4b 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -118,6 +118,7 @@ enum pp_clock_type {
>         OD_ACOUSTIC_LIMIT,
>         OD_ACOUSTIC_TARGET,
>         OD_FAN_TARGET_TEMPERATURE,
> +       OD_FAN_MINIMUM_PWM,
>  };
>
>  enum amd_pp_sensors {
> @@ -197,6 +198,7 @@ enum PP_OD_DPM_TABLE_COMMAND {
>         PP_OD_EDIT_ACOUSTIC_LIMIT,
>         PP_OD_EDIT_ACOUSTIC_TARGET,
>         PP_OD_EDIT_FAN_TARGET_TEMPERATURE,
> +       PP_OD_EDIT_FAN_MINIMUM_PWM,
>  };
>
>  struct pp_states_info {
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/=
amdgpu_pm.c
> index 682eef0c0eeb..fa6c4ab16ccf 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -3772,6 +3772,57 @@ static umode_t fan_target_temperature_visible(stru=
ct amdgpu_device *adev)
>         return umode;
>  }
>
> +/**
> + * DOC: fan_minimum_pwm
> + *
> + * The amdgpu driver provides a sysfs API for checking and adjusting the
> + * minimum fan speed in PWM.
> + *
> + * Reading back the file shows you the current setting and the permitted
> + * ranges if changable.
> + *
> + * Writing an integer to the file, change the setting accordingly.
> + *
> + * When you have finished the editing, write "c" (commit) to the file to=
 commit
> + * your changes. NOTE: this will switch the fan control to auto mode.
> + */
> +static ssize_t fan_minimum_pwm_show(struct kobject *kobj,
> +                                   struct kobj_attribute *attr,
> +                                   char *buf)
> +{
> +       struct od_kobj *container =3D container_of(kobj, struct od_kobj, =
kobj);
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)container-=
>priv;
> +
> +       return (ssize_t)amdgpu_retrieve_od_settings(adev, OD_FAN_MINIMUM_=
PWM, buf);
> +}
> +
> +static ssize_t fan_minimum_pwm_store(struct kobject *kobj,
> +                                    struct kobj_attribute *attr,
> +                                    const char *buf,
> +                                    size_t count)
> +{
> +       struct od_kobj *container =3D container_of(kobj, struct od_kobj, =
kobj);
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)container-=
>priv;
> +
> +       return (ssize_t)amdgpu_distribute_custom_od_settings(adev,
> +                                                            PP_OD_EDIT_F=
AN_MINIMUM_PWM,
> +                                                            buf,
> +                                                            count);
> +}
> +
> +static umode_t fan_minimum_pwm_visible(struct amdgpu_device *adev)
> +{
> +       umode_t umode =3D 0000;
> +
> +       if (adev->pm.od_feature_mask & OD_OPS_SUPPORT_FAN_MINIMUM_PWM_RET=
RIEVE)
> +               umode |=3D S_IRUSR | S_IRGRP | S_IROTH;
> +
> +       if (adev->pm.od_feature_mask & OD_OPS_SUPPORT_FAN_MINIMUM_PWM_SET=
)
> +               umode |=3D S_IWUSR;
> +
> +       return umode;
> +}
> +
>  static struct od_feature_set amdgpu_od_set =3D {
>         .containers =3D {
>                 [0] =3D {
> @@ -3817,6 +3868,14 @@ static struct od_feature_set amdgpu_od_set =3D {
>                                                 .store =3D fan_target_tem=
perature_store,
>                                         },
>                                 },
> +                               [5] =3D {
> +                                       .name =3D "fan_minimum_pwm",
> +                                       .ops =3D {
> +                                               .is_visible =3D fan_minim=
um_pwm_visible,
> +                                               .show =3D fan_minimum_pwm=
_show,
> +                                               .store =3D fan_minimum_pw=
m_store,
> +                                       },
> +                               },
>                         },
>                 },
>         },
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/am=
d/pm/inc/amdgpu_dpm.h
> index 80d2ac1ecb9f..342c4d8318dc 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -324,6 +324,8 @@ struct config_table_setting
>  #define OD_OPS_SUPPORT_ACOUSTIC_TARGET_THRESHOLD_SET           BIT(7)
>  #define OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_RETRIEVE BIT(8)
>  #define OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_SET      BIT(9)
> +#define OD_OPS_SUPPORT_FAN_MINIMUM_PWM_RETRIEVE                BIT(10)
> +#define OD_OPS_SUPPORT_FAN_MINIMUM_PWM_SET             BIT(11)
>
>  struct amdgpu_pm {
>         struct mutex            mutex;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/=
amd/pm/swsmu/amdgpu_smu.c
> index 22a6527139a6..d22ed5a272ce 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2491,6 +2491,8 @@ static enum smu_clk_type smu_convert_to_smuclk(enum=
 pp_clock_type type)
>                 clk_type =3D SMU_OD_ACOUSTIC_TARGET; break;
>         case OD_FAN_TARGET_TEMPERATURE:
>                 clk_type =3D SMU_OD_FAN_TARGET_TEMPERATURE; break;
> +       case OD_FAN_MINIMUM_PWM:
> +               clk_type =3D SMU_OD_FAN_MINIMUM_PWM; break;
>         default:
>                 clk_type =3D SMU_CLK_COUNT; break;
>         }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/d=
rm/amd/pm/swsmu/inc/smu_types.h
> index 1a00f807fb09..5c8f30f600f8 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> @@ -285,6 +285,7 @@ enum smu_clk_type {
>         SMU_OD_ACOUSTIC_LIMIT,
>         SMU_OD_ACOUSTIC_TARGET,
>         SMU_OD_FAN_TARGET_TEMPERATURE,
> +       SMU_OD_FAN_MINIMUM_PWM,
>         SMU_CLK_COUNT,
>  };
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 953620f95abc..bedd9ca3605c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -107,6 +107,7 @@
>  #define PP_OD_FEATURE_FAN_ACOUSTIC_LIMIT               8
>  #define PP_OD_FEATURE_FAN_ACOUSTIC_TARGET              9
>  #define PP_OD_FEATURE_FAN_TARGET_TEMPERATURE           10
> +#define PP_OD_FEATURE_FAN_MINIMUM_PWM                  11
>
>  #define LINK_SPEED_MAX                                 3
>
> @@ -1140,6 +1141,10 @@ static void smu_v13_0_0_get_od_setting_limits(stru=
ct smu_context *smu,
>                 od_min_setting =3D overdrive_lowerlimits->FanTargetTemper=
ature;
>                 od_max_setting =3D overdrive_upperlimits->FanTargetTemper=
ature;
>                 break;
> +       case PP_OD_FEATURE_FAN_MINIMUM_PWM:
> +               od_min_setting =3D overdrive_lowerlimits->FanMinimumPwm;
> +               od_max_setting =3D overdrive_upperlimits->FanMinimumPwm;
> +               break;
>         default:
>                 od_min_setting =3D od_max_setting =3D INT_MAX;
>                 break;
> @@ -1452,6 +1457,24 @@ static int smu_v13_0_0_print_clk_levels(struct smu=
_context *smu,
>                                       min_value, max_value);
>                 break;
>
> +       case SMU_OD_FAN_MINIMUM_PWM:
> +               if (!smu_v13_0_0_is_od_feature_supported(smu,
> +                                                        PP_OD_FEATURE_FA=
N_CURVE_BIT))
> +                       break;
> +
> +               size +=3D sysfs_emit_at(buf, size, "FAN_MINIMUM_PWM:\n");
> +               size +=3D sysfs_emit_at(buf, size, "%d\n",
> +                                       (int)od_table->OverDriveTable.Fan=
MinimumPwm);
> +
> +               size +=3D sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
> +               smu_v13_0_0_get_od_setting_limits(smu,
> +                                                 PP_OD_FEATURE_FAN_MINIM=
UM_PWM,
> +                                                 &min_value,
> +                                                 &max_value);
> +               size +=3D sysfs_emit_at(buf, size, "MINIMUM_PWM: %u %u\n"=
,
> +                                     min_value, max_value);
> +               break;
> +
>         case SMU_OD_RANGE:
>                 if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATU=
RE_GFXCLK_BIT) &&
>                     !smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATU=
RE_UCLK_BIT) &&
> @@ -1766,6 +1789,28 @@ static int smu_v13_0_0_od_edit_dpm_table(struct sm=
u_context *smu,
>                 od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_F=
EATURE_FAN_CURVE_BIT);
>                 break;
>
> +       case PP_OD_EDIT_FAN_MINIMUM_PWM:
> +               if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATU=
RE_FAN_CURVE_BIT)) {
> +                       dev_warn(adev->dev, "Fan curve setting not suppor=
ted!\n");
> +                       return -ENOTSUPP;
> +               }
> +
> +               smu_v13_0_0_get_od_setting_limits(smu,
> +                                                 PP_OD_FEATURE_FAN_MINIM=
UM_PWM,
> +                                                 &minimum,
> +                                                 &maximum);
> +               if (input[0] < minimum ||
> +                   input[0] > maximum) {
> +                       dev_info(adev->dev, "fan minimum pwm setting(%ld)=
 must be within [%d, %d]!\n",
> +                                input[0], minimum, maximum);
> +                       return -EINVAL;
> +               }
> +
> +               od_table->OverDriveTable.FanMinimumPwm =3D input[0];
> +               od_table->OverDriveTable.FanMode =3D FAN_MODE_AUTO;
> +               od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_F=
EATURE_FAN_CURVE_BIT);
> +               break;
> +
>         case PP_OD_RESTORE_DEFAULT_TABLE:
>                 feature_ctrlmask =3D od_table->OverDriveTable.FeatureCtrl=
Mask;
>                 memcpy(od_table,
> @@ -2030,7 +2075,9 @@ static void smu_v13_0_0_set_supported_od_feature_ma=
sk(struct smu_context *smu)
>                                             OD_OPS_SUPPORT_ACOUSTIC_TARGE=
T_THRESHOLD_RETRIEVE |
>                                             OD_OPS_SUPPORT_ACOUSTIC_TARGE=
T_THRESHOLD_SET |
>                                             OD_OPS_SUPPORT_FAN_TARGET_TEM=
PERATURE_RETRIEVE |
> -                                           OD_OPS_SUPPORT_FAN_TARGET_TEM=
PERATURE_SET;
> +                                           OD_OPS_SUPPORT_FAN_TARGET_TEM=
PERATURE_SET |
> +                                           OD_OPS_SUPPORT_FAN_MINIMUM_PW=
M_RETRIEVE |
> +                                           OD_OPS_SUPPORT_FAN_MINIMUM_PW=
M_SET;
>  }
>
>  static int smu_v13_0_0_set_default_od_settings(struct smu_context *smu)
> @@ -2096,6 +2143,8 @@ static int smu_v13_0_0_set_default_od_settings(stru=
ct smu_context *smu)
>                         user_od_table_bak.OverDriveTable.AcousticTargetRp=
mThreshold;
>                 user_od_table->OverDriveTable.FanTargetTemperature =3D
>                         user_od_table_bak.OverDriveTable.FanTargetTempera=
ture;
> +               user_od_table->OverDriveTable.FanMinimumPwm =3D
> +                       user_od_table_bak.OverDriveTable.FanMinimumPwm;
>         }
>
>         smu_v13_0_0_set_supported_od_feature_mask(smu);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index a4d48ef5aaa7..c2ca5f228dd5 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -83,6 +83,7 @@
>  #define PP_OD_FEATURE_FAN_ACOUSTIC_LIMIT               8
>  #define PP_OD_FEATURE_FAN_ACOUSTIC_TARGET              9
>  #define PP_OD_FEATURE_FAN_TARGET_TEMPERATURE           10
> +#define PP_OD_FEATURE_FAN_MINIMUM_PWM                  11
>
>  #define LINK_SPEED_MAX                                 3
>
> @@ -1126,6 +1127,10 @@ static void smu_v13_0_7_get_od_setting_limits(stru=
ct smu_context *smu,
>                 od_min_setting =3D overdrive_lowerlimits->FanTargetTemper=
ature;
>                 od_max_setting =3D overdrive_upperlimits->FanTargetTemper=
ature;
>                 break;
> +       case PP_OD_FEATURE_FAN_MINIMUM_PWM:
> +               od_min_setting =3D overdrive_lowerlimits->FanMinimumPwm;
> +               od_max_setting =3D overdrive_upperlimits->FanMinimumPwm;
> +               break;
>         default:
>                 od_min_setting =3D od_max_setting =3D INT_MAX;
>                 break;
> @@ -1438,6 +1443,24 @@ static int smu_v13_0_7_print_clk_levels(struct smu=
_context *smu,
>                                       min_value, max_value);
>                 break;
>
> +       case SMU_OD_FAN_MINIMUM_PWM:
> +               if (!smu_v13_0_7_is_od_feature_supported(smu,
> +                                                        PP_OD_FEATURE_FA=
N_CURVE_BIT))
> +                       break;
> +
> +               size +=3D sysfs_emit_at(buf, size, "FAN_MINIMUM_PWM:\n");
> +               size +=3D sysfs_emit_at(buf, size, "%d\n",
> +                                       (int)od_table->OverDriveTable.Fan=
MinimumPwm);
> +
> +               size +=3D sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
> +               smu_v13_0_7_get_od_setting_limits(smu,
> +                                                 PP_OD_FEATURE_FAN_MINIM=
UM_PWM,
> +                                                 &min_value,
> +                                                 &max_value);
> +               size +=3D sysfs_emit_at(buf, size, "MINIMUM_PWM: %u %u\n"=
,
> +                                     min_value, max_value);
> +               break;
> +
>         case SMU_OD_RANGE:
>                 if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATU=
RE_GFXCLK_BIT) &&
>                     !smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATU=
RE_UCLK_BIT) &&
> @@ -1752,6 +1775,28 @@ static int smu_v13_0_7_od_edit_dpm_table(struct sm=
u_context *smu,
>                 od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_F=
EATURE_FAN_CURVE_BIT);
>                 break;
>
> +       case PP_OD_EDIT_FAN_MINIMUM_PWM:
> +               if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATU=
RE_FAN_CURVE_BIT)) {
> +                       dev_warn(adev->dev, "Fan curve setting not suppor=
ted!\n");
> +                       return -ENOTSUPP;
> +               }
> +
> +               smu_v13_0_7_get_od_setting_limits(smu,
> +                                                 PP_OD_FEATURE_FAN_MINIM=
UM_PWM,
> +                                                 &minimum,
> +                                                 &maximum);
> +               if (input[0] < minimum ||
> +                   input[0] > maximum) {
> +                       dev_info(adev->dev, "fan minimum pwm setting(%ld)=
 must be within [%d, %d]!\n",
> +                                input[0], minimum, maximum);
> +                       return -EINVAL;
> +               }
> +
> +               od_table->OverDriveTable.FanMinimumPwm =3D input[0];
> +               od_table->OverDriveTable.FanMode =3D FAN_MODE_AUTO;
> +               od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_F=
EATURE_FAN_CURVE_BIT);
> +               break;
> +
>         case PP_OD_RESTORE_DEFAULT_TABLE:
>                 feature_ctrlmask =3D od_table->OverDriveTable.FeatureCtrl=
Mask;
>                 memcpy(od_table,
> @@ -2011,7 +2056,9 @@ static void smu_v13_0_7_set_supported_od_feature_ma=
sk(struct smu_context *smu)
>                                             OD_OPS_SUPPORT_ACOUSTIC_TARGE=
T_THRESHOLD_RETRIEVE |
>                                             OD_OPS_SUPPORT_ACOUSTIC_TARGE=
T_THRESHOLD_SET |
>                                             OD_OPS_SUPPORT_FAN_TARGET_TEM=
PERATURE_RETRIEVE |
> -                                           OD_OPS_SUPPORT_FAN_TARGET_TEM=
PERATURE_SET;
> +                                           OD_OPS_SUPPORT_FAN_TARGET_TEM=
PERATURE_SET |
> +                                           OD_OPS_SUPPORT_FAN_MINIMUM_PW=
M_RETRIEVE |
> +                                           OD_OPS_SUPPORT_FAN_MINIMUM_PW=
M_SET;
>  }
>
>  static int smu_v13_0_7_set_default_od_settings(struct smu_context *smu)
> @@ -2077,6 +2124,8 @@ static int smu_v13_0_7_set_default_od_settings(stru=
ct smu_context *smu)
>                         user_od_table_bak.OverDriveTable.AcousticTargetRp=
mThreshold;
>                 user_od_table->OverDriveTable.FanTargetTemperature =3D
>                         user_od_table_bak.OverDriveTable.FanTargetTempera=
ture;
> +               user_od_table->OverDriveTable.FanMinimumPwm =3D
> +                       user_od_table_bak.OverDriveTable.FanMinimumPwm;
>         }
>
>         smu_v13_0_7_set_supported_od_feature_mask(smu);
> --
> 2.34.1
>
