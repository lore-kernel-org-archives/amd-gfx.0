Return-Path: <SRS0=p2a1=3E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE31C32771
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 17:26:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 853292084D
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 17:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SB/5K17Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853292084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 436E96EA58;
	Wed, 15 Jan 2020 17:26:47 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F9526EA57
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 17:26:46 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id p17so823763wma.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 09:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=79CyoPm4V7zjcWE2b3ht/ZY8oOgKh4RF8gb01hp53+g=;
 b=SB/5K17ZuzyYkzbIcOoO0aKfItni6DL3IukChm/9PfLc55oTTg9b+UUEACWrjLqoOi
 gd5JkWO38K7oqMwORnALQSlk4he2l+bvQNlzu1SsglRxH/uCwhS+t+AK0OQGEVcYc7sF
 ZhTuBEXPko9sTRVSP23TuSSeCKLKFeBLdfQoHDp7o0Id/ZPRAJqtM+3o6zB4mB9YIYTA
 J2L61dRF7SAI//XeBLrJ3xbnJ3UoibrhNysjDSfZIps1OntgoPKWzKSqdBXtn8xGbGy8
 NvLhIzT4l5MFYEHzdccZtfo+kH/ViEneeZyukEldJBPQwK7nFBF2/hH81FeGSbcuF8PZ
 +VzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=79CyoPm4V7zjcWE2b3ht/ZY8oOgKh4RF8gb01hp53+g=;
 b=ElK1hpkLbBU85GEgu64IlI1MroFH6GFHYqjsWLOf1SUQNYP6QryN2fouYRe/dPjPTM
 mS4TPsH92jqrkyZjiIaiHujUqeRRBue1V2xPfx4F/P/I75/IpbNQm3iOSYuGItgMrKK4
 EW/C7kBV/Zu2/MJsgjsRuQEAvGK+16mo+y1whCNOoBsLiDwcUMV5eFKFFUFO6Yyr9gQ3
 1m3VrvuPWLxivytVocsj7maK7F+mctUCPf6gWhWDrph/rWGLjGeBhOhY8mnHRh6wABaL
 31O1Rp8OFqqpBdDRFVSZWIci63hARgZC6fBwvgdWY1duPGX0ZZU4NOYpjxHGI8zYyDec
 dKAA==
X-Gm-Message-State: APjAAAXAJTe9uvb/RIPFjz9n2PoibkFj5yzEP6Op6MaxHm7+Ux3thLsX
 +ouTk3kINVlVdh0KYWW4Sd48Dm/mB82xUwpRTOiJ9A==
X-Google-Smtp-Source: APXvYqwVq9QiSnKimj4bU4brSinzt9yBQo3hvzJegDc65tcqm9afBzu1qb7WfGlzwXWLd4ARAfC6+z4tgCS6BZuzKs4=
X-Received: by 2002:a1c:6404:: with SMTP id y4mr959711wmb.143.1579109205063;
 Wed, 15 Jan 2020 09:26:45 -0800 (PST)
MIME-Version: 1.0
References: <20200114234144.GA56595@google.com>
 <20200115171421.GA174505@google.com>
In-Reply-To: <20200115171421.GA174505@google.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 15 Jan 2020 12:26:32 -0500
Message-ID: <CADnq5_Onw1JgtAYiJgkdL55pe5UdVaJ7j-Tmj3THikWEs-nbkQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Adjust AMD GPU ATS quirks
To: Bjorn Helgaas <helgaas@kernel.org>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Linux PCI <linux-pci@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 15, 2020 at 12:14 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Jan 14, 2020 at 05:41:44PM -0600, Bjorn Helgaas wrote:
> > On Tue, Jan 14, 2020 at 03:55:21PM -0500, Alex Deucher wrote:
> > > We've root caused the issue and clarified the quirk.
> > > This also adds a new quirk for a new GPU.
> > >
> > > Alex Deucher (2):
> > >   pci: Clarify ATS quirk
> > >   pci: add ATS quirk for navi14 board (v2)
> > >
> > >  drivers/pci/quirks.c | 32 +++++++++++++++++++++++++-------
> > >  1 file changed, 25 insertions(+), 7 deletions(-)
> >
> > I propose the following, which I intend to be functionally identical.
> > It just doesn't repeat the pci_info() and pdev->ats_cap = 0.
>
> Applied to pci/misc for v5.6, thanks!

Can we add this to stable as well?

Alex

>
> > commit 998c4f7975b0 ("PCI: Mark AMD Navi14 GPU rev 0xc5 ATS as broken")
> > Author: Bjorn Helgaas <bhelgaas@google.com>
> > Date:   Tue Jan 14 17:09:28 2020 -0600
> >
> >     PCI: Mark AMD Navi14 GPU rev 0xc5 ATS as broken
> >
> >     To account for parts of the chip that are "harvested" (disabled) due to
> >     silicon flaws, caches on some AMD GPUs must be initialized before ATS is
> >     enabled.
> >
> >     ATS is normally enabled by the IOMMU driver before the GPU driver loads, so
> >     this cache initialization would have to be done in a quirk, but that's too
> >     complex to be practical.
> >
> >     For Navi14 (device ID 0x7340), this initialization is done by the VBIOS,
> >     but apparently some boards went to production with an older VBIOS that
> >     doesn't do it.  Disable ATS for those boards.
> >
> >     https://lore.kernel.org/r/20200114205523.1054271-3-alexander.deucher@amd.com
> >     Bug: https://gitlab.freedesktop.org/drm/amd/issues/1015
> >     See-also: d28ca864c493 ("PCI: Mark AMD Stoney Radeon R7 GPU ATS as broken")
> >     See-also: 9b44b0b09dec ("PCI: Mark AMD Stoney GPU ATS as broken")
> >     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> >
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 4937a088d7d8..fbeb9f73ef28 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -5074,18 +5074,25 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0422, quirk_no_ext_tags);
> >
> >  #ifdef CONFIG_PCI_ATS
> >  /*
> > - * Some devices have a broken ATS implementation causing IOMMU stalls.
> > - * Don't use ATS for those devices.
> > + * Some devices require additional driver setup to enable ATS.  Don't use
> > + * ATS for those devices as ATS will be enabled before the driver has had a
> > + * chance to load and configure the device.
> >   */
> > -static void quirk_no_ats(struct pci_dev *pdev)
> > +static void quirk_amd_harvest_no_ats(struct pci_dev *pdev)
> >  {
> > -     pci_info(pdev, "disabling ATS (broken on this device)\n");
> > +     if (pdev->device == 0x7340 && pdev->revision != 0xc5)
> > +             return;
> > +
> > +     pci_info(pdev, "disabling ATS\n");
> >       pdev->ats_cap = 0;
> >  }
> >
> >  /* AMD Stoney platform GPU */
> > -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x98e4, quirk_no_ats);
> > -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6900, quirk_no_ats);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x98e4, quirk_amd_harvest_no_ats);
> > +/* AMD Iceland dGPU */
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6900, quirk_amd_harvest_no_ats);
> > +/* AMD Navi14 dGPU */
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7340, quirk_amd_harvest_no_ats);
> >  #endif /* CONFIG_PCI_ATS */
> >
> >  /* Freescale PCIe doesn't support MSI in RC mode */
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
