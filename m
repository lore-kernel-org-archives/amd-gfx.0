Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103B5C636CC
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Feb 2023 15:39:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E2A110E144;
	Wed, 15 Feb 2023 15:39:19 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A152910E144
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Feb 2023 15:39:17 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 00694B8225D;
 Wed, 15 Feb 2023 15:39:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E44C4339B;
 Wed, 15 Feb 2023 15:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1676475554;
 bh=KAqVQM9UCH1nsN4dVqO6EI2zHup8vWAXhFqadtkfxJM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=RaKm6Vd89p1r/UPhvnoxGM8/yaSzsjglgOBhaKDjkb66pV8QyxW8L6p+iTAWHw5fr
 ow8VrkUQ47yCIqPBTU12Y1e5i6FQqvtasc3nI4nTwipHy5QQbmYPKq03feQ7lj4lxB
 4QvQP7lmtYdMV0LqxnrmYKW366R92hVLF2jIVfEPtf9kxNDIL2kuPkGfGAeNKJhSNf
 4mXkTP0lpilWn114gDuj2C6vCcgr+i1x6jYnf/mpp5g7Cpy2lNTa75PV15gDik493s
 EuhBBIu98FjsuRQjkJIexThiNjQJYAiaNHezaExE++u+q49OIi+57CU1rQ5jj4Q5ii
 nBJHKKqXH+3UA==
Date: Wed, 15 Feb 2023 09:39:13 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [regression, =?iso-8859-1?Q?bisected?=
 =?iso-8859-1?Q?=2C_pci=2Fiommu=5D_Bug=A0216865_-_Black_screen_when_amdgp?=
 =?iso-8859-1?Q?u?= started during 6.2-rc1 boot with AMD IOMMU enabled
Message-ID: <20230215153913.GA3189407@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7bbc0f65-e1c6-f388-29a8-390b8c9c92c8@linux.intel.com>
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
Cc: Joerg Roedel <jroedel@suse.de>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 Linux PCI <linux-pci@vger.kernel.org>, Felix Kuehling <felix.kuehling@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Hegde, Vasant" <Vasant.Hegde@amd.com>,
 amd-gfx@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Matt Fagnani <matt.fagnani@bell.net>, Jason Gunthorpe <jgg@nvidia.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[+cc Christian, Xinhui, amd-gfx]

On Fri, Jan 06, 2023 at 01:48:11PM +0800, Baolu Lu wrote:
> On 1/5/23 11:27 PM, Felix Kuehling wrote:
> > Am 2023-01-05 um 09:46 schrieb Deucher, Alexander:
> > > > -----Original Message-----
> > > > From: Hegde, Vasant <Vasant.Hegde@amd.com>
> > > > On 1/5/2023 4:07 PM, Baolu Lu wrote:
> > > > > On 2023/1/5 18:27, Vasant Hegde wrote:
> > > > > > On 1/5/2023 6:39 AM, Matt Fagnani wrote:
> > > > > > > I built 6.2-rc2 with the patch applied. The same black
> > > > > > > screen problem happened with 6.2-rc2 with the patch. I
> > > > > > > tried to use early kdump with 6.2-rc2 with the patch
> > > > > > > twice by panicking the kernel with sysrq+alt+c after the
> > > > > > > black screen happened. The system rebooted after about
> > > > > > > 10-20 seconds both times, but no kdump and dmesg files
> > > > > > > were saved in /var/crash. I'm attaching the lspci -vvv
> > > > > > > output as requested. ...

> > > > > > Looking into lspci output, it doesn't list ACS feature
> > > > > > for Graphics card. So with your fix it didn't enable PASID
> > > > > > and hence it failed to boot. ...

> > > > > So do you mind telling why does the PASID need to be enabled
> > > > > for the graphic device? Or in another word, what does the
> > > > > graphic driver use the PASID for? ...

> > > The GPU driver uses the pasid for shared virtual memory between
> > > the CPU and GPU.  I.e., so that the user apps can use the same
> > > virtual address space on the GPU and the CPU.  It also uses
> > > pasid to take advantage of recoverable device page faults using
> > > PRS. ...

> > Agreed. This applies to GPU computing on some older AMD APUs that
> > take advantage of memory coherence and IOMMUv2 address translation
> > to create a shared virtual address space between the CPU and GPU.
> > In this case it seems to be a Carrizo APU. It is also true for
> > Raven APUs. ...

> Thanks for the explanation.
> 
> This is actually the problem that commit 201007ef707a was trying to
> fix.  The PCIe fabric routes Memory Requests based on the TLP
> address, ignoring any PASID (PCIe r6.0, sec 2.2.10.4), so a TLP with
> PASID that should go upstream to the IOMMU may instead be routed as
> a P2P Request if its address falls in a bridge window.
> 
> In SVA case, the IOMMU shares the address space of a user
> application.  The user application side has no knowledge about the
> PCI bridge window.  It is entirely possible that the device is
> programed with a P2P address and results in a disaster.

Is this stalled?  We explored the idea of changing the PCI core so
that for devices that use ATS/PRI, we could enable PASID without
checking for ACS [1], but IIUC we ultimately concluded that it was
based on a misunderstanding of how ATS Translation Requests are routed
and that an AMD driver change would be required [2].

So it seems like we still have this regression, and we're running out
of time before v6.2.

[1] https://lore.kernel.org/all/20230114073420.759989-1-baolu.lu@linux.intel.com/
[2] https://lore.kernel.org/all/Y91X9MeCOsa67CC6@nvidia.com/
