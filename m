Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D42C46CA1
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Sep 2023 14:05:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51A1510E0FA;
	Mon, 18 Sep 2023 14:05:59 +0000 (UTC)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 401FC10E0FA
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Sep 2023 14:05:58 +0000 (UTC)
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-1ba5cda3530so2873761fac.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Sep 2023 07:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695045957; x=1695650757; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iBRhgIdGqlnhsi6zr05Qr2BZgu/eul40VmhLOApMMNg=;
 b=Vyv0/k2KLq/Iv9MHXM7/899fEe7tZ0Ij/jMTltDASVYbC0Rp6OTboZY+MAoXNGremQ
 aN/v7GRT0jiqRU8O4zRvKmZooLzIBdikGc7e+uhvikJ5fhsOQN7ahv97VoppQMvIfvnT
 O2ldBrkt3X/th3nYj6r+hY/UiH/Zi5QmKuu+z9lYJUF2TlC/uq1uFP8r4cBnEvaiIkWV
 Qfb+ihhAAyyWYaf2LKR9beC6RLANNycl2e4D3Z+1nbhwxZD2rBrR7v5Pneb6KeRyhiww
 5EjaQ1bkQ/j0Py0fGO9AGxTN79gYFXqmU/8FhZhTbzUlF4Rp/zPZbgV4OSydNUL10pyl
 8ggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695045957; x=1695650757;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iBRhgIdGqlnhsi6zr05Qr2BZgu/eul40VmhLOApMMNg=;
 b=RKEBm3QLrSPvYkUFy6kjxity5XNae1M/+aL8dFKqIrWgSc/cbaEEkawxodWR7YfSSA
 cblNDUEyVZJ8EU85SpoA9UrykiDZOZnmdHmQQWRArqd+C0vRZkGdIj/J/vnSUfJbmd6P
 O+zGGi2Di7vL2l0tMEGrOxlTyJu4y7hUnXH0Y28yxksvfpSifrYl9SH7qR7KsjBjJHPj
 yxbCpduvczF7RuEik4kjuVFvIkKdWeyFfGzmwFXfA9BwNI9fSZNFjMrtViNMQiqJ7okb
 GGkuvcTblghrFtpYIboxpOUWBueilGbLsIKYfLVQFKLDwzByz2nSpxbF+2Zqg8Y4yhZX
 lpRw==
X-Gm-Message-State: AOJu0Yy8WRmSNVZXwtpW9xW78vWVje1JGThoihVVIEkv9cIUOXlBmhwm
 lLg8vTRbrboKl0/ne52elfGMNZpB5sFw7CrE4DYODN9M
X-Google-Smtp-Source: AGHT+IHx579JatJHBR6/euMiT0T3eWbXnxCQKAgc1Lb3X2ViyBFSvL3L6orBrTa5OHk5Y02kYQnO6Nf/4XvB1kmJm6k=
X-Received: by 2002:a05:6870:4194:b0:1bf:df47:7b5e with SMTP id
 y20-20020a056870419400b001bfdf477b5emr11911971oac.16.1695045957296; Mon, 18
 Sep 2023 07:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230911055350.3940534-1-Jun.Ma2@amd.com>
In-Reply-To: <20230911055350.3940534-1-Jun.Ma2@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 Sep 2023 10:05:46 -0400
Message-ID: <CADnq5_OXMm9aP0oXpqA2bpV+UcikuXbDcNjGs8JMD+i4nq4JvQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Add reset option for fan_curve on smu13_0_0
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

On Mon, Sep 11, 2023 at 2:00=E2=80=AFAM Ma Jun <Jun.Ma2@amd.com> wrote:
>
> Add reset option for fan_curve.
> User can use command "echo r > fan_cure" to reset the fan_curve
> to boot value
>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  8 ++++
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 43 +++++++++++++++++--
>  2 files changed, 47 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/=
amdgpu_pm.c
> index d05d9cd61331..2acac21387bc 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -3437,6 +3437,11 @@ static int parse_input_od_command_lines(const char=
 *buf,
>         case 'c':
>                 *type =3D PP_OD_COMMIT_DPM_TABLE;
>                 return 0;
> +       case 'r':
> +               params[parameter_size] =3D *type;
> +               *num_of_params =3D 1;
> +               *type =3D PP_OD_RESTORE_DEFAULT_TABLE;
> +               return 0;
>         default:
>                 break;
>         }
> @@ -3531,6 +3536,9 @@ amdgpu_distribute_custom_od_settings(struct amdgpu_=
device *adev,
>   * When you have finished the editing, write "c" (commit) to the file to=
 commit
>   * your changes.
>   *
> + * If you want to reset to the default value, write "r" (reset) to the f=
ile to
> + * reset them
> + *
>   * There are two fan control modes supported: auto and manual. With auto=
 mode,
>   * PMFW handles the fan speed control(how fan speed reacts to ASIC tempe=
rature).
>   * While with manual mode, users can set their own fan curve line as wha=
t
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index a719bae54e2c..644773c4bccb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -1484,6 +1484,36 @@ static int smu_v13_0_0_print_clk_levels(struct smu=
_context *smu,
>         return size;
>  }
>
> +
> +static int smu_v13_0_0_od_restore_table_single(struct smu_context *smu, =
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
> +       default:
> +               dev_info(adev->dev, "Invalid table index: %ld\n", input);
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
>  static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
>                                          enum PP_OD_DPM_TABLE_COMMAND typ=
e,
>                                          long input[],
> @@ -1770,13 +1800,18 @@ static int smu_v13_0_0_od_edit_dpm_table(struct s=
mu_context *smu,
>                 break;
>
>         case PP_OD_RESTORE_DEFAULT_TABLE:
> -               feature_ctrlmask =3D od_table->OverDriveTable.FeatureCtrl=
Mask;
> -               memcpy(od_table,
> +               if (size =3D=3D 1) {
> +                       ret =3D smu_v13_0_0_od_restore_table_single(smu, =
input[0]);
> +                       if (ret)
> +                               return ret;
> +               } else {
> +                       feature_ctrlmask =3D od_table->OverDriveTable.Fea=
tureCtrlMask;
> +                       memcpy(od_table,
>                        table_context->boot_overdrive_table,
>                        sizeof(OverDriveTableExternal_t));
> -               od_table->OverDriveTable.FeatureCtrlMask =3D feature_ctrl=
mask;
> +                       od_table->OverDriveTable.FeatureCtrlMask =3D feat=
ure_ctrlmask;
> +               }
>                 fallthrough;

I'm not sure the fallthrough here is correct.  I think setting the
reset should just reset the values, but you'd still need to commit to
actually set them to the firmware.  Double check that the behavior is
consistent with older chips.

Alex


> -
>         case PP_OD_COMMIT_DPM_TABLE:
>                 /*
>                  * The member below instructs PMFW the settings focused i=
n
> --
> 2.34.1
>
