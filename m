Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33D2C54E58
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Mar 2024 07:10:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 575F510E5F3;
	Mon, 25 Mar 2024 07:10:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kFARA2LO";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BF8210E5EF
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Mar 2024 07:10:08 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 04E1960DEA;
 Mon, 25 Mar 2024 07:10:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF2DC43394;
 Mon, 25 Mar 2024 07:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711350607;
 bh=A9TxYq3UpnnXqXe4Ry5wOngxfykxcqU3LiaWPn5EjBk=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=kFARA2LOYRrO5xqIgKf6WUYQsLLv53tYDhUtPQ06+TVXMszutNq+GyQXlmWL94J6X
 OIAM1vT9Fw8KI8oQo8/Lr/f6hxkUw0UNiXjpR/3YVStTv5z8l8MOpOe115NMNFVKP/
 m7V/gjDpqBlpMuCrU3OBzq7XKn0sofTjBcdI5B2odCVKGqetsaAP4t3X6ETt0Ucohx
 HJToHwp4ED5Y7i6w25yoOcLrAG18FtjkcptCKSqWoHYxqP8BxlLq4r37Nq2mG6gA+S
 MnwOzDnkeQC1J5KF5BQEvlVQTIa+NxGFBkPgtF1Ub/hpX7hTblXLpYC//JaPzRukh6
 RPzYeUFUtNDpA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
 linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Jaroslav Kysela <perex@perex.cz>, linux-sound@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-serial@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 platform-driver-x86@vger.kernel.org, ntb@lists.linux.dev,
 Lee Jones <lee@kernel.org>, David Airlie <airlied@gmail.com>,
 amd-gfx@lists.freedesktop.org, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-rdma@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 05/28] usb: hcd-pci: Use PCI_IRQ_INTX
Date: Mon, 25 Mar 2024 16:09:16 +0900
Message-ID: <20240325070944.3600338-6-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240325070944.3600338-1-dlemoal@kernel.org>
References: <20240325070944.3600338-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Use the macro PCI_IRQ_INTX instead of the deprecated PCI_IRQ_LEGACY
macro.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/usb/core/hcd-pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
index ee3156f49533..a08f3f228e6d 100644
--- a/drivers/usb/core/hcd-pci.c
+++ b/drivers/usb/core/hcd-pci.c
@@ -189,7 +189,8 @@ int usb_hcd_pci_probe(struct pci_dev *dev, const struct hc_driver *driver)
 	 * make sure irq setup is not touched for xhci in generic hcd code
 	 */
 	if ((driver->flags & HCD_MASK) < HCD_USB3) {
-		retval = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_LEGACY | PCI_IRQ_MSI);
+		retval = pci_alloc_irq_vectors(dev, 1, 1,
+					       PCI_IRQ_INTX | PCI_IRQ_MSI);
 		if (retval < 0) {
 			dev_err(&dev->dev,
 			"Found HC with no IRQ. Check BIOS/PCI %s setup!\n",
-- 
2.44.0

