Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 685A2C55182
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2026 13:22:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 024CA10E653;
	Mon,  3 Aug 2026 13:22:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nn5D+TjY";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2204710E653
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2026 13:22:52 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-38f0f3c8da5so390229a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Aug 2026 06:22:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785763371; cv=none;
 d=google.com; s=arc-20260327;
 b=Cyc1910JL3WgXUQmmvRW1s7Q5MPdp0FX9Yw0utDjHXq/LZ51zbThEToI+hs6ZDTNBI
 BYkwbjvEJtbsBFT7I75xTVbJAQ+q10KwqDH2PxRs2g+frkGqpF+w4I9BhjNJDg2jg6fH
 0UlTh1WWeaCaNLg7eRwBZzUE6rlHxfSb43bKab4eyJ4u+FVxBYgzmC4sI3glntzPvamu
 NbKSiGB4Gr/kcB2+0I53adYv6XGt1eKNoG/i2RmOTwQh/qLONpx5gX3e7dJwsw5k0Y11
 qgGp3PHJJ2EFJ1oNqcepGRpuW1g57sok47qTOK5PY8srtc3+nCQdM6AOmB/PDhO8Bv1y
 FO5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cLH4iGXx87g4Ud6V0lJ2Xd2StrulAU/UfSqpGTWeSuA=;
 fh=W4urHV6Jxzgzzxw2YDhJT/SpG6V6wMzjpVvif4ofd8U=;
 b=UIOt2yiK7NihUVuDfeFa+nD7SyWv110ozDZvnzEXyPZTVFkb5xtTID18K4kW1z4yGf
 1xYqeDvF5Iau4mlgQy7ivUODh5wV+i/LSbkRx4jYUnm4iXjqHMv2dYLvmVmlITU53Uhg
 hzQjft8JidOkeWev67lxWjWGulImxMnQpIacvgDGA0Zxs8vK9TvQ7Rd5rgW4Udz4S0VA
 db1xdiKEQEMK71IgYVwf5ue6dBYEs9FH1DhSEh3zs2vaaEft8OlUCj3N8pHxoUIYiH89
 mYDr2kzFO1nJ5f9g4JWp1HltyYpw6qbwIT3MqH4SkmhL6N/u/JS57Eg/hxBrkY2BrRxb
 GRKQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785763371; x=1786368171; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cLH4iGXx87g4Ud6V0lJ2Xd2StrulAU/UfSqpGTWeSuA=;
 b=Nn5D+TjYcjqd4Qh3bwBzRjCrBSy5L3WubLUBFXB5cswmVY1w9PxElR5yQQWH14Dlt6
 HjrJfmjIoTcEXMKEaxUgky4jQcIN4DMptVVod/BO3Ntm6yrai1b8Kjeq/f0sh4EFuTMt
 /jCxqpOWd6NyQqnTtdxrRKeyzgvHW7PKTZKP+gWax1KcqpVDhw5MPhwxjTol+qk2Bq17
 0Zk2uvsMPVb1h88Z2/jbheBa7yifixvN8TtQwJpvMyX5S3pJolZfm8MUOGSmZZJ4Phx3
 H9GnrriTw8wlCH9Z7+D+VYGbVTnVLdoV6o/yOJa4lg/9+mhebN1rtN7sZrm3q9dVhHvh
 1GUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785763371; x=1786368171;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cLH4iGXx87g4Ud6V0lJ2Xd2StrulAU/UfSqpGTWeSuA=;
 b=rIdvA0qytJPrHXxa1whBxz5iRZB7NRSSx5GcaclGNomP7YZjPkHRvM8Ic+Lo79MmdG
 PmKq7VzBV+Bvok+G67ZACy+amQgs2WBP5LIKvqYbgE0EWcDZMgTUkJPmnH7Wrr4Hsks9
 F9da5OB9M8kz6KKA7nqBdQ5wD47byhme3WJJbKVWQyYuD6Ly7+8ttngm/viXdMtqwTSp
 MgDXBvXy+yEyrMuknHWF4lYpoW1u8AXCZDGAgg0mdWpDBj4/uOO6RAoO+Sq1vL3kuKV8
 1tI8ig6PgSka37DM5qyq3oZS5Ex9wWtxl7jidngL7QjYFGjkcksmFGJaRp4WccSzK/RM
 Syjg==
X-Gm-Message-State: AOJu0YxJ4xHYmK6w6pihZCH9Rw294ys5x4JdZEF6QKtFZYGYwVGtmFn+
 XITLS31zcXQtWq07nehvzX2tpzR9aeu3mFLuOfALRSqbgYnmcDpXSqZy4NLFRlsrAC8RiB0dGzT
 3Llm22UefDTEjpJAbZfIByHVYyR8TU7SK6w==
X-Gm-Gg: AR+sD13GeIzrG1ChB1Rj3+cwECZnmUXBuw+Y1NuFKxw4L/IP3Bfh4sn10adCy3szh55
 PpHGy942WRNDqJJ6ICRP/uqeH3qZxeNR3aDFhQnyQr85yBgQl/7acFUBHcSiH/QbrmlKc9V/2vd
 4HhTepBmL2GBacToVVjMtpLJMitupDYbjIBJjqfoXgNnTlURCXHshDYYLOeKtsKRLsR9O69FkDz
 LIlwssYVry85iYEVkw9FXM0rVdbI4GnM8S3+Z9JKkRYy8QGFlbC+bWdeg4h07CeBaoKobN2EtfH
 w2pgZmjmnrZ2JXKJXI9CQhg7ZdKUBAhlUntquUom1EVfJigi3nUfYDyeUusWLN01aGwryvy9Agb
 1OIT0vTOYB3P7PSOyUBicn/T4LMrwe/Y=
X-Received: by 2002:a17:90a:e7cf:b0:37f:eda5:516f with SMTP id
 98e67ed59e1d1-38fbc0c3541mr12090316a91.0.1785763371308; Mon, 03 Aug 2026
 06:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260715063128.581232-1-Prike.Liang@amd.com>
 <DS7PR12MB6005701083F93C0330D4F4C0FBC02@DS7PR12MB6005.namprd12.prod.outlook.com>
 <PH7PR12MB60005AAE1676A52D0A72A0C4FBD52@PH7PR12MB6000.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB60005AAE1676A52D0A72A0C4FBD52@PH7PR12MB6000.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 3 Aug 2026 09:22:39 -0400
X-Gm-Features: AUfX_mwGLCKkV2Ylsgyqxcm2s7tSAH9DkrdpT4yTOblBCuMcTuyBsKKJCqBM6q0
Message-ID: <CADnq5_MeA+koAWeUF1L5WnLCeB-c=W2n0nnLzY3fpguOQprGgw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: Remove separate guilty compute userq reset
To: "Liang, Prike" <Prike.Liang@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
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

On Mon, Aug 3, 2026 at 5:25=E2=80=AFAM Liang, Prike <Prike.Liang@amd.com> w=
rote:
>
> AMD General
>
> As for the hung userq, it should be identified by the MES reset API with =
the hang_detect_only setting. However, it is unlikely to miss detecting the=
 invalid opcode hang case, especially given that the userq invalid opcode I=
GT test has not been implemented yet.
>
> Hi @Liu, Shaoyun, are you aware of any known userq hang scenarios that ca=
nnot be identified by MES API hang_detect_only? If not, could you please he=
lp review the following patch, which unifies the userq reset path for hung =
queues?
>

We added it in the first place to deal with those cases.  There can be
queues which are not hung, but will never complete and hence never
signal their fence.  E.g., you can have a queue that is waiting on a
memory location that MES can preempt, but due to a bug elsewhere that
memory location will never change so the fence will never signal.

Alex

> Regards,
>       Prike
>
> > -----Original Message-----
> > From: Liang, Prike
> > Sent: Thursday, July 23, 2026 2:38 PM
> > To: amd-gfx@lists.freedesktop.org; Zhang, Jesse(Jie) <Jesse.Zhang@amd.c=
om>
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>
> > Subject: RE: [PATCH 1/2] drm/amdgpu: Remove separate guilty compute use=
rq
> > reset
> >
> > I checked each different userq hang cases, and the guilty userq can be =
identified by
> > the MES firmware and report correctly.  @Zhang, Jesse(Jie) could you fu=
rther check
> > as well at you side?
> >
> > If there're some hang queues miss identified by MES firmware, then the =
correct thing
> > is to further debug from MES firmware side rather than have such strang=
e reset
> > sequence and this reset workaround should be cleaned sooner or later.
> >
> >
> > Regards,
> >       Prike
> >
> > > -----Original Message-----
> > > From: Liang, Prike <Prike.Liang@amd.com>
> > > Sent: Wednesday, July 15, 2026 2:31 PM
> > > To: amd-gfx@lists.freedesktop.org
> > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > > <Christian.Koenig@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> > > Subject: [PATCH 1/2] drm/amdgpu: Remove separate guilty compute userq
> > > reset
> > >
> > > amdgpu_mes_detect_and_reset_hung_queues() already detects the guilty
> > > compute user queue and resets it through mes_userq_reset_queue(). The
> > > additional reset via
> > > mes_userq_reset() is unnecessary, so remove it to unify the compute u=
serq reset.
> > >
> > > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 5 -----
> > >  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 2 --
> > >  2 files changed, 7 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > > index 1e275c2e7dd3..4f2d5ff2f7be 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > > @@ -2315,11 +2315,6 @@ int amdgpu_gfx_reset_mes_compute(struct
> > > amdgpu_device *adev,
> > >             deferred_end[n_deferred].fence =3D guilty_fence;
> > >             n_deferred++;
> > >     }
> > > -   if (uq) {
> > > -           r =3D mes_userq_reset(uq);
> > > -           if (r)
> > > -                   goto out;
> > > -   }
> > >     for (i =3D 0; i < num_hung; i++) {
> > >             struct amdgpu_ring *hr =3D NULL;
> > >             struct amdgpu_fence *hf =3D NULL;
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > > b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > > index b6bfa3974839..fab21d4275f3 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > > @@ -226,8 +226,6 @@ int mes_userq_reset_queue(struct amdgpu_device
> > > *adev,
> > >
> > >     xa_for_each(&adev->userq_doorbell_xa, uq_id, uq) {
> > >             if (uq->queue_type =3D=3D queue_type) {
> > > -                   if (uq =3D=3D guilty_uq)
> > > -                           continue;
> > >                     if (uq->doorbell_index =3D=3D db) {
> > >                             uq->state =3D AMDGPU_USERQ_STATE_HUNG;
> > >                             if (use_mmio)
> > > --
> > > 2.34.1
>
