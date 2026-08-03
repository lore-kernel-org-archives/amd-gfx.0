Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636A4C55179
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2026 13:40:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E280310E044;
	Mon,  3 Aug 2026 13:40:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RedDQCKT";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CD8810E044
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2026 13:40:33 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-cb20b0a387bso165168a12.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Aug 2026 06:40:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785764433; cv=none;
 d=google.com; s=arc-20260327;
 b=oi1xWS96jPWqhcTraYjEYwJDMhOauzA9054idqRCW8XNlyFh90DMxWjt2K/9zbRmOy
 Wvu2Zy8Um/GUoiVuBpqsZ43qzv3oIu3zsPDLUkwrC0Q+2asbKs65LwloC7Soq0RdPekH
 DPpPmGJ7RpqQ+7czhn1rsAzpsZS/axJ1m8wCrEFP/XNsu58ata0R6IHacuIA04qWgIyM
 trSO5PJYgE4A0agJXG3OVc4XaL1BhIgvxjUNIuYRO0MQUtHdORu/HXNOTKNfDAGAdEho
 Z/NIsh5iE+yY07YErBxGvNvFt6fCsWOhSvXpwg3FGX/DxW6RKEMji54ujtP108CpJYmN
 QkqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=p6U8WLGDgo3LYMw79HuXCi+a8+TjTRLDYeFFihtBJ4I=;
 fh=W4urHV6Jxzgzzxw2YDhJT/SpG6V6wMzjpVvif4ofd8U=;
 b=Ck2+LegSvi4OLr9Bd6614BMTahEQmuoPnLA/NMTr2Lg3WCXMIfzXQKd+RFIglQQ0VI
 neRrUGvKswrvT8LxDtPJ/w552GmXyuL23/1tC94ixrZ9rj9ypxuIRuUxS04YmSFfV+Ug
 86KGKo9MR8i7yzUNwJdgDl6gM6E4o9pZsV5NU4B+SLAcu+2WG9ghtt6f+rTtq0Woyz8J
 D1aCg1505KcklsW83YuOy7hh2ckKNuYDqHabhgPeLYHWcIBoY+7fAqkuqBXYBp/a+job
 mm+cVaVdi8xOvbQyHIaMz+9e1nDfj5pu+6EhNdYYhe8Ss7tYgLZj3hVvKpAMJ8wAeCmJ
 aqHA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785764433; x=1786369233; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=p6U8WLGDgo3LYMw79HuXCi+a8+TjTRLDYeFFihtBJ4I=;
 b=RedDQCKTIY10UBq54HgkzfJenJoAVYqod8rjJmKMyGwRG4Ismrp5UHXmwQki52R8qd
 OEgVClG9QUb8ZED6pYeN001vGjHzYVQfUHd1wxX3N3a6lEe8uFJEsNE9y70Q56+Wn73i
 +QdOEGUTw0+NAUiDEEzTkXIXZI/c/tCTcHLTvdEjnAGeXhIeJ5E75IShJqaRdpvoMWna
 Nns2vG8t3jCZ4P48K4dsszpduiw80DvXyAaTj7pdZbNW0yyR+bvYznt88b3mYYQQvGLu
 FzmBqaIsXI8CdYGSR8taXzohYDFTnw64DcOjSsFyCtad3CaTv2THJIBd8pzx1rNe8H+B
 1qeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785764433; x=1786369233;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=p6U8WLGDgo3LYMw79HuXCi+a8+TjTRLDYeFFihtBJ4I=;
 b=fbcllsuwOMYmqa3SYBJrWv/lVEZA+VADbX/SdNUn8tDvagkgVrQrhtgOtp/qmg7v7M
 AjDV3WD/WNgQgqmj5wr+hhUZyPQn4jC6rVQ90TSikQaBFpRg3GvbZV5ZBuW1ksb+lkw4
 0MnPB1ZhrhlD3J+MsMrwYEaRLqsQA3yMIKO/EgC7/jr6OJXWXjnW7nisPX5EUPbOQHCh
 aEE+su5Zvr2Y72VIBvDvyHCUKY5F2kGZb+U617EwqY/W8ZZwrVtMlnbkOhQSE2Ev7tgp
 eXq/32OVo2P3gxEt2HuTR2ZIQoIrKd/zyD3V5zzynXA/+X0ig2MLhmBIPVdflsFw78Wy
 u7zg==
X-Gm-Message-State: AOJu0Ywh/x2bcf9Avj1FsgbEQoX/BqDeOamXv75j31bp70rccIe4fMsC
 Umb2nho/q+zYju4XIVRSPSWfgZ1GkwPmZkXxSYjNhY7PKWJsMtqTGS/+c2m80Q3gr8wehkVaD3Q
 V4SVO/NldJWx+MWOtmpK/8+Rm+WPtSts=
X-Gm-Gg: AR+sD12C3MuTWyka1X8z6seByid9K8BL4rdRdwaadfvXLKvq2NhBrMHDHd3v2ieSY3L
 BEIJ86GRM40m490dhMxsV/xgQ6Ce/zi+nADp5+8iKRc5PmPO8I2Q8Mfk0pX0Te5RPiGcgDTHDEa
 W9b/nnrRKsvApRNS03uwQFiWEN2dMufjPagaBltUTfulTQnxQdecF8spQ6FQOLAP8WnwRAQkzI0
 ZJgB4FwU5cvd8OuoOH3MkUPKozRA4nsauJcfUt+h30GOSmc7IBdn+1jNi+kH3ufRZNQ58lseDRx
 5p3NDjKL+I7zEsD3UoiA9rl+DgTaL9ru57JjuBd0TLxiImpWrW4+HjfkZnxtu8GQ9ET9EiTcvRP
 yTjpNb6/FkMKdu6frJojrF7nsvK6EjpE=
X-Received: by 2002:a17:90b:3c50:b0:381:2788:a437 with SMTP id
 98e67ed59e1d1-38fbc3ffa28mr13227096a91.1.1785764433297; Mon, 03 Aug 2026
 06:40:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260715063128.581232-1-Prike.Liang@amd.com>
 <DS7PR12MB6005701083F93C0330D4F4C0FBC02@DS7PR12MB6005.namprd12.prod.outlook.com>
 <PH7PR12MB60005AAE1676A52D0A72A0C4FBD52@PH7PR12MB6000.namprd12.prod.outlook.com>
 <CADnq5_MeA+koAWeUF1L5WnLCeB-c=W2n0nnLzY3fpguOQprGgw@mail.gmail.com>
 <DS7PR12MB6005E76101209F514B1544D9FBD52@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB6005E76101209F514B1544D9FBD52@DS7PR12MB6005.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 3 Aug 2026 09:40:21 -0400
X-Gm-Features: AUfX_mzNmpEyoOb9YVFTgYR1ciVBBUVIfDPnywdzovsRsofEO9_CsI3nJJxz7nw
Message-ID: <CADnq5_PL1ECn9BHex4czV=35+ZkTmPrpQHbVOFg_ZQK7t1HygA@mail.gmail.com>
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

On Mon, Aug 3, 2026 at 9:36=E2=80=AFAM Liang, Prike <Prike.Liang@amd.com> w=
rote:
>
> AMD General
>
> Regards,
>       Prike
>
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Monday, August 3, 2026 9:23 PM
> > To: Liang, Prike <Prike.Liang@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org; Zhang, Jesse(Jie) <Jesse.Zhang@amd.c=
om>;
> > Liu, Shaoyun <Shaoyun.Liu@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.co=
m>
> > Subject: Re: [PATCH 1/2] drm/amdgpu: Remove separate guilty compute use=
rq reset
> >
> > On Mon, Aug 3, 2026 at 5:25=E2=80=AFAM Liang, Prike <Prike.Liang@amd.co=
m> wrote:
> > >
> > > AMD General
> > >
> > > As for the hung userq, it should be identified by the MES reset API w=
ith the
> > hang_detect_only setting. However, it is unlikely to miss detecting the=
 invalid opcode
> > hang case, especially given that the userq invalid opcode IGT test has =
not been
> > implemented yet.
> > >
> > > Hi @Liu, Shaoyun, are you aware of any known userq hang scenarios tha=
t cannot
> > be identified by MES API hang_detect_only? If not, could you please hel=
p review the
> > following patch, which unifies the userq reset path for hung queues?
> > >
> >
> > We added it in the first place to deal with those cases.  There can be =
queues which
> > are not hung, but will never complete and hence never signal their fenc=
e.  E.g., you
> > can have a queue that is waiting on a memory location that MES can pree=
mpt, but
> > due to a bug elsewhere that memory location will never change so the fe=
nce will
> > never signal.
>
> Thank you for the input. However, for fake timeout cases such as the long=
 shader scenario, we should identify the fake hang cases by checking whethe=
r the guilty queue appears in the hang list, or whether the queue rptr is s=
till updating? If so, preempt the queue rather than resetting it?
>

We have to assume that if we end up in the queue reset path that the
queue is hung.  The fences have to signal in finite time.  If we
preempt the queue that won't signal the fence so we'll just end up in
the queue reset path again.  Preemption of a queue that won't make
progress only makes sense if fences are not involved.

Alex

> >
> > Alex
> >
> > > Regards,
> > >       Prike
> > >
> > > > -----Original Message-----
> > > > From: Liang, Prike
> > > > Sent: Thursday, July 23, 2026 2:38 PM
> > > > To: amd-gfx@lists.freedesktop.org; Zhang, Jesse(Jie)
> > > > <Jesse.Zhang@amd.com>
> > > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig,
> > > > Christian <Christian.Koenig@amd.com>
> > > > Subject: RE: [PATCH 1/2] drm/amdgpu: Remove separate guilty compute
> > > > userq reset
> > > >
> > > > I checked each different userq hang cases, and the guilty userq can
> > > > be identified by the MES firmware and report correctly.  @Zhang,
> > > > Jesse(Jie) could you further check as well at you side?
> > > >
> > > > If there're some hang queues miss identified by MES firmware, then
> > > > the correct thing is to further debug from MES firmware side rather
> > > > than have such strange reset sequence and this reset workaround sho=
uld be
> > cleaned sooner or later.
> > > >
> > > >
> > > > Regards,
> > > >       Prike
> > > >
> > > > > -----Original Message-----
> > > > > From: Liang, Prike <Prike.Liang@amd.com>
> > > > > Sent: Wednesday, July 15, 2026 2:31 PM
> > > > > To: amd-gfx@lists.freedesktop.org
> > > > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig,
> > > > > Christian <Christian.Koenig@amd.com>; Liang, Prike
> > > > > <Prike.Liang@amd.com>
> > > > > Subject: [PATCH 1/2] drm/amdgpu: Remove separate guilty compute
> > > > > userq reset
> > > > >
> > > > > amdgpu_mes_detect_and_reset_hung_queues() already detects the
> > > > > guilty compute user queue and resets it through
> > > > > mes_userq_reset_queue(). The additional reset via
> > > > > mes_userq_reset() is unnecessary, so remove it to unify the compu=
te userq
> > reset.
> > > > >
> > > > > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > > > > ---
> > > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 5 -----
> > > > >  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 2 --
> > > > >  2 files changed, 7 deletions(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > > > > index 1e275c2e7dd3..4f2d5ff2f7be 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > > > > @@ -2315,11 +2315,6 @@ int amdgpu_gfx_reset_mes_compute(struct
> > > > > amdgpu_device *adev,
> > > > >             deferred_end[n_deferred].fence =3D guilty_fence;
> > > > >             n_deferred++;
> > > > >     }
> > > > > -   if (uq) {
> > > > > -           r =3D mes_userq_reset(uq);
> > > > > -           if (r)
> > > > > -                   goto out;
> > > > > -   }
> > > > >     for (i =3D 0; i < num_hung; i++) {
> > > > >             struct amdgpu_ring *hr =3D NULL;
> > > > >             struct amdgpu_fence *hf =3D NULL; diff --git
> > > > > a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > > > > index b6bfa3974839..fab21d4275f3 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > > > > @@ -226,8 +226,6 @@ int mes_userq_reset_queue(struct amdgpu_devic=
e
> > > > > *adev,
> > > > >
> > > > >     xa_for_each(&adev->userq_doorbell_xa, uq_id, uq) {
> > > > >             if (uq->queue_type =3D=3D queue_type) {
> > > > > -                   if (uq =3D=3D guilty_uq)
> > > > > -                           continue;
> > > > >                     if (uq->doorbell_index =3D=3D db) {
> > > > >                             uq->state =3D AMDGPU_USERQ_STATE_HUNG=
;
> > > > >                             if (use_mmio)
> > > > > --
> > > > > 2.34.1
> > >
