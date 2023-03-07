Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB0BDC678D4
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Mar 2023 15:23:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F75910E506;
	Tue,  7 Mar 2023 15:23:12 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C17B10E506
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Mar 2023 15:23:11 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id bi17so9875863oib.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Mar 2023 07:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1678202590;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gZr2QnTRQdTAfDXdSLsNqN3Isjg0RjNUVQMxSgVSnXc=;
 b=RA862DUf7EI9elABGr1NV5V6RO3A8h1YxkEdTtIBAxuWLzacVbJRNgCYUDcAcuZHWk
 c25u8+j9lo+9mtOd3DZG/euztCT1AnVtnAKYYB1sZNbtAOoYzlCJldUrOp559Yc6OHS4
 KYcxajQXfbHjoGMHcnCTVkTzZnil+2UOJlI78yl6d8CsUTPupCFaQ6Ej7ZjQsm5GpLNQ
 k0V1n3MdBlelQIouIT155FjdJl3oq/kFLR27Wt63o2fGAGKf6u1g9tCf4z6Q2HLdeMsC
 wnn66qAn6U9S73HRkKmEALD4izN3lPwj0hO4vxOUKfRwOOvN/rwoHqOS4L681HL0AGQt
 bL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678202590;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gZr2QnTRQdTAfDXdSLsNqN3Isjg0RjNUVQMxSgVSnXc=;
 b=WppsItO5JDgebOrd0DabFO9eu2vAGd652CMXII/EprNGAqDepx/IMoxZX2gfImiWfs
 vDCJAKLfH9G9NHTuOEBR4BTa1vWDho4p4dvvqYPErFsu++xfoxfbCbXxzyQ8XnRsHGh0
 4qbURjcfjhDa4yAkpZyZ6K1PNF+byRoJ/14VGzdMpsMQxnxcOrdM8jN80o4UzTYdaMWx
 lE2QtRTh6Ojy7ZgyaxnWvkIdYpGVJFcY7Yox6o/dt841Y8C1J2ll0ry3CzgZFuJytnpV
 6yLODOGPJ7EMvw/t8K8KnfQvXieEeRnhmUGlSULQ+kbmcDQfZ+TucYB2tdO/nP6s8SDh
 w+QA==
X-Gm-Message-State: AO0yUKVBUqdju0Vh0Dn+56Fb5J2rWGAZtGVxjUnLZZm3tB6TjQ/IGbq8
 WPXTQ+lY6DGSdwJQ3w8mHywr0Jv8ojLJZElnv0I=
X-Google-Smtp-Source: AK7set8eDR8b7GbtBYSUVYSJULqxarNk8AlL+8u/MsPfdj6GRQNGvESW/6qN5qhUJbr0EC0lo/W+noMTo9O91i6q2Mw=
X-Received: by 2002:a54:400e:0:b0:384:2018:571c with SMTP id
 x14-20020a54400e000000b003842018571cmr4746833oie.8.1678202590546; Tue, 07 Mar
 2023 07:23:10 -0800 (PST)
MIME-Version: 1.0
References: <20230304142035.37615-1-mumei6102@gmail.com>
 <20230304234431.29507-1-mumei6102@gmail.com>
 <DM6PR12MB2619D4679EE188A9F44F0FD9E4B79@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619D4679EE188A9F44F0FD9E4B79@DM6PR12MB2619.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 7 Mar 2023 10:22:59 -0500
Message-ID: <CADnq5_Nt6dUryL+Ad5vrFkAnxRJTuW_wP_g_4G-T76nLfviKCQ@mail.gmail.com>
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

On Tue, Mar 7, 2023 at 3:23 AM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> [AMD Official Use Only - General]
>
> Can you share more background about this? I cannot see how this can addre=
ss incorrect OD voltage issue.

See https://gitlab.freedesktop.org/drm/amd/-/issues/1897
The OD settings don't seem to be restored properly on resume.

Alex

>
> BR
> Evan
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > Blazej Szczygiel
> > Sent: Sunday, March 5, 2023 7:45 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: B=C5=82a=C5=BCej Szczygie=C5=82 <mumei6102@gmail.com>
> > Subject: [PATCH v2] drm/amd/pm: Fix sienna cichlid incorrect OD volage =
after
> > resume
> >
> > Always setup overdrive tables after resume. Preserve only some
> > user-defined settings in user_overdrive_table if they're set.
> >
> > Copy restored user_overdrive_table into od_table to get correct
> > values.
> >
> > Signed-off-by: B=C5=82a=C5=BCej Szczygie=C5=82 <mumei6102@gmail.com>
> > ---
> >  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 43 ++++++++++++++----
> > -
> >  1 file changed, 33 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > index 697e98a0a20a..75f18681e984 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > @@ -2143,16 +2143,9 @@ static int
> > sienna_cichlid_set_default_od_settings(struct smu_context *smu)
> >               (OverDriveTable_t *)smu->smu_table.boot_overdrive_table;
> >       OverDriveTable_t *user_od_table =3D
> >               (OverDriveTable_t *)smu->smu_table.user_overdrive_table;
> > +     OverDriveTable_t user_od_table_bak;
> >       int ret =3D 0;
> >
> > -     /*
> > -      * For S3/S4/Runpm resume, no need to setup those overdrive
> > tables again as
> > -      *   - either they already have the default OD settings got durin=
g cold
> > bootup
> > -      *   - or they have some user customized OD settings which cannot=
 be
> > overwritten
> > -      */
> > -     if (smu->adev->in_suspend)
> > -             return 0;
> > -
> >       ret =3D smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE,
> >                                  0, (void *)boot_od_table, false);
> >       if (ret) {
> > @@ -2163,7 +2156,23 @@ static int
> > sienna_cichlid_set_default_od_settings(struct smu_context *smu)
> >       sienna_cichlid_dump_od_table(smu, boot_od_table);
> >
> >       memcpy(od_table, boot_od_table, sizeof(OverDriveTable_t));
> > -     memcpy(user_od_table, boot_od_table, sizeof(OverDriveTable_t));
> > +
> > +     /*
> > +      * For S3/S4/Runpm resume, we need to setup those overdrive
> > tables again,
> > +      * but we have to preserve user defined values in "user_od_table"=
.
> > +      */
> > +     if (!smu->adev->in_suspend) {
> > +             memcpy(user_od_table, boot_od_table,
> > sizeof(OverDriveTable_t));
> > +             smu->user_dpm_profile.user_od =3D false;
> > +     } else if (smu->user_dpm_profile.user_od) {
> > +             memcpy(&user_od_table_bak, user_od_table,
> > sizeof(OverDriveTable_t));
> > +             memcpy(user_od_table, boot_od_table,
> > sizeof(OverDriveTable_t));
> > +             user_od_table->GfxclkFmin =3D
> > user_od_table_bak.GfxclkFmin;
> > +             user_od_table->GfxclkFmax =3D
> > user_od_table_bak.GfxclkFmax;
> > +             user_od_table->UclkFmin =3D user_od_table_bak.UclkFmin;
> > +             user_od_table->UclkFmax =3D user_od_table_bak.UclkFmax;
> > +             user_od_table->VddGfxOffset =3D
> > user_od_table_bak.VddGfxOffset;
> > +     }
> >
> >       return 0;
> >  }
> > @@ -2373,6 +2382,20 @@ static int
> > sienna_cichlid_od_edit_dpm_table(struct smu_context *smu,
> >       return ret;
> >  }
> >
> > +static int sienna_cichlid_restore_user_od_settings(struct smu_context
> > *smu)
> > +{
> > +     struct smu_table_context *table_context =3D &smu->smu_table;
> > +     OverDriveTable_t *od_table =3D table_context->overdrive_table;
> > +     OverDriveTable_t *user_od_table =3D table_context-
> > >user_overdrive_table;
> > +     int res;
> > +
> > +     res =3D smu_v11_0_restore_user_od_settings(smu);
> > +     if (res =3D=3D 0)
> > +             memcpy(od_table, user_od_table,
> > sizeof(OverDriveTable_t));
> > +
> > +     return res;
> > +}
> > +
> >  static int sienna_cichlid_run_btc(struct smu_context *smu)
> >  {
> >       int res;
> > @@ -4400,7 +4423,7 @@ static const struct pptable_funcs
> > sienna_cichlid_ppt_funcs =3D {
> >       .set_soft_freq_limited_range =3D
> > smu_v11_0_set_soft_freq_limited_range,
> >       .set_default_od_settings =3D sienna_cichlid_set_default_od_settin=
gs,
> >       .od_edit_dpm_table =3D sienna_cichlid_od_edit_dpm_table,
> > -     .restore_user_od_settings =3D smu_v11_0_restore_user_od_settings,
> > +     .restore_user_od_settings =3D
> > sienna_cichlid_restore_user_od_settings,
> >       .run_btc =3D sienna_cichlid_run_btc,
> >       .set_power_source =3D smu_v11_0_set_power_source,
> >       .get_pp_feature_mask =3D smu_cmn_get_pp_feature_mask,
> > --
> > 2.39.2
