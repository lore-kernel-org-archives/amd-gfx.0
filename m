Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 584EAC61DA4
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Mar 2023 22:27:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E907D10E354;
	Mon,  6 Mar 2023 22:27:29 +0000 (UTC)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDCBA10E441
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Mar 2023 22:27:27 +0000 (UTC)
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-176b48a9a05so5729955fac.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Mar 2023 14:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1678141647;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W3qxWDvjerISNaxKF3Ra6sY6j46tGnEJGDU1d94VlvA=;
 b=kJwtvZMr3YHSGEzS2psyWDWD/BWvNwMC1Q/T8TpjpOhI9Bqcy7C6v+Rsb7CE9MaoCa
 LkDs1WEC8cFJd3FklOtsqb+J75BArpzi8UEb1AerYHbzv34Wsf2d/6QIGa9kGNCCm+W5
 5Zs7WlMcU9RMhXrjJh7LuPrqH5VtSuaE9z/jH84/sQdgMfTOm8z8eTRrDJHpKcPKNaOq
 OaFO/+DbsNYMLmVYoxykyKe6yFJp+V0RZCeca6btxsBUoRzQk9BAFqkvWMXzWXrWq0kj
 Ugvtp2fFPsTQKSZfUdLxF/w7Eiq7qUkMY+0UkdqydmZ6c7q/NNvDoE3OpO8QbqOSGoVm
 kpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678141647;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W3qxWDvjerISNaxKF3Ra6sY6j46tGnEJGDU1d94VlvA=;
 b=4KKdee0crAuPYI4VYiB1B97hao6kln+g9J0oUeEkc+Mb9QyHj4rGSTRYTRWXQ3tk2F
 dyI/L5eVQafMpRyKt6pjPyrC89Gtgo0U15COR+YQyZke4dWPFTIhfOQzA9uK/vYzP5XU
 gjtM5mtfoIsV25Fu+AqxfLQBiIBuSzBPT9gOzCtWOTIG/ASE/DT+e2HWQ+2pYQ3O8i8a
 BUVhKKZsJT6EJGbr9musCfysIhuyOvMqLDXFLxrd96IlURFi3D2z1LZ3GibMBFi1Ixld
 xx9LIl02i9gN2lgpJia+1pnxmgiKelp2Kml1z3ZYj5Wwtiavec5viu2eyYUrUU9hoWlt
 tsnA==
X-Gm-Message-State: AO0yUKXP07XP/1b2BFq037gnsRyx2NFORhjpyyduROAHLx68DYCOS3Gi
 2inbFBFaEJJbrKxx+/BfHGLgrl65ZuAd/J+zouA=
X-Google-Smtp-Source: AK7set/Da8UuCEOb/WaB3N+3ukRiiZIlt6PkEXVGwrGaGbXODTPjVVCrRLvZM72wiJWXoWsEQSPLvOujY0RDaGqUziY=
X-Received: by 2002:a05:6871:6a91:b0:176:aee9:99e9 with SMTP id
 zf17-20020a0568716a9100b00176aee999e9mr1845029oab.3.1678141646963; Mon, 06
 Mar 2023 14:27:26 -0800 (PST)
MIME-Version: 1.0
References: <20230304234431.29507-1-mumei6102@gmail.com>
 <88948047-4f96-67fe-4135-1b385c4a1234@amd.com>
In-Reply-To: <88948047-4f96-67fe-4135-1b385c4a1234@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Mar 2023 17:27:15 -0500
Message-ID: <CADnq5_N4MgLeGGpYfs-UBoCfdHh2LyW9p3yi9Ncr1EkY2O-YhA@mail.gmail.com>
Subject: Re: [v2] drm/amd/pm: Fix sienna cichlid incorrect OD volage after
 resume
To: "Limonciello, Mario" <mario.limonciello@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
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
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

+ Evan, Kenneth

On Mon, Mar 6, 2023 at 2:49 PM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
> On 3/4/2023 17:44, B=C5=82a=C5=BCej Szczygie=C5=82 wrote:
> > Always setup overdrive tables after resume. Preserve only some
> > user-defined settings in user_overdrive_table if they're set.
> >
> > Copy restored user_overdrive_table into od_table to get correct
> > values.
> >
> > Signed-off-by: B=C5=82a=C5=BCej Szczygie=C5=82 <mumei6102@gmail.com>

Please add a link to the bug tracker as well:
Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1897

Alex



> > ---
> >   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 43 ++++++++++++++----=
-
> >   1 file changed, 33 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/=
drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > index 697e98a0a20a..75f18681e984 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > @@ -2143,16 +2143,9 @@ static int sienna_cichlid_set_default_od_setting=
s(struct smu_context *smu)
> >               (OverDriveTable_t *)smu->smu_table.boot_overdrive_table;
> >       OverDriveTable_t *user_od_table =3D
> >               (OverDriveTable_t *)smu->smu_table.user_overdrive_table;
> > +     OverDriveTable_t user_od_table_bak;
> >       int ret =3D 0;
> >
> > -     /*
> > -      * For S3/S4/Runpm resume, no need to setup those overdrive table=
s again as
> > -      *   - either they already have the default OD settings got durin=
g cold bootup
> > -      *   - or they have some user customized OD settings which cannot=
 be overwritten
> > -      */
> > -     if (smu->adev->in_suspend)
> > -             return 0;
> > -
> >       ret =3D smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE,
> >                                  0, (void *)boot_od_table, false);
> >       if (ret) {
> > @@ -2163,7 +2156,23 @@ static int sienna_cichlid_set_default_od_setting=
s(struct smu_context *smu)
> >       sienna_cichlid_dump_od_table(smu, boot_od_table);
> >
> >       memcpy(od_table, boot_od_table, sizeof(OverDriveTable_t));
> > -     memcpy(user_od_table, boot_od_table, sizeof(OverDriveTable_t));
> > +
> > +     /*
> > +      * For S3/S4/Runpm resume, we need to setup those overdrive table=
s again,
> > +      * but we have to preserve user defined values in "user_od_table"=
.
> > +      */
> > +     if (!smu->adev->in_suspend) {
> > +             memcpy(user_od_table, boot_od_table, sizeof(OverDriveTabl=
e_t));
> > +             smu->user_dpm_profile.user_od =3D false;
> > +     } else if (smu->user_dpm_profile.user_od) {
> > +             memcpy(&user_od_table_bak, user_od_table, sizeof(OverDriv=
eTable_t));
> > +             memcpy(user_od_table, boot_od_table, sizeof(OverDriveTabl=
e_t));
> > +             user_od_table->GfxclkFmin =3D user_od_table_bak.GfxclkFmi=
n;
> > +             user_od_table->GfxclkFmax =3D user_od_table_bak.GfxclkFma=
x;
> > +             user_od_table->UclkFmin =3D user_od_table_bak.UclkFmin;
> > +             user_od_table->UclkFmax =3D user_od_table_bak.UclkFmax;
> > +             user_od_table->VddGfxOffset =3D user_od_table_bak.VddGfxO=
ffset;
> > +     }
> >
> >       return 0;
> >   }
> > @@ -2373,6 +2382,20 @@ static int sienna_cichlid_od_edit_dpm_table(stru=
ct smu_context *smu,
> >       return ret;
> >   }
> >
> > +static int sienna_cichlid_restore_user_od_settings(struct smu_context =
*smu)
> > +{
> > +     struct smu_table_context *table_context =3D &smu->smu_table;
> > +     OverDriveTable_t *od_table =3D table_context->overdrive_table;
> > +     OverDriveTable_t *user_od_table =3D table_context->user_overdrive=
_table;
> > +     int res;
> > +
> > +     res =3D smu_v11_0_restore_user_od_settings(smu);
> > +     if (res =3D=3D 0)
> > +             memcpy(od_table, user_od_table, sizeof(OverDriveTable_t))=
;
> > +
> > +     return res;
> > +}
> > +
> >   static int sienna_cichlid_run_btc(struct smu_context *smu)
> >   {
> >       int res;
> > @@ -4400,7 +4423,7 @@ static const struct pptable_funcs sienna_cichlid_=
ppt_funcs =3D {
> >       .set_soft_freq_limited_range =3D smu_v11_0_set_soft_freq_limited_=
range,
> >       .set_default_od_settings =3D sienna_cichlid_set_default_od_settin=
gs,
> >       .od_edit_dpm_table =3D sienna_cichlid_od_edit_dpm_table,
> > -     .restore_user_od_settings =3D smu_v11_0_restore_user_od_settings,
> > +     .restore_user_od_settings =3D sienna_cichlid_restore_user_od_sett=
ings,
>
> Rather than introduce a new static function perhaps it would be better
> to just change 'smu_v11_0_restore_user_od_settings'.
>
> That could help this issue if it also occurs on Navi10 as well.
>
> >       .run_btc =3D sienna_cichlid_run_btc,
> >       .set_power_source =3D smu_v11_0_set_power_source,
> >       .get_pp_feature_mask =3D smu_cmn_get_pp_feature_mask,
>
