Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B39CD11DF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Mar 2024 21:14:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9EDF10F34F;
	Tue, 26 Mar 2024 21:14:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NLVThY5Y";
	dkim-atps=neutral
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBF1610F336
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Mar 2024 21:14:35 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 5BA56CE0921;
 Tue, 26 Mar 2024 21:14:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5738BC433F1;
 Tue, 26 Mar 2024 21:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711487672;
 bh=cxfzcpVl6iw0nLD4z59WnZub1zdzpHD3Ab/gARw6LCQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=NLVThY5Yh2SzMHj4gx9UytpQfFJgRigfFFXt+bm6Vuu3F1XJQiMr6mpQ5ZiPngd1n
 Y3oah6WxB6w8vOtameV4wbrxrY5wofrUOI9g31Io5EdLc/j+KK8tfXH3xtt0JxGB2N
 41zLFvHWmMYUpsRk36/3btrCOrPAtRy6KTbcAmYOIBNVugRcJC8xbhUFT667lR/66s
 K8/Ub7VERzydJeXZrf3U8gIU/jnq6GIZoo3e1f50o0x4S+IefKUpldWak2O8Z9945C
 M/N49IG+6Cnb/a1N5y474X7v3YHt+/i2pidMu6YhpMQK8dJegtAohGlEJNPNCUpTS8
 8oqh9BxzR+lAw==
Date: Tue, 26 Mar 2024 16:14:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>,
 Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
 linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Jaroslav Kysela <perex@perex.cz>, linux-sound@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linux-serial@vger.kernel.org,
 Hans de Goede <hdegoede@redhat.com>,
 platform-driver-x86@vger.kernel.org, ntb@lists.linux.dev,
 Lee Jones <lee@kernel.org>, David Airlie <airlied@gmail.com>,
 amd-gfx@lists.freedesktop.org, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-rdma@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/28] mfd: intel-lpss-pci: Use PCI_IRQ_INTX
Message-ID: <20240326211430.GA1497386@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325210444.GA1449676@bhelgaas>
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

On Mon, Mar 25, 2024 at 04:04:44PM -0500, Bjorn Helgaas wrote:
> On Mon, Mar 25, 2024 at 09:39:38PM +0200, Andy Shevchenko wrote:
> > On Mon, Mar 25, 2024 at 04:09:20PM +0900, Damien Le Moal wrote:
> > > Use the macro PCI_IRQ_INTX instead of the deprecated PCI_IRQ_LEGACY
> > > macro.
> > 
> > Not needed anymore. MFD subsystem has a patch moving this to MSI support.
> > But you need to coordinate with Lee how to proceed (in case of conflicts MFD
> > version should be taken).
> 
> Thanks!  It looks like your patch [1] has been applied already and
> makes this one obsolete, so I dropped this one from the series.

I put this patch back in to prevent an ordering requirement between
MFD and PCI.  There will be a trivial merge conflict as Andy
mentioned.

> [1] https://lore.kernel.org/all/20240312165905.1764507-1-andriy.shevchenko@linux.intel.com/
