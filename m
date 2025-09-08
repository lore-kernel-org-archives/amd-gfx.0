Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C546DCAC581
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 13:51:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C48410E524;
	Mon,  8 Sep 2025 13:51:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nnJadAmM";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40DC210E524
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 13:51:39 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-24c95f20117so12034115ad.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Sep 2025 06:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757339499; x=1757944299; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=idZYdofpAv7HrF9OKepRmbuYjr+lH9OxH1jXOBxdmjo=;
 b=nnJadAmM8XerxHbPwPoiLcRHGRh8dGCD8hXbo69RvSFwv5EMV4Y1SXSJTBlsuJj4X2
 3P2PiXujhj8yFOtyfcSaSs+PfLBrRkf/d8Ushkx3W9Yw5LoRAhvKGnlVc4QzP56vNXCn
 YoERwJg30W1rV3kadr6i56AbRM1TFxB9oak1uYN5B+CwiHkb7S3Wz/QGcyiON9FfjjBN
 a86gOvVvzjIUUczIGqnSlxIv+ikTqaM/YuBMxFCRcxJ97dxVN/V45yhCu6nTs6hWe5eD
 vw/X+xvBrl7iKDg69Xr5n6QsJf1x8PoOWl0bCm7VM7MJs4CQNeyJx8XNn4cXBMV0ev/l
 LD/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757339499; x=1757944299;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=idZYdofpAv7HrF9OKepRmbuYjr+lH9OxH1jXOBxdmjo=;
 b=JjrFtrBYZ3EiiTdVu5XUcBOClzl0o+BYbR6BzG5HCi9JcUYSp6xDESbq7kyNMYUzxl
 0r/wqLMxh3TGD0A0Y4h7FJDO+2TnfWdMovfsvHQfrnQmwVSDFMDkSW8uLtjMeUESbCZj
 OwOExOhFPUOA8/0igYoOjk48hYLpGVsSwd5mMGK0ktXMfq3cU5RBprATqXH/ioeIGeHf
 BJ4+FLwXXFzJIreQ4pISx7OUT7LgzUyNuzoDF1C1ibF+ZzInV4yMEE0rfFgblrZNi13S
 w1rO1eKfbHtUkOQqSybXZzA4mjCaJ/26yLlCHAqcq5txBykKn6mH5aH5Hs4dngZaNglS
 J7dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV02urwJutpDlJLsjevZ7D5+0EGWKif1Tkwn366XjXg0aKQ32VF0Q3FSnxLQNu6gmEw/P2y9lvV@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzyfKIkcjt5ssPc/mHhz62wxkcbOqU4JEFOvU2kA1F28wuTukM7
 qM4iqd7J3ZoIFgNjBHVOnRAutB0IMXhjt4IFtRMYNhlRtBCBT5Y6FiwIZAq+JWPSMviMMMt+zhN
 XcWsLXikzOgD2jfO+ON229gESK/tQfGc=
X-Gm-Gg: ASbGncvJMmI46Lnm7fq4hSiNcLs2NRdMQuwDDe9EsOWOiSQVz2GAfj+WjQzLhVV0UGA
 QfS/dOVmHqiQfBGWhDWvGVgDbPmthsCy6PcztUdOJLndtibNzdUggtAJacB4C56XQU122pgp8t3
 JVNewY1+wsm8UA5sAx6T/n4RqsLpp1WdqtwV0dhzbz2yvPoZtWUY/QOzRBFi2QtUeQqhqDeAtAo
 ysZTGM=
X-Google-Smtp-Source: AGHT+IHfnXhXUvw+F/knFk8m5jVBQddR4DLhzuhiYl84c2T6soYDwsXI1BdGE5CXeqnN1mrZ353iUCl82KlvYT0jIUA=
X-Received: by 2002:a17:902:e952:b0:252:3606:ce05 with SMTP id
 d9443c01a7336-2523606d0d3mr57485375ad.6.1757339498623; Mon, 08 Sep 2025
 06:51:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250905124742.11305-1-christian.koenig@amd.com>
 <20250905124742.11305-2-christian.koenig@amd.com>
 <CADnq5_OmQkYaYSu-QYCXV7YcPLtbVsKqwsjwWt=coPoRcrvadg@mail.gmail.com>
 <CH0PR12MB537231D3E692E6028C057F0EF403A@CH0PR12MB5372.namprd12.prod.outlook.com>
 <8c919bc1-0ea5-4b73-b73f-657adb6a8f50@amd.com>
In-Reply-To: <8c919bc1-0ea5-4b73-b73f-657adb6a8f50@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 8 Sep 2025 09:51:26 -0400
X-Gm-Features: Ac12FXwWf7sVO_79V4LF35sK8cq0faaNfYNpmzb_biUd_JaJ7ul0OUqYbhnISMw
Message-ID: <CADnq5_MnUN208f-ix-QyOGZcYnY2S-F3tvzpD4RWCZ1SGbWOaQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: reject gang submissions under SRIOV
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "timur.kristof@gmail.com" <timur.kristof@gmail.com>
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

On Mon, Sep 8, 2025 at 8:54=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> On 05.09.25 20:39, Liu, Shaoyun wrote:
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >
> > I can confirm that during world switch the entire gfx block (including =
gfx, compute and sdma for gfx10+) been switched together .
>
> Yeah, but that simply doesn't work as expected.
>
> The problem is that the world switch can't preempt running gfx shaders an=
d compute shaders only when CWSR is available.
>
> Now what world switch currently does is to wait for the gfx draw to finis=
h, then pause the gfx queue and then other the compute queues.
>
> When gfx starts first that approach works, but when the compute queue run=
s first we then try to preempt a compute queue which is waiting for the gfx=
 draw to start.
>
> Since we don't have CWSR for this compute queue this results in a lockup =
at the moment.

Compute queues can still preempt without CWSR, it's just dispatch
level (like gfx) rather than instruction level preemption.

Alex

>
> Regards,
> Christian.
>
> >
> > Regards
> > Shaoyun.liu
> >
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex=
 Deucher
> > Sent: Friday, September 5, 2025 9:32 AM
> > To: Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freed=
esktop.org; timur.kristof@gmail.com
> > Subject: Re: [PATCH 2/2] drm/amdgpu: reject gang submissions under SRIO=
V
> >
> > On Fri, Sep 5, 2025 at 8:47=E2=80=AFAM Christian K=C3=B6nig <ckoenig.le=
ichtzumerken@gmail.com> wrote:
> >>
> >> Gang submission means that the kernel driver guarantees that multiple
> >> submissions are executed on the HW at the same time on different engin=
es.
> >>
> >> Background is that those submissions then depend on each other and
> >> each can't finish stand alone.
> >>
> >> SRIOV now uses world switch to preempt submissions on the engines to
> >> allow sharing the HW resources between multiple VFs.
> >>
> >> The problem is now that the SRIOV world switch can't know about such
> >> inter dependencies and will cause a timeout if it waits for a
> >> partially running gang submission.
> >>
> >> To conclude SRIOV and gang submissions are fundamentally incompatible
> >> at the moment. For now just disable them.
> >
> > Are you sure about this?  Thinking about this more, most gang submissio=
ns are between gfx and compute.  The entire GC block (gfx, compute, and sdm=
a on gfx10+) gets preempted on world switch so all of the active queues wou=
ld be preempted.  Everything gets resumed when the VF gets switched back.  =
VCN/JPEG gets switched independently so that could be a problem if you have=
 a gang with VCN and GC, but I think all gangs within GC should in theory b=
e ok.
> >
> > Alex
> >
> >>
> >> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >> ---
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> >> index 2ac9729e4c86..434a551365c7 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> >> @@ -286,7 +286,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser=
 *p,
> >>                 }
> >>         }
> >>
> >> -       if (!p->gang_size) {
> >> +       if (!p->gang_size || (amdgpu_sriov_vf(p->adev) && p->gang_size
> >> + > 1)) {
> >>                 ret =3D -EINVAL;
> >>                 goto free_all_kdata;
> >>         }
> >> --
> >> 2.43.0
> >>
>
