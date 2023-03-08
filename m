Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A2D6C678D5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Mar 2023 14:59:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1E4010E0E6;
	Wed,  8 Mar 2023 14:59:37 +0000 (UTC)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72A2210E0E6
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Mar 2023 14:59:35 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id bi17so12382693oib.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Mar 2023 06:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1678287574;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iEwkCtzvJHQREniBaUm1XgKy2CfbDmGEkZ5SFL8rJ3c=;
 b=TU/HPKnPsTu5yCJbDqvy7u8jWqepaslXByHQFHHK60sqTQKFh6DiVLYfyFqGZfSwRS
 +3a5uZJvPKcT6/0BG2JlANrfgWbC8rB4m67ZK3XtYxjoEx1p8liGFXrSGVi1FW85vFvx
 MwdWg0g0omFNwJSRJW92Jpo1ZqaWfExIk55gT0sLXucPT0hKdv8sgDKzC6i4dh+Cz+5Y
 f+ZvTJKDfmc/ZRBirOts0Rpz6FodiDDkcRLNP8H0pUMeXDDwHhA0ZJ27lcIPRZneyLeu
 nWXxfBg20rXO6mjPkMF2repxbTPnlzDniFYQo900GFumAmmF/luw5YiaHgT/3SWcnA3P
 YX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678287574;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iEwkCtzvJHQREniBaUm1XgKy2CfbDmGEkZ5SFL8rJ3c=;
 b=BnT22aPdWAsiyWJnBHxnUhcbNZ5Gc/eaTrh2xru80aXqgblXqTfA3JvUEhwsRsXMTI
 n9/Ypz6ZpUZXpj7LxFhzP+65TxlhErXMVaI+ra00U1r1wt/sQ424PuV+nAimxHVAtanS
 v7yP8VY5/961PbmR+9w7uy6KKg7bFD7iW6+r3TtDfGEv4MXRBYsN3CCxww1rufjPnWov
 UbXZGhCVv/pvf4aSG+EG450Y/U7yArTPxo7q+C6XKQHfIHLJKa2EbVFCU52lEAcd7FRV
 0XQgCCyEA/qhuIX0dp+eCpNCI2EdKXp/2HGMT9PKhbNJjsrq27P+JXSd2la560AJJOGW
 2lVQ==
X-Gm-Message-State: AO0yUKUlTBZMWWTmVDzdASGa4i2meXEP1aCSsB7fYwbkpFd/jKbRxhrB
 TlyN2qzzdu3UkNSFeoaCQqlCKAxvVna2PINhcAc=
X-Google-Smtp-Source: AK7set+C/DVlTPSf382SmwhqBcZahzbqMNCTvOFZ3yk9HSf4MaD2HCtwOsORZZT13RhA3gN9EfNoE43ddHDPFkYVLLE=
X-Received: by 2002:a05:6808:92:b0:384:23ed:1ff6 with SMTP id
 s18-20020a056808009200b0038423ed1ff6mr5404132oic.3.1678287574691; Wed, 08 Mar
 2023 06:59:34 -0800 (PST)
MIME-Version: 1.0
References: <20230304142035.37615-1-mumei6102@gmail.com>
 <20230304234431.29507-1-mumei6102@gmail.com>
 <DM6PR12MB2619D4679EE188A9F44F0FD9E4B79@DM6PR12MB2619.namprd12.prod.outlook.com>
 <CADnq5_Nt6dUryL+Ad5vrFkAnxRJTuW_wP_g_4G-T76nLfviKCQ@mail.gmail.com>
 <DM6PR12MB2619360B969854BDCF57129CE4B49@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619360B969854BDCF57129CE4B49@DM6PR12MB2619.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Mar 2023 09:59:22 -0500
Message-ID: <CADnq5_PgQS2Yhp32vwy-E++UfR+CgxNnRUC8jguN-1qYWuxXqA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/pm: Fix sienna cichlid incorrect OD volage
 after resume
To: "Quan, Evan" <Evan.Quan@amd.com>
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
Cc: =?UTF-8?B?QsWCYcW8ZWogU3pjenlnaWXFgg==?= <mumei6102@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Mar 7, 2023 at 9:34 PM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> [AMD Official Use Only - General]
>
> Thanks Alex. I probably get the root cause of the issue. It should be rel=
ated with the BTC feature.
> - On cold boot, BTC was triggered and GfxVfCurve was calibrated.
>    We got VfCurve settings (a).
> - On resuming back, BTC will be triggered again and GfxVfCurve will be re=
calibrated.
>    VfCurve settings (b) got may be different from those of cold boot.
>    So if to reuse those VfCurve settings (a) got on cold boot, we might g=
ot some V/f issues.
>
> These can be confirmed by comparing the CustomGfxVfCurve settings got on =
cold boot and resuming.
> +       dev_err(smu->adev->dev, "OD: GfxVfCurve: (%d, %d, %d)\n",
> +                                                       od_table->CustomG=
fxVfCurve.a,
> +                                                       od_table->CustomG=
fxVfCurve.b,
> +                                                       od_table->CustomG=
fxVfCurve.c);
> Below are some data collected on my nv21 platform and we can see the GfxV=
fCurve settings are different.
> - On cold boot: OD: GfxVfCurve: (1046469987, -1089068751, 1066221898)
> - On resuming back: OD: GfxVfCurve: (1046393849, -1089130480, 1066199153)
>
> Hi @B=C5=82a=C5=BCej Szczygie=C5=82,
> If you can add some descriptions about the BTC and GfxVfCurve related in =
the patch header/description part, it will be better.
> Anyway, the patch is Reviewed-by: Evan Quan <evan.quan@amd.com>

Presumably this should be done for navi10 as well?

Alex

>
> BR
> Evan
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> > Deucher
> > Sent: Tuesday, March 7, 2023 11:23 PM
> > To: Quan, Evan <Evan.Quan@amd.com>
> > Cc: B=C5=82a=C5=BCej Szczygie=C5=82 <mumei6102@gmail.com>; amd-
> > gfx@lists.freedesktop.org
> > Subject: Re: [PATCH v2] drm/amd/pm: Fix sienna cichlid incorrect OD vol=
age
> > after resume
> >
> > On Tue, Mar 7, 2023 at 3:23 AM Quan, Evan <Evan.Quan@amd.com> wrote:
> > >
> > > [AMD Official Use Only - General]
> > >
> > > Can you share more background about this? I cannot see how this can
> > address incorrect OD voltage issue.
> >
> > See https://gitlab.freedesktop.org/drm/amd/-/issues/1897
> > The OD settings don't seem to be restored properly on resume.
> >
> > Alex
> >
> > >
> > > BR
> > > Evan
> > > > -----Original Message-----
> > > > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > > > Blazej Szczygiel
> > > > Sent: Sunday, March 5, 2023 7:45 AM
> > > > To: amd-gfx@lists.freedesktop.org
> > > > Cc: B=C5=82a=C5=BCej Szczygie=C5=82 <mumei6102@gmail.com>
> > > > Subject: [PATCH v2] drm/amd/pm: Fix sienna cichlid incorrect OD
> > > > volage after resume
> > > >
> > > > Always setup overdrive tables after resume. Preserve only some
> > > > user-defined settings in user_overdrive_table if they're set.
> > > >
> > > > Copy restored user_overdrive_table into od_table to get correct
> > > > values.
> > > >
> > > > Signed-off-by: B=C5=82a=C5=BCej Szczygie=C5=82 <mumei6102@gmail.com=
>
> > > > ---
> > > >  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 43
> > ++++++++++++++----
> > > > -
> > > >  1 file changed, 33 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git
> > a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > > > b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > > > index 697e98a0a20a..75f18681e984 100644
> > > > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > > > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > > > @@ -2143,16 +2143,9 @@ static int
> > > > sienna_cichlid_set_default_od_settings(struct smu_context *smu)
> > > >               (OverDriveTable_t *)smu->smu_table.boot_overdrive_tab=
le;
> > > >       OverDriveTable_t *user_od_table =3D
> > > >               (OverDriveTable_t
> > > > *)smu->smu_table.user_overdrive_table;
> > > > +     OverDriveTable_t user_od_table_bak;
> > > >       int ret =3D 0;
> > > >
> > > > -     /*
> > > > -      * For S3/S4/Runpm resume, no need to setup those overdrive
> > > > tables again as
> > > > -      *   - either they already have the default OD settings got d=
uring cold
> > > > bootup
> > > > -      *   - or they have some user customized OD settings which ca=
nnot be
> > > > overwritten
> > > > -      */
> > > > -     if (smu->adev->in_suspend)
> > > > -             return 0;
> > > > -
> > > >       ret =3D smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE,
> > > >                                  0, (void *)boot_od_table, false);
> > > >       if (ret) {
> > > > @@ -2163,7 +2156,23 @@ static int
> > > > sienna_cichlid_set_default_od_settings(struct smu_context *smu)
> > > >       sienna_cichlid_dump_od_table(smu, boot_od_table);
> > > >
> > > >       memcpy(od_table, boot_od_table, sizeof(OverDriveTable_t));
> > > > -     memcpy(user_od_table, boot_od_table, sizeof(OverDriveTable_t)=
);
> > > > +
> > > > +     /*
> > > > +      * For S3/S4/Runpm resume, we need to setup those overdrive
> > > > tables again,
> > > > +      * but we have to preserve user defined values in "user_od_ta=
ble".
> > > > +      */
> > > > +     if (!smu->adev->in_suspend) {
> > > > +             memcpy(user_od_table, boot_od_table,
> > > > sizeof(OverDriveTable_t));
> > > > +             smu->user_dpm_profile.user_od =3D false;
> > > > +     } else if (smu->user_dpm_profile.user_od) {
> > > > +             memcpy(&user_od_table_bak, user_od_table,
> > > > sizeof(OverDriveTable_t));
> > > > +             memcpy(user_od_table, boot_od_table,
> > > > sizeof(OverDriveTable_t));
> > > > +             user_od_table->GfxclkFmin =3D
> > > > user_od_table_bak.GfxclkFmin;
> > > > +             user_od_table->GfxclkFmax =3D
> > > > user_od_table_bak.GfxclkFmax;
> > > > +             user_od_table->UclkFmin =3D user_od_table_bak.UclkFmi=
n;
> > > > +             user_od_table->UclkFmax =3D user_od_table_bak.UclkFma=
x;
> > > > +             user_od_table->VddGfxOffset =3D
> > > > user_od_table_bak.VddGfxOffset;
> > > > +     }
> > > >
> > > >       return 0;
> > > >  }
> > > > @@ -2373,6 +2382,20 @@ static int
> > > > sienna_cichlid_od_edit_dpm_table(struct smu_context *smu,
> > > >       return ret;
> > > >  }
> > > >
> > > > +static int sienna_cichlid_restore_user_od_settings(struct
> > > > +smu_context
> > > > *smu)
> > > > +{
> > > > +     struct smu_table_context *table_context =3D &smu->smu_table;
> > > > +     OverDriveTable_t *od_table =3D table_context->overdrive_table=
;
> > > > +     OverDriveTable_t *user_od_table =3D table_context-
> > > > >user_overdrive_table;
> > > > +     int res;
> > > > +
> > > > +     res =3D smu_v11_0_restore_user_od_settings(smu);
> > > > +     if (res =3D=3D 0)
> > > > +             memcpy(od_table, user_od_table,
> > > > sizeof(OverDriveTable_t));
> > > > +
> > > > +     return res;
> > > > +}
> > > > +
> > > >  static int sienna_cichlid_run_btc(struct smu_context *smu)  {
> > > >       int res;
> > > > @@ -4400,7 +4423,7 @@ static const struct pptable_funcs
> > > > sienna_cichlid_ppt_funcs =3D {
> > > >       .set_soft_freq_limited_range =3D
> > > > smu_v11_0_set_soft_freq_limited_range,
> > > >       .set_default_od_settings =3D sienna_cichlid_set_default_od_se=
ttings,
> > > >       .od_edit_dpm_table =3D sienna_cichlid_od_edit_dpm_table,
> > > > -     .restore_user_od_settings =3D smu_v11_0_restore_user_od_setti=
ngs,
> > > > +     .restore_user_od_settings =3D
> > > > sienna_cichlid_restore_user_od_settings,
> > > >       .run_btc =3D sienna_cichlid_run_btc,
> > > >       .set_power_source =3D smu_v11_0_set_power_source,
> > > >       .get_pp_feature_mask =3D smu_cmn_get_pp_feature_mask,
> > > > --
> > > > 2.39.2
