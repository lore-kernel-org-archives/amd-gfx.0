Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD55BCE79CE
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 14:05:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AD3010E4B4;
	Wed, 20 Sep 2023 14:05:28 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3785410E4B4
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 14:05:27 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3ade1011f8cso1664571b6e.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 07:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695218726; x=1695823526; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1KQ2RA8qAcOpFnR0lFHsDLc6ti3xqhsvD5WNt05bNLE=;
 b=UqN2gf0mPEW2LiKmxJaZelX11jMSeJs7VPDulbIIfhTZGsUfictz+u3Dxt/UAEB1sd
 h6fSM6D16XfPIXYNo11/Su9lazNmvTPQhuHY/G1GcYay03tJtlNnz46dDnaT+M8QhZrU
 F2mXZn4QP96ajh0R1ImlvIpPXii7MywMVYMp2ClA/j93p7Ea/vHt21qm9L12NDb1bsdY
 ixVG4SRHg6A9c1YkLmLD1nZtCd4ppdgBABdNxqGDM5i+agFFAE8Qpa8A/EjP38FSlJOk
 JTVsNU7jehbklHqfqa8soGwVd5kqTGlamiAu5HlP7mPqict2XntfqgWF42dwwxDDmci9
 fX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695218726; x=1695823526;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1KQ2RA8qAcOpFnR0lFHsDLc6ti3xqhsvD5WNt05bNLE=;
 b=PXkoEHdmwgnxV1kIBUa6mtN0P+DRwD5zTlRuG9lUQ2oMNvNhQPcore1/ihDvzneG5e
 /Pd/6yZq/jziYgbsRbs9QaTr8Txp5c4Kbnd+uOXJLf3J2cYbcNQFAT7OXGCE+3gSbm4i
 MSEYVq1wExSAFn6ygox0DZCAznwVWbc/BL5yBLjnb/OVb9PEyi7hsfBt5xUSqkHALo/e
 T8BldT5BZX9hJmabBl+SdQSSgBCN3Tid19deNOen3uv0Gb3cRa6t0ALmmxhJhAv+RyBC
 QEf0PHmiemdvQGV5bNucViWTeC12UWwE6w+KmQKFuCgxy6rcVP+E9IQAKmchcu8Dm+5t
 91BA==
X-Gm-Message-State: AOJu0YzH3lGKyI7joRJ3lc/SVRxY4lIAXMP3DIq9uhYo6dSgRcIuow1B
 q2DvbISIJEAkjFHo0IGF0Z8IjVRkiG7iBMPXn1KdkJ25
X-Google-Smtp-Source: AGHT+IEN74f/JrsCh1bkk/WVkKgcpnBjw/820dPJdbarCpVKl1oUjBomMuYPmEee1lvTEHUAlS1UDWVQ1j0m/tFBiO0=
X-Received: by 2002:a05:6871:8a6:b0:1bb:6cca:3468 with SMTP id
 r38-20020a05687108a600b001bb6cca3468mr2970242oaq.47.1695218726330; Wed, 20
 Sep 2023 07:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230911055350.3940534-1-Jun.Ma2@amd.com>
 <CADnq5_OXMm9aP0oXpqA2bpV+UcikuXbDcNjGs8JMD+i4nq4JvQ@mail.gmail.com>
 <429163f7-5a22-331e-4caf-697c9e73a78d@amd.com>
In-Reply-To: <429163f7-5a22-331e-4caf-697c9e73a78d@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 20 Sep 2023 10:05:15 -0400
Message-ID: <CADnq5_N7rhhTYJA8iMB0v8G6KW8XWexQDm6xdx99-y5GPjzAbA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Add reset option for fan_curve on smu13_0_0
To: "Ma, Jun" <majun@amd.com>
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
Cc: Alexander.Deucher@amd.com, Ma Jun <Jun.Ma2@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Sep 19, 2023 at 11:00=E2=80=AFPM Ma, Jun <majun@amd.com> wrote:
>
> Hi Alex,
>
> On 9/18/2023 10:05 PM, Alex Deucher wrote:
> > On Mon, Sep 11, 2023 at 2:00=E2=80=AFAM Ma Jun <Jun.Ma2@amd.com> wrote:
> >>
> >> Add reset option for fan_curve.
> >> User can use command "echo r > fan_cure" to reset the fan_curve
> >> to boot value
> >>
> >> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> >> ---
> >>  drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  8 ++++
> >>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 43 +++++++++++++++++-=
-
> >>  2 files changed, 47 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/=
pm/amdgpu_pm.c
> >> index d05d9cd61331..2acac21387bc 100644
> >> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> >> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> >> @@ -3437,6 +3437,11 @@ static int parse_input_od_command_lines(const c=
har *buf,
> >>         case 'c':
> >>                 *type =3D PP_OD_COMMIT_DPM_TABLE;
> >>                 return 0;
> >> +       case 'r':
> >> +               params[parameter_size] =3D *type;
> >> +               *num_of_params =3D 1;
> >> +               *type =3D PP_OD_RESTORE_DEFAULT_TABLE;
> >> +               return 0;
> >>         default:
> >>                 break;
> >>         }
> >> @@ -3531,6 +3536,9 @@ amdgpu_distribute_custom_od_settings(struct amdg=
pu_device *adev,
> >>   * When you have finished the editing, write "c" (commit) to the file=
 to commit
> >>   * your changes.
> >>   *
> >> + * If you want to reset to the default value, write "r" (reset) to th=
e file to
> >> + * reset them
> >> + *
> >>   * There are two fan control modes supported: auto and manual. With a=
uto mode,
> >>   * PMFW handles the fan speed control(how fan speed reacts to ASIC te=
mperature).
> >>   * While with manual mode, users can set their own fan curve line as =
what
> >> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/dr=
ivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> >> index a719bae54e2c..644773c4bccb 100644
> >> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> >> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> >> @@ -1484,6 +1484,36 @@ static int smu_v13_0_0_print_clk_levels(struct =
smu_context *smu,
> >>         return size;
> >>  }
> >>
> >> +
> >> +static int smu_v13_0_0_od_restore_table_single(struct smu_context *sm=
u, long input)
> >> +{
> >> +       struct smu_table_context *table_context =3D &smu->smu_table;
> >> +       OverDriveTableExternal_t *boot_overdrive_table =3D
> >> +               (OverDriveTableExternal_t *)table_context->boot_overdr=
ive_table;
> >> +       OverDriveTableExternal_t *od_table =3D
> >> +               (OverDriveTableExternal_t *)table_context->overdrive_t=
able;
> >> +       struct amdgpu_device *adev =3D smu->adev;
> >> +       int i;
> >> +
> >> +       switch (input) {
> >> +       case PP_OD_EDIT_FAN_CURVE:
> >> +               for (i =3D 0; i < NUM_OD_FAN_MAX_POINTS; i++) {
> >> +                       od_table->OverDriveTable.FanLinearTempPoints[i=
] =3D
> >> +                                       boot_overdrive_table->OverDriv=
eTable.FanLinearTempPoints[i];
> >> +                       od_table->OverDriveTable.FanLinearPwmPoints[i]=
 =3D
> >> +                                       boot_overdrive_table->OverDriv=
eTable.FanLinearPwmPoints[i];
> >> +               }
> >> +               od_table->OverDriveTable.FanMode =3D FAN_MODE_AUTO;
> >> +               od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_O=
D_FEATURE_FAN_CURVE_BIT);
> >> +               break;
> >> +       default:
> >> +               dev_info(adev->dev, "Invalid table index: %ld\n", inpu=
t);
> >> +               return -EINVAL;
> >> +       }
> >> +
> >> +       return 0;
> >> +}
> >> +
> >>  static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
> >>                                          enum PP_OD_DPM_TABLE_COMMAND =
type,
> >>                                          long input[],
> >> @@ -1770,13 +1800,18 @@ static int smu_v13_0_0_od_edit_dpm_table(struc=
t smu_context *smu,
> >>                 break;
> >>
> >>         case PP_OD_RESTORE_DEFAULT_TABLE:
> >> -               feature_ctrlmask =3D od_table->OverDriveTable.FeatureC=
trlMask;
> >> -               memcpy(od_table,
> >> +               if (size =3D=3D 1) {
> >> +                       ret =3D smu_v13_0_0_od_restore_table_single(sm=
u, input[0]);
> >> +                       if (ret)
> >> +                               return ret;
> >> +               } else {
> >> +                       feature_ctrlmask =3D od_table->OverDriveTable.=
FeatureCtrlMask;
> >> +                       memcpy(od_table,
> >>                        table_context->boot_overdrive_table,
> >>                        sizeof(OverDriveTableExternal_t));
> >> -               od_table->OverDriveTable.FeatureCtrlMask =3D feature_c=
trlmask;
> >> +                       od_table->OverDriveTable.FeatureCtrlMask =3D f=
eature_ctrlmask;
> >> +               }
> >>                 fallthrough;
> >
> > I'm not sure the fallthrough here is correct.  I think setting the
> > reset should just reset the values, but you'd still need to commit to
> > actually set them to the firmware.  Double check that the behavior is
> > consistent with older chips.
> >
>
> We also use the "fallthrough" in sienna_cichlid_od_edit_dpm_table() and
> smu_v13_0_7_od_edit_dpm_table().
>
> But other chips used "break" here for reset. I think user maybe need
> to use command " echo r > xx" and "echo c > xx" to reset.
>
> So, It seems that it makes more sense to use  "fallthrough" here.
>

I guess if that's what we do for seinna_cichlid, it's fine.  Too bad
we lost consistency here.
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> Regards,
> Ma Jun
>
> > Alex
> >
> >
> >> -
> >>         case PP_OD_COMMIT_DPM_TABLE:
> >>                 /*
> >>                  * The member below instructs PMFW the settings focuse=
d in
> >> --
> >> 2.34.1
> >>
