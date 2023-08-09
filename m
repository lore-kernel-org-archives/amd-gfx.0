Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14483C0015E
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 12:37:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA9CD10E42E;
	Wed,  9 Aug 2023 12:37:29 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42B7410E42E
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 12:37:28 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1bc479cc815so5347582fac.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Aug 2023 05:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691584647; x=1692189447;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lz7NQzVV5j5CzsEjbcRpZPi0q5UgnN+ZwxooL2cDqB8=;
 b=CWEMfti9vJm6dg2NxIZQnIDW7H6MaqtKf9+JSbWGViecvkUtpUgz+nSd80rVksJkZG
 JiZhnlFvOU0G+ZtPgTW3+WjUHMVOjX69CymB3iK7saVTp6hOn6IYpo8VuW4hEF5Q28O5
 ENmum0zQMW1rLS3MhHV7DS2fsxFBOBTUeOvf//ZOE00Yltuflq3viZSFhmE9E6uZK1Rd
 r5LE5Vf80NaErSBDeFMn/oNO69TJVMGXHy3mlbxRoJRFX0JaLbX0BHLYPMiOu3LpmJ24
 jsdlJe/cWcRV6wmfGwOBfrV6FmwrExd57qoeii+G6q/XNbsyTE31zKyv2PTbMFfp0SdA
 cHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691584647; x=1692189447;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lz7NQzVV5j5CzsEjbcRpZPi0q5UgnN+ZwxooL2cDqB8=;
 b=V5KfxxrUQe6BH9v3Ryc2HhyGu/ZHzv31T1wqB5sxLMwqtbAMq+BGzI702s5HN/2HdR
 Q1kw32jnDTQwY4p/f449RTwNFaEpalL9kOaBRGJo9EqN1A8wz0W0q5206hVmgRCWgzYq
 6xc1JCz0PyuHZJ2U3pT3wjCJPL/lMnUNr6T87r8z5EPmr9uywjcQWX57uf1bxd83QKcm
 yCPmoQpwzepf2yCCyp6MTUjMDcv1T/wBhXuWEpF6eQ2tYuY68adqQQW14BmTg53vJFR/
 5PK6GYM+eVCmE7RVBhf6N5J1g4U/dP7THv3mB6SmfAexNQPVTHGD6hfy4P9Mmjdq67fa
 Zsgw==
X-Gm-Message-State: AOJu0YxhYUZ36x/io7rpIfz6dc4cVuOKH8ymwUHkED/v9czJ2mFKYCnd
 U9vTjyW/BYENuvravXczITazvROJ9q5U8GLMBxQ=
X-Google-Smtp-Source: AGHT+IHAPN9P1b1OXKDbiCauaIaYCvCuawCWc4wCrHE0HsVUJjvqIyTVmlQIOAlGsgPLhXmd+xc1uIOjGGLCjerkReU=
X-Received: by 2002:a05:6870:d14f:b0:1c0:3110:12cc with SMTP id
 f15-20020a056870d14f00b001c0311012ccmr3166402oac.55.1691584647502; Wed, 09
 Aug 2023 05:37:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230809101235.285114-1-kenneth.feng@amd.com>
 <CADnq5_Ot96o8RdopafMVOT6jZKgfkuxTOT4CVQJ6k8aBVPNBSw@mail.gmail.com>
 <d98258e6-ae06-f353-0fc8-a2add9cfb1e4@amd.com>
In-Reply-To: <d98258e6-ae06-f353-0fc8-a2add9cfb1e4@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 9 Aug 2023 08:37:16 -0400
Message-ID: <CADnq5_Oe2rG58c3LSCnP9S_xA4Xh+=2Aqqr-uv3j6CeoZCF95w@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/pm: disallow the fan setting if there is no
 fan on smu 13.0.0
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
Cc: Kenneth Feng <kenneth.feng@amd.com>, maisam.arif@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Aug 9, 2023 at 8:28=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> wro=
te:
>
>
>
> On 8/9/2023 5:50 PM, Alex Deucher wrote:
> > On Wed, Aug 9, 2023 at 6:12=E2=80=AFAM Kenneth Feng <kenneth.feng@amd.c=
om> wrote:
> >>
> >> drm/amd/pm: disallow the fan setting if there is no fan on smu 13.0.0
> >> V2: depend on pm.no_fan to check
> >>
> >> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> >
> > You can still read the fan speed though right?  Don't we want to just
> > not expose the ability to manually set the fan speed?
>
> If PMFW is not controlling fan, there is no guarantee that the cooling
> solution (any other external one) is using GPU's fan controller itself.
> In that way, reading the speed from controller doesn't make sense.
>

Ah, ok, I misunderstood.  My brain isn't working yet.  This is for the
case of the PMFW not controlling the fan.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> Thanks,
> Lijo
>
> >
> > Alex
> >
> >> ---
> >>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 4 ++++
> >>   1 file changed, 4 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/dr=
ivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> >> index fddcd834bcec..0fb6be11a0cc 100644
> >> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> >> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> >> @@ -331,6 +331,7 @@ static int smu_v13_0_0_check_powerplay_table(struc=
t smu_context *smu)
> >>          struct smu_13_0_0_powerplay_table *powerplay_table =3D
> >>                  table_context->power_play_table;
> >>          struct smu_baco_context *smu_baco =3D &smu->smu_baco;
> >> +       PPTable_t *pptable =3D smu->smu_table.driver_pptable;
> >>   #if 0
> >>          PPTable_t *pptable =3D smu->smu_table.driver_pptable;
> >>          const OverDriveLimits_t * const overdrive_upperlimits =3D
> >> @@ -371,6 +372,9 @@ static int smu_v13_0_0_check_powerplay_table(struc=
t smu_context *smu)
> >>          table_context->thermal_controller_type =3D
> >>                  powerplay_table->thermal_controller_type;
> >>
> >> +       smu->adev->pm.no_fan =3D
> >> +               !(pptable->SkuTable.FeaturesToRun[0] & (1 << FEATURE_F=
AN_CONTROL_BIT));
> >> +
> >>          return 0;
> >>   }
> >>
> >> --
> >> 2.34.1
> >>
