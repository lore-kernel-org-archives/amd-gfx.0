Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86647C7EE37
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 19:35:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E70810E39E;
	Tue,  6 Jun 2023 19:35:47 +0000 (UTC)
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com
 [IPv6:2607:f8b0:4864:20::a2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82D5E10E39E
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 19:35:44 +0000 (UTC)
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-45eabad43c4so2310135e0c.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Jun 2023 12:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686080143; x=1688672143;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7WNUhc6EOU+k61yIdrNm+E3oNw4Ztiymxbf5SrtdJeM=;
 b=OAtaQIKnWxb27fJ6TQUcrFq4Uj6Fm8Qik1YAKmvxVI2SijAKpNR6gw3ND19cCQSP5u
 p86y2l1bJetJqfo7NYgodpVikyuG0Acpa5jxAaQulU4zWTq85Nr30JNAR4t8j28LvYYG
 +aNCUFYm8xBLxnAS4MQ0q8Ozhc780XRNjvWQYpCsx6tSqTpMo5V0yPoQNTEVBlh17nMW
 t+yFZuxIcGwUZlvRyp9I4qJsN3Re+DOKpJk2hmVpu77VNMGHsskTSdwQxH4g9UlOQqS6
 BrL0BXbS4h3962e5f4z09jUdOJGsIGJFUHdMUVpeG1Qpr0p39c3jACP+9V3THL5wFKnf
 bQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686080143; x=1688672143;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7WNUhc6EOU+k61yIdrNm+E3oNw4Ztiymxbf5SrtdJeM=;
 b=ZowD0GT/d35HZj1ANz2GwokFPkeW0rSKdEB/GdHVJQ8/8Dieh2JDJajtFFEkuJuIDs
 JgITmpbbQvY919y8oAT/IhKhsVx+YvCrBhSX5m7EzhN7rUhFKpDCVhHah9pT8Bq5Tr8C
 l/11rKo0tJtwZBpF84m0JdiDp+gqiVqF1ezl5e5KBiVHc5A2+4dE2HSKNdMKDolC84m1
 IWgIOxTJvwUyIqhp4x/qKd1dAedebNGP7z56lZyxkSuypT1o70CB+6dF0BCaADhpBiar
 49fhCoe6FGT13jqKYsPwSzg9gOBfAGl1amppQ2IMxbvfX7jedBXeKSrww5MszemwOCC+
 Itaw==
X-Gm-Message-State: AC+VfDxZiYuOeHKlj0fblvFdYYm9UNIRk58+qUiFvigLl+3xjL150FCJ
 rujCxv9KgOsvd1CNqR0/01DtuVEPgkfcnqeXXYIsdP/R
X-Google-Smtp-Source: ACHHUZ4yOChY2GqmKhYtFI2nRjc/GpXTQegYHYbqmx8aBfxwUplIw2ye/W5kcwf5trOmxctAlCfdIN6UwLpSmR/AmEk=
X-Received: by 2002:a05:6870:73c3:b0:196:8dc3:4e16 with SMTP id
 a3-20020a05687073c300b001968dc34e16mr2839070oan.39.1686079688302; Tue, 06 Jun
 2023 12:28:08 -0700 (PDT)
MIME-Version: 1.0
References: <ZH7vaonsPEHJpy1j@moroto>
 <DM6PR12MB26192FFABF329682D9001C3BE452A@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB26192FFABF329682D9001C3BE452A@DM6PR12MB2619.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 6 Jun 2023 15:27:57 -0400
Message-ID: <CADnq5_OjjkfGzj3Px3wARYEsgX=D7KhjfjJLAVbFWMAsqOCxAg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Fix memory some memory corruption
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
Cc: "Zhang, Horatio" <Hongkun.Zhang@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, "Wang, Yang\(Kevin\)" <KevinYang.Wang@amd.com>,
 David Airlie <airlied@gmail.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Chai,
 Thomas" <YiPeng.Chai@amd.com>, Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Tue, Jun 6, 2023 at 6:27=E2=80=AFAM Quan, Evan <Evan.Quan@amd.com> wrote=
:
>
> [AMD Official Use Only - General]
>
> Thanks for catching this.
> Reviewed-by: Evan Quan <evan.quan@amd.com>
>
> > -----Original Message-----
> > From: Dan Carpenter <dan.carpenter@linaro.org>
> > Sent: Tuesday, June 6, 2023 4:34 PM
> > To: Quan, Evan <Evan.Quan@amd.com>
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; David
> > Airlie <airlied@gmail.com>; Daniel Vetter <daniel@ffwll.ch>; Lazar, Lij=
o
> > <Lijo.Lazar@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Feng,
> > Kenneth <Kenneth.Feng@amd.com>; Li, Candice <Candice.Li@amd.com>;
> > Chai, Thomas <YiPeng.Chai@amd.com>; Wang, Yang(Kevin)
> > <KevinYang.Wang@amd.com>; Zhang, Horatio <Hongkun.Zhang@amd.com>;
> > amd-gfx@lists.freedesktop.org; kernel-janitors@vger.kernel.org
> > Subject: [PATCH] drm/amd/pm: Fix memory some memory corruption
> >
> > The "od_table" is a pointer to a large struct, but this code is doing p=
ointer
> > math as if it were pointing to bytes.  It results in writing far outsid=
e the struct.
> >
> > Fixes: f0a0c659fb96 ("drm/amd/pm: fulfill the OD support for SMU13.0.0"=
)
> > Fixes: e3afa4f988b3 ("drm/amd/pm: fulfill the OD support for SMU13.0.7"=
)
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 4 ++--
> > drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 4 ++--
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> > index 5ac5ea770c1c..413e592f0ed6 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> > @@ -1535,7 +1535,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct
> > smu_context *smu,
> >                * settings. Thus we do not cache it.
> >                */
> >               offset_of_featurectrlmask =3D offsetof(OverDriveTable_t,
> > FeatureCtrlMask);
> > -             if (memcmp(od_table + offset_of_featurectrlmask,
> > +             if (memcmp((u8 *)od_table + offset_of_featurectrlmask,
> >                          table_context->user_overdrive_table +
> > offset_of_featurectrlmask,
> >                          sizeof(OverDriveTableExternal_t) -
> > offset_of_featurectrlmask)) {
> >                       smu_v13_0_0_dump_od_table(smu, od_table); @@ -
> > 1548,7 +1548,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct
> > smu_context *smu,
> >
> >                       od_table->OverDriveTable.FeatureCtrlMask =3D 0;
> >                       memcpy(table_context->user_overdrive_table +
> > offset_of_featurectrlmask,
> > -                            od_table + offset_of_featurectrlmask,
> > +                            (u8 *)od_table + offset_of_featurectrlmask=
,
> >                              sizeof(OverDriveTableExternal_t) -
> > offset_of_featurectrlmask);
> >
> >                       if (!memcmp(table_context->user_overdrive_table,
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > index 0bd086360efa..cda4e818aab7 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > @@ -1524,7 +1524,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct
> > smu_context *smu,
> >                * settings. Thus we do not cache it.
> >                */
> >               offset_of_featurectrlmask =3D offsetof(OverDriveTable_t,
> > FeatureCtrlMask);
> > -             if (memcmp(od_table + offset_of_featurectrlmask,
> > +             if (memcmp((u8 *)od_table + offset_of_featurectrlmask,
> >                          table_context->user_overdrive_table +
> > offset_of_featurectrlmask,
> >                          sizeof(OverDriveTableExternal_t) -
> > offset_of_featurectrlmask)) {
> >                       smu_v13_0_7_dump_od_table(smu, od_table); @@ -
> > 1537,7 +1537,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct
> > smu_context *smu,
> >
> >                       od_table->OverDriveTable.FeatureCtrlMask =3D 0;
> >                       memcpy(table_context->user_overdrive_table +
> > offset_of_featurectrlmask,
> > -                            od_table + offset_of_featurectrlmask,
> > +                            (u8 *)od_table + offset_of_featurectrlmask=
,
> >                              sizeof(OverDriveTableExternal_t) -
> > offset_of_featurectrlmask);
> >
> >                       if (!memcmp(table_context->user_overdrive_table,
> > --
> > 2.39.2
>
