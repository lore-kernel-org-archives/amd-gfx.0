Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64246C54E67
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Mar 2024 08:18:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B212410EDBC;
	Tue, 26 Mar 2024 08:18:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HqQ7RdWG";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CC5F10E0EE
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Mar 2024 19:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711395587; x=1742931587;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=D6MfnrEFK0/vmjnJEcjSthiQ8tmUlQRWp4661t4UP/k=;
 b=HqQ7RdWG+Lw1MCIjj21cTC1fwXcPU9/EMfx1ROyiBYbmE8eU38GdtPpH
 YAjxZUCHoA+2MGA1Ui4aMl0u3s9RbcHeXqr5LNUX4n9cH0sEnSz6Y/7PL
 Un7RgwCxyAWzDNw1MXQOjI3aebAj4Z4BYwKxInG6ciJOn/ra6ZdqoosCx
 9zVX3W0fAu1teOrPKsy1hG0wLtoIpd7JXhmqMj2DpoyPtfT6kbvw37AMM
 vjwYlMzlKrnJMvn7768pvnqK7+Qp8boyfYwwjpYufYlgjRYHagdzDmClg
 imcLLoZmnEwfvDgbulyq927hXSJxo/2uwjubjmjcTipch8Fs5rjyiBGou A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6601591"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="6601591"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2024 12:39:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="914852875"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; d="scan'208";a="914852875"
Received: from smile.fi.intel.com ([10.237.72.54])
 by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2024 12:39:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
 (envelope-from <andriy.shevchenko@intel.com>)
 id 1roqAU-0000000G7FV-4928; Mon, 25 Mar 2024 21:39:38 +0200
Date: Mon, 25 Mar 2024 21:39:38 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
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
Message-ID: <ZgHS-qZliVyFD5xh@smile.fi.intel.com>
References: <20240325070944.3600338-1-dlemoal@kernel.org>
 <20240325070944.3600338-10-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325070944.3600338-10-dlemoal@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Mailman-Approved-At: Tue, 26 Mar 2024 08:18:33 +0000
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

On Mon, Mar 25, 2024 at 04:09:20PM +0900, Damien Le Moal wrote:
> Use the macro PCI_IRQ_INTX instead of the deprecated PCI_IRQ_LEGACY
> macro.

Not needed anymore. MFD subsystem has a patch moving this to MSI support.
But you need to coordinate with Lee how to proceed (in case of conflicts MFD
version should be taken).

-- 
With Best Regards,
Andy Shevchenko


