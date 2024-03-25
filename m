Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F93C54E64
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Mar 2024 07:11:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C88A10E633;
	Mon, 25 Mar 2024 07:11:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nu67yIa1";
	dkim-atps=neutral
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84C3910E633
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Mar 2024 07:11:37 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id D23BCCE0B65;
 Mon, 25 Mar 2024 07:11:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49A5C43390;
 Mon, 25 Mar 2024 07:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711350695;
 bh=cNYwknOCoYozJYQki18ub+BQTqAuTBwIbKmwkZH+Rdw=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=nu67yIa15SCpfTJanXaBWhOku7Ap2WldWog9PIvPYtQPZeiYE926Hie6SdsjloJH6
 YQ6R8skFC+9ab9kVrHZFuyLivI+Q1eWoHLN5yxo/pgnMhkeb5Pi3wVMr/YnG8STYFh
 sOQiwxOgY7p6DxYSBLLIPJ9mTqOqzcLEh/tXKSVLeip3JGYceudpbifFCjbV5FqCBq
 8HITItpYSLpEC1F2HzymMHHFEul4WNVKbPWXqQhHogxudlpl7p5i8PRE9nC5tDBgnc
 l4pnrR7cP7UAlAso5G48ciHZN4QbC/+8mjek7+1x7jWuc1SMzH55HvRQyXAAFQWm2f
 vjO+LHlblY5ww==
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
Subject: [PATCH 28/28] PCI: Remove PCI_IRQ_LEGACY
Date: Mon, 25 Mar 2024 16:09:39 +0900
Message-ID: <20240325070944.3600338-29-dlemoal@kernel.org>
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

Replace the last references to PCI_IRQ_LEGACY with PCI_IRQ_INTX in pci.h
header file. With this change, PCI_IRQ_LEGACY is unused and we can
remove its definition.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 include/linux/pci.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 16493426a04f..b19992a5dfaf 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1077,8 +1077,6 @@ enum {
 #define PCI_IRQ_MSIX		(1 << 2) /* Allow MSI-X interrupts */
 #define PCI_IRQ_AFFINITY	(1 << 3) /* Auto-assign affinity */
 
-#define PCI_IRQ_LEGACY		PCI_IRQ_INTX /* Deprecated! Use PCI_IRQ_INTX */
-
 /* These external functions are only available when PCI support is enabled */
 #ifdef CONFIG_PCI
 
@@ -1648,8 +1646,7 @@ int pci_set_vga_state(struct pci_dev *pdev, bool decode,
  */
 #define PCI_IRQ_VIRTUAL		(1 << 4)
 
-#define PCI_IRQ_ALL_TYPES \
-	(PCI_IRQ_LEGACY | PCI_IRQ_MSI | PCI_IRQ_MSIX)
+#define PCI_IRQ_ALL_TYPES	(PCI_IRQ_INTX | PCI_IRQ_MSI | PCI_IRQ_MSIX)
 
 #include <linux/dmapool.h>
 
@@ -1719,7 +1716,7 @@ pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 			       unsigned int max_vecs, unsigned int flags,
 			       struct irq_affinity *aff_desc)
 {
-	if ((flags & PCI_IRQ_LEGACY) && min_vecs == 1 && dev->irq)
+	if ((flags & PCI_IRQ_INTX) && min_vecs == 1 && dev->irq)
 		return 1;
 	return -ENOSPC;
 }
-- 
2.44.0

