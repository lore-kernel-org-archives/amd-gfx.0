Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FBD3C61DA4
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Mar 2023 03:15:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA22810E92D;
	Fri, 10 Mar 2023 03:15:20 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF69610E92D
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Mar 2023 03:15:18 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id e21so3307849oie.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Mar 2023 19:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1678418118;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nKUV9gWX+GsOWGNunUigDEJZt4SgXRW6j6Nnds1Ihj8=;
 b=Hmh7Jm/LHWbQQn0NBIq/rdK9z0PZTn/CBlon4NIXmPx0H80Wiugue7zhK3QijF5zAV
 8Q5GQMiOsrSRn9nA9TJsWPXL9ICoxvb/IdG5TkYik3sgD2i6UbxmLUTvyq1R7VvOY8SW
 TshpQ4J8pFxbduj79DwYzhYXGrd4QaGoVgMfQYoV3xXOegHMLs5bWsuv59HSt8L097kz
 wv4GViiK3wZA+rasksQrAoRQ0H02AAN/A3zV0ZihmI70kiK4AuayVm+LYj4Puzt4QZN8
 cA7vYo5hUhp+FSGB7eLZXZ8IW25kjzrXSqyoBrpJGRxHqIdrctPNhAZ8dMT6Lp/R5DOJ
 NC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678418118;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nKUV9gWX+GsOWGNunUigDEJZt4SgXRW6j6Nnds1Ihj8=;
 b=vzn3+EnydCXVbJWYIB+QGLyjZbzv2cUf82b0LtJQxLySaANKrWZffnq47zZI1S821u
 gH/Carnjl+Ge4QWwMypZ0WOicPhL6FVGlCH8fEconXEwhrvam+zqDj7dUdz2aFav1Dcj
 zPad4BvE+w6So/hBq6netsTsYW0bUX7UX3fVmcfVwWTenHht2zeqGXcnVAPepszLMZb+
 G5sCvT5bN7UL8pIvXJckM9BD0ratDYK4uTk0w5s2TOd+hrjgPUeT2sM1wiQw3UxunDFQ
 2zv2OkeG3ZjyFHjB4fYYsT4au1zDZWkBbmrIgFkIe/mZWkKG+9eHI9KDfS5wOUETtdaO
 /low==
X-Gm-Message-State: AO0yUKVyYj48HPJaF91ad31L++GjWWQMwx/RxegO0Tl+ihc+6LUPgi1P
 0vTCf8zHohl8ZvPS5zK+uzmEn/jTY6/zOxX4r6IDJS6Q
X-Google-Smtp-Source: AK7set9JdH0rCE9qJBRNNveefNxnlSali69XsL3vDIsYyZmsWo970Tf0U5MPZ7g0R5ED5PJl/WJDyE74ONj3G78t2fA=
X-Received: by 2002:aca:240d:0:b0:384:22aa:f4cf with SMTP id
 n13-20020aca240d000000b0038422aaf4cfmr7050470oic.8.1678418117954; Thu, 09 Mar
 2023 19:15:17 -0800 (PST)
MIME-Version: 1.0
References: <20230308152014.3814372-1-alexander.deucher@amd.com>
 <20230308152014.3814372-2-alexander.deucher@amd.com>
 <DM6PR12MB2619B94DAFC8A9BF7504ED56E4B59@DM6PR12MB2619.namprd12.prod.outlook.com>
 <f37c9550-c9b8-3f3f-a819-cddd8b21fd9d@amd.com>
In-Reply-To: <f37c9550-c9b8-3f3f-a819-cddd8b21fd9d@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 Mar 2023 22:15:05 -0500
Message-ID: <CADnq5_Nyki9uUYVC4fUERG728ipCQD9tPBTo5Qum+xpyEP9bcA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/pm: Fix navi10 incorrect OD volage after
 resume
To: "Lazar, Lijo" <lijo.lazar@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>,
 =?UTF-8?B?QsWCYcW8ZWogU3pjenlnaWXFgg==?= <mumei6102@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Mar 9, 2023 at 6:54 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>
>
>
> On 3/9/2023 8:11 AM, Quan, Evan wrote:
> > [AMD Official Use Only - General]
> >
> >
> >
> >> -----Original Message-----
> >> From: Deucher, Alexander <Alexander.Deucher@amd.com>
> >> Sent: Wednesday, March 8, 2023 11:20 PM
> >> To: amd-gfx@lists.freedesktop.org
> >> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; B=C5=82a=C5=BCej S=
zczygie=C5=82
> >> <mumei6102@gmail.com>; Quan, Evan <Evan.Quan@amd.com>
> >> Subject: [PATCH 2/2] drm/amd/pm: Fix navi10 incorrect OD volage after
> >> resume
> >>
> >> Always setup overdrive tables after resume. Preserve only some
> >> user-defined settings in user_overdrive_table if they're set.
> >>
> >> Copy restored user_overdrive_table into od_table to get correct
> >> values.
> >>
> >> On cold boot, BTC was triggered and GfxVfCurve was calibrated. We
> >> got VfCurve settings (a). On resuming back, BTC will be triggered
> >> again and GfxVfCurve will be recalibrated. VfCurve settings (b)
> >> got may be different from those of cold boot.  So if we reuse
> >> those VfCurve settings (a) got on cold boot on suspend, we can
> >> run into discrepencies.
> >>
> >> Based on the sienna cichlid patch from B=C5=82a=C5=BCej Szczygie=C5=82
> >> <mumei6102@gmail.com>
> >>
> >> Cc: B=C5=82a=C5=BCej Szczygie=C5=82 <mumei6102@gmail.com>
> >> Cc: Evan Quan <evan.quan@amd.com>
> >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >> ---
> >>   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 47
> >> +++++++++++++++----
> >>   1 file changed, 37 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> >> b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> >> index 95da6dd1cc65..68201d8e1c72 100644
> >> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> >> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> >> @@ -2510,16 +2510,9 @@ static int navi10_set_default_od_settings(struc=
t
> >> smu_context *smu)
> >>              (OverDriveTable_t *)smu->smu_table.boot_overdrive_table;
> >>      OverDriveTable_t *user_od_table =3D
> >>              (OverDriveTable_t *)smu->smu_table.user_overdrive_table;
> >> +    OverDriveTable_t user_od_table_bak;
> >>      int ret =3D 0;
> >>
> >> -    /*
> >> -     * For S3/S4/Runpm resume, no need to setup those overdrive
> >> tables again as
> >> -     *   - either they already have the default OD settings got durin=
g cold
> >> bootup
> >> -     *   - or they have some user customized OD settings which cannot=
 be
> >> overwritten
> >> -     */
> >> -    if (smu->adev->in_suspend)
> >> -            return 0;
> >> -
> >>      ret =3D smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0,
> >> (void *)boot_od_table, false);
> >>      if (ret) {
> >>              dev_err(smu->adev->dev, "Failed to get overdrive table!\n=
");
> >> @@ -2553,7 +2546,27 @@ static int navi10_set_default_od_settings(struc=
t
> >> smu_context *smu)
> >>      navi10_dump_od_table(smu, boot_od_table);
> >>
> >>      memcpy(od_table, boot_od_table, sizeof(OverDriveTable_t));
> >> -    memcpy(user_od_table, boot_od_table, sizeof(OverDriveTable_t));
> >> +
> >> +    /*
> >> +     * For S3/S4/Runpm resume, we need to setup those overdrive
> >> tables again,
> >> +     * but we have to preserve user defined values in "user_od_table"=
.
> >> +     */
> >> +    if (!smu->adev->in_suspend) {
> >> +            memcpy(user_od_table, boot_od_table,
> >> sizeof(OverDriveTable_t));
> >> +            smu->user_dpm_profile.user_od =3D false;
> >> +    } else if (smu->user_dpm_profile.user_od) {
> >> +            memcpy(&user_od_table_bak, user_od_table,
> >> sizeof(OverDriveTable_t));
> >> +            memcpy(user_od_table, boot_od_table,
> >> sizeof(OverDriveTable_t));
> >> +            user_od_table->GfxclkFmin =3D
> >> user_od_table_bak.GfxclkFmin;
> >> +            user_od_table->GfxclkFmax =3D
> >> user_od_table_bak.GfxclkFmax;
> >> +            user_od_table->UclkFmax =3D user_od_table_bak.UclkFmax;
> >> +            user_od_table->GfxclkFreq1 =3D
> >> user_od_table_bak.GfxclkFreq1;
> >> +            user_od_table->GfxclkVolt1 =3D
> >> user_od_table_bak.GfxclkVolt1;
> >> +            user_od_table->GfxclkFreq2 =3D
> >> user_od_table_bak.GfxclkFreq2;
> >> +            user_od_table->GfxclkVolt2 =3D
> >> user_od_table_bak.GfxclkVolt2;
> >> +            user_od_table->GfxclkFreq3 =3D
> >> user_od_table_bak.GfxclkFreq3;
> >> +            user_od_table->GfxclkVolt3 =3D
> >> user_od_table_bak.GfxclkVolt3;
> >> +    }
> > Thing is a little tricky for navi10...
> > For navi2x, the vfcurve settings(GfxVfCurve.a, GfxVfCurve.b, GfxVfCurve=
.c) are not configurable by user. We do not expose them to user.
> > So, we can just load the new vfcurve settings on resuming back without =
worry about overriding user's settings.
> >
> > Unlike navi2x, user can customize the vfcurve settings(by setting Gfxcl=
kFreq/GfxVolt pairs) on navi10. More specifically:
> > - On cold boot, btc was triggered and vfcurve line was calibrated
> > - Driver calculated the target voltage(via navi10_overdrive_get_gfx_clk=
_base_voltage) for the point frequencies(GfxclkFreq1, GfxclkFreq2, GfxclkFr=
eq3) and expose them to user
> >     - e.g. point1 frequency/voltage:  500Mhz/ 0.75v
> > - Then user customized the vfcurve line by setting a new target voltage=
 for the point frequency.
> >     - e.g. 500Mhz / 0.76v  --> 10mv added
> > - On resuming back, the vfcurve line was recalibrated. The target volta=
ge for the point1 frequency may be changed to for example 0.745v(for 500Mhz=
). Under such scenario, if we just restore user's settings(0.76v which will=
 add 15mv),  that might not fit user's original intention.
> >
> > So, for this case:
> > 1. Either we add some new variables to record the voltage offset(10mv) =
from user's settings. And we restore the target voltage with new vfcurve li=
ne and voltage offset(that is 0.745v + 10mv =3D 0.755v for the case above).=
 But still we cannot know whether it truely reflects user's original intent=
ion.
> > 2. Or we just restore back to the new vfcurve line calibrated and remin=
d user that original setting was dropped and they need to set new ones.
> >
>
> As per the current driver logic, user may choose to override (voltage,
> frequency) points to define a new curve. Since the user is defining the
> curve, it's better to restore the same curve.
>
> BTW, this patch doesn't seem to have any effect as the curve will be
> restored properly otherwise also.
>

I'll drop this patch then.

Thanks,

Alex

> Thanks,
> Lijo
>
> > BR
> > Evan
> >>
> >>      return 0;
> >>   }
> >> @@ -2733,6 +2746,20 @@ static int navi10_od_edit_dpm_table(struct
> >> smu_context *smu, enum PP_OD_DPM_TABL
> >>      return ret;
> >>   }
> >>
> >> +static int navi10_restore_user_od_settings(struct smu_context *smu)
> >> +{
> >> +    struct smu_table_context *table_context =3D &smu->smu_table;
> >> +    OverDriveTable_t *od_table =3D table_context->overdrive_table;
> >> +    OverDriveTable_t *user_od_table =3D table_context-
> >>> user_overdrive_table;
> >> +    int res;
> >> +
> >> +    res =3D smu_v11_0_restore_user_od_settings(smu);
> >> +    if (res =3D=3D 0)
> >> +            memcpy(od_table, user_od_table,
> >> sizeof(OverDriveTable_t));
> >> +
> >> +    return res;
> >> +}
> >> +
> >>   static int navi10_run_btc(struct smu_context *smu)
> >>   {
> >>      int ret =3D 0;
> >> @@ -3560,7 +3587,7 @@ static const struct pptable_funcs navi10_ppt_fun=
cs
> >> =3D {
> >>      .set_soft_freq_limited_range =3D
> >> smu_v11_0_set_soft_freq_limited_range,
> >>      .set_default_od_settings =3D navi10_set_default_od_settings,
> >>      .od_edit_dpm_table =3D navi10_od_edit_dpm_table,
> >> -    .restore_user_od_settings =3D smu_v11_0_restore_user_od_settings,
> >> +    .restore_user_od_settings =3D navi10_restore_user_od_settings,
> >>      .run_btc =3D navi10_run_btc,
> >>      .set_power_source =3D smu_v11_0_set_power_source,
> >>      .get_pp_feature_mask =3D smu_cmn_get_pp_feature_mask,
> >> --
> >> 2.39.2
