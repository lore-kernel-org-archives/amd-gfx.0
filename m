Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA03CD80CD
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Oct 2023 13:20:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2077110E1E6;
	Tue, 10 Oct 2023 13:20:27 +0000 (UTC)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3913110E1E6
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 13:20:24 +0000 (UTC)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-1dcfb2a3282so3921751fac.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 06:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696944023; x=1697548823; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ym5hEOXjDj7NqEIrQc3Q9DxmgDyN+8JowioKzDhzGLQ=;
 b=RTKwVjjr22smbp7qqIjqwLsoRqHHuxyfiEedT6XmX+Jy+aGuClgNgcUjvDRWMb+jfH
 dlQFrEOFpnbLbAP/oy8Q7aQLRBZgIEhKBm/l3iC+Kzm8xoIEa8VznmWV9DjrvFKyqYCR
 JHGJumVMWL4cOWYoKY9eFCrwBvj9OcEuAMkAShGmcSUCFNb98WIfhRleclhomqQg3pz/
 18iX0xBnlt/y7CDK4N+bTv5AfvOvU03Dqg00kiaAkQb2xxDLHwIcR0De6KuyGlTNc+It
 JMF0w3PN6gxQcTzi7MVUj0GMjgd4OSJ+BOnJvANzYAlw5zWw+qoGWiuXefmlRwbtJcZy
 IZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696944023; x=1697548823;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ym5hEOXjDj7NqEIrQc3Q9DxmgDyN+8JowioKzDhzGLQ=;
 b=LFq0Zujygbho2I3JdC5QQgZna4bl38oW4UVf9Dl2e2/g8E0FgdFdDyx5QettfCqaMh
 izl5qAAKgyhC8Q9vQUGLfOZHFxtBtaafFkC64hvVEga5aGGvEAnxd3popnlD8WV0EP76
 Gx1t6pt+yEMB3H2Ich5RH/pOie5iZz5Mw+kJCtbPRK/0XpNbOdpPWcwyIYdWeFv9Kv4S
 DIXncJMFxUo0uJevBj7imubtV3H5tc3QfhYcqkRWTpAqiJDHI+zMNioa00ZHAXhxMgUl
 70aw+wqoJmZU/SoegyPOzTcRnwReTTRT3JN2KWQRujwYriYD6zKJC2GRMnKRczF98tV2
 H1iw==
X-Gm-Message-State: AOJu0Yw3X3PVc0RWlZhDQA29P+TcMmKf7ndnJXKeSS9eiVU824ewUljX
 6fCMhHETupyjKeOpkzWWPdFEHf0/m8M6EIk1mUfYt79C
X-Google-Smtp-Source: AGHT+IFfY+XylU7TtS54mreSQyPx7BUDkU1kh8+7VXf66n2WsyC9o6ufOLlhorxobzXhzX3nFTUaO9agOQuNVrBHKpM=
X-Received: by 2002:a05:6870:e2cf:b0:1d6:563b:c3a5 with SMTP id
 w15-20020a056870e2cf00b001d6563bc3a5mr23508214oad.7.1696944023337; Tue, 10
 Oct 2023 06:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231010100022.1023882-1-Jun.Ma2@amd.com>
 <20231010100022.1023882-2-Jun.Ma2@amd.com>
In-Reply-To: <20231010100022.1023882-2-Jun.Ma2@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 10 Oct 2023 09:20:12 -0400
Message-ID: <CADnq5_NfXi1eQLtgobbFBUtm77Kdf11iDJV8fya_rx8OCS+g+A@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/pm: Add reset option for fan_ctrl on smu
 13.0.7
To: Ma Jun <Jun.Ma2@amd.com>
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

On Tue, Oct 10, 2023 at 6:17=E2=80=AFAM Ma Jun <Jun.Ma2@amd.com> wrote:
>
> Add reset option for fan_ctrl interfaces on the smu v13.0.7
> User can use command "echo r > interface_name" to reset the
> interface to boot value
>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 69 +++++++++++++++++--
>  1 file changed, 64 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index b8a7a1d853df..3c5526babb14 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -1497,6 +1497,59 @@ static int smu_v13_0_7_print_clk_levels(struct smu=
_context *smu,
>         return size;
>  }
>
> +static int smu_v13_0_7_od_restore_table_single(struct smu_context *smu, =
long input)
> +{
> +       struct smu_table_context *table_context =3D &smu->smu_table;
> +       OverDriveTableExternal_t *boot_overdrive_table =3D
> +               (OverDriveTableExternal_t *)table_context->boot_overdrive=
_table;
> +       OverDriveTableExternal_t *od_table =3D
> +               (OverDriveTableExternal_t *)table_context->overdrive_tabl=
e;
> +       struct amdgpu_device *adev =3D smu->adev;
> +       int i;
> +
> +       switch (input) {
> +       case PP_OD_EDIT_FAN_CURVE:
> +               for (i =3D 0; i < NUM_OD_FAN_MAX_POINTS; i++) {
> +                       od_table->OverDriveTable.FanLinearTempPoints[i] =
=3D
> +                                       boot_overdrive_table->OverDriveTa=
ble.FanLinearTempPoints[i];
> +                       od_table->OverDriveTable.FanLinearPwmPoints[i] =
=3D
> +                                       boot_overdrive_table->OverDriveTa=
ble.FanLinearPwmPoints[i];
> +               }
> +               od_table->OverDriveTable.FanMode =3D FAN_MODE_AUTO;
> +               od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_F=
EATURE_FAN_CURVE_BIT);
> +               break;
> +       case PP_OD_EDIT_ACOUSTIC_LIMIT:
> +               od_table->OverDriveTable.AcousticLimitRpmThreshold =3D
> +                                       boot_overdrive_table->OverDriveTa=
ble.AcousticLimitRpmThreshold;
> +               od_table->OverDriveTable.FanMode =3D FAN_MODE_AUTO;
> +               od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_F=
EATURE_FAN_CURVE_BIT);
> +               break;
> +       case PP_OD_EDIT_ACOUSTIC_TARGET:
> +               od_table->OverDriveTable.AcousticTargetRpmThreshold =3D
> +                                       boot_overdrive_table->OverDriveTa=
ble.AcousticTargetRpmThreshold;
> +               od_table->OverDriveTable.FanMode =3D FAN_MODE_AUTO;
> +               od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_F=
EATURE_FAN_CURVE_BIT);
> +               break;
> +       case PP_OD_EDIT_FAN_TARGET_TEMPERATURE:
> +               od_table->OverDriveTable.FanTargetTemperature =3D
> +                                       boot_overdrive_table->OverDriveTa=
ble.FanTargetTemperature;
> +               od_table->OverDriveTable.FanMode =3D FAN_MODE_AUTO;
> +               od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_F=
EATURE_FAN_CURVE_BIT);
> +               break;
> +       case PP_OD_EDIT_FAN_MINIMUM_PWM:
> +               od_table->OverDriveTable.FanMinimumPwm =3D
> +                                       boot_overdrive_table->OverDriveTa=
ble.FanMinimumPwm;
> +               od_table->OverDriveTable.FanMode =3D FAN_MODE_AUTO;
> +               od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_F=
EATURE_FAN_CURVE_BIT);
> +               break;
> +       default:
> +               dev_info(adev->dev, "Invalid table index: %ld\n", input);
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
>  static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
>                                          enum PP_OD_DPM_TABLE_COMMAND typ=
e,
>                                          long input[],
> @@ -1783,11 +1836,17 @@ static int smu_v13_0_7_od_edit_dpm_table(struct s=
mu_context *smu,
>                 break;
>
>         case PP_OD_RESTORE_DEFAULT_TABLE:
> -               feature_ctrlmask =3D od_table->OverDriveTable.FeatureCtrl=
Mask;
> -               memcpy(od_table,
> -                      table_context->boot_overdrive_table,
> -                      sizeof(OverDriveTableExternal_t));
> -               od_table->OverDriveTable.FeatureCtrlMask =3D feature_ctrl=
mask;
> +               if (size =3D=3D 1) {
> +                       ret =3D smu_v13_0_7_od_restore_table_single(smu, =
input[0]);
> +                       if (ret)
> +                               return ret;
> +               } else {
> +                       feature_ctrlmask =3D od_table->OverDriveTable.Fea=
tureCtrlMask;
> +                       memcpy(od_table,
> +                                       table_context->boot_overdrive_tab=
le,
> +                                       sizeof(OverDriveTableExternal_t))=
;
> +                       od_table->OverDriveTable.FeatureCtrlMask =3D feat=
ure_ctrlmask;
> +               }
>                 fallthrough;
>
>         case PP_OD_COMMIT_DPM_TABLE:
> --
> 2.34.1
>
