Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D868EC55184
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2026 14:18:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CCC410EA89;
	Tue,  4 Aug 2026 14:18:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sGuXwaSX";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 277D110EA89
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2026 14:17:59 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-384caf7b168so431997a91.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Aug 2026 07:17:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785853079; cv=none;
 d=google.com; s=arc-20260327;
 b=bpufB0kRRboiChLv73cHl22Z7DbkA3Uwrh4dayP0PvEqwtbZ2TJ84sUEgkUSgWT0mj
 ZQXhWoxQtrXKukoXcjU97chfTRoMSg3WboFVo8SnvDFRpVM8LjobmGbeW52edAlX2/7Z
 xkDvgqykDO8tN/NS0g9jM1hgyRzyFYZ2oJbQ2Ix8pm3HJo4Zzeo4PqWul/SSt3oHSo5L
 mvOWZo0RJLU9q4Rixdk64PsnxmGUrbXmtapqAPFkVzsODOazljq8AnKfVERo0fcFtYtV
 ebYb6Rc5sPc1wjsoeAKwvKQGhmpg20l/fEMvu+tclZaUZKsZqNh0/hFwyPXNiI14ycLe
 xEMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3gkPzqGRT7GZHdDszva1fW41n2W274XDsxXzol4uodE=;
 fh=W4urHV6Jxzgzzxw2YDhJT/SpG6V6wMzjpVvif4ofd8U=;
 b=F2TlCMEOAMQych4fr8GSi8nUDqD/5VT8mi/LJL1wsIbrnkBdQdCRlhftsf/VU8aBPP
 J7XAUmK4llvkBFAJ3IfIY/bXmPmxowM6ZAmGa8hhnACmzIgbO6d5gBPsstIH8d4KP+CK
 BjdMr7bcAgkSeUkXyfKejOsmhOX1gxfwfVoFxvlSGVNmMfHQ7j/AE2P1jEEhYJZyZNsP
 3T7X21wTC161fRAki47fCoHaIp/PRRpzQ+th4fBZ6TyyhIsTW2AAJz+j02P6qU5+cKZS
 56YNDYCdaYeCNy0BrYvtWY0kqC3pSIIxN0FEjDqGId0UcUccybK6aoTxxQEqNDdCeMYW
 tGng==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785853079; x=1786457879; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3gkPzqGRT7GZHdDszva1fW41n2W274XDsxXzol4uodE=;
 b=sGuXwaSXn45txY1eGmIDTbXD6KqP1hI/TM5zg19HoWud1qPjDC64pnItNvHpzy0odA
 vT25QWl55uJDrMi2WjKubtdUbxWsjQXLZ58ql86QWXhIXPHcPBx/bcIr88RCo0ikSwOp
 be8B+ClLDPwmtr5+2xXmRMaVlUBzeoCEN9Prw/H6IZRV2RuVcwT601UBFUwzrFmfYfM6
 qq+Bosp7vxk/FN8zWboPUuB4s2sncizjEUCmqRlPMmKKX0aRwfjmuGdVWaXB4FdgzbNO
 aXVY8Y1wGzJIh02O6qRnXFrWGBr0kUOR9x9fnmYsnGuuImFCgoVDLsabrHYMT4IrPOqf
 T0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785853079; x=1786457879;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3gkPzqGRT7GZHdDszva1fW41n2W274XDsxXzol4uodE=;
 b=Jp49R9OBj3s5B/QqL9Zj2A8HTgCEiutKYe6Payw4/2y5v7E8v3Bexvq6uzOIEDeq/7
 OI2ymSO/nkm/nVxjC4q+xTyx4f+sNm/1RkfIatGCU2aGo1dBguUhAdlz+gV25whzZ+8x
 bjG3IRn3dJ9sMUGOU+6aFlqbFbzkiaUrdztp8MkyNVdGauFMCBAhXrJnB3JjvplxhPZ3
 CwD63FDohAZvqc9WFqtORQlOCn2ok7rn0pYB0KMpU15Cjy6zPmuonmZxR1PT6YFn79B0
 XHvHmKBQ81Z1j0pLw3FxuD5GsNQN4ES72n/Tio+aOS9bw9Aerzr0I+5oI28BhgQWHsRJ
 kNLg==
X-Gm-Message-State: AOJu0Yz5ogGcyZnzqhGhjnoYBxr1a1kqXTaXGpEes53LM2bmIHeSBkzX
 lSregH5mgVL/xeiR/FT80bb8cmTfSVAtpWSHiVk9Dl0gAm/7bU+IqXFJVZA/gD65LMhaQpOFdrY
 z2g11cqZl7UI/1EJ/ETYUAV79Cv6ffvA=
X-Gm-Gg: AR+sD13Kkd/IO9xLvTKKwwxUGVU6rhvFFQP59F/++crDI+xF4WgKoZuAUQZ6j5uXEZ3
 gRJI55IerSs36wBdc49nRiRGw906Kf4gXjifONM5eRjDbZYSLKOSBZNLNmNMAy2DgjyxWing2Sf
 F76CBN6lcKh3zgmamAqq8TF7zeIUdyq1XtV5XwlMCKbeiElbRBpMcUP//GxM7Cna7OFb0/vp8+e
 +K82+TMPtOqiM7oOGiwLo77GaoT5P+/K7TljP918loZumMo7/Lt64zt4qE4WV0q04EetOD23SqM
 icc9aKQ7psQPTYvJy0q8yCFuEYmjJmjTUt9C3M+zS7TamIU4MXAI3HT8AI6UlpmUGyMRa+WpOh5
 8tM4ywAy2OGFDh8+GJqUiRWqjDVpf2II=
X-Received: by 2002:a17:90b:35c9:b0:38f:57f0:1f51 with SMTP id
 98e67ed59e1d1-38fbc0a5ccemr19141265a91.0.1785853078580; Tue, 04 Aug 2026
 07:17:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260715063128.581232-1-Prike.Liang@amd.com>
 <DS7PR12MB6005701083F93C0330D4F4C0FBC02@DS7PR12MB6005.namprd12.prod.outlook.com>
 <PH7PR12MB60005AAE1676A52D0A72A0C4FBD52@PH7PR12MB6000.namprd12.prod.outlook.com>
 <CADnq5_MeA+koAWeUF1L5WnLCeB-c=W2n0nnLzY3fpguOQprGgw@mail.gmail.com>
 <DS7PR12MB6005E76101209F514B1544D9FBD52@DS7PR12MB6005.namprd12.prod.outlook.com>
 <CADnq5_PL1ECn9BHex4czV=35+ZkTmPrpQHbVOFg_ZQK7t1HygA@mail.gmail.com>
 <DS7PR12MB60058ABC1D885DF414416607FBD42@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB60058ABC1D885DF414416607FBD42@DS7PR12MB6005.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 4 Aug 2026 10:17:46 -0400
X-Gm-Features: AUfX_mzmVfRqfzRITrMVkUdla2DZsanxMS6PJh-nxgfraV8rmGL0AO9cfcO74Ts
Message-ID: <CADnq5_ONP+D7kSJEb0B0d3q8CaJGL4PTV7jfq+=j+dd_Tj0+Ow@mail.gmail.com>
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

On Tue, Aug 4, 2026 at 4:16=E2=80=AFAM Liang, Prike <Prike.Liang@amd.com> w=
rote:
>
> AMD General
>
> Regards,
>       Prike
>
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Monday, August 3, 2026 9:40 PM
> > To: Liang, Prike <Prike.Liang@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org; Zhang, Jesse(Jie) <Jesse.Zhang@amd.c=
om>;
> > Liu, Shaoyun <Shaoyun.Liu@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.co=
m>
> > Subject: Re: [PATCH 1/2] drm/amdgpu: Remove separate guilty compute use=
rq reset
> >
> > On Mon, Aug 3, 2026 at 9:36=E2=80=AFAM Liang, Prike <Prike.Liang@amd.co=
m> wrote:
> > >
> > > AMD General
> > >
> > > Regards,
> > >       Prike
> > >
> > > > -----Original Message-----
> > > > From: Alex Deucher <alexdeucher@gmail.com>
> > > > Sent: Monday, August 3, 2026 9:23 PM
> > > > To: Liang, Prike <Prike.Liang@amd.com>
> > > > Cc: amd-gfx@lists.freedesktop.org; Zhang, Jesse(Jie)
> > > > <Jesse.Zhang@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>; Deucher,
> > > > Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > > > <Christian.Koenig@amd.com>
> > > > Subject: Re: [PATCH 1/2] drm/amdgpu: Remove separate guilty compute
> > > > userq reset
> > > >
> > > > On Mon, Aug 3, 2026 at 5:25=E2=80=AFAM Liang, Prike <Prike.Liang@am=
d.com> wrote:
> > > > >
> > > > > AMD General
> > > > >
> > > > > As for the hung userq, it should be identified by the MES reset
> > > > > API with the
> > > > hang_detect_only setting. However, it is unlikely to miss detecting
> > > > the invalid opcode hang case, especially given that the userq
> > > > invalid opcode IGT test has not been implemented yet.
> > > > >
> > > > > Hi @Liu, Shaoyun, are you aware of any known userq hang scenarios
> > > > > that cannot
> > > > be identified by MES API hang_detect_only? If not, could you please
> > > > help review the following patch, which unifies the userq reset path=
 for hung
> > queues?
> > > > >
> > > >
> > > > We added it in the first place to deal with those cases.  There can
> > > > be queues which are not hung, but will never complete and hence
> > > > never signal their fence.  E.g., you can have a queue that is
> > > > waiting on a memory location that MES can preempt, but due to a bug
> > > > elsewhere that memory location will never change so the fence will =
never signal.
> > >
> > > Thank you for the input. However, for fake timeout cases such as the =
long shader
> > scenario, we should identify the fake hang cases by checking whether th=
e guilty
> > queue appears in the hang list, or whether the queue rptr is still upda=
ting? If so,
> > preempt the queue rather than resetting it?
> > >
> >
> > We have to assume that if we end up in the queue reset path that the qu=
eue is hung.
> > The fences have to signal in finite time.  If we preempt the queue that=
 won't signal
> > the fence so we'll just end up in the queue reset path again.  Preempti=
on of a queue
> > that won't make progress only makes sense if fences are not involved.
>
> The most cases relevant to userq fence timeout and reset worker likely to=
 be scheduled when a userq fence polling period expires. If a long running =
shader is detected, the driver may need to try preempting the queue within =
a few retry cycles. If the userq fence remains unsignaled after the retries=
 are exhausted, the driver can either return -ETIME to userspace for furthe=
r handling or fall back to resetting the queue directly. Meanwhile, If the =
preemption succeeds and the queue completes its work during the subsequent =
restore process, no further reset is necessary for the guilty queue?
>

If an application wants to run long running jobs they shouldn't use
protected fences in the first place.  If they don't use protected
fences, then it should behave like KFD queues.  If there is some
operation that needs to happen the queues will get preempted and then
will continue later.  DMA fences need to signal in finite time so we
can't just keep pushing them off.  Other kernel paging operations may
depend on them signalling.

Alex

> In the longer term, we may need to introduce a more robust mechanism to d=
istinguish slow queue cases from genuine hangs, handling them appropriately=
 via extending time slice for completing the queue submission, userspace dr=
iven resubmission, or dropping the work through a queue reset. If it makes =
sense and right way to do, then I will work on implementing the solution fo=
r such slow/long queue cases.
>
> Thanks,
> Prike
>
> > Alex
> >
> > > >
> > > > Alex
> > > >
> > > > > Regards,
> > > > >       Prike
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Liang, Prike
> > > > > > Sent: Thursday, July 23, 2026 2:38 PM
> > > > > > To: amd-gfx@lists.freedesktop.org; Zhang, Jesse(Jie)
> > > > > > <Jesse.Zhang@amd.com>
> > > > > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig,
> > > > > > Christian <Christian.Koenig@amd.com>
> > > > > > Subject: RE: [PATCH 1/2] drm/amdgpu: Remove separate guilty
> > > > > > compute userq reset
> > > > > >
> > > > > > I checked each different userq hang cases, and the guilty userq
> > > > > > can be identified by the MES firmware and report correctly.
> > > > > > @Zhang,
> > > > > > Jesse(Jie) could you further check as well at you side?
> > > > > >
> > > > > > If there're some hang queues miss identified by MES firmware,
> > > > > > then the correct thing is to further debug from MES firmware
> > > > > > side rather than have such strange reset sequence and this rese=
t
> > > > > > workaround should be
> > > > cleaned sooner or later.
> > > > > >
> > > > > >
> > > > > > Regards,
> > > > > >       Prike
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Liang, Prike <Prike.Liang@amd.com>
> > > > > > > Sent: Wednesday, July 15, 2026 2:31 PM
> > > > > > > To: amd-gfx@lists.freedesktop.org
> > > > > > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig,
> > > > > > > Christian <Christian.Koenig@amd.com>; Liang, Prike
> > > > > > > <Prike.Liang@amd.com>
> > > > > > > Subject: [PATCH 1/2] drm/amdgpu: Remove separate guilty
> > > > > > > compute userq reset
> > > > > > >
> > > > > > > amdgpu_mes_detect_and_reset_hung_queues() already detects the
> > > > > > > guilty compute user queue and resets it through
> > > > > > > mes_userq_reset_queue(). The additional reset via
> > > > > > > mes_userq_reset() is unnecessary, so remove it to unify the
> > > > > > > compute userq
> > > > reset.
> > > > > > >
> > > > > > > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > > > > > > ---
> > > > > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 5 -----
> > > > > > >  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 2 --
> > > > > > >  2 files changed, 7 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > > > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > > > > > > index 1e275c2e7dd3..4f2d5ff2f7be 100644
> > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > > > > > > @@ -2315,11 +2315,6 @@ int amdgpu_gfx_reset_mes_compute(struc=
t
> > > > > > > amdgpu_device *adev,
> > > > > > >             deferred_end[n_deferred].fence =3D guilty_fence;
> > > > > > >             n_deferred++;
> > > > > > >     }
> > > > > > > -   if (uq) {
> > > > > > > -           r =3D mes_userq_reset(uq);
> > > > > > > -           if (r)
> > > > > > > -                   goto out;
> > > > > > > -   }
> > > > > > >     for (i =3D 0; i < num_hung; i++) {
> > > > > > >             struct amdgpu_ring *hr =3D NULL;
> > > > > > >             struct amdgpu_fence *hf =3D NULL; diff --git
> > > > > > > a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > > > > > > b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > > > > > > index b6bfa3974839..fab21d4275f3 100644
> > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > > > > > > @@ -226,8 +226,6 @@ int mes_userq_reset_queue(struct
> > > > > > > amdgpu_device *adev,
> > > > > > >
> > > > > > >     xa_for_each(&adev->userq_doorbell_xa, uq_id, uq) {
> > > > > > >             if (uq->queue_type =3D=3D queue_type) {
> > > > > > > -                   if (uq =3D=3D guilty_uq)
> > > > > > > -                           continue;
> > > > > > >                     if (uq->doorbell_index =3D=3D db) {
> > > > > > >                             uq->state =3D AMDGPU_USERQ_STATE_=
HUNG;
> > > > > > >                             if (use_mmio)
> > > > > > > --
> > > > > > > 2.34.1
> > > > >
