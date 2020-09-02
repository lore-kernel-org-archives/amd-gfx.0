Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E858AC433E2
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 18:13:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6F91206EB
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 18:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhQrjFfK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6F91206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 363506E489;
	Wed,  2 Sep 2020 18:13:21 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B19946E489
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 18:13:19 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id z4so400382wrr.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Sep 2020 11:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GvWIRYOqP3ZIfXo87nUuygIoZbhwZ262UW6o7wsdo1E=;
 b=bhQrjFfKnFLPjl/gqfa/KQp+ZdsB8GO7PwVAndDGAasTuA6rOYe2bhk2OtZXidOG52
 iA/Lw39A9MKK2yXSp/fGkMWYKGnOiacFOYoMzQFdrTPTVbpuT5xB+Be8Ucb86Yt4E0Be
 D8p6kc+YLyGtzXu8LBi/NxntBjUeuml98N9/Cqt2BlBl1ZpxaR9aUIlrjAdfyLCBPhxi
 wm0dQHswWMQtCcdgmgrMOPU1GWq8qBhVXoGoP+4GaskCyNOJxEZlRaWmRT617dXITimV
 0vceVmkRHwSdS+IdG2+okp887Js5OjqYQQBx5sVuC/MlaDRxYmiPdjsO8mSxvfyfZgTW
 suDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GvWIRYOqP3ZIfXo87nUuygIoZbhwZ262UW6o7wsdo1E=;
 b=P632Zb3tIpOTSV0uUXLCV9G9I/2fer9vaWvcuqgRfUuKQrbd2LffUcFOvFdWgsQHVQ
 a4hy4YFta4myjYQshWvtq3grv1Ni9dLlkeHVdSdjm5LV4Z4gincGFChXafs95ac+bRl1
 gZc9Caw9MSoF7GYvJfxVs+9ZCA4EfXNJ1ZywJL1xWLUxXWqEOlbdJPa2/lDGezXRPYOA
 Lim2VnUxsQhdjCZV/49f3O6W9fg4QLThxiAfipQy09bXU/R/i/1wZ9i1LCZ4yPrV7QLi
 nJnPNayDX2C9Cpg1eMmDWLxywF/NZJANOUMXxbRCx1DkAihQ5oBd+DZZmgyOfkeG6H+F
 968Q==
X-Gm-Message-State: AOAM533ATUpp1oOM4CppCgzLcF+kjxFIy3WXjHV8SZFzN5wU3PkROUCL
 GUvrDkgq1u65rvGzXKVyf1bWZd/2mvN3rllykfU=
X-Google-Smtp-Source: ABdhPJwN7f8H+XdUUZa1QRKnY4SMn4AlsNvWaVZRqHutSDhWrP1vI8iWmuVjKmOjO/PShwt2nVYt8Jb9Kk83nAnLRBc=
X-Received: by 2002:adf:fc0a:: with SMTP id i10mr8239536wrr.111.1599070397477; 
 Wed, 02 Sep 2020 11:13:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200902170118.30751-1-alex.sierra@amd.com>
 <CADnq5_NRFr5vYfuwgMHQ5Y+19_UqXPoJYomBkwGMoWkvjpA_Fw@mail.gmail.com>
In-Reply-To: <CADnq5_NRFr5vYfuwgMHQ5Y+19_UqXPoJYomBkwGMoWkvjpA_Fw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 2 Sep 2020 14:13:06 -0400
Message-ID: <CADnq5_MFC=r=NxhzZ2OmO7EaodZXtGDQxgqw2146DGQoioShwA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: enable ih1 ih2 for Arcturus only
To: Alex Sierra <alex.sierra@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Sep 2, 2020 at 2:08 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Wed, Sep 2, 2020 at 1:01 PM Alex Sierra <alex.sierra@amd.com> wrote:
> >
> > Enable multi-ring ih1 and ih2 for Arcturus only.
> > For Navi10 family multi-ring has been disabled.
> > Apparently, having multi-ring enabled in Navi was causing
> > continus page fault interrupts.
> > Further investigation is needed to get to the root cause.
> > Related issue link:
> > https://gitlab.freedesktop.org/drm/amd/-/issues/1279
> >
>
> Before committing, let's verify that it fixes that issue.

Looking at the bug report, the OSS (presumably IH) block is causing a
write fault so I suspect arcturus may be affected by this as well.  We
should double check the ring sizes and allocations.

Alex


>
> Alex
>
>
> > Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 30 ++++++++++++++++----------
> >  1 file changed, 19 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> > index 350f1bf063c6..4d73869870ab 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> > @@ -306,7 +306,8 @@ static int navi10_ih_irq_init(struct amdgpu_device *adev)
> >         } else {
> >                 WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);
> >         }
> > -       navi10_ih_reroute_ih(adev);
> > +       if (adev->asic_type == CHIP_ARCTURUS)
> > +               navi10_ih_reroute_ih(adev);
> >
> >         if (unlikely(adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT)) {
> >                 if (ih->use_bus_addr) {
> > @@ -668,19 +669,26 @@ static int navi10_ih_sw_init(void *handle)
> >         adev->irq.ih.use_doorbell = true;
> >         adev->irq.ih.doorbell_index = adev->doorbell_index.ih << 1;
> >
> > -       r = amdgpu_ih_ring_init(adev, &adev->irq.ih1, PAGE_SIZE, true);
> > -       if (r)
> > -               return r;
> > +       adev->irq.ih1.ring_size = 0;
> > +       adev->irq.ih2.ring_size = 0;
> >
> > -       adev->irq.ih1.use_doorbell = true;
> > -       adev->irq.ih1.doorbell_index = (adev->doorbell_index.ih + 1) << 1;
> > +       if (adev->asic_type == CHIP_ARCTURUS) {
> > +               r = amdgpu_ih_ring_init(adev, &adev->irq.ih1, PAGE_SIZE, true);
> > +               if (r)
> > +                       return r;
> >
> > -       r = amdgpu_ih_ring_init(adev, &adev->irq.ih2, PAGE_SIZE, true);
> > -       if (r)
> > -               return r;
> > +               adev->irq.ih1.use_doorbell = true;
> > +               adev->irq.ih1.doorbell_index =
> > +                                       (adev->doorbell_index.ih + 1) << 1;
> > +
> > +               r = amdgpu_ih_ring_init(adev, &adev->irq.ih2, PAGE_SIZE, true);
> > +               if (r)
> > +                       return r;
> >
> > -       adev->irq.ih2.use_doorbell = true;
> > -       adev->irq.ih2.doorbell_index = (adev->doorbell_index.ih + 2) << 1;
> > +               adev->irq.ih2.use_doorbell = true;
> > +               adev->irq.ih2.doorbell_index =
> > +                                       (adev->doorbell_index.ih + 2) << 1;
> > +       }
> >
> >         r = amdgpu_irq_init(adev);
> >
> > --
> > 2.17.1
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
