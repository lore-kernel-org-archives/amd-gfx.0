Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECAAEF8FF0
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2026 14:51:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7B0210EA16;
	Wed,  4 Mar 2026 14:51:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GK0xjn1b";
	dkim-atps=neutral
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0B3710EA16
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2026 14:51:38 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-2b8095668ebso405657eec.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Mar 2026 06:51:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772635898; cv=none;
 d=google.com; s=arc-20240605;
 b=PGKCeXLqlOdvIFiekg4CHLXZIzoYOdUTZz25aHl9r6F8ptjhe7d2EM4mgSSH3Ic+jJ
 HyIUaC3JutOP/q7jBIxXHWMF6uYWgt9Ishmrtfl7LeOjQE/NeWXKYXuPzFt6ZYl+gRfq
 9KYaopHGWMy4xg9fGvdEk3qWPHX4oOcCoan/hWKba/iangNnKHning9N4SgzpV771Qar
 uFvAdDePPP9EfohjITOJYl46e2Kr2Mwu1bFjtyPhg62z0FziZzY2DecD3OxfX3tzid44
 FEDBfeXw+v7QfIKSBGe0rQyZ3thh7p0A2rzzbJY7SzDps+XAlLGJULb+jlF3jEQWxnKe
 o5Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LFtcYNjc5fgbSPX2QKVsoYhvoAOmwuOqagqJEjp/N1U=;
 fh=71VkXJtsWnrS0YqLNTqW148VSsoh0S3c+hQD0YDWlqM=;
 b=LP/LxO1VdgTfikTH/ORlqM7bWQT3ZyYIcmQpV0rQEYkVlk5ZumQ7xe7gtMUWm4Q35i
 SCWE/xcVxgFuPjHzFk8y8joE9e54kKtYjH4Uvn3GRho2GuQcJoe3pRjLsKQrmKMAMJrF
 SfFP+w92Gh3OgV39Tuej5XajofwEbbgsCsYXlIu06dsrmlcYCXMQO/Q66DLnLLEMY63M
 3N+DE9dcd2jYTIqNWe5002bUJhqGX0KMkjuBH41mEH8w3yAnfIQGxHYuH0o1ljmkqcgW
 AbOWJTStE1g3vmpBl/lbvhnWolmTkkrlnn3dPd8TEQwcjflLRBB/v2QKxSTrD098GV0Q
 /QOg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772635898; x=1773240698; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LFtcYNjc5fgbSPX2QKVsoYhvoAOmwuOqagqJEjp/N1U=;
 b=GK0xjn1bd35IyTUknGCr4PqybsI7T4H9o033FbR0ZArHOEgvrF0SkifBogf5Yn22Pa
 GInqn9QLaes47GGwCvvZcIXMaKkOdgflryzbQZZFmptyMJM2LCZF0JzAds5uUWxLZLI6
 /5ujWHF4Mp85f5mo1HlGdQfS94zcyl0bNcBHuMYRqLEOCggkPSDS6O7ON//RqS/PlR94
 jiPNSf9Ji4zQkqaMmCxCvLbS9wMvzrbjr4gBUtHLpvzWv1uqEMqs2Khd3RNmT34HgjkJ
 y//kCkTlnJdC+q/r2c8LTcfFEOloCB7sUfXxLCR5EYcI2v9wwcESeoKE9pGJHocRPz92
 aVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772635898; x=1773240698;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LFtcYNjc5fgbSPX2QKVsoYhvoAOmwuOqagqJEjp/N1U=;
 b=o702Idanbx0/EXyF4rLcWbFiitkGkIpIeWjiiFwUTm1bWaRfAGoAtox5Noc146D7hV
 AZb48kso+g1MlqtBOU67tE2nhWMdYst/lOT5KahCuTAec4TbsBvVW3bPfwCNz6NxEgsD
 +vSCSWzkt4YtrvAHybgQXx6Rg9d42gPwR8ppx0g7rIun32oul3YD7mqjlgNqUiIRlsOG
 47KMotNEEY4UX/KPEru2fSVTy9honmzTeiBYQIAAUB4vjoM2ngEWNG3Dy822GSdaA4UW
 jgrJpe/GHOkotjVp59zdFqmmVFnisWLhlyhNfpf2ud5WbHwM6zYLG9Naw39Hh6T3gcvN
 0KrQ==
X-Gm-Message-State: AOJu0YxKQmttBl0kbTUDBO6OyjU/1qvntRhradBrnJgeUWk3CNoi0GnH
 ABkhyG5FbbxkjTAZ+5R8kPyfJuQ74p8RnVaqkocTOYzbbLn1eRD4+cfoUUYmOCXOLaEURzz+W3A
 zqd0xdx32cP4em/tSBuiXCqxYzBRQworZyg==
X-Gm-Gg: ATEYQzzfpHN8D71eYiM3h2/ZaCZtbqi/85OgnAraSE1TTR60X2jIzkgEa+M3NDjGhmV
 90AtHiv85VrBq1moGKaIoyl+kb1Arr3wq23ee37s06fDfGd8kKUhDYRR/dDfe7hKZU2UDCoLe/c
 fU59ad75zY+n4OGN1JpT7gKn5g072+VZXAkerQrS3Lw5hiGDW2iRNEL0kagUKTx98XjQkHcqXjm
 Wlso9Qx+1QFNvm4HLQhMno9ehTe7aPKA0THFEKdIl553H/Q/1sYMB/mNSN8wjZ8znOHhzbmn9+y
 QjJF3LVnwKF9oR7c0Vun2jX4ID/ujWdtdiQrZSqT+qoD05o0/pFLvyYObOKPVz+Ps7HQeA==
X-Received: by 2002:a05:7022:44:b0:127:1186:812f with SMTP id
 a92af1059eb24-128b70d3621mr474469c88.7.1772635897665; Wed, 04 Mar 2026
 06:51:37 -0800 (PST)
MIME-Version: 1.0
References: <20260304024811.897237-1-kevinyang.wang@amd.com>
 <CADnq5_NhvdRV-GrnP+9DnTVK0zL2jNRsDrHM9XEYFM-bDaiLYQ@mail.gmail.com>
 <DM6PR12MB2972A6D3002D4824AE045B7A827CA@DM6PR12MB2972.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2972A6D3002D4824AE045B7A827CA@DM6PR12MB2972.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 Mar 2026 09:51:26 -0500
X-Gm-Features: AaiRm52ijT4cPp6Oj54ZFG3mIYBW9Il0-wu12vUlEVpTZA7weH1Fm9BWAeCJI5o
Message-ID: <CADnq5_MaVNQfGNYHBTa5QDxBD8HftZ__a0eae0+J4Zjp6hk3Ew@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd/pm: add missing od setting
 PP_OD_FEATURE_ZERO_FAN_BIT for smu v13
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
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

On Wed, Mar 4, 2026 at 1:14=E2=80=AFAM Wang, Yang(Kevin) <KevinYang.Wang@am=
d.com> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> >> Is it ok to always set these, or should they only be restored based on=
 the user's settings?  Same question for the existing feature bits.
> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/pm/swsm=
u/smu13/smu_v13_0_0_ppt.c#L1871
>                 /*
>                  * The member below instructs PMFW the settings focused i=
n
>                  * this single operation.
>                  * `uint32_t FeatureCtrlMask;`
>                  * It does not contain actual informations about user's c=
ustom
>                  * settings. Thus we do not cache it.
>                  */
> Please check above code comments first.
> And according to the current PMFW/OD feature design, all OD feature switc=
h is not located in 'FeatureCtrlMask'.
> If a certain bit is not set, PMFW will overwrite the values in OD using e=
ither the default values in 'Default OverDriverTable built-in PMFW' or the =
PPTable values.
> and all OD actual information data has been saved in the 'user_od_table' =
structure before entering S3.
> Therefore, the Driver can safely configure these OD BITMASK directly with=
out additional checks in od restore stage.

Thanks for clarifying.  The patches are:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> Best Regards,
> Kevin
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Wednesday, March 4, 2026 11:05 AM
> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@=
amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Fe=
ng@amd.com>
> Subject: Re: [PATCH 1/2] drm/amd/pm: add missing od setting PP_OD_FEATURE=
_ZERO_FAN_BIT for smu v13
>
> On Tue, Mar 3, 2026 at 9:48=E2=80=AFPM Yang Wang <kevinyang.wang@amd.com>=
 wrote:
> >
> > add missing od setting PP_OD_FEATURE_ZERO_FAN_BIT for smu
> > v13.0.0/13.0.7
> >
> > Fixes: cfffd980bf21 ("drm/amd/pm: add zero RPM OD setting support for
> > SMU13")
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5018
> >
> > Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 3 ++-
> > drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 3 ++-
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> > index 35d36f2fe7dd..0a7307f5eb4c 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> > @@ -2223,7 +2223,8 @@ static int smu_v13_0_0_restore_user_od_settings(s=
truct smu_context *smu)
> >         user_od_table->OverDriveTable.FeatureCtrlMask =3D BIT(PP_OD_FEA=
TURE_GFXCLK_BIT) |
> >                                                         BIT(PP_OD_FEATU=
RE_UCLK_BIT) |
> >                                                         BIT(PP_OD_FEATU=
RE_GFX_VF_CURVE_BIT) |
> > -                                                       BIT(PP_OD_FEATU=
RE_FAN_CURVE_BIT);
> > +                                                       BIT(PP_OD_FEATU=
RE_FAN_CURVE_BIT) |
> > +
> > + BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
>
> Is it ok to always set these, or should they only be restored based on th=
e user's settings?  Same question for the existing feature bits.
>
> Alex
>
> >         res =3D smu_v13_0_0_upload_overdrive_table(smu, user_od_table);
> >         user_od_table->OverDriveTable.FeatureCtrlMask =3D 0;
> >         if (res =3D=3D 0)
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > index 4f729f54a64c..fa23f3d4a3fd 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > @@ -2225,7 +2225,8 @@ static int smu_v13_0_7_restore_user_od_settings(s=
truct smu_context *smu)
> >         user_od_table->OverDriveTable.FeatureCtrlMask =3D BIT(PP_OD_FEA=
TURE_GFXCLK_BIT) |
> >                                                         BIT(PP_OD_FEATU=
RE_UCLK_BIT) |
> >                                                         BIT(PP_OD_FEATU=
RE_GFX_VF_CURVE_BIT) |
> > -                                                       BIT(PP_OD_FEATU=
RE_FAN_CURVE_BIT);
> > +                                                       BIT(PP_OD_FEATU=
RE_FAN_CURVE_BIT) |
> > +
> > + BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
> >         res =3D smu_v13_0_7_upload_overdrive_table(smu, user_od_table);
> >         user_od_table->OverDriveTable.FeatureCtrlMask =3D 0;
> >         if (res =3D=3D 0)
> > --
> > 2.47.3
> >
