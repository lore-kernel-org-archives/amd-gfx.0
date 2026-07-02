Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81947C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2026 13:26:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14C2E10F39C;
	Thu,  2 Jul 2026 13:26:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NEPJrg78";
	dkim-atps=neutral
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com
 [209.85.217.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D44310F39C
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2026 13:26:40 +0000 (UTC)
Received: by mail-vs1-f52.google.com with SMTP id
 ada2fe7eead31-73843e514a3so60921137.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Jul 2026 06:26:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782998799; cv=none;
 d=google.com; s=arc-20260327;
 b=PV0rMULZfHkgTQdeg3bbme78vwKtubPFVcHPGf2nO7lBq1CZsjDpHlK2Yf398rqNXg
 5O1vtW0Dj8YJqFvvIorZIDEDxfYXvBwbdVnDAq4y9cOV5rMPGSUwVl0jm44zEq5Kyo02
 vfvDAWM3pcJshmgqp0eLYHcViB85Zq5kSAU2MyFkTnCHrFFpHwfDhGFK7/2t0/7aLkcR
 ImbNEua+BDghLHisX6W85W71SJap3L3GtX4f/KcCC1iwEZzAdqf28IUCoKSfP3EKT4lv
 YQrZWr+MQEPkLqKRbfbo7ho1vwHmJ01TEeohb6yieUxRZbNldD/mcG++bBVffDb/bN7C
 VEqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KRJdaSWQpWusfVL4aaGi+nNDXjgiftmBc+N5woofPDI=;
 fh=ZiX8erw0mInmQQ7pXBvY8+wP8odNg9wiMnzkd6waQes=;
 b=IWWEV9w7lSBloJaGtzgAWuIon0bc2Us+J6vp23zqlvMR1hJmnll5I1GFiI2lwlVLqF
 SDCmmIw62zduu+Tm9i7pEDiB7pdy0lMIvQ4qqTPrN3n7Yw7faHI/uV/BHiPqg+Ebulef
 Bxad2oLMIj7FxfddRVPd83CUsqJjPetu8E07sfdfYZ1COgHPjoEUMR2sHCYR/AdhG+1Y
 dh1NcfrKr4+eGuUeR/l9IndKKiKU2fueMsGl797SVcCkSxOADWv8buPkxCqFCQqP0wMt
 mU1JMjMCayA3buRk7ngNH7EBandMoxH5Ar2gm25w10jiU4C0B6LUeu5+qbsC99CMHI0m
 rKcg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782998799; x=1783603599; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KRJdaSWQpWusfVL4aaGi+nNDXjgiftmBc+N5woofPDI=;
 b=NEPJrg78aLkGKOL1WLSQREm6qr9EC4lHZPQmm8uwWdrKeM4BgmcD6VLkPQP4C4pUOz
 HyOvYgShSGzKV64LCjUiu3wu8NHBivE+0t0jTneqwfE9QbqcUsNcduEs4mHx9VGpAncN
 rXD7H4kKkTgtbutFt/ENjygG3nO2PFZ5u2tahZT3N7u4TOPaBOP1M8VIJ8vtUaDhDQn6
 tzS62Bh4Kpj2rLe2+xVTcRnAvUd90rAqwVdi+e9DNa51yXbD9exk8J0S9ldlvmdHCJvH
 /bRfDJoOePQUDC7W2qLLfzGJ2ndIqJYA2kH5Gv+R1COJfTGLqAdy2OOzvM8il47YkYXb
 WeYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782998799; x=1783603599;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KRJdaSWQpWusfVL4aaGi+nNDXjgiftmBc+N5woofPDI=;
 b=AjOZ0NqLNzQAdnzvKWUPiN56dKk5dJNeC8Mf+Ke8dg+fFGfOdZqkq82NeCdUWciWhF
 5JyA8HF+f+Hyw9zegr4sFsOGQi2BOk2rM/QsrDx6oDOyUHmhRLtL3n2rayQsneXsXdS+
 5Jyu3A6IiK2Bs9sSMAZwE6S7iOa03/tlM9WhbdkrQdg1nuG8oVxero+WpPjtwEMNRsXX
 BuzuRWCd3RDgCuHsHlNvwoYm0nbEvYLec1IveyYrzWzxzMPKkxcLobRMYBAuLifNQuQd
 6fu2cNje9Q7x/nop4qXmrelrlbo+p2VBJtFnRtsSBCtQVy5zmgd0rganV9+IpQD1Xp5U
 uA8Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoeYkf0dhR+hOKHa7qnd6NzdLv/7eYjZScnuTSnivBbTsF45Zjq3d4MqL3GHCOv3CZTDqmUZYx+@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzXqdaTKTcmT6K5otfHezCy5F3U9ucHR/WfCBmmMzIY+vzIDcDl
 nt9n4s8nYoYt1o9wne4RHykqsWNwFWd6OcnqRNjFZetnr2ZSWI8kuRKlYihGCoWbGiuyoxJa+Vr
 qzT5XxKD8Tm0LNhdJNau80mFqyfBFsxI=
X-Gm-Gg: AfdE7clDBM3GJfhl5D211nCx2SNLzJyBBycx9Z2jWz5sugCVo27njC80j84vvnEZ1Kr
 CoRGnNRohBue9tukdMKkM7HOA6RctlR/cCrE9HRfj/OaU86FFc/EtMedtMM1Ow3mLSMPkLaFjYa
 bkakYctkZOAdzMY22Y2ZMgMw5AghmWPDMLEnac/khIl2UEEYOAM/nvGn+D6iNjkLW93tpDSQTrk
 e5Pn/2SR4KSLkOvcI14GzYM7l4an17pk3Fxyf1PU2JmOCrF55R0jzvU/cBN1S/7I3I+tQo1uhwQ
 D7BRr4oBo9ETZGfh8NAIPMw4zdk75IqO17tk6dmkFiDHs+6iQnlQlBfFwWo=
X-Received: by 2002:a05:6102:1483:b0:739:64ad:bf4e with SMTP id
 ada2fe7eead31-73dab0f643amr917912137.7.1782998798899; Thu, 02 Jul 2026
 06:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260701161721.85681-1-timur.kristof@gmail.com>
 <20260701161721.85681-15-timur.kristof@gmail.com>
 <dee4f6f3-0494-40e6-94d9-e0249633d0bc@amd.com>
 <5873192.ZASKD2KPVS@timur-max> <15459d84-24fd-404c-b90f-97d2ecfb7af8@amd.com>
In-Reply-To: <15459d84-24fd-404c-b90f-97d2ecfb7af8@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 2 Jul 2026 09:26:25 -0400
X-Gm-Features: AVVi8CcgqqfX6rCZ3WxgEf1PaLlFPebLI4PJ3-HYjejub4-j4j-xg0VVNX0ITWg
Message-ID: <CADnq5_PFyqkXwwWHNipu5QEYCLFA_VdCV5OKA6uhKz=TPQ9YJw@mail.gmail.com>
Subject: Re: [PATCH 14/14] drm/amdgpu/ih7.0: Enable retry CAM on Navi 4 dGPUs
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>, 
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>, 
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Siwei He <siwei.he@amd.com>, 
 Philip Yang <philip.yang@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
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

On Thu, Jul 2, 2026 at 9:09=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
>
>
> On 7/2/26 13:53, Timur Krist=C3=B3f wrote:
> > On 2026. j=C3=BAlius 2., cs=C3=BCt=C3=B6rt=C3=B6k 12:38:12 k=C3=B6z=C3=
=A9p-eur=C3=B3pai ny=C3=A1ri id=C5=91 Christian K=C3=B6nig
> > wrote:
> >> On 7/1/26 18:17, Timur Krist=C3=B3f wrote:
> >>> The retry CAM can filter interrupts which occur repeatedly,
> >>> such as page fault interrupts when retry faults are enabled.
> >>> This makes processing those interrupts much more efficient,
> >>> because the CPU won't have to deal with processing the same
> >>> interrupt repeatedly.
> >>>
> >>> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> >>> ---
> >>>
> >>>  drivers/gpu/drm/amd/amdgpu/ih_v7_0.c | 3 ++-
> >>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> >>> b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c index 291326d2ee8b..ec0919fa82=
54
> >>> 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> >>> @@ -390,7 +390,8 @@ static int ih_v7_0_irq_init(struct amdgpu_device
> >>> *adev)
> >>>
> >>>     pci_set_master(adev->pdev);
> >>>
> >>> -   if (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) =3D=3D IP_VERSION(7, =
1,
> > 0)) {
> >>> +   if (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) =3D=3D IP_VERSION(7, =
1, 0)
> > ||
> >>> +       !(adev->flags & AMD_IS_APU)) {
> >>
> >> I think the check should be the other way around.
> >>
> >> In other words we can enable the cam on dGPU or APUs with IP version 7=
.1
> >> because that one has the CAM as well.
> >
> > What do you mean by the other way around?
> >
> > The patch keeps pre-existing behaviour on IH 7.1 and additionally enabl=
es the
> > retry CAM on dGPUs. The patch makes no functional changes to IH 7.1, on=
 that
> > version the retry CAM is always enabled regardless of whether it's an A=
PU or
> > dGPU.
>
> I just wanted to make the logic more readable. In other words:
>
> if (!(adev->flags & AMD_IS_APU) ||
>     amdgpu_ip_version(adev, OSSSYS_HWIP, 0) =3D=3D IP_VERSION(7, 1, 0))
> ...
>
> I still need to double check why we have the exception for OSSSYS 7.1.
>
> Could be that this is for some MI* product, but I'm not 100% sure yet.

oss 7.1 is for an datacenter part.

Alex

>
> Regards,
> Christian.
>
> >
> >>
> >>>             /* Enable IH Retry CAM */
> >>>             tmp =3D RREG32_SOC15(OSSSYS, 0,
> > regIH_RETRY_INT_CAM_CNTL);
> >>>             tmp =3D REG_SET_FIELD(tmp, IH_RETRY_INT_CAM_CNTL, ENABLE,
> > 1);
> >
> >
> >
> >
>
