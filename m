Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC1CC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 15:56:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F01910E4C6;
	Fri,  8 Apr 2022 15:56:36 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6367010E4DE;
 Fri,  8 Apr 2022 15:56:35 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 c24-20020a9d6c98000000b005e6b7c0a8a8so2920416otr.2; 
 Fri, 08 Apr 2022 08:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zgPFew/129J9uUrYqgZcVA+g7qNHsWob0wEdFbRdpLU=;
 b=dktOw19q9ZbYejGac9aUvdm7bnjZO6AVQ9nVh7HYnAnDGbZlxD+btfMrdrWirobS88
 OfBJr4SOeGf7ASzNiaXh3mN79WPPil6Ob2DuXBqxXgJMZH48aNxvRGHb5b1SluttE4RZ
 77iMMPzO7WtymN5YLYlbS3iVXWDnNyfzvDHJStRQL33gyQLOprl6NjKepSdRDSiPXUmU
 1jJizhER3IGFh/+FrDPao35luJJyGYEL53f7TCMTuIQ+mcUA/DObmR2IOCcSYYOAE726
 GMdR+PSEAT7TZEMDfSEhb9gooThqU5UnXh0Hne6kqF3hyNtPveqNs7sQi5Jl/oqaYClP
 vWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zgPFew/129J9uUrYqgZcVA+g7qNHsWob0wEdFbRdpLU=;
 b=bUdfSKJuMTZneQNPHtWOnekOuA8nsJaZ9rkNeH9tyK4IOdpTR+w0Y+zhfL8igyHbyR
 1w1vCILtdyb8KQprsQR9HhFKFNYbMnqWwz79//dDuYrQdgLxm/L5NwCJCNTFtIYVhjbm
 UhESFmfRVwiBlziJfszUyYw5EUuyGRkO0z6STob+2A+zeHJjXxr0f8y0IBIDBUq6+rTE
 N5D/44ZwfCX9o5WvTjaWhwT2M5iZsj6AOFpzShKDLSm3uNErjuVRz6dSuf+zxbgzKmsI
 yOUpyuseJnR8zEi3beOJrnldifwbf5jwjg1sBLX9M7MhHduLKN907rH43YIEQzp+PY1W
 r6NQ==
X-Gm-Message-State: AOAM5323kpzKzy8EVSto2e0r53GY8jsyrLY4eznxh5jkHlBTpAMcj2hc
 A+Xv9+DAx48FhWIT8ixR5H/b+cbC1rgrC9WyKEA=
X-Google-Smtp-Source: ABdhPJyuyaJRBQCOjtaH0m0rI1qNrPzvqTn/RpB560wfXhQSx2kwk8zS8cWzYR3Xe6H+fvl1IN49y2SVV0Rc1dw4VrQ=
X-Received: by 2002:a9d:4702:0:b0:5cd:481a:148a with SMTP id
 a2-20020a9d4702000000b005cd481a148amr7010989otf.200.1649433394746; Fri, 08
 Apr 2022 08:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220408154447.3519453-1-richard.gong@amd.com>
 <BL1PR12MB51576654D3EEB10F5DF862A7E2E99@BL1PR12MB5157.namprd12.prod.outlook.com>
 <CADnq5_PmxGxrJG5uZkkFXQ1YbJbDZTvAqb2oYqdCE=NtqBojqw@mail.gmail.com>
In-Reply-To: <CADnq5_PmxGxrJG5uZkkFXQ1YbJbDZTvAqb2oYqdCE=NtqBojqw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 8 Apr 2022 11:56:23 -0400
Message-ID: <CADnq5_M2HBGhVod+ECmPbtBN6FGizjGkgU-m-mtGSqGjMh8b9w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: disable ASPM for legacy products that don't
 support ASPM
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "airlied@linux.ie" <airlied@linux.ie>, "Gong,
 Richard" <Richard.Gong@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "daniel@ffwll.ch" <daniel@ffwll.ch>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Apr 8, 2022 at 11:54 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Fri, Apr 8, 2022 at 11:47 AM Limonciello, Mario
> <Mario.Limonciello@amd.com> wrote:
> >
> > [Public]
> >
> >
> >
> > > -----Original Message-----
> > > From: Gong, Richard <Richard.Gong@amd.com>
> > > Sent: Friday, April 8, 2022 10:45
> > > To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > > <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>;
> > > airlied@linux.ie; daniel@ffwll.ch
> > > Cc: amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-
> > > kernel@vger.kernel.org; Limonciello, Mario <Mario.Limonciello@amd.com>;
> > > Gong, Richard <Richard.Gong@amd.com>
> > > Subject: [PATCH] drm/amdgpu: disable ASPM for legacy products that don't
> > > support ASPM
> > >
> > > Active State Power Management (ASPM) feature is enabled since kernel
> > > 5.14.
> > > However there are some legacy products (WX3200 and RX640 are examples)
> > > that
> > > do not support ASPM. Use them as video/display output and system would
> > > hang
> > > during suspend/resume.
> > >
> > > Add extra check to disable ASPM for old products that don't have
> > > ASPM support.
>
> The patch description is incorrect.  ASPM works just fine on these
> GPUs.  It's more of an issue with whether the underlying platform
> supports ASPM or not.  Rather than disabling a chip family, I would
> prefer to add a check for problematic platforms and disable ASPM on
> those platforms.

For example, see intel_core_rkl_chk() in smu7_hwmgr.c.  We disable
PCIe DPM on RKL platforms due to compatibility issues with that
particular platform.

Alex

>
> Alex
>
> > >
> > > Signed-off-by: Richard Gong <richard.gong@amd.com>
> > > Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1885
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > index bb1c025d9001..8987107f41ee 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > @@ -2012,6 +2012,10 @@ static int amdgpu_pci_probe(struct pci_dev
> > > *pdev,
> > >       if (amdgpu_aspm == -1 && !pcie_aspm_enabled(pdev))
> > >               amdgpu_aspm = 0;
> > >
> > > +     /* disable ASPM for the legacy products that don't support ASPM */
> > > +     if ((flags & AMD_ASIC_MASK) == CHIP_POLARIS12)
> > > +             amdgpu_aspm = 0;
> > > +
> >
> > I think it's problematic to disable it for the entire driver.  There might be multiple
> > AMDGPUs in the system, and others may support ASPM.
> >
> > Can it be done just as part of probe for Polaris?
> >
> > >       if (amdgpu_virtual_display ||
> > >           amdgpu_device_asic_has_dc_support(flags & AMD_ASIC_MASK))
> > >               supports_atomic = true;
> > > --
> > > 2.25.1
