Return-Path: <SRS0=W/Sk=6I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC715C54FCB
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 14:03:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FA5B2075A
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 14:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tFoBkq8a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA5B2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EED16E053;
	Fri, 24 Apr 2020 14:03:50 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 200966E053
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2020 14:03:49 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id y24so10878701wma.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2020 07:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+SX1hF6S/TfJD7pysxQDh7fyYSoXvG7nBA/i7b7NcCc=;
 b=tFoBkq8aRXoCVtMH9wNkJg4JH4jasnV/+KUkJbSiHyQD0WhENY7+trYP/QGLIEzf1o
 72dM/FrgWMn+01l+Ic6fcEV37CmVHPawxFsKC9M8qq34FfBdkbC4VGhoapAGxE2vgXY6
 qFtgwVt82af3JDeT0npcI9e6Q/lVavlwuWesYwXQ7TRGflOCEX7UjgNlVosv4SXkoCjZ
 /pOGc9qoCBGtZrQ113nHHJUCsEKr8ISCiwIlI4TzzK9sg9RjZ5GiT7QQb8JHVn3AkrIT
 gBj4/teY/QjFvVWU354PXAuV8CnpVntn2xlG56NVbyL8+oom8YLj4kYi6vP4L5qHi58V
 sDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+SX1hF6S/TfJD7pysxQDh7fyYSoXvG7nBA/i7b7NcCc=;
 b=TvcYN9r3qYNCxw7QcHNhUWVjMz+PnOng2QhfYxFkjcd+HSHBdhVyDrX6orlhsrhkxF
 lXX2BSs20iC4+ii0/4yovvDWV7zUdMbFX6slXk984UG+K0v8G7FCYn9N+bXf/yUdYQwq
 t/V3Ke82lH1daTHFBUQWygOzrb4ik9/Cl6OrqSrQ7A7DzlTuz9R3pRYKlO5w7VW/x8cy
 jOz+jY/HIVdfOSBuP7Nd9PmdPdxlw85xb5Jz5uEa1yY7xQ3RTy9p9+1QmFsHa5KmNkuK
 68rmU0Wc2ylEDcrYcsBVBos3ouIaHTJEwXjHkAiu2530xt/S7iMYGSZzECr7mMwCW665
 THmA==
X-Gm-Message-State: AGi0Pub9ZdQfLhRzw2tT52JpznkNhu35ZgzV42IzS25EBIk0YSow27pu
 MHjuk4p+uTcQxJTMDgUF11e/FY3azUCksnWxw27U2Wsp
X-Google-Smtp-Source: APiQypLilxjc1o+FcAYqR+wmR98C2P3u/MODyNkaaq/VQTBMAAOjFn1VWTmRQ1lc3d96DbO5mUBoKeQ7dENzNRTbgyw=
X-Received: by 2002:a05:600c:258:: with SMTP id
 24mr10162625wmj.73.1587737027715; 
 Fri, 24 Apr 2020 07:03:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200424080547.25599-1-evan.quan@amd.com>
 <20200424080547.25599-2-evan.quan@amd.com>
 <CADnq5_PB_1Pef-C923gNut2+neF_1yxXPhzQUCWGvgLsyc1-eg@mail.gmail.com>
In-Reply-To: <CADnq5_PB_1Pef-C923gNut2+neF_1yxXPhzQUCWGvgLsyc1-eg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 24 Apr 2020 10:03:36 -0400
Message-ID: <CADnq5_OTeEvqXWBOkjL1z8rqNf_-32DEPVHjdok-Hhcksay7eQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drma/dmgpu: drop redundant cg/pg ungate on runpm enter
To: Evan Quan <evan.quan@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, Prike Liang <prike.liang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Apr 24, 2020 at 10:02 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Also, I just noticed a typo in the patch title:
>
> drma/dmgpu -> drm/admgpu

Can't type.

drma/dmgpu -> drm/amdgpu

Alex

>
> Alex
>
> On Fri, Apr 24, 2020 at 4:06 AM Evan Quan <evan.quan@amd.com> wrote:
> >
> > CG/PG ungate is already performed in ip_suspend_phase1. Otherwise,
> > the CG/PG ungate will be performed twice. That will cause gfxoff
> > disablement is performed twice also on runpm enter while gfxoff
> > enablemnt once on rump exit. That will put gfxoff into disabled
> > state.
> >
> > Change-Id: I489ca456770d3fe482b685f132400202467f712b
> > Signed-off-by: Evan Quan <evan.quan@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index 08eeb0d2c149..71278942f9f0 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -3453,9 +3453,6 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
> >                 }
> >         }
> >
> > -       amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
> > -       amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
> > -
> >         amdgpu_ras_suspend(adev);
> >
> >         r = amdgpu_device_ip_suspend_phase1(adev);
> > --
> > 2.26.2
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
