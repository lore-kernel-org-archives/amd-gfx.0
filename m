Return-Path: <SRS0=p2a1=3E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAB7C33CB3
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 20:20:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AECE924679
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 20:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrPqp7EJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AECE924679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BD3D6EB33;
	Wed, 15 Jan 2020 20:20:32 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FA3B6EB33
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 20:20:31 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id q6so16934167wro.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 12:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zhQGA9v5B9UO5Q9PGnqpCtSgKgbmPkCZlk7QHpjWWGc=;
 b=MrPqp7EJN7qxuTYtKPPeNcmJjla3Vm6l/XtIW0uudLOBZZTCVmOC6v9m4OgW5JNOMh
 C9fkTg3t1xEVJd0sUCrGUe4UYuQnQ+pZX7ZTUASxn5kGcN/adby3Slwa/wrZ8N2uDgMf
 YPpbdpMcTEwd4yfEZ8k12k/YyLJLJEQkY6R0r/ecWIjdvt/Vc7LcT+fF1PTh4XZNokhR
 s5kBegJ4STu/Uq2Ye5pUEBfRIjlIjzDIRDQW1XAPHfIWKX9Uczh7zQK1UvLCpN7f0gwn
 q/RwPu+GcKkNnwx+ixAv2gZZUzErbIh9A0sPJWdV5dPCa7NjV65jpmNqLNbtsxF3bN9o
 Ssyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zhQGA9v5B9UO5Q9PGnqpCtSgKgbmPkCZlk7QHpjWWGc=;
 b=GHkn75VRYnibd5k4GH0EiUNhJ47cpisjf93RlN/OLWYxpfFp2boIrHiuV4ulI52HH1
 A7MOCQTlqTdTprGlr9LiuD7twdqlJzOpl+I94c2K4iRr8y0pDskrkOpVH+YZuChPXm6P
 aZlx5B/RHX+aD/Gk43lGvG0ZTMWz6vfNRU8k+LiGSceO8juEMj/YEbvNfU1BWbS01cH1
 ifnvW/powhE/ZNigGSQGGQ3j1V60oRu4ixgX1mckdSAvOFdp0zaB2pos7BF2NxbOCQw+
 gUTtl66iJ5VXfjrD5HEX6zKtKCTgIGAe89vYYY+mJMiH553RrE1JBE5dx60KRM0kUawc
 mU+Q==
X-Gm-Message-State: APjAAAWdXh70+lMj1BbKF1s0Y0OBFEq0EythzCeXF/kIwJgUjO3oIZQ9
 JHkY/QcMokvm28nnlp/t1TIFN9qTp/iRewyigf0=
X-Google-Smtp-Source: APXvYqyHJ0fOjvdMpd/sLykUjdcL5D5L6PvlsNRUAnQKLbU8jCLgzkOCrjcj84KwDIe8qaTtqTY3AqsnFBv5RldE40o=
X-Received: by 2002:adf:e8ca:: with SMTP id k10mr33400269wrn.50.1579119629699; 
 Wed, 15 Jan 2020 12:20:29 -0800 (PST)
MIME-Version: 1.0
References: <CADnq5_Onw1JgtAYiJgkdL55pe5UdVaJ7j-Tmj3THikWEs-nbkQ@mail.gmail.com>
 <20200115201738.GA190184@google.com>
In-Reply-To: <20200115201738.GA190184@google.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 15 Jan 2020 15:20:18 -0500
Message-ID: <CADnq5_MbiwYBNj5tB9=Dwj02Mi4GwJ7_5uBtx+8RkOdfC5HqLw@mail.gmail.com>
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

On Wed, Jan 15, 2020 at 3:17 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Jan 15, 2020 at 12:26:32PM -0500, Alex Deucher wrote:
> > On Wed, Jan 15, 2020 at 12:14 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Tue, Jan 14, 2020 at 05:41:44PM -0600, Bjorn Helgaas wrote:
> > > > On Tue, Jan 14, 2020 at 03:55:21PM -0500, Alex Deucher wrote:
> > > > > We've root caused the issue and clarified the quirk.
> > > > > This also adds a new quirk for a new GPU.
> > > > >
> > > > > Alex Deucher (2):
> > > > >   pci: Clarify ATS quirk
> > > > >   pci: add ATS quirk for navi14 board (v2)
> > > > >
> > > > >  drivers/pci/quirks.c | 32 +++++++++++++++++++++++++-------
> > > > >  1 file changed, 25 insertions(+), 7 deletions(-)
> > > >
> > > > I propose the following, which I intend to be functionally identical.
> > > > It just doesn't repeat the pci_info() and pdev->ats_cap = 0.
> > >
> > > Applied to pci/misc for v5.6, thanks!
> >
> > Can we add this to stable as well?
>
> Done!  Do you want it in v5.5?  It's pretty localized so looks pretty
> low-risk.

Sure.  Thanks!

Alex
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
