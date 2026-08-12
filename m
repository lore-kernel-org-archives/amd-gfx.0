Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B5C6C5B56A
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2026 12:47:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E180810EEBC;
	Wed, 12 Aug 2026 12:47:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GTtAcCCV";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75A7610EEBC
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2026 12:47:12 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-384c94c9423so175304a91.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2026 05:47:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786538832; cv=none;
 d=google.com; s=arc-20260327;
 b=Uvgy0mPcZCiIZNcPO1DOjZ6oZXDgZwX2RErHr0M3lyULFnuCTB1pduVI0KHNs2uXnm
 TOT1cFEvVmL16KQMNzCCzDa1b+izdyyxb/92hATIRYsrRqF5KOTKGqT3igWC802uvVpe
 xHylI584OniTbTxuYbB0nkVyqs4kHEljWZ7vl33a214W/3OYrOeDc40njSEZTmHI6KQO
 yMYeQtnsCkRMJe9ZpLmvSPxWq1JH6IVy4/tpDEjBDB1O8ruuADMPocmKUlefECV5turW
 Qa1Xscg1qK1ZIxVlhcrhIQ/3pTJo8k+4GgA5s3NK7ya64rmS3wmJfSiiVKqM4bgtH3mb
 vRIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=sbospAZJFrkiLd7dGzgbRYF0HvWC9S3FOmFvYIRR+vY=;
 fh=W4urHV6Jxzgzzxw2YDhJT/SpG6V6wMzjpVvif4ofd8U=;
 b=cWPGzCtMV+usnyVlR3mBkWoyRMVbWY39YK48aqKqnK597C3l0VQ9gDdVf8T3wbU2/2
 nUZURJmvUoiwbgJuqlkJqRjiQlMYZQfAERMrf3Wj54z+CT2g4YX9I9jomCQ52h9gHui4
 ODRZZYH8cjlPhAeLXXW8ffmYF08eSUNPSmPDzVbCGGwNrnGerXAcqu/RNTh1OOgDs1vK
 sXN3ICePSfu+7R1aw/Jh/tI93EXhRKEviD1VoncavM3IWe1jRXV8blKgQdhWaK8fgYgn
 TndIft7QQGaGskizIPu3Fl1rKF9qOLHnj7qSsTLbttbuOgpZwPDMFYVUlS0B6U/0sAS5
 CHuw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786538832; x=1787143632; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sbospAZJFrkiLd7dGzgbRYF0HvWC9S3FOmFvYIRR+vY=;
 b=GTtAcCCVa6PvzeGGRUGJ7EzTlJ3NFnvDqzDUjmx3xtRgQmLAG+OHmrsdryRxy90IJK
 DnsGIedoAwJMmqtY3HISq5lbUT68udMaaKvlxN8EurIjQM+OhaYKfYZwJ/F3YEbXXcXD
 Z439yIels0jw2tjdglRZphw4oN4gLJ4RqpHlqsQQdLbISVbkP+wOFdu+TFT+ww3fqXmL
 yTemGvDD6jPW5XYiwyAf+Ry16GzN4usXjUizIQyY1iJrgSPNDIIitz6p9dRVVGfPP7Os
 WYdslHTIY+/IcXlR5mwtGW/ZlZrCeD8MDF4t3SAijiSGCRilaVS8yihexSP/DMxdrK9N
 QqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786538832; x=1787143632;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sbospAZJFrkiLd7dGzgbRYF0HvWC9S3FOmFvYIRR+vY=;
 b=K7REpB9oPRWaqA2/rE2XfDgFXyBTU0RSwt2seKm1Y45gG9/+CaqBq67M7DqHtdeU5q
 7pf19pWz9jBiFgiXEOK88aw1kBv68RNsalg+s0c/DmXkM9HCtrLRkvhpHisNWl4TPVAY
 SVVbJi0a68mXm8vvndhZUMqxKvpsxCEgaSBFV+aKI6K8Y/Oyt8syCGSoiD/uX0IDjFpy
 nkQGSbB2idbIhIZ8WVTL2HxfX0uhNQJKNieulRGHpXsG5jHl7CQAI2dDMWPyc1VIO15w
 Tlr2E8JXaeDW+Y611nks33+tt1MM57r3nA3KHUAov7UOZhv5Tjh0xykwaW5PHzAPY19t
 qJ+g==
X-Gm-Message-State: AOJu0YwHHVAbj25nwv0dSG+fs7anGafSA+Qe53GY01NCsGZPkV70DHVu
 4CjLcTwpaDs8NkgqFpFD24aogN0uqorH5SwpXy227KJNOJF/wL9nT3JnI+ZeCmwW8qApaQ8tivU
 m1x7XuYbM8Hsy4/6yhhjgXpWPy80bXBo=
X-Gm-Gg: AR+sD10F/L9eOeXzo2e839rlcL2OJ4MQuHYzPf1FBoH9n2WA8fFI/Y/TCBrOsu+loxY
 6BSsz8cwpunqE0XWULqYRAQLjZL++/tcsEfP/ByknIhbamgjVYE5MWfFZk9luqLmI2pMepN3m5f
 K8OiRgE8bEcYtW7zcQxoueWzTqNkUAiislXROjNvINFVx6Q4zo7kElZktaSQ/W/WH9Ed1ajVEHW
 pfzHsNT7VXi8nDmdZGtdbcd3WnHb2lG7mh9jLhtlkE/u4kQIL75FYhjbRRbb0Tu1WnuV+oaoKEJ
 /au9bj+1KOdy7aUy/t+ZfIfYRvKWdZ9ZIxtiv/SPHiRZi6nwCfkfhYrInMEJrieB1CYkjfRSesr
 ZfPWAX/ZIPlI+vtuLnTo2YV4QL52h/cM=
X-Received: by 2002:a17:90a:e18c:b0:381:bcfb:e710 with SMTP id
 98e67ed59e1d1-3930161e073mr3832755a91.3.1786538831732; Wed, 12 Aug 2026
 05:47:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260715063128.581232-1-Prike.Liang@amd.com>
 <DS7PR12MB6005701083F93C0330D4F4C0FBC02@DS7PR12MB6005.namprd12.prod.outlook.com>
 <PH7PR12MB60005AAE1676A52D0A72A0C4FBD52@PH7PR12MB6000.namprd12.prod.outlook.com>
 <CADnq5_MeA+koAWeUF1L5WnLCeB-c=W2n0nnLzY3fpguOQprGgw@mail.gmail.com>
 <DS7PR12MB6005E76101209F514B1544D9FBD52@DS7PR12MB6005.namprd12.prod.outlook.com>
 <CADnq5_PL1ECn9BHex4czV=35+ZkTmPrpQHbVOFg_ZQK7t1HygA@mail.gmail.com>
 <DS7PR12MB60058ABC1D885DF414416607FBD42@DS7PR12MB6005.namprd12.prod.outlook.com>
 <CADnq5_ONP+D7kSJEb0B0d3q8CaJGL4PTV7jfq+=j+dd_Tj0+Ow@mail.gmail.com>
 <PH7PR12MB600029F6BFBAD2FE80A1841DFBD12@PH7PR12MB6000.namprd12.prod.outlook.com>
 <CADnq5_NtQF7eU0iZv5786gVPUJ+U8daOBrqP0snAUpknKogMgQ@mail.gmail.com>
 <PH7PR12MB6000775677CD969B8AE74AB7FBD12@PH7PR12MB6000.namprd12.prod.outlook.com>
 <CADnq5_NBuTYNc=XgJztJZCY6ZU6w4g_Cu51dmK+1AV1nFA3xiw@mail.gmail.com>
 <PH7PR12MB6000E91DA1F11496A776E1ABFBDC2@PH7PR12MB6000.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB6000E91DA1F11496A776E1ABFBDC2@PH7PR12MB6000.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 12 Aug 2026 08:46:59 -0400
X-Gm-Features: AUfX_my3swyX2rTfdbU--55eABAEhnqmmms5ChBpVsBvZ9ss5ISzleXZpZ9upbU
Message-ID: <CADnq5_MtbqCeD0yDCQ0zv9DbKD9SEBjkPyxAxGKF_H_Nmc0Zog@mail.gmail.com>
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

On Wed, Aug 12, 2026 at 5:18=E2=80=AFAM Liang, Prike <Prike.Liang@amd.com> =
wrote:
>
> AMD General
>
> Regards,
>       Prike
>
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Friday, August 7, 2026 10:38 PM
> > To: Liang, Prike <Prike.Liang@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org; Zhang, Jesse(Jie) <Jesse.Zhang@amd.c=
om>;
> > Liu, Shaoyun <Shaoyun.Liu@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.co=
m>
> > Subject: Re: [PATCH 1/2] drm/amdgpu: Remove separate guilty compute use=
rq reset
> >
> > On Fri, Aug 7, 2026 at 10:11=E2=80=AFAM Liang, Prike <Prike.Liang@amd.c=
om> wrote:
> > >
> > > AMD General
> > >
> > > Regards,
> > >       Prike
> > >
> > > > -----Original Message-----
> > > > From: Alex Deucher <alexdeucher@gmail.com>
> > > > Sent: Friday, August 7, 2026 9:47 PM
> > > > To: Liang, Prike <Prike.Liang@amd.com>
> > > > Cc: amd-gfx@lists.freedesktop.org; Zhang, Jesse(Jie)
> > > > <Jesse.Zhang@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>; Deucher,
> > > > Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > > > <Christian.Koenig@amd.com>
> > > > Subject: Re: [PATCH 1/2] drm/amdgpu: Remove separate guilty compute
> > > > userq reset
> > > >
> > > > On Fri, Aug 7, 2026 at 9:39=E2=80=AFAM Liang, Prike <Prike.Liang@am=
d.com> wrote:
> > > > >
> > > > > AMD General
> > > > >
> > > > >
> > > > >
> > > > > Regards,
> > > > >       Prike
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Alex Deucher <alexdeucher@gmail.com>
> > > > > > Sent: Tuesday, August 4, 2026 10:18 PM
> > > > > > To: Liang, Prike <Prike.Liang@amd.com>
> > > > > > Cc: amd-gfx@lists.freedesktop.org; Zhang, Jesse(Jie)
> > > > > > <Jesse.Zhang@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>;
> > > > > > Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig,
> > > > > > Christian <Christian.Koenig@amd.com>
> > > > > > Subject: Re: [PATCH 1/2] drm/amdgpu: Remove separate guilty
> > > > > > compute userq reset
> > > > > >
> > > > > > On Tue, Aug 4, 2026 at 4:16=E2=80=AFAM Liang, Prike <Prike.Lian=
g@amd.com>
> > wrote:
> > > > > > >
> > > > > > > AMD General
> > > > > > >
> > > > > > > Regards,
> > > > > > >       Prike
> > > > > > >
> > > > > > > > -----Original Message-----
> > > > > > > > From: Alex Deucher <alexdeucher@gmail.com>
> > > > > > > > Sent: Monday, August 3, 2026 9:40 PM
> > > > > > > > To: Liang, Prike <Prike.Liang@amd.com>
> > > > > > > > Cc: amd-gfx@lists.freedesktop.org; Zhang, Jesse(Jie)
> > > > > > > > <Jesse.Zhang@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>;
> > > > > > > > Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig,
> > > > > > > > Christian <Christian.Koenig@amd.com>
> > > > > > > > Subject: Re: [PATCH 1/2] drm/amdgpu: Remove separate guilty
> > > > > > > > compute userq reset
> > > > > > > >
> > > > > > > > On Mon, Aug 3, 2026 at 9:36=E2=80=AFAM Liang, Prike
> > > > > > > > <Prike.Liang@amd.com>
> > > > wrote:
> > > > > > > > >
> > > > > > > > > AMD General
> > > > > > > > >
> > > > > > > > > Regards,
> > > > > > > > >       Prike
> > > > > > > > >
> > > > > > > > > > -----Original Message-----
> > > > > > > > > > From: Alex Deucher <alexdeucher@gmail.com>
> > > > > > > > > > Sent: Monday, August 3, 2026 9:23 PM
> > > > > > > > > > To: Liang, Prike <Prike.Liang@amd.com>
> > > > > > > > > > Cc: amd-gfx@lists.freedesktop.org; Zhang, Jesse(Jie)
> > > > > > > > > > <Jesse.Zhang@amd.com>; Liu, Shaoyun
> > > > > > > > > > <Shaoyun.Liu@amd.com>; Deucher, Alexander
> > > > > > > > > > <Alexander.Deucher@amd.com>; Koenig, Christian
> > > > > > > > > > <Christian.Koenig@amd.com>
> > > > > > > > > > Subject: Re: [PATCH 1/2] drm/amdgpu: Remove separate
> > > > > > > > > > guilty compute userq reset
> > > > > > > > > >
> > > > > > > > > > On Mon, Aug 3, 2026 at 5:25=E2=80=AFAM Liang, Prike
> > > > > > > > > > <Prike.Liang@amd.com>
> > > > > > wrote:
> > > > > > > > > > >
> > > > > > > > > > > AMD General
> > > > > > > > > > >
> > > > > > > > > > > As for the hung userq, it should be identified by the
> > > > > > > > > > > MES reset API with the
> > > > > > > > > > hang_detect_only setting. However, it is unlikely to
> > > > > > > > > > miss detecting the invalid opcode hang case, especially
> > > > > > > > > > given that the userq invalid opcode IGT test has not be=
en
> > implemented yet.
> > > > > > > > > > >
> > > > > > > > > > > Hi @Liu, Shaoyun, are you aware of any known userq
> > > > > > > > > > > hang scenarios that cannot
> > > > > > > > > > be identified by MES API hang_detect_only? If not, coul=
d
> > > > > > > > > > you please help review the following patch, which
> > > > > > > > > > unifies the userq reset path for hung
> > > > > > > > queues?
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > We added it in the first place to deal with those cases=
.
> > > > > > > > > > There can be queues which are not hung, but will never
> > > > > > > > > > complete and hence never signal their fence.  E.g., you
> > > > > > > > > > can have a queue that is waiting on a memory location
> > > > > > > > > > that MES can preempt, but due to a bug elsewhere that
> > > > > > > > > > memory location will never change so the fence will
> > > > > > never signal.
> > > > > > > > >
> > > > > > > > > Thank you for the input. However, for fake timeout cases
> > > > > > > > > such as the long shader
> > > > > > > > scenario, we should identify the fake hang cases by checkin=
g
> > > > > > > > whether the guilty queue appears in the hang list, or
> > > > > > > > whether the queue rptr is still updating? If so, preempt th=
e
> > > > > > > > queue rather than resetting
> > > > it?
> > > > > > > > >
> > > > > > > >
> > > > > > > > We have to assume that if we end up in the queue reset path
> > > > > > > > that the queue is
> > > > > > hung.
> > > > > > > > The fences have to signal in finite time.  If we preempt th=
e
> > > > > > > > queue that won't signal the fence so we'll just end up in
> > > > > > > > the queue reset path again.  Preemption of a queue that
> > > > > > > > won't make progress only makes sense
> > > > > > if fences are not involved.
> > > > > > >
> > > > > > > The most cases relevant to userq fence timeout and reset
> > > > > > > worker likely to be
> > > > > > scheduled when a userq fence polling period expires. If a long
> > > > > > running shader is detected, the driver may need to try
> > > > > > preempting the queue
> > > > within a few retry cycles.
> > > > > > If the userq fence remains unsignaled after the retries are
> > > > > > exhausted, the driver can either return -ETIME to userspace for
> > > > > > further handling or fall back to resetting the queue directly.
> > > > > > Meanwhile, If the preemption succeeds and the queue completes
> > > > > > its work during the subsequent restore process, no further rese=
t
> > > > > > is necessary for the
> > > > guilty queue?
> > > > > > >
> > > > > >
> > > > > > If an application wants to run long running jobs they shouldn't
> > > > > > use protected fences in the first place.  If they don't use
> > > > > > protected fences, then it should behave like KFD queues.  If
> > > > > > there is some operation that needs to happen the queues will ge=
t
> > > > > > preempted and then will continue later.  DMA fences need to
> > > > > > signal in finite time so we can't just keep pushing them off.
> > > > > > Other kernel paging operations may
> > > > depend on them signalling.
> > > > >
> > > > > Regarding the protected fences, do you mean the userq fence that
> > > > > triggers the
> > > > hang detection work queue?
> > > > >
> > > >
> > > > Yes.
> > > >
> > > > > If so, the current implementation calls amdgpu_userq_fence_init()
> > > > > at fence emit
> > > > time (i.e., at each queue submission), which both initializes the
> > > > dma_fence structure and starts the hang detection timer for that
> > > > submission. Once the timeout expires,
> > > > amdgpu_userq_hang_detect_work() fires and triggers a queue reset
> > > > regardless of whether the queue is actually hung or simply
> > > > long-running. But there's a core problem for the kernel to
> > > > distinguish a hung queue from a slow one at fence emit time, since =
both look
> > identical an unsignaled fence with an active queue.
> > > > >
> > > >
> > > > That is the intended behavior. If you opt into using a dma fence,
> > > > you need to abide by its semantics.
> > > >
> > > > > However, we can defer that determination to the first timeout
> > > > > expiry in
> > > > amdgpu_userq_hang_detect_work(). At that point we have more
> > > > information to work
> > > > with:
> > > > >
> > > > >
> > > > > Check for real hang: query rptr and rptr has not updated since th=
e
> > > > > fence was
> > > > emitted, the queue is genuinely stuck (frozen waves, infinite loop)=
.
> > > > This is a real hang, reset immediately and forcing completing the f=
ences.
> > > > > Check for forward progress: if rptr has updated but the fence is
> > > > > still unsignaled, the
> > > > queue is making progress, so it is long running, not hung. In this =
case:
> > > > >
> > > > > Extend the timeout (reschedule hang_detect_work with a longer
> > > > > interval) Track retry count if the queue still has not completed
> > > > > after N extended
> > > > cycles, escalate: Preempt the queue, force completing the fence and
> > > > return -ETIME to userspace then let the application decide: resubmi=
t, split the
> > workload, or drop.
> > > > >
> > > > > Avoid unnecessary resets: if preemption succeeds and the queue
> > > > > resumes and
> > > > completes within the extended window, cancel the reset entirely
> > > > since the queue was slow, not broken.
> > > > >
> > > > >
> > > > > Do you think this is the right way for handling long-running task=
s
> > > > > to resolve the
> > > > userq timeout issue, or does it align with your idea?
> > > >
> > > > If you want to run a super long running job, then you shouldn't use
> > > > a dma fence in the first place.  There might be a job that takes 2
> > > > minutes or even an hour to run, but you can't wait that long for a
> > > > dma fence.  If you do, the kernel might run out of memory and the
> > > > OOM killer will start killing processes or you could deadlock.  If
> > > > you want to run a long job, don't use a dma fence.  If you don't us=
e
> > > > a dma fence, then the kernel can preempt the queues, do whatever me=
mory
> > management it needs to and then it can resume the queues.  dma fences h=
ave to
> > signal in finite time.
> > >
> > > Got it. So to skip attaching a dma_fence to a long-running submission=
, does this
> > require an explicit flag from userspace at queue creation, or is there =
another
> > mechanism to identify it on the kernel side?
> > >
> >
> > Userspace would simply not call the userq signal IOCTL if they want to =
run long
> > running jobs.
>
> Yes, this approach can also handle long-running jobs submitted from users=
pace. However, after revisiting the Mesa code, it appears that a fence is a=
lways emitted for each userq submission, and I could not find any code for =
identifying long-running submissions. How should long-running submissions b=
e identified in userspace?

Userspace should not use protected fences in that case.  In theory
compositors that use explicit sync do not need to use the protected
fence.  Someone just needs to handle this case in mesa.

>
> If a long-running submission does not use a protected fence, hang_detect_=
work should not be scheduled for that submission, and this cleanup patch sh=
ould not affect the corresponding long-running userq. This should therefore=
 be treated as a separate case requiring further investigation, including h=
ow to identify long-running userq submissions and avoid attaching protected=
 fences to them.
>

All we need to do is check for the presence of a fence on the queue
(the application would have called the fence IOCTL).  If the fence is
present, then we'd reset the queue.  If no fence, and MES hang_detect
doesn't detect the queue as hung, then there is no need to reset it.

> Regarding the cleanup, if all hung user queues can be identified through =
hang_detect_only, do we still need to handle the guilty userq separately? C=
ould we simply reset all guilty queues by traversing the list of hung doorb=
ells, as proposed in this cleanup patch?

If there are no protected fences, then yes, all we need is MES hang detect.

Alex

>
> Regards,
> Prike
>
> > Alex
> >
> > > Thanks,
> > > Prike
> > > > Alex
> > > >
> > > > >
> > > > > Thanks,
> > > > > Prike
> > > > >
> > > > > Avoid unnecessary resets: if preemption succeeds and the queue
> > > > > resumes and completes within the extended window, cancel the rese=
t
> > > > > entirely =E2=80=94 the queue was slow, not broken.>
> > > > > > Alex
> > > > > >
> > > > > > > In the longer term, we may need to introduce a more robust
> > > > > > > mechanism to
> > > > > > distinguish slow queue cases from genuine hangs, handling them
> > > > > > appropriately via extending time slice for completing the queue
> > > > > > submission, userspace driven resubmission, or dropping the work
> > > > > > through a queue reset. If it makes sense and right way to do,
> > > > > > then I will work on implementing the solution for such slow/lon=
g queue
> > cases.
> > > > > > >
> > > > > > > Thanks,
> > > > > > > Prike
> > > > > > >
> > > > > > > > Alex
> > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Alex
> > > > > > > > > >
> > > > > > > > > > > Regards,
> > > > > > > > > > >       Prike
> > > > > > > > > > >
> > > > > > > > > > > > -----Original Message-----
> > > > > > > > > > > > From: Liang, Prike
> > > > > > > > > > > > Sent: Thursday, July 23, 2026 2:38 PM
> > > > > > > > > > > > To: amd-gfx@lists.freedesktop.org; Zhang, Jesse(Jie=
)
> > > > > > > > > > > > <Jesse.Zhang@amd.com>
> > > > > > > > > > > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>;
> > > > > > > > > > > > Koenig, Christian <Christian.Koenig@amd.com>
> > > > > > > > > > > > Subject: RE: [PATCH 1/2] drm/amdgpu: Remove separat=
e
> > > > > > > > > > > > guilty compute userq reset
> > > > > > > > > > > >
> > > > > > > > > > > > I checked each different userq hang cases, and the
> > > > > > > > > > > > guilty userq can be identified by the MES firmware
> > > > > > > > > > > > and report
> > > > correctly.
> > > > > > > > > > > > @Zhang,
> > > > > > > > > > > > Jesse(Jie) could you further check as well at you s=
ide?
> > > > > > > > > > > >
> > > > > > > > > > > > If there're some hang queues miss identified by MES
> > > > > > > > > > > > firmware, then the correct thing is to further debu=
g
> > > > > > > > > > > > from MES firmware side rather than have such strang=
e
> > > > > > > > > > > > reset sequence and this reset workaround should be
> > > > > > > > > > cleaned sooner or later.
> > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > Regards,
> > > > > > > > > > > >       Prike
> > > > > > > > > > > >
> > > > > > > > > > > > > -----Original Message-----
> > > > > > > > > > > > > From: Liang, Prike <Prike.Liang@amd.com>
> > > > > > > > > > > > > Sent: Wednesday, July 15, 2026 2:31 PM
> > > > > > > > > > > > > To: amd-gfx@lists.freedesktop.org
> > > > > > > > > > > > > Cc: Deucher, Alexander
> > > > > > > > > > > > > <Alexander.Deucher@amd.com>; Koenig, Christian
> > > > > > > > > > > > > <Christian.Koenig@amd.com>; Liang, Prike
> > > > > > > > > > > > > <Prike.Liang@amd.com>
> > > > > > > > > > > > > Subject: [PATCH 1/2] drm/amdgpu: Remove separate
> > > > > > > > > > > > > guilty compute userq reset
> > > > > > > > > > > > >
> > > > > > > > > > > > > amdgpu_mes_detect_and_reset_hung_queues() already
> > > > > > > > > > > > > detects the guilty compute user queue and resets
> > > > > > > > > > > > > it through mes_userq_reset_queue(). The additiona=
l
> > > > > > > > > > > > > reset via
> > > > > > > > > > > > > mes_userq_reset() is unnecessary, so remove it to
> > > > > > > > > > > > > unify the compute userq
> > > > > > > > > > reset.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > > > > > > > > > > > > ---
> > > > > > > > > > > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 5 -=
----
> > > > > > > > > > > > >  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 2 -=
-
> > > > > > > > > > > > >  2 files changed, 7 deletions(-)
> > > > > > > > > > > > >
> > > > > > > > > > > > > diff --git
> > > > > > > > > > > > > a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > > > > > > > > > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > > > > > > > > > > > > index 1e275c2e7dd3..4f2d5ff2f7be 100644
> > > > > > > > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > > > > > > > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > > > > > > > > > > > > @@ -2315,11 +2315,6 @@ int
> > > > > > > > > > > > > amdgpu_gfx_reset_mes_compute(struct
> > > > > > > > > > > > > amdgpu_device *adev,
> > > > > > > > > > > > >             deferred_end[n_deferred].fence =3D gu=
ilty_fence;
> > > > > > > > > > > > >             n_deferred++;
> > > > > > > > > > > > >     }
> > > > > > > > > > > > > -   if (uq) {
> > > > > > > > > > > > > -           r =3D mes_userq_reset(uq);
> > > > > > > > > > > > > -           if (r)
> > > > > > > > > > > > > -                   goto out;
> > > > > > > > > > > > > -   }
> > > > > > > > > > > > >     for (i =3D 0; i < num_hung; i++) {
> > > > > > > > > > > > >             struct amdgpu_ring *hr =3D NULL;
> > > > > > > > > > > > >             struct amdgpu_fence *hf =3D NULL; dif=
f
> > > > > > > > > > > > > --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.=
c
> > > > > > > > > > > > > b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > > > > > > > > > > > > index b6bfa3974839..fab21d4275f3 100644
> > > > > > > > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > > > > > > > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > > > > > > > > > > > > @@ -226,8 +226,6 @@ int
> > > > > > > > > > > > > mes_userq_reset_queue(struct amdgpu_device *adev,
> > > > > > > > > > > > >
> > > > > > > > > > > > >     xa_for_each(&adev->userq_doorbell_xa, uq_id, =
uq) {
> > > > > > > > > > > > >             if (uq->queue_type =3D=3D queue_type)=
 {
> > > > > > > > > > > > > -                   if (uq =3D=3D guilty_uq)
> > > > > > > > > > > > > -                           continue;
> > > > > > > > > > > > >                     if (uq->doorbell_index =3D=3D=
 db) {
> > > > > > > > > > > > >                             uq->state =3D
> > AMDGPU_USERQ_STATE_HUNG;
> > > > > > > > > > > > >                             if (use_mmio)
> > > > > > > > > > > > > --
> > > > > > > > > > > > > 2.34.1
> > > > > > > > > > >
