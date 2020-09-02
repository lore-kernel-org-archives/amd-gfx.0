Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0304FC43461
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 18:16:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1D56207EA
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 18:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M04PaINL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1D56207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 423046E4CA;
	Wed,  2 Sep 2020 18:16:21 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 092468870A
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 18:16:20 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id c19so3691146wmd.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Sep 2020 11:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3p3bdXrNaWWEz/kLD+Q+WcRjAC6EcCD2SKlQp2kHJxs=;
 b=M04PaINLO75Fkpd/50sRBIaBp3PKEF7TKWJk9woBvztppJvB7V+tsrFgPaf2bEOYB8
 os0CoxAxtWoTKipkKqXSf169fK807eYWQ0xRsCN6g6SMmd1wid2R3BC3kQebag68/tWf
 bbvW7tOaNyacyY2Vq4FXb9tYUK7jKIJbfq117Ze90Pn7DXlFYTRg4pW2SLhdhY/hXFK4
 3LMTbOx0Gk0y1R9vhSRw2ZFxAvjNHGuMuQyMvNKQWEl5Qsib3IBu4Bgt+yRpfEtwFQN+
 extfZqmH69Nrppx6A7rGWvAcm+U5tQmThbRrBGaympwLN576UuitLvPiOGS5kAJZqIwC
 SyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3p3bdXrNaWWEz/kLD+Q+WcRjAC6EcCD2SKlQp2kHJxs=;
 b=dBY64MksJXkJBw5LMBLSaNPdMSTDSJYcoz5Z3bhWif7ppm1rOo2c4Wmbs0azZD0VSm
 HfjN9PcFkRWGrfz+H3uqjGV3Cfd10RR7TmDg+hPX5IYwAqGerqVc5ZiaM03bheis+52c
 EsVTnL1tsDcMq7v82q2dvqaEu0ADxqx1gZ8Xcu4TxjwOlZ56Z9bRebV9KwEP2VDvRN/m
 YhUhbM1W+Ak5IZDepdAKp1KRwZIilvtADUEzys2gcoOPCgTwksIqn84mK0xc25PJLBMC
 7nDeWvjeEjmQcvgsy9/tCZjHoq1zUgcXPSqOXS9O/QbV50F28906vRhf5YpDfFSNqBLH
 G9cA==
X-Gm-Message-State: AOAM5328NuUD/q8YPc84YqpVYYt0s9c5JmY3zCFTOCWujoglM9Tm2xjZ
 djkz0Vc9YBzhf3qYbmS5bjRge2bkQEVvRmvs5xA=
X-Google-Smtp-Source: ABdhPJyGnSSPQCeMjUwigd27jO45nXS4pn7939U4gsHDyEUK/ebwsMUXFZGlPIiBQR26ZcnyhXxmnqcdARJHV9tpUnQ=
X-Received: by 2002:a7b:cb17:: with SMTP id u23mr1916237wmj.79.1599070578668; 
 Wed, 02 Sep 2020 11:16:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200902170118.30751-1-alex.sierra@amd.com>
 <CADnq5_NRFr5vYfuwgMHQ5Y+19_UqXPoJYomBkwGMoWkvjpA_Fw@mail.gmail.com>
 <a973acd3-e07a-2e81-c2f0-e1da707155f6@amd.com>
In-Reply-To: <a973acd3-e07a-2e81-c2f0-e1da707155f6@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 2 Sep 2020 14:16:07 -0400
Message-ID: <CADnq5_Oiy_VqS4qZHS6DDY=6_3OsfrBmODsTncjAgphUcu1L4A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: enable ih1 ih2 for Arcturus only
To: Felix Kuehling <felix.kuehling@amd.com>
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
Cc: Alex Sierra <alex.sierra@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Sep 2, 2020 at 2:10 PM Felix Kuehling <felix.kuehling@amd.com> wrote:
>
> Am 2020-09-02 um 2:08 p.m. schrieb Alex Deucher:
> > On Wed, Sep 2, 2020 at 1:01 PM Alex Sierra <alex.sierra@amd.com> wrote:
> >> Enable multi-ring ih1 and ih2 for Arcturus only.
> >> For Navi10 family multi-ring has been disabled.
> >> Apparently, having multi-ring enabled in Navi was causing
> >> continus page fault interrupts.
> >> Further investigation is needed to get to the root cause.
> >> Related issue link:
> >> https://gitlab.freedesktop.org/drm/amd/-/issues/1279
> >>
> > Before committing, let's verify that it fixes that issue.
>
> Has anyone reproduced this in AMD? Or should we ask the gitlab issue
> reporter to test the patch?

I've asked on the bug report.  I think Nicolai reported an mmhub error
at some point, but I can't find the reference now.  I haven't heard of
anything else.

Alex

>
> Thanks,
>   Felix
>
>
> >
> > Alex
> >
> >
> >> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> >> ---
> >>  drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 30 ++++++++++++++++----------
> >>  1 file changed, 19 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> >> index 350f1bf063c6..4d73869870ab 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> >> @@ -306,7 +306,8 @@ static int navi10_ih_irq_init(struct amdgpu_device *adev)
> >>         } else {
> >>                 WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);
> >>         }
> >> -       navi10_ih_reroute_ih(adev);
> >> +       if (adev->asic_type == CHIP_ARCTURUS)
> >> +               navi10_ih_reroute_ih(adev);
> >>
> >>         if (unlikely(adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT)) {
> >>                 if (ih->use_bus_addr) {
> >> @@ -668,19 +669,26 @@ static int navi10_ih_sw_init(void *handle)
> >>         adev->irq.ih.use_doorbell = true;
> >>         adev->irq.ih.doorbell_index = adev->doorbell_index.ih << 1;
> >>
> >> -       r = amdgpu_ih_ring_init(adev, &adev->irq.ih1, PAGE_SIZE, true);
> >> -       if (r)
> >> -               return r;
> >> +       adev->irq.ih1.ring_size = 0;
> >> +       adev->irq.ih2.ring_size = 0;
> >>
> >> -       adev->irq.ih1.use_doorbell = true;
> >> -       adev->irq.ih1.doorbell_index = (adev->doorbell_index.ih + 1) << 1;
> >> +       if (adev->asic_type == CHIP_ARCTURUS) {
> >> +               r = amdgpu_ih_ring_init(adev, &adev->irq.ih1, PAGE_SIZE, true);
> >> +               if (r)
> >> +                       return r;
> >>
> >> -       r = amdgpu_ih_ring_init(adev, &adev->irq.ih2, PAGE_SIZE, true);
> >> -       if (r)
> >> -               return r;
> >> +               adev->irq.ih1.use_doorbell = true;
> >> +               adev->irq.ih1.doorbell_index =
> >> +                                       (adev->doorbell_index.ih + 1) << 1;
> >> +
> >> +               r = amdgpu_ih_ring_init(adev, &adev->irq.ih2, PAGE_SIZE, true);
> >> +               if (r)
> >> +                       return r;
> >>
> >> -       adev->irq.ih2.use_doorbell = true;
> >> -       adev->irq.ih2.doorbell_index = (adev->doorbell_index.ih + 2) << 1;
> >> +               adev->irq.ih2.use_doorbell = true;
> >> +               adev->irq.ih2.doorbell_index =
> >> +                                       (adev->doorbell_index.ih + 2) << 1;
> >> +       }
> >>
> >>         r = amdgpu_irq_init(adev);
> >>
> >> --
> >> 2.17.1
> >>
> >> _______________________________________________
> >> amd-gfx mailing list
> >> amd-gfx@lists.freedesktop.org
> >> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
