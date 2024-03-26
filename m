Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE079CD11DD
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Mar 2024 12:58:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 629DB10E913;
	Tue, 26 Mar 2024 12:58:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Iw6U8WjZ";
	dkim-atps=neutral
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 162E810EDD7
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Mar 2024 08:28:00 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 0EAE1CE1F24;
 Tue, 26 Mar 2024 08:27:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8715C43394;
 Tue, 26 Mar 2024 08:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1711441678;
 bh=nQyk3qdNwZ8anxHMwxL1UdJZCo+TRv8Hz9hdRnnLqBk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Iw6U8WjZi0ZrwwftN3emjcJ/oZOIzjr7swKZOnMNp/4chnUfYm+SEpuiRo28qOLEZ
 05RijM8OUNxINXKYuwPEO7Ht/fCvBCqa1KgnTXedu6EYOEENmKvfR1mkZnQy9URTTN
 u4AC8W9q5PVErxInCdbfvkZkLUegBAglB4RLcz9Q=
Date: Tue, 26 Mar 2024 09:27:55 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
 linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Jaroslav Kysela <perex@perex.cz>, linux-sound@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-serial@vger.kernel.org,
 Hans de Goede <hdegoede@redhat.com>,
 platform-driver-x86@vger.kernel.org, ntb@lists.linux.dev,
 Lee Jones <lee@kernel.org>, David Airlie <airlied@gmail.com>,
 amd-gfx@lists.freedesktop.org, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-rdma@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/28] misc: vmci_guest: Use PCI_IRQ_ALL_TYPES
Message-ID: <2024032646-cosigner-whoopee-cd17@gregkh>
References: <20240325070944.3600338-1-dlemoal@kernel.org>
 <20240325070944.3600338-14-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325070944.3600338-14-dlemoal@kernel.org>
X-Mailman-Approved-At: Tue, 26 Mar 2024 12:58:37 +0000
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

On Mon, Mar 25, 2024 at 04:09:24PM +0900, Damien Le Moal wrote:
> In vmci_guest_probe_device(), remove the reference to PCI_IRQ_LEGACY by
> using PCI_IRQ_ALL_TYPES instead of an explicit OR of all IRQ types.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
