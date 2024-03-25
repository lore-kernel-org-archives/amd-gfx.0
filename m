Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC80C54E58
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Mar 2024 07:10:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECDB210E601;
	Mon, 25 Mar 2024 07:10:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="rFvvwxM+";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49DE910E601
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Mar 2024 07:10:31 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id B478C60DF8;
 Mon, 25 Mar 2024 07:10:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249C8C43390;
 Mon, 25 Mar 2024 07:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711350630;
 bh=yQkEdpK+pQC5xgDqqVQKDe1hrD7TK7KQYXOn9F7ILT4=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=rFvvwxM+nOfC6ZINMkuVQCj79iT/f6YfZu82C8ota8vaEaAzc2AFR0ak8taEZM5dg
 B5mM5UJWkiNfsPa2zPhe4sasKskWbl7OfeS/VXzUMd/KNc38aM0nuw71t4DsYBpadJ
 gHojJtPOMg78lJcw5I4GDKgvLoRY7/ObWycdLbJJUgUgzhb6mcRcqWk44EzKJqZelh
 7MxygxPQBzbK5l+dwzver1Eq69x7R9ZhLf2Eip2pB1KYc1HDx6kYTY4vjixVRZgOMX
 4HEGu4gqfllsTwe/1Jib+o6VOSJ1yY4PqpPEDQEL93hs6tyLqWQEmEoeDqEnPWt7ti
 4sCCR8FUQRWoA==
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
Subject: [PATCH 11/28] infiniband: qib: Use PCI_IRQ_INTX
Date: Mon, 25 Mar 2024 16:09:22 +0900
Message-ID: <20240325070944.3600338-12-dlemoal@kernel.org>
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
 drivers/infiniband/hw/qib/qib_iba7220.c | 2 +-
 drivers/infiniband/hw/qib/qib_iba7322.c | 5 ++---
 drivers/infiniband/hw/qib/qib_pcie.c    | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_iba7220.c b/drivers/infiniband/hw/qib/qib_iba7220.c
index 6af57067c32e..78dfe98ebcf7 100644
--- a/drivers/infiniband/hw/qib/qib_iba7220.c
+++ b/drivers/infiniband/hw/qib/qib_iba7220.c
@@ -3281,7 +3281,7 @@ static int qib_7220_intr_fallback(struct qib_devdata *dd)
 
 	qib_free_irq(dd);
 	dd->msi_lo = 0;
-	if (pci_alloc_irq_vectors(dd->pcidev, 1, 1, PCI_IRQ_LEGACY) < 0)
+	if (pci_alloc_irq_vectors(dd->pcidev, 1, 1, PCI_IRQ_INTX) < 0)
 		qib_dev_err(dd, "Failed to enable INTx\n");
 	qib_setup_7220_interrupt(dd);
 	return 1;
diff --git a/drivers/infiniband/hw/qib/qib_iba7322.c b/drivers/infiniband/hw/qib/qib_iba7322.c
index f93906d8fc09..9db29916e35a 100644
--- a/drivers/infiniband/hw/qib/qib_iba7322.c
+++ b/drivers/infiniband/hw/qib/qib_iba7322.c
@@ -3471,8 +3471,7 @@ static void qib_setup_7322_interrupt(struct qib_devdata *dd, int clearpend)
 				    pci_irq_vector(dd->pcidev, msixnum),
 				    ret);
 			qib_7322_free_irq(dd);
-			pci_alloc_irq_vectors(dd->pcidev, 1, 1,
-					      PCI_IRQ_LEGACY);
+			pci_alloc_irq_vectors(dd->pcidev, 1, 1, PCI_IRQ_INTX);
 			goto try_intx;
 		}
 		dd->cspec->msix_entries[msixnum].arg = arg;
@@ -5143,7 +5142,7 @@ static int qib_7322_intr_fallback(struct qib_devdata *dd)
 	qib_devinfo(dd->pcidev,
 		"MSIx interrupt not detected, trying INTx interrupts\n");
 	qib_7322_free_irq(dd);
-	if (pci_alloc_irq_vectors(dd->pcidev, 1, 1, PCI_IRQ_LEGACY) < 0)
+	if (pci_alloc_irq_vectors(dd->pcidev, 1, 1, PCI_IRQ_INTX) < 0)
 		qib_dev_err(dd, "Failed to enable INTx\n");
 	qib_setup_7322_interrupt(dd, 0);
 	return 1;
diff --git a/drivers/infiniband/hw/qib/qib_pcie.c b/drivers/infiniband/hw/qib/qib_pcie.c
index 47bf64ace05c..58c1d62d341b 100644
--- a/drivers/infiniband/hw/qib/qib_pcie.c
+++ b/drivers/infiniband/hw/qib/qib_pcie.c
@@ -210,7 +210,7 @@ int qib_pcie_params(struct qib_devdata *dd, u32 minw, u32 *nent)
 	}
 
 	if (dd->flags & QIB_HAS_INTX)
-		flags |= PCI_IRQ_LEGACY;
+		flags |= PCI_IRQ_INTX;
 	maxvec = (nent && *nent) ? *nent : 1;
 	nvec = pci_alloc_irq_vectors(dd->pcidev, 1, maxvec, flags);
 	if (nvec < 0)
-- 
2.44.0

