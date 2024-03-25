Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93352C54E64
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Mar 2024 21:04:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32DC710E11D;
	Mon, 25 Mar 2024 21:04:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aQB/RO/B";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADD1910E11D
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Mar 2024 21:04:47 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id C941F61189;
 Mon, 25 Mar 2024 21:04:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA71C433F1;
 Mon, 25 Mar 2024 21:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711400686;
 bh=dQwGwZ+Gav/BpPhKx3Wa0ikFo4EZJchq5Waw+sq2uOE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=aQB/RO/BdbSwsm4YVZOTcLoSEoHNn1nENBpDFKUfosZwRbY6uK+mzFHmQX3R2A3bz
 Lr+uvxIaoRmIFH64uTfjIz4xZjz/mqSot2JFYFo8bhh/dH8jDck2MzEvLuab/6QtVs
 N3ao6t6vj+p8usmZbstXhSMgGJDHiJs9X7sjH9ltdCNb1aLiII2n0eQyUy4EOKHS/r
 4pEc+5pIpfQ54Y751Gr9hY2iRSNc+uyTQu3w3X15NmFwMUal1vmNajw6blETHn9dYk
 SvwXtnqDJ0Q3dKnkfZcslSJjhcjxB0RSn8pAjhrzBk9kIvMUoEomg/E0SdzIV/Koz/
 e1s8/FRDSrkrA==
Date: Mon, 25 Mar 2024 16:04:44 -0500
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
Message-ID: <20240325210444.GA1449676@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgHS-qZliVyFD5xh@smile.fi.intel.com>
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

On Mon, Mar 25, 2024 at 09:39:38PM +0200, Andy Shevchenko wrote:
> On Mon, Mar 25, 2024 at 04:09:20PM +0900, Damien Le Moal wrote:
> > Use the macro PCI_IRQ_INTX instead of the deprecated PCI_IRQ_LEGACY
> > macro.
> 
> Not needed anymore. MFD subsystem has a patch moving this to MSI support.
> But you need to coordinate with Lee how to proceed (in case of conflicts MFD
> version should be taken).

Thanks!  It looks like your patch [1] has been applied already and
makes this one obsolete, so I dropped this one from the series.

Bjorn

[1] https://lore.kernel.org/all/20240312165905.1764507-1-andriy.shevchenko@linux.intel.com/
