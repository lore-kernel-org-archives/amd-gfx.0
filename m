Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACFFDC77B7E
	for <amd-gfx@archiver.kernel.org>; Thu, 25 May 2023 15:52:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31EC810E192;
	Thu, 25 May 2023 15:52:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C3BD10E87D
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 May 2023 09:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
 :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=oTK7jsFG28WXK3rbDJ/X/Ehdt81MjRxqzlzU9gtnCdI=; b=GCvl5EpAe4K7xorgvYX2XrZY+l
 ZHjzsPZmS6uPnJEDZgkpv1YolqRKeRvnJVfXQcEH/6MhsiI4lCj9rZL7bi0Cz2HVqXuCBF2458npC
 qct8mWiVBOlbDH1Upozmbw6HDpfGsSZTqhUt9cWZ5+rMQK2yUW/5nz157uwKoRxQpwq4FmJeq+17M
 whMfn2hfs0V4htWG+NlwFI6YrErSvFfGz/8q4vsfncbt3DND4jrpm7Fw69l2TkB1Oh1bBDMDlx3s2
 zHzLfi59XfctH7e3OoaElA3O6Ad6bqCLDbjhb+aZ+cnapfLh/6/ag0Yz2VViKoV+NPWmiakEx34Pn
 Cnm7wEqw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1q27YF-00GBSU-10; Thu, 25 May 2023 09:46:31 +0000
Date: Thu, 25 May 2023 02:46:31 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add the accelerator pcie class
Message-ID: <ZG8ud4JWpF7BXJ7c@infradead.org>
References: <20230523040232.21756-1-shiwu.zhang@amd.com>
 <ZGxfEklioAu6orvo@infradead.org>
 <CADnq5_Pnob2+NPyf6GEcsCExC26qg_QvTri_CQLT=ArPibSxSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_Pnob2+NPyf6GEcsCExC26qg_QvTri_CQLT=ArPibSxSA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Mailman-Approved-At: Thu, 25 May 2023 15:52:00 +0000
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
Cc: Christoph Hellwig <hch@infradead.org>, bhelgaas@google.com,
 amd-gfx@lists.freedesktop.org, Shiwu Zhang <shiwu.zhang@amd.com>,
 linux-pci@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, May 23, 2023 at 10:02:32AM -0400, Alex Deucher wrote:
> On Tue, May 23, 2023 at 5:25 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Tue, May 23, 2023 at 12:02:32PM +0800, Shiwu Zhang wrote:
> > > +     { PCI_DEVICE(0x1002, PCI_ANY_ID),
> > > +       .class = PCI_CLASS_ACCELERATOR_PROCESSING << 8,
> > > +       .class_mask = 0xffffff,
> > > +       .driver_data = CHIP_IP_DISCOVERY },
> >
> > Probing for every single device of a given class for a single vendor
> > to a driver is just fundamentaly wrong.  Please list the actual IDs
> > that the driver can handle.
> 
> How so?  The driver handles all devices of that class.  We already do
> that for PCI_CLASS_DISPLAY_VGA and PCI_CLASS_DISPLAY_OTHER.  Other
> drivers do similar things.

How is that going to work in the long run?  The chances of totally
incompatbile devices from the same vendor appearing is absolutely given.

> The hda audio driver does the same thing
> for PCI_CLASS_MULTIMEDIA_HD_AUDIO for example.
>

That, just like PCI_CLASS_STORAGE_EXPRESS is a different case, as
the class is associated with an actual documented programming interface.
