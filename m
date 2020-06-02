Return-Path: <SRS0=q3BR=7P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309EFC433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 14:36:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04C10205CB
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 14:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSXSlqHy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04C10205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B56916E3F5;
	Tue,  2 Jun 2020 14:36:31 +0000 (UTC)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38CB26E3F3;
 Tue,  2 Jun 2020 14:35:21 +0000 (UTC)
Received: by mail-pf1-x442.google.com with SMTP id a4so5131317pfo.4;
 Tue, 02 Jun 2020 07:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mYlS2iciwsHXiaofbZsld8ptg5tb8qfGANhtOourZvI=;
 b=mSXSlqHydsbU5VJwZsklBYuOKu4DgisHccVnCvpwG7iUPxHWtWHxBjW86nVTGr7ZUH
 T54oYG/OKUn/YXneO0NPQFRHQwMUAv7mie5yg2mtH6tJvM9m0nhsAM/N0mAPoAUYHDPl
 bhig6+z0feWmjC+0y1eO/hG48+JaRBp3QZS2G8IcS4CVypUA2mM0HsOPG64Sf0/yX/MZ
 y8HGSOlPfafdSiyijkDbRiiBBAMRpuUe6/xPYCACNg9LL/6uJwjM3t5eHV2D0FvlqP7A
 2OSM36Icybzzkw9UXW49MiJw28t+ha37NRdx39sIVnk8u98X6zjr55Q+rdJ/qpm37DH6
 vjAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mYlS2iciwsHXiaofbZsld8ptg5tb8qfGANhtOourZvI=;
 b=fkF3REqTiaKJRHM4SO4SnSAp2wDONADZ6XtOqqMLacPOfNUQEqAxN2mw8BAysoIiSu
 dgLNQWc86A2vq2SzlG8piNYAmUh3K11IWJWlkkGaDpv1+qteixMn+jywry7UAThkH+yc
 Ybz6FMlYt0ph4n2PYBCHZL+AsCdQNwg+UPEa8lOd81184BmtD8HyPeZNJZcAmytBMvfb
 MfPhpKj9W2hjYZSW8a66OSHDiM0CSzI2o3LYVLFCJI0+WFOFJRCPUMWDbTtZN9oXVldl
 jHsR0jkdY7l8f7R3G6DxKG0YGLbvhwZp25d8ouGJo4Mdi0dUsyiteWGR/Gap6SMCL1rZ
 Pe0A==
X-Gm-Message-State: AOAM532rFSGX8zsEScc3/PxmZUqMb0S6vgcFp1JWl3x4c3MBcweBlfpb
 72v7sBeiaNkhPVPRnP9iNvwDfLhOXzjtcKacmSM=
X-Google-Smtp-Source: ABdhPJyCpwadTio0lN2T0Sanps9T+uhOtWpM2pkaVVZ+ZtL107eRbrGhBVpEicozrQekDLdG1bZ231XwC1g/LIyNQqE=
X-Received: by 2002:a63:305:: with SMTP id 5mr23614425pgd.74.1591108520518;
 Tue, 02 Jun 2020 07:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200602092030.31966-1-piotr.stankiewicz@intel.com>
 <14063C7AD467DE4B82DEDB5C278E8663010E23E538@FMSMSX108.amr.corp.intel.com>
 <CAHp75Vfe5dQkOiFoAZx5b-NS1afiD-YC_w+5LcX8P1Hm0ASenA@mail.gmail.com>
 <CADnq5_OO=gyo22ZrXp6pDtz2QZ2=LC429u_kkd0ZvX4=M3mBPw@mail.gmail.com>
In-Reply-To: <CADnq5_OO=gyo22ZrXp6pDtz2QZ2=LC429u_kkd0ZvX4=M3mBPw@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 2 Jun 2020 17:35:08 +0300
Message-ID: <CAHp75Vd1zVt7F2+44EFPHOrCOzexe=mLaiZixqJR9NNK9-wNQg@mail.gmail.com>
Subject: Re: [PATCH 07/15] drm/amdgpu: use PCI_IRQ_MSI_TYPES where appropriate
To: Alex Deucher <alexdeucher@gmail.com>
X-Mailman-Approved-At: Tue, 02 Jun 2020 14:36:29 +0000
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
Cc: David Airlie <airlied@linux.ie>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Ruhl,
 Michael J" <michael.j.ruhl@intel.com>, "Stankiewicz,
 Piotr" <piotr.stankiewicz@intel.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jun 2, 2020 at 5:21 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> On Tue, Jun 2, 2020 at 10:00 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Tue, Jun 2, 2020 at 4:38 PM Ruhl, Michael J <michael.j.ruhl@intel.com> wrote:
> > > >From: dri-devel <dri-devel-bounces@lists.freedesktop.org> On Behalf Of
> > > >Piotr Stankiewicz

> > > >               int nvec = pci_msix_vec_count(adev->pdev);
> > > >               unsigned int flags;
> > > >
> > > >-              if (nvec <= 0) {
> > > >+              if (nvec > 0)
> > > >+                      flags = PCI_IRQ_MSI_TYPES;
> > > >+              else
> > > >                       flags = PCI_IRQ_MSI;
> > > >-              } else {
> > > >-                      flags = PCI_IRQ_MSI | PCI_IRQ_MSIX;
> > > >-              }
> > >
> > > Minor nit:
> > >
> > > Is it really necessary to set do this check?  Can flags just
> > > be set?
> > >
> > > I.e.:
> > >         flags = PCI_IRQ_MSI_TYPES;
> > >
> > > pci_alloc_irq_vector() tries stuff in order.  If MSIX is not available,
> > > it will try MSI.
> >
> > That's also what I proposed earlier. But I suggested as well to wait
> > for AMD people to confirm that neither pci_msix_vec_count() nor flags
> > is needed and we can directly supply MSI_TYPES to the below call.
> >
>
> I think it was leftover from debugging and just to be careful.  We had
> some issues when we originally enabled MSI-X on certain boards.  The
> fix was to just allocate a single vector (since that is all we use
> anyway) and we were using the wrong irq (pdev->irq vs
> pci_irq_vector(pdev, 0)).

Do you agree that simple

  nvec = pci_alloc_irq_vectors(adev->pdev, 1, 1, PCI_IRQ_MSI_TYPES);

will work and we can remove that leftover?

-- 
With Best Regards,
Andy Shevchenko
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
