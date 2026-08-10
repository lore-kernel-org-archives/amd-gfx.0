Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90BD8C5AD7B
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 15:19:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA4BE10E219;
	Mon, 10 Aug 2026 15:19:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K5cU2qrF";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9849610E0A9
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 15:19:19 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-38dd1cc8dc8so210382a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 08:19:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786375159; cv=none;
 d=google.com; s=arc-20260327;
 b=SYXIN0KasyvhC5HlBOdG7mOzF0NJ8UqY6qSXvR35DPnwjJlskzpDS1XpaKwLBfQE8k
 0HjD5aFW77iUTArL0JDfOsPP1Gxw3Mc4B5EudfNVcijm5cdefyT7x9hqmVuUi2QV1v1V
 cUhWPEOTUFsnKnuJIe3WYaQwzOLcZZC1E8xF6cDvX5sq/oQg74PzDwvdNsRjEd+hhdfa
 ldKtYGVMl9Ls+IWsT+OG1Zq926OZSaQFxmnmuU4XRKXcS/FSPW2Bxa8vN1e393W/LP0S
 L+phvS7qsReDD9zXnFrdwPOM8OTjgUC43J2QKRckgiTCxjWr/ZWoaChkIFQrD4ciHBsk
 3nCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=B1rzR26ClzMaYFuUSq8Lzwl7sxG7gX5jiXeOHc3Ewd4=;
 fh=lVQ7q9gvI/uf1ZVMdM8r4a1d7aK9Efkn917dRdI6HPk=;
 b=dR/4VqIuM1arH3pmw6wjeqaYCH45A8deSsi0GHGEmjxgTggSshcnrsDaCdgSbUjRBP
 A4wH+ROGxSYNFj248tvvfHUeU2Fy3h2BwOOFtRHlTrdhDSAq9Yhv4QUmw5PIrRNYNJz9
 oXrhDozWYoif2S2bOinuD2eh4cRmeSE6oTJdoR24dmTyc/1fUmBOrJYYsO0FvNsLQLuF
 Gm4uhhzuyEAu8e4sBvGBoRG8YaV9GMUoFH1KNMRLU4PSRJsdD1Wa7IljS0MAQxJn+RQu
 F23IWGWOPacZOR7swI3CdOfTWBdnLPJl6247rurWUyG3RBkJrr03d7DCyGVgkTfN9PHO
 2T9w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786375159; x=1786979959; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=B1rzR26ClzMaYFuUSq8Lzwl7sxG7gX5jiXeOHc3Ewd4=;
 b=K5cU2qrFyZ1ww80toj9JWERD2lU7AMA7P05aI79IBsj8gnS4sUwoW1bAJdWZx6fM6P
 tbY424M3aMqDOum9sSD0ISYXsSrtq8GGT7T7rf9FYrRBMLe+mY7294c79Grz7ggx0FUq
 8nzBAVbhaMj9oAlwZm0TlqF80YNh/OYD+enai5FBe9aaVo3GyS/L2Ef2LMH/gaCoMIN8
 UTDciBj2vRWKq8UHJBg9G+/J1oEFipHvQT5iILfAkYBlMHGWbX8Ei2Ebgv/9q1e6jNJN
 JAqM3D96NYIs7BlyzU7jI9oQ+Yzo5OIdJ4tYr8hgYvg6lxJ9CAt/Kd+QZhThwjkWzKDf
 w/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786375159; x=1786979959;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=B1rzR26ClzMaYFuUSq8Lzwl7sxG7gX5jiXeOHc3Ewd4=;
 b=CkkJycuA283zshFO30/J6+gohJ6WxnUVGAKDW07OHGuATPzDy2nXcEP/pZjlbubQx/
 K9t6EppSZL6KFJmNsqlMtohtOkERWPBH+bxxfYDDoWHlBvmw5ct0Vy1cfuzImZZssKVM
 6EIosjSG0MJ4fqBoklVSqsZSpAzhsSykWbh0dvet8W7wq0e2o6qYJE4dmVrCvn92kV4M
 GTAV2mDbLylyICAntQgk7DNdlLoEmQ8hN3NO3f3oVy2kf14G5z1oG8Dg6rMpoqD9ZB+f
 IY4DJJvwKEc2o4EM9BMsVl36AlDBm9pE+R9EmoEMFgibjexHmd8KgezlO88yOttcAkhG
 QP/A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq3PbzM4bsqtrtk90QQUvzoceBgHDaZOH5WkT/7eVt5S5EIe3Ml3/LIgsBl+BX5y7t7j/LY2rnE@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwUEiOz/1HfYwv1XiiOBu558jIexRtHS21hmLaWU6R/EvpW73wG
 wIoDF5GwSEnicHlhR5KmZvA88rG1ufsBsUsJOF6gMY2zYc23Li4Dj2PNZi73sjLolqy76Yh/WWV
 I1/9kLposcJOc6DmiF6cY7Wh0JnOAKy8=
X-Gm-Gg: AR+sD13/p3iXZPoMrpe0B+kBPR0eiDPtKXrDAsy3LDarHsBHm9lnE3csspzK1TladcQ
 hMjkIyuszdGy1hXyHWhgy7B5/y1xaZ5tA9RxT9mayZrG8IbcRIJwliF7gvajFxoioTunY0UOuUn
 pY8bm+GpBPCgwNxYLjKUmWtejsQlCHefPggIBCDp+BbrRjF/VJXjGeT4Ob4MvD0JFEIOzIKcJ6V
 W1IyORNP88GzfAJd/V8w1e0j1Ae2s077eYn76/W2drm6nXn1kvXs+ceA2Aw00aQSSdjJF3Aap/M
 rY+QK5gylReiX/1BH0B/HTOv+gOBRryyB/DlGR2Nl7mB7cqzp9K+zjkwkFmVbblBCvMuTPCf2Wt
 6Cph4G+Uvmobj95O8Z1Xtu/PP77RwrDe1BX7mbTjtDB0=
X-Received: by 2002:a17:90b:1651:b0:38e:6a7c:abbc with SMTP id
 98e67ed59e1d1-3903c7278f5mr30731971a91.3.1786375159041; Mon, 10 Aug 2026
 08:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <aneGaKJUl_Jyu05n@stanley.mountain>
 <77e1ef2b-24ab-4492-bc91-08c01f012a46@amd.com>
In-Reply-To: <77e1ef2b-24ab-4492-bc91-08c01f012a46@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 10 Aug 2026 11:19:07 -0400
X-Gm-Features: AUfX_my-fKt5c9y2JIhF4-1Z_U26HVMXLUvLd5Y3sRxip_FQzAlVj9Rt96mRi6A
Message-ID: <CADnq5_Mc89DZGYwXrCQ+WLYVE8RBj9vdV5TBbZbwgcuV==HeEA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: silence uninitialized variable warnings
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Dan Carpenter <error27@gmail.com>, Asad Kamal <asad.kamal@amd.com>, 
 Kenneth Feng <kenneth.feng@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Yang Wang <kevinyang.wang@amd.com>, 
 Hawking Zhang <Hawking.Zhang@amd.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
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

Applied.  Thanks!

Alex

On Mon, Aug 10, 2026 at 12:50=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> w=
rote:
>
>
>
> On 09-Aug-26 1:11 AM, Dan Carpenter wrote:
> > Smatch complains that:
> >
> >      drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu15/smu_v15_0_8_ppt.c:196=
4
> >      smu_v15_0_8_set_performance_level() error: uninitialized symbol 'r=
et'.
> >
> > In this line there is an "if (ret)" condition where "ret" is either
> > zero or uninitialized.  Initialize "ret" at the start of the function t=
o
> > avoid a potential uninitialized variable bug.  But also delete the
> > condition since it is never true.
> >
> > Fixes: 422b399b09c7 ("drm/amd/pm: Add od_edit_dpm_table support")
> > Signed-off-by: Dan Carpenter <error27@gmail.com>
>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
>
> Thanks,
> Lijo
>
> > ---
> >   drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c | 5 +----
> >   1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/dri=
vers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
> > index 59fdd2319b66..c78e611d2a25 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
> > @@ -1920,7 +1920,7 @@ static int smu_v15_0_8_set_performance_level(stru=
ct smu_context *smu,
> >       struct smu_dpm_table *gfx_table =3D &dpm_context->dpm_tables.gfx_=
table;
> >       struct smu_dpm_table *uclk_table =3D &dpm_context->dpm_tables.ucl=
k_table;
> >       struct smu_umd_pstate_table *pstate_table =3D &smu->pstate_table;
> > -     int ret;
> > +     int ret =3D 0;
> >
> >       switch (level) {
> >       case AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM:
> > @@ -1961,9 +1961,6 @@ static int smu_v15_0_8_set_performance_level(stru=
ct smu_context *smu,
> >                               SMU_DPM_TABLE_MAX(uclk_table);
> >               }
> >
> > -             if (ret)
> > -                     goto out;
> > -
> >               smu_cmn_reset_custom_level(smu);
> >
> >               break;
>
